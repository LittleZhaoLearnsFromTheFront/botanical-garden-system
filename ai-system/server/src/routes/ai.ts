import { Router, Request, Response } from 'express';
import AIService from '../lib/AIProvider.ts';
import type { AIRequest, AIMessage } from '@ai-system/types';
import Logger from '../lib/Logger.ts';
import { AIMessageRole } from '../lib/constents.ts';
import { sessionEntity } from '../entity/session.entity.ts';
import { messageEntity } from '../entity/message.entity.ts';
import pkg from '@prisma/client';
import type { MessageRole, Prisma } from '@prisma/client';
import Config from '../lib/Config.ts';
const { MessageRole: MessageRoleEnum } = pkg;

const router = Router();
const logger = Logger.of('ai-route');

const validateRequestBody = (body: any) => {
    if (!body || Object.keys(body).length === 0) {
        return 'Request body is required';
    }
    if (!body.messages || !Array.isArray(body.messages) || body.messages.length === 0) {
        return 'messages must be a non-empty array';
    }
    return null;
};

const buildAIRequest = (body: any): AIRequest => {
    const { messages, model, temperature, max_tokens, stream } = body;

    const validMessages: AIMessage[] = messages.map((msg: any) => {
        if (!msg.role || !msg.content) {
            throw new Error('Each message must have role and content');
        }
        // 兼容大小写与字符串/枚举：统一转成大写字符串再校验
        const roleUpper = String(msg.role).toUpperCase();
        const allowRoles = [AIMessageRole.SYSTEM, AIMessageRole.USER, AIMessageRole.ASSISTANT].map(r =>
            String(r).toUpperCase()
        );
        if (!allowRoles.includes(roleUpper)) {
            throw new Error('Message role must be SYSTEM, USER, or ASSISTANT');
        }
        return {
            role: roleUpper as AIMessageRole,
            content: String(msg.content)
        };
    });
    logger.info({
        messages: validMessages,
        model,
        temperature,
        max_tokens,
        stream
    });
    return {
        messages: validMessages,
        model,
        temperature,
        max_tokens,
        stream
    };
};

const getLastUserMessageContent = (messages: AIMessage[]): string | null => {
    for (let i = messages.length - 1; i >= 0; i--) {
        if (messages[i].role === AIMessageRole.USER) {
            return messages[i].content;
        }
    }
    return null;
};

// 确保会话存在
const ensureSession = async (body: any, provider: string): Promise<{ id: string; title?: string } | false> => {
    const { sessionId, title, model } = body;
    if (sessionId) {
        const existing = await sessionEntity.getSessionById(sessionId);
        if (existing) {
            // 如果需要同步最新 provider/model 信息，执行一次轻量更新
            if (provider !== existing.provider || model !== existing.model || title) {
                await sessionEntity.editSession(sessionId, {
                    provider: provider ?? existing.provider,
                    model: model ?? existing.model,
                    title: title ?? existing.title
                });
            }
            return { id: sessionId, title: existing.title ?? title };
        }
    }


    return false
};

const recordMessage = async (
    sessionId: string,
    role: MessageRole,
    content: string,
    provider?: string,
    model?: string,
    tokenUsage?: { prompt?: number; completion?: number; total?: number }
) => {
    if (!content) return;
    await messageEntity.addMessage({
        role,
        content,
        provider,
        model,
        promptTokens: tokenUsage?.prompt,
        completionTokens: tokenUsage?.completion,
        totalTokens: tokenUsage?.total,
        session: {
            connect: { id: sessionId }
        }
    });
};

const handleStreamResponse = async (
    provider: string,
    request: AIRequest,
    res: Response,
    sessionContext: { sessionId: string; modelName?: string }
) => {
    // 设置 SSE 响应头，尽量关闭各类缓冲
    res.setHeader('Content-Type', 'text/event-stream; charset=utf-8');
    res.setHeader('Cache-Control', 'no-cache, no-transform');
    res.setHeader('Connection', 'keep-alive');
    // 对 Nginx 等代理关闭缓冲
    res.setHeader('X-Accel-Buffering', 'no');

    // 立刻把响应头刷给客户端，避免等到首个数据块才开始显示
    (res as any).flushHeaders?.();

    let fullContent = '';
    try {
        for await (const chunk of AIService.chatStream(provider, request)) {
            fullContent += chunk;
            // 每个 chunk 一到就写出一条 SSE 消息
            res.write(`data: ${JSON.stringify({ content: chunk, sessionId: sessionContext.sessionId })}\n\n`);
            // 主动 flush，减少 Node / 代理的缓冲
            (res as any).flush?.();
        }
        res.write(`data: ${JSON.stringify({ done: true, content: '', sessionId: sessionContext.sessionId })}\n\n`);
        res.end();

        await recordMessage(
            sessionContext.sessionId,
            MessageRoleEnum.ASSISTANT,
            fullContent,
            provider,
            sessionContext.modelName || request.model
        );
    } catch (error: any) {
        logger.error({ error: error.message, stack: error.stack }, 'Stream chat request error');
        res.write(`data: ${JSON.stringify({ error: error.message, sessionId: sessionContext.sessionId })}\n\n`);
        res.end();
        throw error;
    }
};

type WorkOrderActionDecision = {
    action: 'FINISH_WORK_ORDER' | 'ACCEPT_WORK_ORDER' | 'CANCEL_WORK_ORDER' | 'NONE';
    workOrderId: number | null;
    triggered: boolean;
    reason?: string;
};

const handleChatRequest = async (userId: string, provider: string, body: any, res: Response) => {
    const validationError = validateRequestBody(body);
    if (validationError) {
        res.status(400).json({
            success: false,
            error: 'Invalid request',
            message: validationError
        });
        return;
    }

    const request = buildAIRequest(body);
    // 确保会话存在
    const session = await ensureSession(body, provider);
    // 如果会话不存在，返回错误
    if (!session) {
        res.status(400).json({
            success: false,
            error: 'Invalid request',
            message: 'Session not found'
        });
        return;
    }
    const lastUserMessage = getLastUserMessageContent(request.messages);
    if (lastUserMessage) {
        await recordMessage(session.id, MessageRoleEnum.USER, lastUserMessage, provider, request.model);
    }

    // 先由模型判断是否需要触发工单动作（例如完成工单）
    const enableWorkOrderAction = !!(body && body.enableWorkOrderAction);
    let actionDecision: WorkOrderActionDecision = {
        action: 'NONE',
        workOrderId: null,
        triggered: false,
    };
    if (enableWorkOrderAction) {
        try {
            actionDecision = await decideWorkOrderAction(provider, request, lastUserMessage || '');
        } catch (e: any) {
            logger.warn({ error: e?.message }, 'decide work order action failed');
        }
    }

    // 如果已经由动作判断触发了实际操作（例如完成工单），则直接返回简要结果，不再生成普通对话回答
    if (enableWorkOrderAction && actionDecision.triggered) {
        let content = '已根据你的指令执行了相应操作。请刷新页面！';
        if (actionDecision.workOrderId) {
            if (actionDecision.action === 'FINISH_WORK_ORDER') {
                content = `已根据你的指令，将工单【${actionDecision.workOrderId}】标记为完成。请刷新页面！`;
            } else if (actionDecision.action === 'ACCEPT_WORK_ORDER') {
                content = `已为你接单工单【${actionDecision.workOrderId}】。请刷新页面！`;
            } else if (actionDecision.action === 'CANCEL_WORK_ORDER') {
                content = `已为你取消工单【${actionDecision.workOrderId}】。请刷新页面！`;
            }
        }

        await recordMessage(
            session.id,
            MessageRoleEnum.ASSISTANT,
            content,
            provider,
            request.model || undefined
        );

        res.json({
            success: true,
            data: {
                content,
                model: request.model || 'default',
                sessionId: session.id,
                action: actionDecision.action,
                actionWorkOrderId: actionDecision.workOrderId,
                actionTriggered: actionDecision.triggered,
                actionReason: actionDecision.reason,
            },
        });
        return;
    }

    if (request.stream) {
        await handleStreamResponse(provider, request, res, {
            sessionId: session.id,
            modelName: request.model
        });
        return;
    }

    // 再生成正常的 AI 回复
    const response = await AIService.chat(provider, request);

    await recordMessage(
        session.id,
        MessageRoleEnum.ASSISTANT,
        response.content,
        provider,
        response.model,
        response.usage
            ? {
                prompt: response.usage.prompt_tokens,
                completion: response.usage.completion_tokens,
                total: response.usage.total_tokens
            }
            : undefined
    );

    res.json({
        success: true,
        data: {
            ...response,
            sessionId: session.id,
            // 把动作判断结果一并返回给上层
            action: actionDecision.action,
            actionWorkOrderId: actionDecision.workOrderId,
            actionTriggered: actionDecision.triggered,
            actionReason: actionDecision.reason,
        }
    });
};

const extractSystemInfo = (messages: AIMessage[]): string => {
    for (const msg of messages) {
        if (msg.role === AIMessageRole.SYSTEM) {
            return String(msg.content || '');
        }
    }
    return '';
};

const decideWorkOrderAction = async (
    provider: string,
    request: AIRequest,
    lastUserMessage: string
): Promise<WorkOrderActionDecision> => {
    const systemInfo = extractSystemInfo(request.messages);

    const classifyRequest: AIRequest = {
        messages: [
            {
                role: AIMessageRole.SYSTEM,
                content:
`你是工单动作识别助手。
只根据用户输入和工单信息判断是否需要触发以下动作之一：
- FINISH_WORK_ORDER：将工单状态改为“已完成”
- ACCEPT_WORK_ORDER：将工单状态改为“执行中 / 接单”
- CANCEL_WORK_ORDER：将工单状态改为“已取消”
如果都不需要触发，则返回 NONE。
严格输出 JSON，不能输出解释或多余文字。
JSON 结构如下（字段名必须一致）：
{"action":"FINISH_WORK_ORDER" 或 "ACCEPT_WORK_ORDER" 或 "CANCEL_WORK_ORDER" 或 "NONE","workOrderId":数字或null,"reason":"简单中文原因"}`,
            },
            {
                role: AIMessageRole.USER,
                content:
                    `用户刚才的输入：
${lastUserMessage}

工单关键信息（如果有）：
${systemInfo}

请根据以上内容判断：
- 如果用户明确希望将当前工单状态改为“已完成”，则 action 用 "FINISH_WORK_ORDER"
- 如果用户明确希望“接单/开始执行”该工单，则 action 用 "ACCEPT_WORK_ORDER"
- 如果用户明确希望“取消/作废”该工单，则 action 用 "CANCEL_WORK_ORDER"
- 从工单信息中解析出工单ID（找“工单ID：<数字>”）；解析不到则 workOrderId 为 null。
- 其他情况一律返回 {"action":"NONE","workOrderId":null,"reason":"..."}。`,
            },
        ],
        model: request.model,
    };

    const classifyResp = await AIService.chat(provider, classifyRequest);
    let parsed: any;
    try {
        parsed = JSON.parse(classifyResp.content);
    } catch (e) {
        logger.warn({ content: classifyResp.content }, 'parse work order action json failed');
        return {
            action: 'NONE',
            workOrderId: null,
            triggered: false,
        };
    }

    if (!parsed || typeof parsed !== 'object') {
        return {
            action: 'NONE',
            workOrderId: null,
            triggered: false,
        };
    }
    const action = String(parsed.action || '').toUpperCase();
    const workOrderId = parsed.workOrderId != null ? Number(parsed.workOrderId) : NaN;
    logger.info({ action, workOrderId, reason: parsed.reason }, 'work order action decision');

    if (!Number.isNaN(workOrderId) && workOrderId > 0) {
        if (action === 'FINISH_WORK_ORDER') {
            await tryFinishWorkOrder(workOrderId, '');
            return {
                action: 'FINISH_WORK_ORDER',
                workOrderId,
                triggered: true,
                reason: parsed.reason,
            };
        }
        if (action === 'ACCEPT_WORK_ORDER') {
            await tryAcceptWorkOrder(workOrderId);
            return {
                action: 'ACCEPT_WORK_ORDER',
                workOrderId,
                triggered: true,
                reason: parsed.reason,
            };
        }
        if (action === 'CANCEL_WORK_ORDER') {
            await tryCancelWorkOrder(workOrderId, parsed.reason || '');
            return {
                action: 'CANCEL_WORK_ORDER',
                workOrderId,
                triggered: true,
                reason: parsed.reason,
            };
        }
    }

    return {
        action: 'NONE',
        workOrderId: Number.isNaN(workOrderId) ? null : workOrderId,
        triggered: false,
        reason: parsed.reason,
    };
};

const tryFinishWorkOrder = async (workOrderId: number, resultDesc: string) => {
    const baseUrl = Config.integration?.java?.baseUrl;
    const secret = Config.integration?.java?.callbackSecret;
    if (!baseUrl || !secret) {
        logger.debug('skip java finish callback because baseUrl or secret not set', { baseUrlPresent: !!baseUrl, secretPresent: !!secret });
        return;
    }
    const url = baseUrl.replace(/\/+$/, '') + '/garden/workOrder/ai/finish';
    logger.info({ workOrderId, url }, 'calling java finish work order callback');
    const resp = await fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-AI-SECRET': secret,
        },
        body: JSON.stringify({
            workOrderId,
            resultDesc: (resultDesc || '').slice(0, 2000),
        }),
    });
    if (!resp.ok) {
        const t = await resp.text();
        throw new Error(`java finish failed: ${resp.status} ${t}`);
    }
    logger.info({ workOrderId }, 'java finish work order callback success');
};

const tryAcceptWorkOrder = async (workOrderId: number) => {
    const baseUrl = Config.integration?.java?.baseUrl;
    const secret = Config.integration?.java?.callbackSecret;
    if (!baseUrl || !secret) {
        logger.debug('skip java accept callback because baseUrl or secret not set', { baseUrlPresent: !!baseUrl, secretPresent: !!secret });
        return;
    }
    const url = baseUrl.replace(/\/+$/, '') + '/garden/workOrder/ai/accept';
    logger.info({ workOrderId, url }, 'calling java accept work order callback');
    const resp = await fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-AI-SECRET': secret,
        },
        body: JSON.stringify({
            workOrderId,
        }),
    });
    if (!resp.ok) {
        const t = await resp.text();
        throw new Error(`java accept failed: ${resp.status} ${t}`);
    }
    logger.info({ workOrderId }, 'java accept work order callback success');
};

const tryCancelWorkOrder = async (workOrderId: number, reason: string) => {
    const baseUrl = Config.integration?.java?.baseUrl;
    const secret = Config.integration?.java?.callbackSecret;
    if (!baseUrl || !secret) {
        logger.debug('skip java cancel callback because baseUrl or secret not set', { baseUrlPresent: !!baseUrl, secretPresent: !!secret });
        return;
    }
    const url = baseUrl.replace(/\/+$/, '') + '/garden/workOrder/ai/cancel';
    logger.info({ workOrderId, url }, 'calling java cancel work order callback');
    const resp = await fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-AI-SECRET': secret,
        },
        body: JSON.stringify({
            workOrderId,
            reason: (reason || '').slice(0, 500),
        }),
    });
    if (!resp.ok) {
        const t = await resp.text();
        throw new Error(`java cancel failed: ${resp.status} ${t}`);
    }
    logger.info({ workOrderId }, 'java cancel work order callback success');
};

router.post('/chat', async (req: Request, res: Response) => {
    try {
        const provider = req.body?.provider || 'deepseek';
        const userId = (req as any)['user'];
        await handleChatRequest(userId, provider, req.body, res);
    } catch (error: any) {
        logger.error({ error: error.message, stack: error.stack }, 'Chat request error');
        if (!res.headersSent) {
            res.status(error.message?.includes('not found') ? 404 : 500).json({
                success: false,
                error: error.message || 'Internal server error'
            });
        }
    }
});


router.post('/chat/:provider', async (req: Request, res: Response) => {
    try {
        const { provider } = req.params;
        const userId = (req as any)['user'];
        await handleChatRequest(userId, provider, req.body, res);
    } catch (error: any) {
        logger.error({ error: error.message, stack: error.stack }, 'Chat request error');
        if (!res.headersSent) {
            res.status(error.message?.includes('not found') ? 404 : 500).json({
                success: false,
                error: error.message || 'Internal server error'
            });
        }
    }
});

router.get('/sessions', async (req: Request, res: Response) => {
    try {
        const { keyword } = req.query;
        const userId = (req as any)['user'];
        const where: Prisma.SessionWhereInput = {};
        if (userId) {
            where.userId = String(userId);
        }
        if (keyword) {
            where.title = {
                contains: String(keyword)
            };
        }

        const sessions = await sessionEntity.getSessions(where);
        res.json({
            success: true,
            data: sessions
        });
    } catch (error: any) {
        logger.error({ error: error.message, stack: error.stack }, 'List sessions error');
        res.status(500).json({
            success: false,
            error: error.message || 'Internal server error'
        });
    }
});

router.post('/sessions', async (req: Request, res: Response) => {
    try {
        const userId = (req as any)['user'];
        const { title, provider } = req.body || {};
        if (!title) {
            return res.status(400).json({
                success: false,
                error: 'Invalid request',
                message: 'title is required'
            });
        }
        if (!provider) {
            return res.status(400).json({
                success: false,
                error: 'Invalid request',
                message: 'provider is required'
            });
        }

        const model = AIService.getProviderModel(provider);


        if (!model) {
            return res.status(400).json({
                success: false,
                error: 'Invalid request',
                message: 'model not found'
            });
        }

        const session = await sessionEntity.addSession({
            title,
            userId,
            provider,
            model
        });

        res.json({
            success: true,
            data: session
        });
    } catch (error: any) {
        logger.error({ error: error.message, stack: error.stack }, 'Create session error');
        res.status(500).json({
            success: false,
            error: error.message || 'Internal server error'
        });
    }
});

router.put('/sessions/:id', async (req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const userId = (req as any)['user'];
        const { title, provider, model } = req.body || {};
        const payload: Prisma.SessionUpdateInput = {};
        if (title !== undefined) payload.title = title;
        if (userId !== undefined) payload.userId = userId;
        if (provider !== undefined) payload.provider = provider;
        if (model !== undefined) payload.model = model;

        const session = await sessionEntity.editSession(id, payload);
        res.json({
            success: true,
            data: session
        });
    } catch (error: any) {
        logger.error({ error: error.message, stack: error.stack }, 'Update session error');
        res.status(error.code === 'P2025' ? 404 : 500).json({
            success: false,
            error: error.message || 'Internal server error'
        });
    }
});

router.delete('/sessions/:id', async (req: Request, res: Response) => {
    try {
        const { id } = req.params;
        await sessionEntity.deleteSessionById(id);
        res.json({
            success: true,
            data: { id }
        });
    } catch (error: any) {
        logger.error({ error: error.message, stack: error.stack }, 'Delete session error');
        res.status(error.code === 'P2025' ? 404 : 500).json({
            success: false,
            error: error.message || 'Internal server error'
        });
    }
});

router.get('/sessions/:id', async (req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const session = await sessionEntity.getSessionById(id);
        if (!session) {
            return res.status(404).json({
                success: false,
                error: 'Session not found'
            });
        }
        res.json({
            success: true,
            data: session
        });
    } catch (error: any) {
        logger.error({ error: error.message, stack: error.stack }, 'Get session detail error');
        res.status(500).json({
            success: false,
            error: error.message || 'Internal server error'
        });
    }
});

router.get('/sessions/:id/messages', async (req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const messages = await messageEntity.getMessages({
            sessionId: id
        });
        res.json({
            success: true,
            data: messages
        });
    } catch (error: any) {
        logger.error({ error: error.message, stack: error.stack }, 'Get session messages error');
        res.status(500).json({
            success: false,
            error: error.message || 'Internal server error'
        });
    }
});

// GET /api/ai/providers
router.get('/providers', (req: Request, res: Response) => {
    try {
        const providers = AIService.listProviders();
        res.json({
            success: true,
            data: {
                providers,
                count: providers.length
            }
        });
    } catch (error: any) {
        logger.error({ error: error.message }, 'Get providers error');
        res.status(500).json({
            success: false,
            error: error.message || 'Internal server error'
        });
    }
});


export default router;



