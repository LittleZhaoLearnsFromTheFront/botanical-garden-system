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
      <el-table-column label="当前使用次数" align="center" prop="usageCount" width="120">
        <template slot-scope="scope">
          <span>{{ scope.row.usageCount == null ? 0 : scope.row.usageCount }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="160">
        <template slot-scope="scope">
          <el-button
            type="text"
            size="mini"
            icon="el-icon-edit"
            @click="openEdit(scope.row)"
            v-hasPermi="['garden:device:edit']"
          >设置使用次数</el-button>
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

    <el-dialog :title="'设置使用次数 - ' + (editRow.deviceName || '')" :visible.sync="open" width="400px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="使用次数" prop="usageCount">
          <el-input-number v-model="form.usageCount" :min="0" :max="999999" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listDevice, updateDevice } from "@/api/garden/device"

export default {
  name: "GardenDeviceUsageConfig",
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
      },
      open: false,
      editRow: {},
      form: {
        deviceId: undefined,
        usageCount: 0
      },
      rules: {
        usageCount: [
          { required: true, message: "使用次数不能为空", trigger: "change" }
        ]
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
    },
    openEdit(row) {
      this.editRow = row || {}
      this.form = {
        deviceId: row.deviceId,
        usageCount: row.usageCount == null ? 0 : row.usageCount
      }
      this.open = true
    },
    cancel() {
      this.open = false
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        const payload = {
          deviceId: this.form.deviceId,
          usageCount: this.form.usageCount
        }
        updateDevice(payload).then(() => {
          this.$message.success("设置成功")
          this.open = false
          this.getList()
        })
      })
    }
  }
}
</script>

