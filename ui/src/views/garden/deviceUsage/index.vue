<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="设备名称" prop="deviceName">
        <el-input
          v-model="queryParams.deviceName"
          placeholder="请输入设备名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="设备类型" prop="deviceType">
        <el-select v-model="queryParams.deviceType" placeholder="请选择设备类型" clearable>
          <el-option
            v-for="dict in dict.type.garden_device_type"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="deviceList">
      <el-table-column label="设备名称" align="center" prop="deviceName" min-width="140" />
      <el-table-column label="设备编号" align="center" prop="deviceCode" min-width="120" />
      <el-table-column label="设备类型" align="center" prop="deviceType" min-width="120">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.garden_device_type" :value="scope.row.deviceType"/>
        </template>
      </el-table-column>
      <el-table-column label="所属区域" align="center" prop="areaName" min-width="140" />
      <el-table-column label="使用次数" align="center" prop="usageCount" width="100">
        <template slot-scope="scope">
          <span>{{ scope.row.usageCount == null ? 0 : scope.row.usageCount }}</span>
        </template>
      </el-table-column>
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
import { listDevice } from "@/api/garden/device"

export default {
  name: "GardenDeviceUsage",
  dicts: ['garden_device_type'],
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      deviceList: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        deviceName: undefined,
        deviceType: undefined
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listDevice(this.queryParams).then(res => {
        this.deviceList = res.rows || res.data || []
        this.total = res.total || this.deviceList.length || 0
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
    }
  }
}
</script>

