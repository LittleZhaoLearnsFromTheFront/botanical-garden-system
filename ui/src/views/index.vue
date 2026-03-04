<template>
  <div class="app-container home">
    <el-card class="home-card">
      <div class="title">保定植物园园林管理系统</div>
      <div class="subtitle">基于 Spring Boot + Vue 的园林管理平台</div>

      <el-divider />

      <!-- 数据统计管理 -->
      <h3 class="stat-title">数据统计管理</h3>
      <el-row :gutter="20" class="stat-row">
        <el-col :xs="24" :md="12">
          <el-card shadow="hover" class="chart-card">
            <div slot="header" class="chart-header">
              <span>基础数据统计</span>
            </div>
            <div ref="basicChartRef" class="chart" style="height: 320px;" />
          </el-card>
        </el-col>
        <el-col :xs="24" :md="12">
          <el-card shadow="hover" class="chart-card">
            <div slot="header" class="chart-header">
              <span>任务数据统计</span>
            </div>
            <div ref="taskChartRef" class="chart" style="height: 320px;" />
          </el-card>
        </el-col>
      </el-row>

      <el-divider />

      <div class="meta">
        <span><b>当前版本：</b>v{{ version }}</span>
      </div>
    </el-card>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import { getBasicStatistics, getTaskStatistics } from '@/api/garden/statistics'

export default {
  name: "Index",
  data() {
    return {
      version: "1.0.0",
      basicChart: null,
      taskChart: null
    }
  },
  mounted() {
    this.fetchAndDrawCharts()
    window.addEventListener('resize', this.handleResize)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.handleResize)
    if (this.basicChart) {
      this.basicChart.dispose()
      this.basicChart = null
    }
    if (this.taskChart) {
      this.taskChart.dispose()
      this.taskChart = null
    }
  },
  methods: {
    handleResize() {
      this.basicChart && this.basicChart.resize()
      this.taskChart && this.taskChart.resize()
    },
    fetchAndDrawCharts() {
      Promise.all([getBasicStatistics(), getTaskStatistics()]).then(([basicRes, taskRes]) => {
        const basic = (basicRes && basicRes.data) ? basicRes.data : basicRes || {}
        const task = (taskRes && taskRes.data) ? taskRes.data : taskRes || {}
        this.$nextTick(() => {
          this.drawBasicChart(basic)
          this.drawTaskChart(task)
        })
      }).catch(() => {
        this.$message.warning('数据统计接口暂不可用，请确认后端已重新编译并重启（GardenApplication）后再刷新页面')
        this.$nextTick(() => {
          this.drawBasicChart({})
          this.drawTaskChart({})
        })
      })
    },
    drawBasicChart(data) {
      if (!this.$refs.basicChartRef) return
      if (this.basicChart) this.basicChart.dispose()
      this.basicChart = echarts.init(this.$refs.basicChartRef)
      const xData = ['区域', '植物', '设备', '纪念品']
      const yData = [
        data.areaCount || 0,
        data.plantCount || 0,
        data.deviceCount || 0,
        data.souvenirCount || 0
      ]
      this.basicChart.setOption({
        tooltip: { trigger: 'axis' },
        grid: { top: 20, left: 40, right: 20, bottom: 30, containLabel: true },
        xAxis: {
          type: 'category',
          data: xData,
          axisTick: { alignWithLabel: true }
        },
        yAxis: { type: 'value', axisTick: { show: false } },
        series: [{
          name: '数量',
          type: 'bar',
          barWidth: '50%',
          data: yData,
          itemStyle: {
            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
              { offset: 0, color: '#67c23a' },
              { offset: 1, color: '#95d475' }
            ])
          }
        }]
      })
    },
    drawTaskChart(data) {
      if (!this.$refs.taskChartRef) return
      if (this.taskChart) this.taskChart.dispose()
      this.taskChart = echarts.init(this.$refs.taskChartRef)
      const pieData = [
        { value: data.pending || 0, name: '待执行' },
        { value: data.doing || 0, name: '执行中' },
        { value: data.done || 0, name: '已完成' },
        { value: data.cancelled || 0, name: '已取消' }
      ]
      this.taskChart.setOption({
        tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
        legend: { left: 'center', bottom: 10, data: ['待执行', '执行中', '已完成', '已取消'] },
        series: [{
          name: '工单状态',
          type: 'pie',
          radius: ['40%', '70%'],
          center: ['50%', '45%'],
          avoidLabelOverlap: true,
          itemStyle: {
            borderRadius: 6,
            borderColor: '#fff',
            borderWidth: 2
          },
          label: { show: true, formatter: '{b}: {c}' },
          data: pieData,
          color: ['#909399', '#e6a23c', '#67c23a', '#f56c6c']
        }]
      })
    }
  }
}
</script>

<style scoped lang="scss">
.home-card {
  .title {
    font-size: 22px;
    font-weight: 700;
    line-height: 1.2;
  }

  .subtitle {
    margin-top: 6px;
    color: #606266;
  }

  .stat-title {
    margin: 0 0 16px 0;
    font-size: 16px;
  }

  .stat-row {
    margin-bottom: 8px;
  }

  .chart-card {
    margin-bottom: 20px;
  }

  .chart-header {
    font-weight: 600;
  }

  .chart {
    width: 100%;
  }

  .meta {
    display: flex;
    justify-content: flex-end;
    color: #909399;
  }
}
</style>
