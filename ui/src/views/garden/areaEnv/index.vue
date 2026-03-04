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
              v-hasPermi="['garden:plant:edit']"
            >从植物档案关联</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="danger"
              plain
              icon="el-icon-delete"
              size="mini"
              :disabled="multiple || !currentAreaId"
              @click="handleUnbind"
              v-hasPermi="['garden:plant:edit']"
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
          <el-form-item label="植物名称" prop="plantName">
            <el-input
              v-model="queryParams.plantName"
              placeholder="请输入植物名称"
              clearable
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="健康状态" prop="healthStatus">
            <el-select v-model="queryParams.healthStatus" placeholder="健康状态" clearable>
              <el-option v-for="opt in healthStatusOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-table v-loading="loading" :data="plantList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="55" align="center" />
          <el-table-column label="植物名称" align="center" prop="plantName" min-width="140" />
          <el-table-column label="植物编号" align="center" prop="plantCode" min-width="120" />
          <el-table-column label="品种/学名" align="center" prop="species" min-width="140" />
          <el-table-column label="树龄(年)" align="center" prop="ageYears" width="90" />
          <el-table-column label="高度(cm)" align="center" prop="heightCm" width="90" />
          <el-table-column label="健康状态" align="center" prop="healthStatus" width="100">
            <template slot-scope="scope">
              <span>{{ healthStatusLabel(scope.row.healthStatus) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="状态" align="center" prop="status" width="90">
            <template slot-scope="scope">
              <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status"/>
            </template>
          </el-table-column>
          <el-table-column label="创建时间" align="center" prop="createTime" width="180">
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
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

        <!-- 从植物档案选择未关联植物，关联到当前区域 -->
        <el-dialog :title="selectTitle" :visible.sync="selectOpen" width="800px" append-to-body>
          <el-form :model="selectQuery" ref="selectForm" size="small" :inline="true" label-width="68px">
            <el-form-item label="植物名称" prop="plantName">
              <el-input
                v-model="selectQuery.plantName"
                placeholder="请输入植物名称"
                clearable
                @keyup.enter.native="getSelectList"
              />
            </el-form-item>
            <el-form-item label="健康状态" prop="healthStatus">
              <el-select v-model="selectQuery.healthStatus" placeholder="健康状态" clearable>
                <el-option v-for="opt in healthStatusOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
              </el-select>
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
            <el-table-column label="植物名称" align="center" prop="plantName" min-width="140" />
            <el-table-column label="植物编号" align="center" prop="plantCode" min-width="120" />
            <el-table-column label="品种/学名" align="center" prop="species" min-width="140" />
            <el-table-column label="健康状态" align="center" prop="healthStatus" width="100">
              <template slot-scope="scope">
                <span>{{ healthStatusLabel(scope.row.healthStatus) }}</span>
              </template>
            </el-table-column>
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
import { listPlant, updatePlant } from "@/api/garden/plant"

export default {
  name: "GardenAreaEnv",
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
      plantList: [],
      ids: [],
      single: true,
      multiple: true,
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        plantName: undefined,
        healthStatus: undefined
      },
      healthStatusOptions: [
        { value: "0", label: "良好" },
        { value: "1", label: "一般" },
        { value: "2", label: "较差" }
      ],
      // 选择植物档案对话框
      selectOpen: false,
      selectTitle: "选择植物档案",
      selectLoading: false,
      selectList: [],
      selectIds: [],
      selectQuery: {
        plantName: undefined,
        healthStatus: undefined
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
        // 复用 handleTree 将平铺区域转树（来自 mixin）
        this.areaTree = this.handleTree(list, "areaId")
      })
    },
    handleAreaClick(node) {
      this.currentAreaId = node.id
      this.currentAreaName = node.label
      this.handleQuery()
    },
    healthStatusLabel(val) {
      const hit = this.healthStatusOptions.find(x => x.value === (val == null ? "" : String(val)))
      return hit ? hit.label : "-"
    },
    getList() {
      if (!this.currentAreaId) {
        this.plantList = []
        this.total = 0
        return
      }
      this.loading = true
      const params = {
        ...this.queryParams,
        areaId: this.currentAreaId
      }
      listPlant(params).then(res => {
        this.plantList = res.rows || []
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
      this.ids = selection.map(item => item.plantId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    openSelect() {
      if (!this.currentAreaId) {
        this.$modal.msgWarning("请先选择左侧区域")
        return
      }
      this.selectOpen = true
      this.selectTitle = "选择植物档案关联到当前区域"
      this.selectIds = []
      this.getSelectList()
    },
    getSelectList() {
      this.selectLoading = true
      listPlant({
        pageNum: 1,
        pageSize: 1000,
        plantName: this.selectQuery.plantName,
        healthStatus: this.selectQuery.healthStatus
      }).then(res => {
        const rows = res.rows || []
        // 只显示尚未分配区域的植物档案
        this.selectList = rows.filter(p => !p.areaId)
        this.selectLoading = false
      })
    },
    resetSelectQuery() {
      this.selectQuery = {
        plantName: undefined,
        healthStatus: undefined
      }
      this.getSelectList()
    },
    handleSelectChange(selection) {
      this.selectIds = selection.map(item => item.plantId)
    },
    confirmSelect() {
      if (!this.selectIds.length || !this.currentAreaId) {
        return
      }
      this.$modal.confirm("是否将选中的植物关联到当前区域？").then(() => {
        const requests = this.selectIds.map(id => {
          const row = this.selectList.find(p => p.plantId === id)
          return updatePlant({ ...row, areaId: this.currentAreaId })
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
      this.$modal.confirm("是否将选中的植物移出当前区域？").then(() => {
        const requests = this.ids.map(id => {
          const row = this.plantList.find(p => p.plantId === id)
          return updatePlant({ ...row, areaId: null })
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

