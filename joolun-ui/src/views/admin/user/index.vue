<template>
  <div class="user">
    <basic-container>
      <el-row :span="24">
        <el-col :xs="24"
                :sm="24"
                :md="4">
          <avue-tree :option="treeOption"
                     :data="treeData"
                     @node-click="nodeClick"></avue-tree>
        </el-col>
        <el-col :xs="24"
                :sm="24"
                :md="20"
                class="user__main">
          <avue-crud :option="option"
                     ref="crud"
                     v-model="form"
                     :page="page"
                     :permission="permissionList"
                     :table-loading="listLoading"
                     :before-open="beforeOpen"
                     @on-load="getPage"
                     @sort-change="sortChange"
                     @search-change="searchChange"
                     @refresh-change="refreshChange"
                     @row-update="handleUpdate"
                     @row-save="handleSave"
                     @row-del="handleDel"
                     :data="list">
            <template slot="lockFlag"
                      slot-scope="scope">
              <el-tag size="mini" effect="light" :type="scope.row.lockFlag == '0' ? 'success' :  'danger'">{{scope.label}}</el-tag>
            </template>
            <template slot-scope="scope"
                      slot="menu">
              <el-button type="text"
                         v-if="permissions['sys:user:password']"
                         icon="el-icon-key"
                         size="small"
                         plain
                         @click="editPassword(scope.row,scope.index)">修改密码</el-button>
            </template>
          </avue-crud>
        </el-col>
      </el-row>
      <el-dialog :title="'修改用户【'+selectRow.username+'】密码'" :visible.sync="dialogVisible" width="40%">
        <avue-form ref="form"
                   v-model="form2"
                   :option="option2"
                   @submit="subPassword">
        </avue-form>
      </el-dialog>
    </basic-container>
  </div>

</template>

<script>
  import {addObj, delObj, getPage, getObj, putObj, editPassword} from "@/api/admin/user"
  import {fetchTree} from "@/api/admin/organ"
  import {tableOption} from '@/const/crud/admin/user'
  import {mapGetters} from "vuex"

  export default {
    name: "sys_user",
    data() {
      return {
        form2: {},
        option2: {
          column: [{
            label: "新密码",
            prop: "password",
            rules: [{
              required: true,
              min: 6,
              message: '不少于6位',
              trigger: "change"
            }]
          }]
        },
        selectRow: {},
        dialogVisible: false,
        treeOption: {
          nodeKey: 'id',
          addBtn: false,
          menu: false,
          defaultExpandAll: true,
          props: {
            label: 'name',
            value: 'id'
          }
        },
        treeData: [],
        option: tableOption,
        checkedKeys: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20, // 每页显示多少条,
          isAsc: false//是否倒序
        },
        list: [],
        listLoading: true,
        role: [],
        form: {}
      };
    },
    computed: {
      ...mapGetters(["permissions"]),
      permissionList() {
        return {
          addBtn: this.permissions['sys:user:add'],
          delBtn: this.permissions['sys:user:del'],
          editBtn: this.permissions['sys:user:edit'],
          viewBtn: this.permissions['sys:user:get']
        }
      }
    },
    watch: {

    },
    created() {
      this.init();
    },
    methods: {
      subPassword(form2,done){
        form2.id = this.selectRow.id
        editPassword(form2).then(() => {
          done()
          this.$notify({
            title: "成功",
            message: "修改成功",
            type: "success",
            duration: 2000
          });
          this.dialogVisible = false
          this.form2.password = ''
        }).catch(() => {
          done()
        })
      },
      editPassword(row,index){
        this.selectRow = row
        this.dialogVisible = true
      },
      init() {
        fetchTree().then(response => {
          this.treeData = response.data.data
        })
      },
      nodeClick(data) {
        this.page.page = 1
        this.getPage(this.page, {organId: data.id});
      },
      sortChange(val){
        let prop = val.prop ? val.prop.replace(/([A-Z])/g,"_$1").toLowerCase() : ''
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
        this.listLoading = true;
        getPage(Object.assign({
          current: page.currentPage,
          size: page.pageSize,
          descs: this.page.descs,
          ascs: this.page.ascs
        }, params)).then(response => {
          this.list = response.data.data.records;
          this.page.total = response.data.data.total
          this.page.currentPage = page.currentPage
          this.page.pageSize = page.pageSize
          this.listLoading = false;
        });
      },
      searchChange(params,done) {
        params = this.filterForm(params)
        this.paramsSearch = params
        this.page.currentPage = 1
        this.getPage(this.page, params)
        done()
      },
      refreshChange(page) {
        this.getPage(this.page)
      },
      handleSave(row, done, loading) {
        addObj(this.form).then(() => {
          this.getPage(this.page)
          this.$notify({
            title: "成功",
            message: "创建成功",
            type: "success",
            duration: 2000
          })
          done()
        }).catch(() => {
          loading()
        })
      },
      handleUpdate(row, index, done, loading) {
        putObj(this.form).then(() => {
          this.getPage(this.page)
          done()
          this.$notify({
            title: "成功",
            message: "修改成功",
            type: "success",
            duration: 2000
          });
        }).catch(() => {
          loading()
        })
      },
      handleDel(row, index) {
        this.$confirm(
          "此操作将永久删除该用户(用户名:" + row.username + "), 是否继续?",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning"
          }
        ).then(() => {
          delObj(row.id)
            .then(() => {
              this.list.splice(index, 1)
              this.$notify({
                title: "成功",
                message: "删除成功",
                type: "success",
                duration: 2000
              })
            })
            .cache(() => {
              this.$notify({
                title: "失败",
                message: "删除失败",
                type: "error",
                duration: 2000
              })
            })
        })
      },
      beforeOpen(done,type){
        window.openType = type
        done()
      },
    }
  };
</script>
<style lang="scss" scoped>

</style>

