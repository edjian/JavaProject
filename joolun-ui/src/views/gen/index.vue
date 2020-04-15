<template>
  <div class="execution">
    <basic-container>
      <el-row :gutter="18">
        <el-col :span="4">
          <div class="grid-content bg-purple" style="margin-bottom: 10px">
            <el-select v-model="q.sysDatasourceId" placeholder="请选择数据源" @change="searchChange">
              <el-option
                v-for="item in dataSourceList"
                :key="item.id"
                :label="item.name"
                :value="item.id">
              </el-option>
            </el-select>
          </div>
        </el-col>
        <el-col :span="3">
          <div class="grid-content bg-purple">
            <el-button type="primary" size="small" icon="el-icon-setting" @click="setting" @close="dsBox=false">数据源配置</el-button>
          </div>
        </el-col>
        <el-col :span="6">
          <div class="grid-content bg-purple">
            <el-input v-model="q.tableName" placeholder="表名称"></el-input>
          </div>
        </el-col>
        <el-col :span="3">
          <div class="grid-content bg-purple">
            <el-button type="primary" size="small" icon="el-icon-search" @click="searchChange">搜索</el-button>
          </div>
        </el-col>
      </el-row>
      <avue-crud ref="crud"
                 :page="page"
                 :data="tableData"
                 :table-loading="tableLoading"
                 :option="tableOption"
                 @on-load="getPage"
                 @sort-change="sortChange"
                 @refresh-change="refreshChange">
        <template slot-scope="scope"
                  slot="menu">
          <el-button type="text"
                     icon="el-icon-view"
                     size="mini"
                     plain
                     @click="handleCodeView(scope.row,scope.index)">预览
          </el-button>
          <el-button type="text"
                     icon="el-icon-edit"
                     size="mini"
                     plain
                     @click="handleConfig(scope.row,scope.index)">配置
          </el-button>
          <el-button type="text"
                     icon="el-icon-download"
                     size="mini"
                     plain
                     @click="generatorCode(scope.row,scope.index)">生成代码
          </el-button>
        </template>
      </avue-crud>

      <el-dialog title="生成配置"
                 :visible.sync="box"
                 width="50%"
                 lock-scroll>
        <div class="pull-auto">
          <avue-form :option="formOption"
                     ref="formData"
                     v-model="formData"
                     @submit="putGenTable">
          </avue-form>
        </div>
      </el-dialog>

      <el-dialog title="数据源管理" :visible.sync="dsBox" width="90%"
                 :table-loading="tableLoading"
                 @close="dsBox=false">
        <avue-crud ref="data-source-settings-crud"
                   v-model="dsForm"
                   :page="dsPage"
                   :data="tableDsData"
                   :option="tableDsOption"
                   :before-open="handleOpenBefore"
                   @row-update="handleUpdate"
                   @row-save="handleSave"
                   @row-del="handleDel"
                   @refresh-change="refreshDsChange"
                   @on-load="getDsList">
        </avue-crud>
      </el-dialog>

      <!-- 预览界面 -->
      <el-dialog :title="preview.title" :visible.sync="preview.open" width="80%" top="5vh">
        <el-tabs v-model="preview.activeName">
          <el-tab-pane
                  v-for="(value, key) in preview.data"
                  :label="key.substring(key.lastIndexOf('/')+1,key.indexOf('.vm'))"
                  :name="key.substring(key.lastIndexOf('/')+1,key.indexOf('.vm'))"
                  :key="key"
          >
            <pre>{{ value }}</pre>
          </el-tab-pane>
        </el-tabs>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
  import {addObj, delObj, fetchDsList, getPage, fetchSelectDsList, generatorView, generatorCode, putObj} from '@/api/gen/gen'
  import {getObj as getGenTable, putObj as putGenTable} from '@/api/gen/gentable'
  import {formOption, tableDsOption, tableOption} from '@/const/crud/gen/gen'

  export default {
    name: 'code-generator',
    data() {
      return {
        dsBox: false,
        q: {},
        dataSourceList: [],
        tableData: [],
        tableDsData: [],
        formData: {},
        box: false,
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20 // 每页显示多少条
        },
        dsPage: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20 // 每页显示多少条
        },
        dsForm: {},
        tableLoading: false,
        tableOption: tableOption,
        tableDsOption: tableDsOption,
        formOption: formOption,
        // 预览参数
        preview: {
          open: false,
          title: "代码预览",
          data: {},
          activeName: "Entity.java"
        }
      }
    },
    created() {
      this.getdataSourceList()
    },
    methods: {
      sortChange(val){
        let prop = val.prop ? val.prop.replace(/([A-Z])/g,"_$1").toLowerCase() : '';
        if(val.order=='ascending'){
          this.page.descs = []
          this.page.ascs = prop
        }else if(val.order=='descending'){
          this.page.ascs = []
          this.page.descs = prop
        }else{
          this.page.ascs = []
          this.page.descs = []
        }
        this.getPage(this.page)
      },
      getPage(page, params) {
        this.tableLoading = true
        getPage(Object.assign({
          current: page.currentPage,
          size: page.pageSize,
          descs: this.page.descs,
          ascs: this.page.ascs,
        }, params,this.filterForm(this.q))).then(response => {
          this.tableData = response.data.data.records
          this.page.total = response.data.data.total
          this.page.currentPage = page.currentPage
          this.page.pageSize = page.pageSize
          this.tableLoading = false
        })
      },
      handleDel: function (row, index) {
        this.$confirm('是否确认删除', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function () {
          return delObj(row.id)
        }).then(() => {
          this.$message.success('删除成功')
          this.getDsList(this.page)
          this.getdataSourceList()
        }).catch(function () {
        })
      },
      handleOpenBefore: function (show) {
        this.dsForm.password = undefined
        show()
      },
      handleUpdate: function (row, index, done, loading) {
        putObj(row).then(() => {
          this.$message.success('修改成功')
          done()
          this.getDsList(this.page)
          this.getdataSourceList()
        }).catch(() => {
          loading()
        })
      },
      handleSave: function (row, done, loading) {
        addObj(row).then(() => {
          this.$message.success('添加成功')
          done()
          this.getDsList(this.page)
          this.getdataSourceList()
        }).catch(() => {
          loading()
        })
      },
      getDsList(page, params) {
        fetchDsList(Object.assign({
          current: page.currentPage,
          size: page.pageSize
        }, params)).then(response => {
          this.tableDsData = response.data.data.records
          this.dsPage.total = response.data.data.total
        })
      },
      //生成代码预览
      handleCodeView(row){
        getGenTable(row.tableName).then(response => {
          let data = response.data.data
          if(data == null){
            data = {
              tableName: row.tableName,
              tableComment: '',
              packageName: '',
              moduleName: '',
              author: '',
              tablePrefix: ''
            }
          }
          data.sysDatasourceId = this.q.sysDatasourceId
          generatorView(data).then(response => {
            this.preview.data = response.data.data
            this.preview.open = true
          })
        })
      },
      //生成代码
      generatorCode(row) {
        getGenTable(row.tableName).then(response => {
          let data = response.data.data
          if(data == null){
            data = {
              tableName: row.tableName,
              tableComment: '',
              packageName: '',
              moduleName: '',
              author: '',
              tablePrefix: ''
            }
          }
          data.sysDatasourceId = this.q.sysDatasourceId
          generatorCode(data).then(() => {

          })
        })
      },
      //生成配置
      handleConfig(row){
        getGenTable(row.tableName).then(response => {
          let data = response.data.data
          this.formData = data
          if(this.formData == null){
            this.formData = {
              tableName: row.tableName,
              tableComment: '',
              packageName: '',
              moduleName: '',
              author: '',
              tablePrefix: ''
            }
          }
          this.box = true
        })
      },
      //提交生成配置
      putGenTable(form,done){
        putGenTable(this.formData).then(() => {
          this.box = false
          done()
        })
      },
      refreshChange(page) {
        this.getPage(this.page)
      },
      refreshDsChange() {
        this.getDsList(this.page)
      },
      setting() {
        this.dsBox = true
      },
      searchChange() {
        this.getPage(this.page)
      },
      getdataSourceList() {
        fetchSelectDsList().then(response => {
          this.dataSourceList = response.data.data
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
</style>

