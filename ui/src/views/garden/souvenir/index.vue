<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="名称" prop="souvenirName">
        <el-input
          v-model="queryParams.souvenirName"
          placeholder="请输入纪念品名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="编码" prop="souvenirCode">
        <el-input
          v-model="queryParams.souvenirCode"
          placeholder="请输入纪念品编码"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="分类" prop="category">
        <el-select v-model="queryParams.category" placeholder="请选择分类" clearable>
          <el-option
            v-for="dict in dict.type.garden_souvenir_category"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="状态" clearable>
          <el-option
            v-for="dict in dict.type.sys_normal_disable"
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

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['garden:souvenir:add']"
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
          v-hasPermi="['garden:souvenir:edit']"
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
          v-hasPermi="['garden:souvenir:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['garden:souvenir:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="souvenirList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="名称" align="center" prop="souvenirName" min-width="160" />
      <el-table-column label="编码" align="center" prop="souvenirCode" min-width="120" />
      <el-table-column label="分类" align="center" prop="category" min-width="120">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.garden_souvenir_category" :value="scope.row.category" />
        </template>
      </el-table-column>
      <el-table-column label="单价" align="center" prop="price" width="100" />
      <el-table-column label="库存数量" align="center" prop="stock" width="110" />
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
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="260">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['garden:souvenir:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-s-operation"
            @click="openStockDialog(scope.row)"
            v-hasPermi="['garden:souvenir:edit']"
          >设置库存</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['garden:souvenir:remove']"
          >删除</el-button>
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

    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="名称" prop="souvenirName">
              <el-input v-model="form.souvenirName" placeholder="请输入纪念品名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="编码" prop="souvenirCode">
              <el-input v-model="form.souvenirCode" placeholder="请输入纪念品编码" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="分类" prop="category">
              <el-select v-model="form.category" placeholder="请选择分类" clearable>
                <el-option
                  v-for="dict in dict.type.garden_souvenir_category"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="单价" prop="price">
              <el-input-number v-model="form.price" :min="0" :step="1" :precision="2" controls-position="right" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio
                  v-for="dict in dict.type.sys_normal_disable"
                  :key="dict.value"
                  :label="dict.value"
                >{{dict.label}}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="设置库存" :visible.sync="stockOpen" width="400px" append-to-body>
      <el-form ref="stockForm" :model="stockForm" :rules="stockRules" label-width="90px">
        <el-form-item label="纪念品" prop="souvenirName">
          <el-input v-model="stockForm.souvenirName" disabled />
        </el-form-item>
        <el-form-item label="库存数量" prop="stock">
          <el-input-number v-model="stockForm.stock" :min="0" :max="999999" controls-position="right" style="width: 100%;" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitStock">确 定</el-button>
        <el-button @click="stockOpen = false">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listSouvenir, getSouvenir, addSouvenir, updateSouvenir, delSouvenir } from "@/api/garden/souvenir"

export default {
  name: "GardenSouvenir",
  dicts: ['sys_normal_disable', 'garden_souvenir_category'],
  data() {
    return {
      loading: false,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      souvenirList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        souvenirName: undefined,
        souvenirCode: undefined,
        category: undefined,
        status: undefined
      },
      form: {},
      rules: {
        souvenirName: [
          { required: true, message: "名称不能为空", trigger: "blur" }
        ]
      },
      stockOpen: false,
      stockForm: {
        souvenirId: undefined,
        souvenirName: "",
        stock: 0
      },
      stockRules: {
        stock: [
          { required: true, message: "库存数量不能为空", trigger: "blur" }
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
      listSouvenir(this.queryParams).then(res => {
        this.souvenirList = res.rows || res.data || []
        this.total = res.total || this.souvenirList.length || 0
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
      this.ids = selection.map(item => item.souvenirId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "新增纪念品"
    },
    handleUpdate(row) {
      this.reset()
      const id = row && row.souvenirId ? row.souvenirId : this.ids[0]
      getSouvenir(id).then(res => {
        this.form = res.data || {}
        this.open = true
        this.title = "修改纪念品"
      })
    },
    reset() {
      this.form = {
        souvenirId: undefined,
        souvenirName: undefined,
        souvenirCode: undefined,
        category: undefined,
        price: 0,
        stock: 0,
        status: "0",
        remark: undefined
      }
      this.resetForm("form")
    },
    cancel() {
      this.open = false
      this.reset()
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        if (this.form.souvenirId) {
          const payload = { ...this.form }
          delete payload.stock
          updateSouvenir(payload).then(() => {
            this.$modal.msgSuccess("修改成功")
            this.open = false
            this.getList()
          })
        } else {
          addSouvenir({ ...this.form, stock: 0 }).then(() => {
            this.$modal.msgSuccess("新增成功")
            this.open = false
            this.getList()
          })
        }
      })
    },
    openStockDialog(row) {
      this.stockForm = {
        souvenirId: row.souvenirId,
        souvenirName: row.souvenirName,
        stock: row.stock == null ? 0 : row.stock
      }
      this.stockOpen = true
    },
    submitStock() {
      this.$refs["stockForm"].validate(valid => {
        if (!valid) return
        updateSouvenir({
          souvenirId: this.stockForm.souvenirId,
          stock: this.stockForm.stock
        }).then(() => {
          this.$modal.msgSuccess("库存设置成功")
          this.stockOpen = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      const ids = row && row.souvenirId ? [row.souvenirId] : this.ids
      this.$modal.confirm("是否确认删除选中的纪念品？").then(() => {
        return delSouvenir(ids.join(","))
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      })
    },
    handleExport() {
      this.download(
        "garden/souvenir/export",
        { ...this.queryParams },
        `souvenir_${new Date().getTime()}.xlsx`
      )
    }
  }
}
</script>

