/**
 * UI 层类型：统一从 monorepo 公共包 @ai-system/types 重新导出，
 * 便于现有 import 路径保持不变。
 */
export {
  type IAnyObject,
  MessageRole,
  type Session,
  type Message,
  type Provider,
  type AIRequestData,
  type SendAIRequest,
  type AIMessage,
  type AIRequest,
  type AIResponse,
} from '@ai-system/types';
