# AI System

一个基于 LangChain 的统一 AI 对话系统，支持多个 AI 提供商，提供现代化的 Web 界面和 RESTful API。

## ✨ 功能特性

- 🤖 **多 AI 提供商支持** - 支持 DeepSeek、OpenAI、Anthropic (Claude) 等多种 AI 提供商
- 🔄 **基于 LangChain** - 使用 LangChain 统一接口，轻松扩展新的 AI 提供商
- 💬 **实时对话** - 支持流式响应，提供流畅的对话体验
- 📝 **会话管理** - 完整的会话历史记录和管理功能
- 🎨 **现代化 UI** - 基于 React + Ant Design 构建的美观界面
- 🔌 **RESTful API** - 提供完整的 API 接口，支持集成到其他系统
- 🗄️ **数据持久化** - 使用 Prisma + SQLite 存储会话和消息数据
- 🚀 **跨平台开发** - 提供 macOS、Linux、Windows 的开发启动脚本
- 🔗 **iframe 嵌入支持** - 支持通过 iframe 快速集成到其他应用，提供跨窗口通信能力

## 🛠️ 技术栈

### 前端 (UI)
- **React 19** - UI 框架
- **TypeScript** - 类型安全
- **Vite** - 构建工具
- **Ant Design 6** - UI 组件库
- **@ant-design/x** - 高级组件（聊天界面）

### 后端 (Server)
- **Node.js** - 运行时环境
- **Express** - Web 框架
- **LangChain** - AI 统一接口
- **Prisma** - ORM 数据库工具
- **SQLite** - 轻量级数据库
- **TypeScript** - 类型安全

### 测试应用 (Parent-Test)
- **React 19** - UI 框架
- **TypeScript** - 类型安全
- **Vite (rolldown)** - 构建工具（使用 rolldown 版本）
- **iframe 通信** - 测试跨窗口消息传递

## 📁 项目结构（pnpm Monorepo）

```
ai-system/
├── packages/
│   └── types/             # 公共类型包 @ai-system/types（ui / server 共用）
│       ├── src/index.ts
│       └── package.json
├── ui/                    # 前端应用（依赖 @ai-system/types）
│   ├── src/
│   │   ├── components/    # React 组件
│   │   ├── hooks/         # React Hooks
│   │   ├── lib/           # 工具函数
│   │   └── types.ts       # 从 @ai-system/types 重新导出
│   └── package.json
├── server/                # 后端服务（依赖 @ai-system/types）
│   ├── src/
│   │   ├── entity/        # 数据实体
│   │   ├── routes/        # API 路由
│   │   ├── lib/           # 核心库
│   │   └── ...
│   ├── prisma/            # 数据库配置
│   └── package.json
├── parent-test/           # 父窗口测试应用
│   ├── src/
│   │   └── App.tsx        # iframe 嵌入测试
│   └── package.json
├── scripts/               # 开发脚本
│   ├── dev                # 跨平台启动脚本
│   ├── dev.sh             # Linux/macOS 脚本
│   ├── dev.bat            # Windows 批处理
│   └── dev.ps1            # Windows PowerShell
├── pnpm-workspace.yaml    # pnpm 工作区配置
└── README.md
```

## 🚀 快速开始

### 前置要求

- **Node.js v22**（推荐使用 `nvm use v22` 切换版本）
- **pnpm**（ui 与 server 均使用 pnpm）
- **tmux** (macOS/Linux，用于分屏开发)

### 1. 克隆项目

```bash
git clone <repository-url>
cd ai-system
```

### 2. 安装依赖

```bash
# 切换 Node 版本（如使用 nvm）
nvm use v22

# 安装前端依赖
cd ui
pnpm install

# 安装后端依赖
cd ../server
pnpm install
pnpm exec prisma generate 
# 安装测试应用依赖（可选，可用 npm 或 pnpm）
cd ../parent-test
npm install
```

**推荐：在项目根目录一次性安装所有工作区依赖并构建公共类型包：**

```bash
nvm use v22
cd ai-system
pnpm install          # 会链接 ui、server、packages/types 并自动构建 @ai-system/types
pnpm run build:types # 仅重新构建公共类型包（可选）
```

### 3. 配置环境变量

在 `server` 目录下创建 `.env` 文件：

```bash
# DeepSeek
DEEPSEEK_API_KEY=your_deepseek_api_key

# OpenAI
OPENAI_API_KEY=your_openai_api_key

# Anthropic (Claude)
ANTHROPIC_API_KEY=your_anthropic_api_key
```

### 4. 初始化数据库

```bash
cd server
pnpm run orm:update
```

### 5. 启动开发服务器

#### 方式一：使用开发脚本（推荐）

**macOS / Linux:**
```bash
./scripts/dev
```

**Windows:**
```cmd
scripts\dev.bat
```

脚本会自动启动前端和后端服务，并在分屏中显示。

#### 方式二：手动启动

**终端 1 - 启动后端:**
```bash
cd server
pnpm run dev
```

**终端 2 - 启动前端:**
```bash
cd ui
pnpm run dev
```

### 6. 访问应用

- **前端界面**: http://localhost:5173 (Vite 默认端口)
- **后端 API**: http://localhost:4000
- **健康检查**: http://localhost:4000/health
- **父窗口测试应用**: http://localhost:5174 (需要单独启动，用于测试 iframe 嵌入)

## 📖 API 文档

### 基础信息

- **Base URL**: `http://localhost:4000`
- **认证**: 需要在请求头中添加 `X-User` 字段

### 接口列表

#### 1. 健康检查

```http
GET /health
```

#### 2. 获取可用的 AI 提供商

```http
GET /api/ai/providers
Headers:
  X-User: your-user-id
```

响应示例：
```json
{
  "success": true,
  "data": {
    "providers": ["deepseek", "openai"],
    "count": 2
  }
}
```

#### 3. 发送聊天消息

```http
POST /api/ai/chat
Headers:
  Content-Type: application/json
  X-User: your-user-id
Body:
{
  "provider": "deepseek",
  "messages": [
    {
      "role": "user",
      "content": "你好"
    }
  ],
  "model": "deepseek-chat",
  "temperature": 0.7,
  "stream": true
}
```

也可以通过 URL 路径指定提供商：

```http
POST /api/ai/chat/deepseek
```

### 请求参数

- `provider` (可选): AI 提供商名称，默认为 `deepseek`
- `messages` (必需): 消息数组
  - `role`: `"system"` | `"user"` | `"assistant"`
  - `content`: 消息内容
- `model` (可选): 模型名称
  - DeepSeek: `deepseek-chat` (默认)
  - OpenAI: `gpt-3.5-turbo` (默认)
  - Anthropic: `claude-3-sonnet-20240229` (默认)
- `temperature` (可选): 温度参数，默认 0.7
- `max_tokens` (可选): 最大 token 数
- `stream` (可选): 是否流式响应，默认 false

## ⚙️ 配置说明

### 服务器配置

编辑 `server/config.yaml`:

```yaml
server:
  name: AI System Server
  port: 4000
  loggerLevel: debug

logger:
  level: debug

ai:
  providers:
    deepseek:
      apiKey: ${DEEPSEEK_API_KEY}
      baseUrl: https://api.deepseek.com
    openai:
      apiKey: ${OPENAI_API_KEY}
      baseUrl: https://api.openai.com
    anthropic:
      apiKey: ${ANTHROPIC_API_KEY}
```

### 添加新的 AI 提供商

#### OpenAI 兼容的 API

如果提供商支持 OpenAI 兼容接口（如 Groq、Together AI），只需在 `config.yaml` 中添加：

```yaml
ai:
  providers:
    groq:
      apiKey: ${GROQ_API_KEY}
      baseUrl: https://api.groq.com/openai/v1
      model: llama-3-8b-8192
```

系统会自动识别并使用 OpenAI 兼容接口。

## 🧩 开发指南

### 开发模式

开发脚本会自动：
- 检测操作系统并使用相应的启动方式
- 在分屏中同时运行前端和后端
- 自动使用 Node.js v22
- 启用热重载

### 构建生产版本

```bash
# 构建前端
cd ui
pnpm run build

# 构建后端
cd ../server
pnpm run build
```

### 数据库迁移

```bash
cd server
pnpm run orm:update
```

### 父窗口测试应用

`parent-test` 是一个测试应用，用于测试 UI 应用在 iframe 中的嵌入功能。它通过 `postMessage` API 与嵌入的 UI 应用进行通信。

**启动测试应用：**

```bash
cd parent-test
npm run dev
```

测试应用会在 http://localhost:5174 启动（如果 5174 端口被占用，Vite 会自动选择其他端口）。

**功能说明：**
- 通过 iframe 嵌入 UI 应用（http://localhost:5173）
- 使用 `postMessage` 向 UI 应用发送用户信息
- 用于测试跨窗口通信和 iframe 集成场景

## 📝 开发脚本说明

项目提供了跨平台的开发启动脚本，详细说明请查看 [scripts/README.md](./scripts/README.md)。

### 快捷键

**macOS/Linux (tmux):**
- `Ctrl+B` + `←`/`→`: 切换面板
- `Ctrl+B` + `D`: 分离会话
- `Ctrl+B` + `X`: 关闭当前面板

**Windows (Windows Terminal):**
- `Alt+Shift+←`/`→`: 切换面板
- `Alt+Shift+D`: 关闭当前面板

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

ISC

## 🔗 相关链接

- [LangChain 文档](https://js.langchain.com/)
- [Prisma 文档](https://www.prisma.io/docs)
- [Ant Design 文档](https://ant.design/)
- [Vite 文档](https://vite.dev/)
