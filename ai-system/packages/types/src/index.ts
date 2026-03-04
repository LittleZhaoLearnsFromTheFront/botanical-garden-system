/** 通用键值对象 */
export type IAnyObject = Record<string, unknown>;

/** 消息角色（与 Prisma enum 对齐） */
export enum MessageRole {
  SYSTEM = 'SYSTEM',
  USER = 'USER',
  ASSISTANT = 'ASSISTANT',
}

/** 会话（与 API / 数据库返回一致） */
export type Session = {
  id: string;
  title: string;
  userId: string;
  provider: string;
  model: string;
  createdAt: Date;
  updatedAt: Date;
};

/** 消息（基础字段；UI 可扩展 history、loading 等） */
export type Message = {
  id: string;
  sessionId: string;
  role: MessageRole;
  content: string;
  history?: boolean;
  loading?: boolean;
};

/** 提供商名称 */
export type Provider = string;

/** SSE 流式响应单条数据 */
export type AIRequestData = {
  content: string;
};

/** 发送 AI 请求的函数类型（用于 SSE 客户端） */
export type SendAIRequest = (obj: {
  url: string;
  headers?: IAnyObject;
  onmessage: (data: AIRequestData) => void;
  onerror?: (err: unknown) => void;
  onclose?: () => void;
}) => void;

/** 单条 AI 消息（API 请求体） */
export interface AIMessage {
  role: MessageRole;
  content: string;
}

/** AI 聊天请求体 */
export interface AIRequest {
  messages: AIMessage[];
  model?: string;
  temperature?: number;
  max_tokens?: number;
  stream?: boolean;
}

/** AI 聊天响应 */
export interface AIResponse {
  content: string;
  model: string;
  usage?: {
    prompt_tokens: number;
    completion_tokens: number;
    total_tokens: number;
  };
}
