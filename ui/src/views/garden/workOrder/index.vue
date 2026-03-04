<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="状态" clearable>
          <el-option v-for="opt in statusOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="任务类型" prop="taskType">
        <el-select v-model="queryParams.taskType" placeholder="任务类型" clearable>
          <el-option v-for="opt in taskTypeOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
        </el-select>
      </el-form-item>
      <el-form-item v-if="!isMyPage" label="执行人" prop="executorId">
        <el-select v-model="queryParams.executorId" placeholder="执行人" clearable filterable>
          <el-option v-for="u in userOptions" :key="u.userId" :label="u.nickName" :value="u.userId" />
        </el-select>
      </el-form-item>
      <el-form-item v-if="!isMyPage">
        <el-checkbox v-model="onlyMine" @change="toggleOnlyMine">只看我的</el-checkbox>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <template v-if="!isMyPage">
        <el-col :span="1.5">
          <el-button
            type="primary"
            plain
            icon="el-icon-plus"
            size="mini"
            @click="handleAdd"
            v-hasPermi="['garden:workOrder:add']"
          >新增</el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
            type="success"
            plain
            icon="el-icon-edit"
            size="mini"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['garden:workOrder:edit']"
          >修改</el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
            type="danger"
            plain
            icon="el-icon-delete"
            size="mini"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['garden:workOrder:remove']"
          >删除</el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
            type="warning"
            plain
            icon="el-icon-download"
            size="mini"
            @click="handleExport"
            v-hasPermi="['garden:workOrder:export']"
          >导出</el-button>
        </el-col>
      </template>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="workOrderList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="标题" align="center" prop="title" min-width="180" />
      <el-table-column label="任务类型" align="center" prop="taskType" width="120">
        <template slot-scope="scope">
          <span>{{ taskTypeLabel(scope.row.taskType) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="目标类型" align="center" prop="targetType" width="100">
        <template slot-scope="scope">
          <span>{{ targetTypeLabel(scope.row.targetType) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="目标" align="center" min-width="160">
        <template slot-scope="scope">
          <span>{{ targetName(scope.row) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="执行人" align="center" prop="executorName" width="120" />
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template slot-scope="scope">
          <el-tag :type="statusTagType(scope.row.status)">{{ statusLabel(scope.row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="计划时间" align="center" prop="planTime" width="170">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.planTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="截止时间" align="center" prop="deadline" width="170">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.deadline) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="300">
        <template slot-scope="scope">
          <el-button
            v-if="!isMyPage"
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['garden:workOrder:edit']"
          >修改</el-button>
          <el-button
            v-if="!isMyPage"
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['garden:workOrder:remove']"
          >删除</el-button>
          <el-button
            v-if="scope.row.status === '0'"
            size="mini"
            type="text"
            icon="el-icon-circle-check"
            @click="acceptWorkOrder(scope.row)"
            v-hasPermi="['garden:workOrder:execute']"
          >接单</el-button>
          <el-button
            v-if="scope.row.status === '1'"
            size="mini"
            type="text"
            icon="el-icon-finished"
            @click="finishWorkOrder(scope.row)"
            v-hasPermi="['garden:workOrder:execute']"
          >完成</el-button>
          <el-button
            v-if="scope.row.status === '0' || scope.row.status === '1'"
            size="mini"
            type="text"
            icon="el-icon-close"
            @click="cancelWorkOrder(scope.row)"
            v-hasPermi="['garden:workOrder:execute']"
          >取消</el-button>
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

    <el-dialog :title="title" :visible.sync="open" width="750px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入标题" />
        </el-form-item>
        <el-row>
          <el-col :span="12">
        <el-form-item label="任务类型" prop="taskType">
          <el-select v-model="form.taskType" placeholder="任务类型" clearable>
            <el-option v-for="opt in currentTaskTypeOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="优先级" prop="priority">
              <el-radio-group v-model="form.priority">
                <el-radio label="0">低</el-radio>
                <el-radio label="1">中</el-radio>
                <el-radio label="2">高</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="目标类型" prop="targetType">
              <el-radio-group v-model="form.targetType" @change="onTargetTypeChange">
                <el-radio label="0">区域</el-radio>
                <el-radio label="1">植物</el-radio>
                <el-radio label="2">设备</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="执行人" prop="executorId">
              <el-select v-model="form.executorId" placeholder="选择执行人" filterable clearable>
                <el-option v-for="u in userOptions" :key="u.userId" :label="u.nickName" :value="u.userId" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item v-if="form.targetType === '0'" label="关联区域" prop="areaId">
          <treeselect v-model="form.areaId" :options="areaOptions" :normalizer="normalizer" placeholder="选择区域" />
        </el-form-item>
        <el-form-item v-if="form.targetType === '1'" label="关联植物" prop="plantId">
          <el-select v-model="form.plantId" placeholder="选择植物" filterable clearable style="width: 100%">
            <el-option v-for="p in plantOptions" :key="p.plantId" :label="p.plantName" :value="p.plantId" />
          </el-select>
        </el-form-item>
        <el-form-item v-if="form.targetType === '2'" label="关联设备" prop="deviceId">
          <el-select v-model="form.deviceId" placeholder="选择设备" filterable clearable style="width: 100%">
            <el-option v-for="d in deviceOptions" :key="d.deviceId" :label="d.deviceName" :value="d.deviceId" />
          </el-select>
        </el-form-item>

        <el-row>
          <el-col :span="12">
            <el-form-item label="计划时间" prop="planTime">
              <el-date-picker
                v-model="form.planTime"
                type="datetime"
                value-format="yyyy-MM-dd HH:mm:ss"
                placeholder="选择计划时间"
                clearable
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="截止时间" prop="deadline">
              <el-date-picker
                v-model="form.deadline"
                type="datetime"
                value-format="yyyy-MM-dd HH:mm:ss"
                placeholder="选择截止时间"
                clearable
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="任务内容" prop="content">
          <el-input v-model="form.content" type="textarea" placeholder="请输入任务内容" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注" />
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
import { listWorkOrder, getWorkOrder, delWorkOrder, addWorkOrder, updateWorkOrder, changeWorkOrderStatus } from "@/api/garden/workOrder"
import { treeselectArea } from "@/api/garden/area"
import { listPlant } from "@/api/garden/plant"
import { listDevice } from "@/api/garden/device"
import { listUser } from "@/api/system/user"
import Treeselect from "@riophae/vue-treeselect"
import "@riophae/vue-treeselect/dist/vue-treeselect.css"

export default {
  name: "GardenWorkOrder",
  components: { Treeselect },
  data() {
    return {
      // 是否“我的工单”页面（根据路由判断）
      isMyPage: false,
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      onlyMine: false,
      workOrderList: [],
      userOptions: [],
      areaOptions: [],
      plantOptions: [],
      deviceOptions: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        title: undefined,
        status: undefined,
        taskType: undefined,
        executorId: undefined
      },
      form: {},
      // 不同目标类型下的任务类型选项
      taskTypeOptionsArea: [
        { value: "CLEANING", label: "区域清理" },
        { value: "PATROL", label: "巡查" },
        { value: "OTHER", label: "其他" }
      ],
      taskTypeOptionsPlant: [
        { value: "WATERING", label: "浇水" },
        { value: "PRUNING", label: "修剪" },
        { value: "FERTILIZE", label: "施肥" },
        { value: "PEST_CONTROL", label: "病虫害处理" },
        { value: "OTHER", label: "其他" }
      ],
      taskTypeOptionsDevice: [
        { value: "INSPECTION", label: "设备巡检" },
        { value: "MAINTAIN", label: "维护保养" },
        { value: "REPAIR", label: "维修" },
        { value: "OTHER", label: "其他" }
      ],
      statusOptions: [
        { value: "0", label: "待执行" },
        { value: "1", label: "执行中" },
        { value: "2", label: "已完成" },
        { value: "3", label: "已取消" }
      ],
      rules: {
        title: [
          { required: true, message: "标题不能为空", trigger: "blur" }
        ],
        taskType: [
          { required: true, message: "任务类型不能为空", trigger: "change" }
        ],
        targetType: [
          { required: true, message: "目标类型不能为空", trigger: "change" }
        ],
        executorId: [
          { required: true, message: "执行人不能为空", trigger: "change" }
        ],
        // 计划时间必填
        planTime: [
          { required: true, message: "计划时间不能为空", trigger: "change" }
        ],
        // 任务内容必填
        content: [
          { required: true, message: "任务内容不能为空", trigger: "blur" }
        ],
        // 目标类型为区域时，关联区域必填
        areaId: [
          {
            validator: (rule, value, callback) => {
              if (this.form.targetType === '0' && !value) {
                callback(new Error("关联区域不能为空"))
              } else {
                callback()
              }
            },
            trigger: "change"
          }
        ]
      }
    }
  },
  created() {
    // 根据路由 path 判断是否是“我的工单”菜单
    const path = this.$route.path || ""
    this.isMyPage = path.includes("/order/myWork") || path.endsWith("/myWork")

    this.getUsers()
    this.getAreas()
    this.getTargets()

    // 我的工单：默认只看自己的工单
    if (this.isMyPage) {
      this.onlyMine = true
      this.queryParams.executorId = this.$store.getters.id
    }

    this.getList()
  },
  computed: {
    // 根据当前目标类型返回对应的任务类型选项
    currentTaskTypeOptions() {
      const t = this.form.targetType == null ? "0" : String(this.form.targetType)
      if (t === "1") return this.taskTypeOptionsPlant
      if (t === "2") return this.taskTypeOptionsDevice
      return this.taskTypeOptionsArea
    }
  },
  methods: {
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children
      }
      return {
        id: node.id,
        label: node.label,
        children: node.children
      }
    },
    getUsers() {
      listUser({ pageNum: 1, pageSize: 1000, status: "0" }).then(res => {
        this.userOptions = res.rows || []
      })
    },
    getAreas() {
      treeselectArea().then(res => {
        this.areaOptions = res.data
      })
    },
    getTargets() {
      listPlant({ pageNum: 1, pageSize: 10000, status: "0" }).then(res => {
        this.plantOptions = res.rows || []
      })
      listDevice({ pageNum: 1, pageSize: 10000, status: "0" }).then(res => {
        this.deviceOptions = res.rows || []
      })
    },
    getList() {
      this.loading = true
      listWorkOrder(this.queryParams).then(response => {
        this.workOrderList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    taskTypeLabel(val) {
      const all = [
        ...this.taskTypeOptionsArea,
        ...this.taskTypeOptionsPlant,
        ...this.taskTypeOptionsDevice
      ]
      const hit = all.find(x => x.value === val)
      return hit ? hit.label : (val || "-")
    },
    targetTypeLabel(val) {
      const v = val == null ? "" : String(val)
      if (v === "0") return "区域"
      if (v === "1") return "植物"
      if (v === "2") return "设备"
      return "-"
    },
    targetName(row) {
      const t = row.targetType == null ? "" : String(row.targetType)
      if (t === "0") return row.areaName || "-"
      if (t === "1") return row.plantName || "-"
      if (t === "2") return row.deviceName || "-"
      return "-"
    },
    statusLabel(val) {
      const hit = this.statusOptions.find(x => x.value === (val == null ? "" : String(val)))
      return hit ? hit.label : "-"
    },
    statusTagType(val) {
      const v = val == null ? "" : String(val)
      if (v === "0") return "info"
      if (v === "1") return "warning"
      if (v === "2") return "success"
      if (v === "3") return "danger"
      return "info"
    },
    toggleOnlyMine() {
      if (this.onlyMine) {
        this.queryParams.executorId = this.$store.getters.id
      } else {
        this.queryParams.executorId = undefined
      }
      this.handleQuery()
    },
    cancel() {
      this.open = false
      this.reset()
    },
    reset() {
      this.form = {
        workOrderId: undefined,
        title: undefined,
        taskType: undefined,
        targetType: "0",
        areaId: undefined,
        plantId: undefined,
        deviceId: undefined,
        content: undefined,
        priority: "1",
        planTime: undefined,
        deadline: undefined,
        executorId: undefined,
        remark: undefined
      }
      this.resetForm("form")
    },
    onTargetTypeChange() {
      this.form.areaId = undefined
      this.form.plantId = undefined
      this.form.deviceId = undefined
      // 切换目标类型时，重置任务类型，避免不匹配
      this.form.taskType = undefined
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm("queryForm")
      this.onlyMine = false
      this.queryParams.executorId = undefined
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.workOrderId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "新增工单任务"
    },
    handleUpdate(row) {
      this.reset()
      const workOrderId = row && row.workOrderId ? row.workOrderId : this.ids[0]
      getWorkOrder(workOrderId).then(res => {
        this.form = {
          ...this.form,
          ...res.data,
          targetType: res.data.targetType == null ? "0" : String(res.data.targetType)
        }
        this.open = true
        this.title = "修改工单任务"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        const payload = { ...this.form }
        if (payload.targetType === "0") {
          payload.plantId = null
          payload.deviceId = null
        } else if (payload.targetType === "1") {
          payload.areaId = null
          payload.deviceId = null
        } else if (payload.targetType === "2") {
          payload.areaId = null
          payload.plantId = null
        }
        if (payload.workOrderId != undefined) {
          updateWorkOrder(payload).then(() => {
            this.$modal.msgSuccess("修改成功")
            this.open = false
            this.getList()
          })
        } else {
          addWorkOrder(payload).then(() => {
            this.$modal.msgSuccess("新增成功")
            this.open = false
            this.getList()
          })
        }
      })
    },
    handleDelete(row) {
      const workOrderIds = row && row.workOrderId ? [row.workOrderId] : this.ids
      this.$modal.confirm('是否确认删除选中的工单任务？').then(() => {
        return delWorkOrder(workOrderIds.join(","))
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    acceptWorkOrder(row) {
      this.$modal.confirm(`是否接单：${row.title}？`).then(() => {
        return changeWorkOrderStatus({ workOrderId: row.workOrderId, status: "1" })
      }).then(() => {
        this.$modal.msgSuccess("接单成功")
        this.getList()
      }).catch(() => {})
    },
    finishWorkOrder(row) {
      this.$prompt("请输入执行结果说明", "完成工单", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        inputType: "textarea",
        inputPlaceholder: "可选"
      }).then(({ value }) => {
        return changeWorkOrderStatus({ workOrderId: row.workOrderId, status: "2", resultDesc: value || "" })
      }).then(() => {
        this.$modal.msgSuccess("完成成功")
        this.getList()
      }).catch(() => {})
    },
    cancelWorkOrder(row) {
      this.$modal.confirm(`是否取消工单：${row.title}？`).then(() => {
        return changeWorkOrderStatus({ workOrderId: row.workOrderId, status: "3" })
      }).then(() => {
        this.$modal.msgSuccess("取消成功")
        this.getList()
      }).catch(() => {})
    },
    handleExport() {
      this.download('/garden/workOrder/export', {
        ...this.queryParams
      }, `work_order_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

