<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="植物名称" prop="plantName">
        <el-input
          v-model="queryParams.plantName"
          placeholder="请输入植物名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="植物编号" prop="plantCode">
        <el-input
          v-model="queryParams.plantCode"
          placeholder="请输入植物编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="健康状态" prop="healthStatus">
        <el-select v-model="queryParams.healthStatus" placeholder="健康状态" clearable>
          <el-option v-for="opt in healthStatusOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
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
          v-hasPermi="['garden:plant:add']"
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
          v-hasPermi="['garden:plant:edit']"
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
          v-hasPermi="['garden:plant:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['garden:plant:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

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
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="260">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-magic-stick"
            @click="goCareAdvice(scope.row)"
            v-hasPermi="['garden:careAdvice:list']"
          >养护建议</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['garden:plant:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['garden:plant:remove']"
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

    <el-dialog :title="title" :visible.sync="open" width="650px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="植物名称" prop="plantName">
              <el-input v-model="form.plantName" placeholder="请输入植物名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="植物编号" prop="plantCode">
              <el-input v-model="form.plantCode" placeholder="请输入植物编号" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="品种/学名" prop="species">
              <el-input v-model="form.species" placeholder="请输入品种/学名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="健康状态" prop="healthStatus">
              <el-select v-model="form.healthStatus" placeholder="健康状态" clearable>
                <el-option v-for="opt in healthStatusOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="树龄(年)" prop="ageYears">
              <el-input-number v-model="form.ageYears" controls-position="right" :min="0" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="高度(cm)" prop="heightCm">
              <el-input-number v-model="form.heightCm" controls-position="right" :min="0" />
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
          <el-col :span="12">
            <el-form-item label="图片" prop="imageUrl">
              <el-upload
                class="avatar-uploader"
                :action="uploadUrl"
                :headers="uploadHeaders"
                :show-file-list="false"
                :on-success="handleUploadSuccess"
                :before-upload="beforeImageUpload"
              >
                <img
                  v-if="form.imageUrl"
                  :src="fullUrl(form.imageUrl)"
                  class="avatar"
                  :style="{ width: '96px', height: '96px', objectFit: 'cover' }"
                >
                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
              </el-upload>
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
  </div>
</template>

<script>
import { listPlant, getPlant, delPlant, addPlant, updatePlant } from "@/api/garden/plant"

export default {
  name: "GardenPlant",
  dicts: ['sys_normal_disable'],
  components: { },
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      plantList: [],
      title: "",
      open: false,
      uploadUrl: process.env.VUE_APP_BASE_API + "/common/upload",
      uploadHeaders: { Authorization: "Bearer " + this.$store.getters.token },
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        plantName: undefined,
        plantCode: undefined,
        healthStatus: undefined,
        status: undefined
      },
      form: {},
      healthStatusOptions: [
        { value: "0", label: "良好" },
        { value: "1", label: "一般" },
        { value: "2", label: "较差" }
      ],
      rules: {
        plantName: [
          { required: true, message: "植物名称不能为空", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    // 拼出完整图片地址
    fullUrl(path) {
      if (!path) return ""
      if (path.startsWith("http://") || path.startsWith("https://")) {
        return path
      }
      // 兼容只返回相对路径的情况
      return process.env.VUE_APP_BASE_API + path
    },
    beforeImageUpload(file) {
      const isImage = file.type.indexOf("image/") === 0
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!isImage) {
        this.$modal.msgError("请上传图片文件")
      }
      if (!isLt2M) {
        this.$modal.msgError("图片大小不能超过 2MB")
      }
      return isImage && isLt2M
    },
    handleUploadSuccess(res) {
      // 情况一：后端直接返回字符串（你现在的情况，msg 就是完整路径）
      if (typeof res === "string") {
        this.form.imageUrl = res
        return
      }
      // 情况二：返回标准 RuoYi JSON：{ code:200, fileName:'相对路径', url:..., data:{url:...} }
      if (res && res.code === 200) {
        this.form.imageUrl = res.fileName || res.url || (res.data && res.data.url) || ""
        if (!this.form.imageUrl) {
          this.$modal.msgError("上传成功，但返回数据中没有图片地址")
        }
        return
      }
      // 其他情况当作失败
      this.$modal.msgError((res && res.msg) || "图片上传失败")
    },
    healthStatusLabel(val) {
      const hit = this.healthStatusOptions.find(x => x.value === (val == null ? "" : String(val)))
      return hit ? hit.label : "-"
    },
    goCareAdvice(row) {
      if (!row || !row.plantId) return
      this.$router.push({ path: '/plant/careAdvice', query: { plantId: row.plantId } })
    },
    getTreeselect() {
      treeselectArea().then(res => {
        this.areaOptions = res.data
      })
    },
    getList() {
      this.loading = true
      listPlant(this.queryParams).then(response => {
        this.plantList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    cancel() {
      this.open = false
      this.reset()
    },
    reset() {
      this.form = {
        plantId: undefined,
        plantName: undefined,
        plantCode: undefined,
        species: undefined,
        ageYears: undefined,
        heightCm: undefined,
        healthStatus: "0",
        status: "0",
        imageUrl: undefined,
        remark: undefined
      }
      this.resetForm("form")
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
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加植物档案"
    },
    handleUpdate(row) {
      this.reset()
      const plantId = row && row.plantId ? row.plantId : this.ids[0]
      getPlant(plantId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改植物档案"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        if (this.form.plantId != undefined) {
          updatePlant(this.form).then(() => {
            this.$modal.msgSuccess("修改成功")
            this.open = false
            this.getList()
          })
        } else {
          addPlant(this.form).then(() => {
            this.$modal.msgSuccess("新增成功")
            this.open = false
            this.getList()
          })
        }
      })
    },
    handleDelete(row) {
      const plantIds = row && row.plantId ? [row.plantId] : this.ids
      this.$modal.confirm('是否确认删除选中的植物档案？').then(() => {
        return delPlant(plantIds.join(","))
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('/garden/plant/export', {
        ...this.queryParams
      }, `plant_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
<style scoped>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 96px;
  height: 96px;
  line-height: 96px;
  text-align: center;
}

.avatar {
  width: 96px;
  height: 96px;
  display: block;
  object-fit: cover;
  border-radius: 4px;
}
</style>

