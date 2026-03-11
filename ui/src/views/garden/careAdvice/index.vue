<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="植物名称" prop="plantName">
        <el-input v-model="queryParams.plantName" placeholder="请输入植物名称" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="状态" clearable>
          <el-option v-for="opt in statusOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="风险" prop="riskLevel">
        <el-select v-model="queryParams.riskLevel" placeholder="风险等级" clearable>
          <el-option label="低" value="0" />
          <el-option label="中" value="1" />
          <el-option label="高" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-magic-stick" size="mini" @click="openGenerateDialog"
          v-hasPermi="['garden:careAdvice:generate']">生成建议</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="list" @selection-change="handleSelectionChange" @row-click="openDetail">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" prop="adviceId" width="80" align="center" />
      <el-table-column label="植物" prop="plantName" min-width="160" />
      <el-table-column label="区域" prop="areaName" min-width="140" />
      <el-table-column label="标题" prop="title" min-width="220" />
      <el-table-column label="风险" prop="riskLevel" width="90" align="center">
        <template slot-scope="scope">
          <el-tag :type="riskTag(scope.row.riskLevel)">{{ riskLabel(scope.row.riskLevel) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态" prop="status" width="120" align="center">
        <template slot-scope="scope">
          <el-tag :type="statusTag(scope.row.status)">{{ statusLabel(scope.row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" prop="createTime" width="170" align="center">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="260" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-document" @click.stop="openDetail(scope.row)">详情</el-button>
          <el-button v-if="scope.row.status === '1'" size="mini" type="text" icon="el-icon-s-check"
            v-hasPermi="['garden:careAdvice:review']" @click.stop="openReview(scope.row)">审核</el-button>
          <el-button v-if="scope.row.status === '2' && !scope.row.linkedWorkOrderId" size="mini" type="text"
            icon="el-icon-s-order" v-hasPermi="['garden:careAdvice:toWorkOrder']"
            @click.stop="toWorkOrder(scope.row)">转工单</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize"
      @pagination="getList" />

    <el-dialog title="生成智能养护建议" :visible.sync="generateOpen" width="520px" append-to-body>
      <el-form ref="generateForm" :model="generateForm" label-width="90px">
        <el-form-item label="选择植物" prop="plantId" required>
          <el-select v-model="generateForm.plantId" filterable remote reserve-keyword placeholder="输入关键词搜索植物"
            :remote-method="remoteSearchPlant" :loading="plantLoading" style="width: 100%;">
            <el-option v-for="p in plantOptions" :key="p.plantId" :label="p.plantName" :value="p.plantId">
              <span style="float:left">{{ p.plantName }}</span>
              <span style="float:right;color:#999;font-size:12px">{{ p.species }}</span>
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="关注点" prop="focus">
          <el-input v-model="generateForm.focus" type="textarea" :rows="3"
            placeholder="可选：例如更关注浇水、施肥、病虫害、防寒等" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="generateOpen = false">取 消</el-button>
        <el-button type="primary" :loading="generateLoading" @click="doGenerate">生 成</el-button>
      </div>
    </el-dialog>

    <el-drawer title="养护建议详情" :visible.sync="detailOpen" direction="rtl" size="520px" append-to-body>
      <div v-loading="detailLoading" class="detail-wrap">
        <el-descriptions v-if="detail" :column="1" border size="small" class="mb8">
          <el-descriptions-item label="ID">{{ detail.adviceId }}</el-descriptions-item>
          <el-descriptions-item label="植物">{{ detail.plantName }}</el-descriptions-item>
          <el-descriptions-item label="区域">{{ detail.areaName }}</el-descriptions-item>
          <el-descriptions-item label="风险">{{ riskLabel(detail.riskLevel) }}</el-descriptions-item>
          <el-descriptions-item label="状态">{{ statusLabel(detail.status) }}</el-descriptions-item>
          <el-descriptions-item label="审核人">{{ detail.reviewBy }}</el-descriptions-item>
          <el-descriptions-item label="审核时间">{{ parseTime(detail.reviewTime) }}</el-descriptions-item>
          <el-descriptions-item label="审核备注">{{ detail.reviewNote }}</el-descriptions-item>
        </el-descriptions>

        <el-card shadow="never" class="mb8">
          <div slot="header">
            <span>建议内容</span>
          </div>
          <div class="content-md">
            <pre>{{ detail ? detail.contentMd : '' }}</pre>
          </div>
        </el-card>

      </div>
    </el-drawer>

    <el-dialog title="审核建议" :visible.sync="reviewOpen" width="520px" append-to-body>
      <el-form ref="reviewForm" :model="reviewForm" label-width="90px">
        <el-form-item label="审核结果" prop="approve" required>
          <el-radio-group v-model="reviewForm.approve">
            <el-radio :label="true">通过</el-radio>
            <el-radio :label="false">驳回</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="备注" prop="reviewNote">
          <el-input v-model="reviewForm.reviewNote" type="textarea" :rows="3" placeholder="可选" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="reviewOpen = false">取 消</el-button>
        <el-button type="primary" :loading="reviewLoading" @click="doReview">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="转工单" :visible.sync="toWorkOpen" width="560px" append-to-body>
      <el-form ref="toWorkForm" :model="toWorkForm" :rules="toWorkRules" label-width="100px">
        <el-form-item label="执行人" prop="executorId">
          <el-select v-model="toWorkForm.executorId" placeholder="选择执行人" filterable clearable style="width: 100%;">
            <el-option v-for="u in userOptions" :key="u.userId" :label="u.nickName" :value="u.userId" />
          </el-select>
        </el-form-item>
        <el-form-item label="计划时间" prop="planTime">
          <el-date-picker v-model="toWorkForm.planTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择计划时间" clearable style="width: 100%" />
        </el-form-item>
        <el-form-item label="截止时间" prop="deadline">
          <el-date-picker v-model="toWorkForm.deadline" type="datetime" value-format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择截止时间" clearable style="width: 100%" />
        </el-form-item>
        <el-form-item label="优先级" prop="priority">
          <el-radio-group v-model="toWorkForm.priority">
            <el-radio label="0">低</el-radio>
            <el-radio label="1">中</el-radio>
            <el-radio label="2">高</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="toWorkOpen = false">取 消</el-button>
        <el-button type="primary" :loading="toWorkLoading" @click="submitToWorkOrder">确 定</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { listCareAdvice, getCareAdvice, generateCareAdvice, reviewCareAdvice, careAdviceToWorkOrder } from '@/api/garden/careAdvice'
import { listPlant } from '@/api/garden/plant'
import { listUser } from '@/api/system/user'

export default {
  name: 'CareAdvice',
  data() {
    return {
      loading: false,
      total: 0,
      list: [],
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        plantName: undefined,
        status: undefined,
        riskLevel: undefined,
        targetType: 'PLANT'
      },
      statusOptions: [
        { label: '待审核', value: '1' },
        { label: '已通过', value: '2' },
        { label: '已拒绝', value: '3' }
      ],

      generateOpen: false,
      generateLoading: false,
      generateForm: { plantId: undefined, focus: '' },
      plantLoading: false,
      plantOptions: [],

      detailOpen: false,
      detailLoading: false,
      detail: null,

      reviewOpen: false,
      reviewLoading: false,
      reviewForm: { adviceId: undefined, approve: true, reviewNote: '' },

      // 转工单（填写项与新增工单一致：执行人/计划时间/截止时间/优先级）
      toWorkOpen: false,
      toWorkLoading: false,
      toWorkAdviceId: undefined,
      userOptions: [],
      toWorkForm: { executorId: undefined, planTime: undefined, deadline: undefined, priority: '1' },
      toWorkRules: {
        executorId: [{ required: true, message: '执行人不能为空', trigger: 'change' }],
        planTime: [{ required: true, message: '计划时间不能为空', trigger: 'change' }],
        deadline: [{ required: true, message: '截止时间不能为空', trigger: 'change' }]
      },
    }
  },
  created() {
    const q = this.$route.query || {}
    if (q.plantId) {
      this.queryParams.targetId = Number(q.plantId)
    }
    this.getUsers()
    this.getList()
  },
  methods: {
    getUsers() {
      // 与工单页一致：取启用用户
      listUser({ pageNum: 1, pageSize: 1000, status: '0' }).then(res => {
        this.userOptions = res.rows || []
      })
    },
    getList() {
      this.loading = true
      listCareAdvice(this.queryParams).then(res => {
        this.list = res.rows || []
        this.total = res.total || 0
      }).finally(() => {
        this.loading = false
      })
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm('queryForm')
      this.queryParams.targetType = 'PLANT'
      this.queryParams.pageNum = 1
      this.getList()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.adviceId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    statusLabel(v) {
      const m = { '1': '待审核', '2': '已通过', '3': '已拒绝' }
      return m[v] || v
    },
    statusTag(v) {
      const m = { '1': 'warning', '2': 'success', '3': 'danger' }
      return m[v] || 'info'
    },
    riskLabel(v) {
      const m = { '0': '低', '1': '中', '2': '高' }
      return m[v] || v
    },
    riskTag(v) {
      const m = { '0': 'success', '1': 'warning', '2': 'danger' }
      return m[v] || 'info'
    },
    openGenerateDialog() {
      this.generateForm = { plantId: undefined, focus: '' }
      this.plantOptions = []
      this.generateOpen = true
    },
    remoteSearchPlant(keyword) {
      if (!keyword) return
      this.plantLoading = true
      listPlant({ plantName: keyword, pageNum: 1, pageSize: 20 }).then(res => {
        this.plantOptions = res.rows || []
      }).finally(() => {
        this.plantLoading = false
      })
    },
    doGenerate() {
      if (!this.generateForm.plantId) {
        this.$modal.msgError('请选择植物')
        return
      }
      this.generateLoading = true
      generateCareAdvice({ plantId: this.generateForm.plantId, focus: this.generateForm.focus }).then(res => {
        this.$modal.msgSuccess('生成成功，已进入待审核')
        const id = res.data && res.data.adviceId
        this.generateOpen = false
        this.getList()
        if (id) {
          this.openDetail({ adviceId: id })
        }
      }).catch(err => {
        const msg = (err && err.message) ? err.message : '生成失败'
        this.$modal.msgError(msg)
      }).finally(() => {
        this.generateLoading = false
      })
    },
    openDetail(row) {
      const adviceId = row && row.adviceId
      if (!adviceId) return
      this.detailOpen = true
      this.detailLoading = true
      this.detail = null
      getCareAdvice(adviceId).then(res => {
        this.detail = res.data
      }).finally(() => {
        this.detailLoading = false
      })
    },
    openReview(row) {
      this.reviewForm = { adviceId: row.adviceId, approve: true, reviewNote: '' }
      this.reviewOpen = true
    },
    doReview() {
      this.reviewLoading = true
      reviewCareAdvice(this.reviewForm).then(() => {
        this.$modal.msgSuccess('已提交审核结果')
        this.reviewOpen = false
        this.getList()
      }).finally(() => {
        this.reviewLoading = false
      })
    },
    toWorkOrder(row) {
      if (!row || !row.adviceId) return
      if (row.status !== '2') {
        this.$modal.msgWarning('需已通过才可转工单')
        return
      }
      if (row.linkedWorkOrderId) {
        this.$modal.msgWarning('该建议已转过工单：' + row.linkedWorkOrderId)
        return
      }
      this.toWorkAdviceId = row.adviceId
      this.toWorkForm = { executorId: undefined, planTime: undefined, deadline: undefined, priority: '1' }
      this.toWorkOpen = true
      this.$nextTick(() => {
        this.$refs.toWorkForm && this.$refs.toWorkForm.clearValidate()
      })
    },
    submitToWorkOrder() {
      this.$refs.toWorkForm.validate(valid => {
        if (!valid) return
        this.toWorkLoading = true
        const payload = {
          adviceId: this.toWorkAdviceId,
          executorId: this.toWorkForm.executorId,
          planTime: this.toWorkForm.planTime,
          deadline: this.toWorkForm.deadline,
          priority: this.toWorkForm.priority
        }
        careAdviceToWorkOrder(payload).then(res => {
          this.$modal.msgSuccess('已转工单，工单ID：' + (res.data && res.data.workOrderId))
          this.toWorkOpen = false
        }).finally(() => {
          this.toWorkLoading = false
        })
      })
    }
  }
}
</script>

<style scoped>
.detail-wrap {
  padding: 12px;
}
.content-md pre {
  white-space: pre-wrap;
  word-break: break-word;
  margin: 0;
  font-family: inherit;
}
</style>

