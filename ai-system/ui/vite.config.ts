import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  optimizeDeps: {
    // Node 22 + Vite 下很多依赖是 CJS，直接按 ESM 加载会报 "does not provide an export named 'default'"。
    // 统一预打包后由 esbuild 转成 ESM，避免逐个报错。
    include: [
      'react-is',
      'is-mobile',
      'json2mq',
      'dayjs',
      'dayjs/plugin/advancedFormat',
      'dayjs/plugin/customParseFormat',
      'dayjs/plugin/weekday',
      'dayjs/plugin/localeData',
      'dayjs/plugin/weekOfYear',
      'dayjs/plugin/weekYear',
      // antd 生态：预打包后 CJS 正确转 ESM（需配合 .npmrc 的 node-linker=hoisted）
      'antd',
      '@ant-design/icons',
      '@ant-design/cssinjs',
      '@ant-design/cssinjs-utils',
      '@ant-design/colors',
      '@ant-design/fast-color',
    ],
  },
})
