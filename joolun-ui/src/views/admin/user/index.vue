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
                     @on-load="getPage"
                     @sort-change="sortChange"
                     @search-change="handleFilter"
                     @refresh-change="handleRefreshChange"
                     @row-update="handleUpdate"
                     @row-save="handleSave"
                     @row-del="handleDel"
                     @current-change="currentChange"
                     :before-open="handleOpenBefore"
                     :data="list">
            <template slot="username"
                      slot-scope="scope">
              <span>{{scope.row.username}}</span>
            </template>
            <template slot="role"
                      slot-scope="scope">
              <span v-for="(role,index) in scope.row.roleList"
                    :key="index">
                <el-tag size="mini">{{role.roleName}} </el-tag>&nbsp;&nbsp;
              </span>
            </template>
            <template slot="organId"
                      slot-scope="scope">
              {{scope.row.organName}}
            </template>
            <template slot="lockFlag"
                      slot-scope="scope">
              <el-tag size="mini" effect="light" :type="scope.row.lockFlag == '0' ? 'success' :  'danger'">{{scope.label}}</el-tag>
            </template>
            <template slot="organIdForm"
                      slot-scope="scope">
              <avue-input v-model="form.organId"
                               type="tree"
                               placeholder="请选择所属机构"
                               :node-click="getNodeData"
                               :dic="treeOrganData"
                               :props="organProps"></avue-input>
            </template>
            <template slot="roleForm"
                      slot-scope="scope">
              <avue-select v-model="role"
                                multiple
                                placeholder="请选择角色"
                                :dic="rolesOptions"
                                :props="roleProps"></avue-select>
            </template>
            <template slot-scope="scope"
                      slot="menu">
              <el-button type="text"
                         v-if="permissions.sys_user_password"
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
  import {organRoleList} from "@/api/admin/role"
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
          props: {
            label: 'name',
            value: 'id'
          }
        },
        treeData: [],
        option: tableOption,
        treeOrganData: [],
        checkedKeys: [],
        roleProps: {
          label: 'roleName',
          value: 'id'
        },
        organProps: {
          label: 'name',
          value: 'id',
        },
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20, // 每页显示多少条,
          isAsc: false//是否倒序
        },
        list: [],
        listLoading: true,
        role: [],
        form: {},
        rolesOptions: [],
      };
    },
    computed: {
      ...mapGetters(["permissions"]),
      permissionList() {
        return {
          addBtn: this.vaildData(this.permissions.sys_user_add, false),
          delBtn: this.vaildData(this.permissions.sys_user_del, false),
          editBtn: this.vaildData(this.permissions.sys_user_edit, false),
          viewBtn: this.vaildData(this.permissions.sys_user_get, false)
        }
      }
    },
    watch: {
      role() {
        this.form.role = this.role
      }
    },
    created() {
      this.init();
    },
    methods: {
      currentChange(currentPage){
        this.page.currentPage = currentPage
      },
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
        fetchTree().then(response => {2
          this.treeData = response.data.data;
        });
      },
      nodeClick(data) {
        this.page.page = 1;
        this.getPage(this.page, {organId: data.id});
      },
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
        this.listLoading = true;
        getPage(Object.assign({
          current: page.currentPage,
          size: page.pageSize,
          descs: this.page.descs,
          ascs: this.page.ascs
        }, params)).then(response => {
          this.list = response.data.data.records;
          this.page.total = response.data.data.total
          this.listLoading = false;
        });
      },
      getNodeData(data) {
        organRoleList().then(response => {
          this.rolesOptions = response.data.data;
        });
      },
      handleOrgan() {
        fetchTree().then(response => {
          this.treeOrganData = response.data.data;
        });
      },
      handleFilter(param) {
        this.page.page = 1;
        this.getPage(this.page, this.filterForm(param));
      },
      handleRefreshChange() {
        this.getPage(this.page)
      },
      handleOpenBefore(show, type) {
        window.boxType = type;
        this.handleOrgan();
        if (['edit', 'views'].includes(type)) {
          this.role = [];
          for (var i = 0; i < this.form.roleList.length; i++) {
            this.role[i] = this.form.roleList[i].id;
          }
          organRoleList().then(response => {
            this.rolesOptions = response.data.data;
          });
        } else if (type === 'add') {
          this.role = [];
        }
        show();
      },
      handleSave(row, done) {
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

        })
      },
      handleUpdate(row, index, done) {
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
      }
    }
  };
</script>
<style lang="scss" scoped>

</style>

