<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="设备名称" prop="deviceName">
        <el-input
          v-model="queryParams.deviceName"
          placeholder="请输入设备名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="执行人" prop="executorName">
        <el-input
          v-model="queryParams.executorName"
          placeholder="请输入执行人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="logList">
      <el-table-column label="设备名称" align="center" prop="deviceName" min-width="140" />
      <el-table-column label="工单标题" align="center" prop="title" min-width="180" />
      <el-table-column label="任务类型" align="center" prop="taskType" min-width="120">
        <template slot-scope="scope">
          <span>{{ taskTypeLabel(scope.row.taskType) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="执行人" align="center" prop="executorName" width="120" />
      <el-table-column label="开始时间" align="center" prop="startTime" width="170">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.startTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="完成时间" align="center" prop="finishTime" width="170">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.finishTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="维护内容" align="center" prop="content" min-width="200" show-overflow-tooltip />
      <el-table-column label="执行结果" align="center" prop="resultDesc" min-width="200" show-overflow-tooltip />
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script>
import { listDeviceLog } from "@/api/garden/deviceLog"

export default {
  name: "GardenDeviceLog",
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      logList: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        deviceName: undefined,
        executorName: undefined
      },
      // 任务类型枚举（与工单页面保持一致）
      taskTypeOptions: [
        { value: "CLEANING", label: "区域清理" },
        { value: "PATROL", label: "巡查" },
        { value: "WATERING", label: "浇水" },
        { value: "PRUNING", label: "修剪" },
        { value: "FERTILIZE", label: "施肥" },
        { value: "PEST_CONTROL", label: "病虫害处理" },
        { value: "INSPECTION", label: "设备巡检" },
        { value: "MAINTAIN", label: "维护保养" },
        { value: "REPAIR", label: "维修" },
        { value: "OTHER", label: "其他" }
      ]
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listDeviceLog(this.queryParams).then(res => {
        const data = res.rows || res.data || []
        this.logList = data
        this.total = res.total || data.length || 0
        this.loading = false
      })
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 将编码任务类型转换为中文名称
    taskTypeLabel(val) {
      const hit = this.taskTypeOptions.find(x => x.value === val)
      return hit ? hit.label : (val || "-")
    }
  }
}
</script>

