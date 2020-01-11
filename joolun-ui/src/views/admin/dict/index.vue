<template>
  <div class="execution">
    <basic-container>
      <el-row>
        <el-col :span="this.clickDictType != null ? 12 : 24">
          <el-card class="box-card">
            <avue-crud ref="crud"
                       :page="page"
                       :data="tableData"
                       :permission="permissionList"
                       :table-loading="tableLoading"
                       :option="tableOption"
                       @on-load="getPage"
                       @row-update="handleUpdate"
                       @row-save="handleSave"
                       @search-change="searchChange"
                       @sort-change="sortChange"
                       @row-del="handleDel">
              <template slot-scope="scope"
                        slot="menu">
                <el-button type="text"
                           icon="el-icon-s-claim"
                           size="mini"
                           plain
                           @click="handleItem(scope.row,scope.index)">键值列表
                </el-button>
              </template>
            </avue-crud>
          </el-card>
        </el-col>
        <el-col :span="12" v-if="this.clickDictType != null">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <h3><i class="el-icon-document-copy"></i> 键值列表，所属类型：{{this.clickDictType}}</h3>
            </div>
            <avue-crud ref="crudItem"
                       :data="tableDictItemData"
                       :permission="permissionList"
                       v-model="form"
                       @row-update="handleItemUpdate"
                       @row-save="handleItemSave"
                       @row-del="rowItemDel"
                       :before-open="beforeOpen"
                       :option="tableDictItemOption"
                       :table-loading="tableLoading2">
            </avue-crud>
          </el-card>
        </el-col>
      </el-row>

    </basic-container>
  </div>
</template>

<script>
  import {addItemObj, addObj, delItemObj, delObj, fetchItemList, getPage, putItemObj, putObj} from '@/api/admin/dict'
  import {tableDictItemOption, tableOption} from '@/const/crud/admin/dict'
  import {mapGetters} from 'vuex'

  export default {
    name: 'dict',
    data() {
      return {
        clickDictType: null,
        form: {},
        dictType: undefined,
        dictId: undefined,
        dialogFormVisible: false,
        tableData: [],
        tableDictItemData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 10 // 每页显示多少条
        },
        tableLoading: false,
        tableLoading2: false,
        tableOption: tableOption,
        tableDictItemOption: tableDictItemOption
      }
    },
    created() {
    },
    mounted: function () {
    },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.vaildData(this.permissions.sys_dict_add, false),
          delBtn: this.vaildData(this.permissions.sys_dict_del, false),
          editBtn: this.vaildData(this.permissions.sys_dict_edit, false)
        };
      }
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
          ascs: this.page.ascs
        }, params)).then(response => {
          this.tableData = response.data.data.records
          this.page.total = response.data.data.total
          this.page.currentPage = page.currentPage
          this.page.pageSize = page.pageSize
          this.tableLoading = false
        })
      },

      getDictItemList(dictId, type) {
        this.dictType = type
        this.dictId = dictId
        this.dialogFormVisible = true
        this.tableLoading2 = true
        fetchItemList(Object.assign({
          current: this.page.currentPage,
          size: this.page.pageSize
        }, {dictId: dictId})).then(response => {
          this.tableDictItemData = response.data.data.records
          this.tableLoading2 = false
        })
      },
      beforeOpen(done) {
        this.$set(this.form,"type",this.dictType)
        this.$set(this.form,"dictId",this.dictId)
        done()
      },
      handleDel: function (row, index) {
        var _this = this
        this.$confirm('是否确认删除?', '警告', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function () {
          return delObj(row)
        }).then(() => {
          this.tableDictItemData = []
          this.getPage(this.page)
          _this.$message({
            showClose: true,
            message: '删除成功',
            type: 'success'
          })
        }).catch(function () {
        })
      },
      /**
       * @title 数据更新
       * @param row 为当前的数据
       * @param index 为当前更新数据的行数
       * @param done 为表单关闭函数
       *
       **/
      handleUpdate: function (row, index, done, loading) {
        putObj(this.filterForm(row)).then(() => {
          this.$message({
            showClose: true,
            message: '修改成功',
            type: 'success'
          })
          this.getPage(this.page)
          done()
        }).catch(() => {
          loading()
        })
      },
      /**
       * @title 数据添加
       * @param row 为当前的数据
       * @param done 为表单关闭函数
       *
       **/
      handleSave: function (row, done, loading) {
        addObj(this.filterForm(row)).then(() => {
          this.$message({
            showClose: true,
            message: '添加成功',
            type: 'success'
          })
          this.getPage(this.page)
          done()
        }).catch(() => {
          loading()
        })
      },
      handleItemSave: function (row, done) {
        addItemObj(row).then(() => {
          this.tableDictItemData.push(Object.assign({}, row))
          this.$message({
            showClose: true,
            message: '添加成功',
            type: 'success'
          })
          this.getDictItemList(row.dictId, row.type)
          done()
        })
      },
      handleItemUpdate: function (row, index, done, loading) {
        putItemObj(row).then(() => {
          this.$message({
            showClose: true,
            message: '修改成功',
            type: 'success'
          })
          this.getDictItemList(row.dictId, row.type)
          done()
        }).catch(() => {
          loading()
        })
      },
      searchChange(form,done) {
        this.getPage(this.page, this.filterForm(form))
        done()
      },
      /**
       * 加载键值列表
       * @param row
       */
      handleItem: function (row) {
        this.clickDictType = row.type
        this.getDictItemList(row.id, row.type)
      },
      rowItemDel: function (row) {
        var _this = this
        this.$confirm('是否确认删除数据为"' + row.label + '"的数据项?', '警告', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function () {
          return delItemObj(row.id)
        }).then(() => {
          this.getDictItemList(row.dictId, row.type)
          _this.$message({
            showClose: true,
            message: '删除成功',
            type: 'success'
          })
        }).catch(function () {
        })
      },
    }
  }
</script>

<style lang="scss" scoped>
</style>
