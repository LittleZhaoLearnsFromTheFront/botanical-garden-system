<template>
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="6" :xs="24">
        <div class="head-container">
          <el-input
            v-model="areaName"
            placeholder="请输入区域名称"
            clearable
            size="small"
            prefix-icon="el-icon-search"
            style="margin-bottom: 10px"
            @keyup.enter.native="handleAreaQuery"
          />
        </div>
        <el-tree
          :data="areaTree"
          :props="defaultProps"
          node-key="id"
          highlight-current
          @node-click="handleAreaClick"
          class="area-tree"
        />
      </el-col>
      <el-col :span="18" :xs="24">
        <div class="head-container">
          <span v-if="currentAreaName">当前区域：{{ currentAreaName }}</span>
          <span v-else>请选择左侧区域</span>
        </div>

        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
              type="primary"
              plain
              icon="el-icon-plus"
              size="mini"
              :disabled="!currentAreaId"
              @click="openSelect"
              v-hasPermi="['garden:device:edit']"
            >从设备档案关联</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="danger"
              plain
              icon="el-icon-delete"
              size="mini"
              :disabled="multiple || !currentAreaId"
              @click="handleUnbind"
              v-hasPermi="['garden:device:edit']"
            >移出本区域</el-button>
          </el-col>
          <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <el-form
          v-show="showSearch"
          ref="queryForm"
          :model="queryParams"
          size="small"
          :inline="true"
          label-width="68px"
        >
          <el-form-item label="设备名称" prop="deviceName">
            <el-input
              v-model="queryParams.deviceName"
              placeholder="请输入设备名称"
              clearable
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="设备类型" prop="deviceType">
            <el-input
              v-model="queryParams.deviceType"
              placeholder="请输入设备类型"
              clearable
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-table v-loading="loading" :data="deviceList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="55" align="center" />
          <el-table-column label="设备名称" align="center" prop="deviceName" min-width="140" />
          <el-table-column label="设备编号" align="center" prop="deviceCode" min-width="120" />
          <el-table-column label="设备类型" align="center" prop="deviceType" min-width="120" />
          <el-table-column label="生产厂家" align="center" prop="manufacturer" min-width="140" />
          <el-table-column label="安装日期" align="center" prop="installDate" width="120">
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.installDate, '{y}-{m}-{d}') }}</span>
            </template>
          </el-table-column>
          <el-table-column label="状态" align="center" prop="status" width="90">
            <template slot-scope="scope">
              <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status"/>
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

        <!-- 从设备档案选择未关联设备，关联到当前区域 -->
        <el-dialog :title="selectTitle" :visible.sync="selectOpen" width="800px" append-to-body>
          <el-form :model="selectQuery" ref="selectForm" size="small" :inline="true" label-width="68px">
            <el-form-item label="设备名称" prop="deviceName">
              <el-input
                v-model="selectQuery.deviceName"
                placeholder="请输入设备名称"
                clearable
                @keyup.enter.native="getSelectList"
              />
            </el-form-item>
            <el-form-item label="设备类型" prop="deviceType">
              <el-input
                v-model="selectQuery.deviceType"
                placeholder="请输入设备类型"
                clearable
                @keyup.enter.native="getSelectList"
              />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="el-icon-search" size="mini" @click="getSelectList">搜索</el-button>
              <el-button icon="el-icon-refresh" size="mini" @click="resetSelectQuery">重置</el-button>
            </el-form-item>
          </el-form>
          <el-table
            v-loading="selectLoading"
            :data="selectList"
            @selection-change="handleSelectChange"
            style="margin-top: 10px"
          >
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column label="设备名称" align="center" prop="deviceName" min-width="140" />
            <el-table-column label="设备编号" align="center" prop="deviceCode" min-width="120" />
            <el-table-column label="设备类型" align="center" prop="deviceType" min-width="120" />
            <el-table-column label="生产厂家" align="center" prop="manufacturer" min-width="140" />
          </el-table>
          <div slot="footer" class="dialog-footer">
            <el-button type="primary" :disabled="!selectIds.length" @click="confirmSelect">确 定</el-button>
            <el-button @click="selectOpen = false">取 消</el-button>
          </div>
        </el-dialog>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { listArea, treeselectArea } from "@/api/garden/area"
import { listDevice, updateDevice } from "@/api/garden/device"

export default {
  name: "GardenAreaResource",
  dicts: ['sys_normal_disable'],
  data() {
    return {
      loading: false,
      showSearch: true,
      areaName: "",
      areaTree: [],
      defaultProps: { children: "children", label: "label" },
      currentAreaId: null,
      currentAreaName: "",
      deviceList: [],
      ids: [],
      single: true,
      multiple: true,
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        deviceName: undefined,
        deviceType: undefined
      },
      // 选择设备对话框
      selectOpen: false,
      selectTitle: "选择设备档案",
      selectLoading: false,
      selectList: [],
      selectIds: [],
      selectQuery: {
        deviceName: undefined,
        deviceType: undefined
      }
    }
  },
  created() {
    this.getAreaTree()
  },
  methods: {
    getAreaTree() {
      this.loading = true
      treeselectArea().then(res => {
        this.areaTree = res.data || []
        this.loading = false
      })
    },
    handleAreaQuery() {
      listArea({ areaName: this.areaName }).then(res => {
        const list = res.data || []
        this.areaTree = this.handleTree(list, "areaId")
      })
    },
    handleAreaClick(node) {
      this.currentAreaId = node.id
      this.currentAreaName = node.label
      this.handleQuery()
    },
    getList() {
      if (!this.currentAreaId) {
        this.deviceList = []
        this.total = 0
        return
      }
      this.loading = true
      const params = {
        ...this.queryParams,
        areaId: this.currentAreaId
      }
      listDevice(params).then(res => {
        this.deviceList = res.rows || []
        this.total = res.total || 0
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
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.deviceId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    openSelect() {
      if (!this.currentAreaId) {
        this.$modal.msgWarning("请先选择左侧区域")
        return
      }
      this.selectOpen = true
      this.selectTitle = "选择设备档案关联到当前区域"
      this.selectIds = []
      this.getSelectList()
    },
    getSelectList() {
      this.selectLoading = true
      listDevice({
        pageNum: 1,
        pageSize: 1000,
        deviceName: this.selectQuery.deviceName,
        deviceType: this.selectQuery.deviceType
      }).then(res => {
        const rows = res.rows || []
        // 只显示尚未分配区域的设备档案
        this.selectList = rows.filter(d => !d.areaId)
        this.selectLoading = false
      })
    },
    resetSelectQuery() {
      this.selectQuery = {
        deviceName: undefined,
        deviceType: undefined
      }
      this.getSelectList()
    },
    handleSelectChange(selection) {
      this.selectIds = selection.map(item => item.deviceId)
    },
    confirmSelect() {
      if (!this.selectIds.length || !this.currentAreaId) {
        return
      }
      this.$modal.confirm("是否将选中的设备关联到当前区域？").then(() => {
        const requests = this.selectIds.map(id => {
          const row = this.selectList.find(d => d.deviceId === id)
          return updateDevice({ ...row, areaId: this.currentAreaId })
        })
        return Promise.all(requests)
      }).then(() => {
        this.$modal.msgSuccess("关联成功")
        this.selectOpen = false
        this.getList()
      }).catch(() => {})
    },
    handleUnbind() {
      if (!this.currentAreaId || !this.ids.length) {
        return
      }
      this.$modal.confirm("是否将选中的设备移出当前区域？").then(() => {
        const requests = this.ids.map(id => {
          const row = this.deviceList.find(p => p.deviceId === id)
          return updateDevice({ ...row, areaId: null })
        })
        return Promise.all(requests)
      }).then(() => {
        this.$modal.msgSuccess("操作成功")
        this.getList()
      }).catch(() => {})
    }
  }
}
</script>

<style scoped>
.area-tree {
  border: 1px solid #ebeef5;
  padding: 10px;
  border-radius: 4px;
}
</style>

