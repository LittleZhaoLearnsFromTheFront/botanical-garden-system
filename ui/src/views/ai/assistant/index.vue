<template>
  <div class="app-container ai-assistant-container">
    <el-card class="ai-card" shadow="never">
      <div slot="header" class="card-header">
        <span>AI 助手</span>
      </div>
      <div class="iframe-wrap">
        <iframe
          v-if="aiAssistantUrl"
          ref="aiFrame"
          :src="aiAssistantUrl"
          class="ai-iframe"
          frameborder="0"
        />
        <div v-else class="ai-placeholder">
          <p>请配置 AI 助手地址（VUE_APP_AI_ASSISTANT_URL）后刷新页面。</p>
          <p class="hint">开发时可在 ai-system 目录启动 UI 服务（默认 http://localhost:5173）</p>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'AiAssistant',
  data() {
    return {
      aiAssistantUrl: process.env.VUE_APP_AI_ASSISTANT_URL || 'http://localhost:5173',
      messageHandler: null
    }
  },
  mounted() {
    this.messageHandler = (event) => {
      if (event.data && event.data.type === 'ready') {
        const user = this.$store.getters.name || this.$store.getters.id || 'guest'
        this.$refs.aiFrame?.contentWindow?.postMessage({ type: 'set-user', user }, '*')
      }
    }
    window.addEventListener('message', this.messageHandler)
  },
  beforeDestroy() {
    if (this.messageHandler) {
      window.removeEventListener('message', this.messageHandler)
    }
  }
}
</script>

<style lang="scss" scoped>
.ai-assistant-container {
  padding: 0;
}
.ai-card {
  .card-header {
    font-weight: 600;
    font-size: 16px;
  }
  ::v-deep .el-card__body {
    padding: 0;
    height: calc(100vh - 180px);
    min-height: 400px;
  }
}
.iframe-wrap {
  width: 100%;
  height: 100%;
  min-height: 400px;
}
.ai-iframe {
  width: 100%;
  height: calc(100vh - 180px);
  min-height: 400px;
  display: block;
  border: none;
}
.ai-placeholder {
  padding: 40px 20px;
  text-align: center;
  color: #909399;
  .hint {
    margin-top: 12px;
    font-size: 12px;
  }
}
</style>
