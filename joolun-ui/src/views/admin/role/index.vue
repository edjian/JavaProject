<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <avue-crud :option="tableOption"
                 :data="list"
                 ref="crud"
                 :page="page"
                 v-model="form"
                 :table-loading="listLoading"
                 :before-open="handleOpenBefore"
                 @on-load="getList"
                 @sort-change="sortChange"
                 @search-change="handleFilter"
                 @refresh-change="handleRefreshChange"
                 @row-update="handleUpdate"
                 @row-save="handleSave"
                 @row-del="handleDel">
        <template slot="dsScopeForm" slot-scope="scope">
          <div v-if="form.dsType == 1">
            <el-tree class="filter-tree"
                     :data="dsScopeData"
                     :check-strictly="true"
                     node-key="id"
                     highlight-current
                     :props="defaultProps"
                     ref="scopeTree"
                     :default-checked-keys="checkedDsScope"
                     show-checkbox>
            </el-tree>
          </div>
        </template>

        <template slot="menu"
                  slot-scope="scope">
          <el-button size="mini"
                     type="text"
                     icon="el-icon-plus"
                     v-if="permissions.sys_role_perm"
                     @click="handlePermission(scope.row,scope.index)">权限
          </el-button>
        </template>
      </avue-crud>
    </basic-container>
    <el-dialog title="分配权限"
               :visible.sync="dialogPermissionVisible">
      <el-tree class="filter-tree"
               :data="treeData"
               :default-checked-keys="checkedKeys"
               :check-strictly="false"
               node-key="id"
               highlight-current
               :props="defaultProps"
               show-checkbox
               ref="menuTree"
               :filter-node-method="filterNode"
               default-expand-all>
      </el-tree>
      <div slot="footer"
           class="dialog-footer">
        <el-button type="primary"
                   @click="updatePermession(id, roleCode)">更 新
        </el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  import {addObj, delObj, getPage, fetchRoleTree, getObj, permissionUpd, putObj} from '@/api/admin/role'
  import {tableOption} from '@/const/crud/admin/role'
  import {fetchTree} from '@/api/admin/organ'
  import {fetchMenuTree} from '@/api/admin/menu'
  import {mapGetters} from 'vuex'

  export default {
    name: 'table_role',
    data() {
      return {
        tableOption: tableOption,
        dsScopeData: [],
        treeData: [],
        checkedKeys: [],
        checkedDsScope: [],
        defaultProps: {
          label: "name",
          value: 'id'
        },
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20 // 每页显示多少条
        },
        menuIds: '',
        list: [],
        listLoading: true,
        form: {},
        id: undefined,
        roleCode: undefined,
        rolesOptions: undefined,
        dialogPermissionVisible: false,
      }
    },
    created() {
    },
    computed: {
      ...mapGetters(['elements', 'permissions']),
      permissionList() {
        return {
          addBtn: this.vaildData(this.permissions.sys_role_add, false),
          delBtn: this.vaildData(this.permissions.sys_role_del, false),
          editBtn: this.vaildData(this.permissions.sys_role_edit, false),
          viewBtn: this.vaildData(this.permissions.sys_role_get, false)
        }
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
        this.getList(this.page)
      },
      getList(page, params) {
        this.listLoading = true
        getPage(Object.assign({
          current: page.currentPage,
          size: page.pageSize,
          descs: this.page.descs,
          ascs: this.page.ascs
        }, params)).then(response => {
          this.list = response.data.data.records
          this.page.total = response.data.data.total
          this.listLoading = false
        }).catch(() => {
          this.listLoading=false
        })
      },
      handleRefreshChange() {
        this.getList(this.page)
      },
      handleFilter(param) {
        this.page.page = 1;
        this.getList(this.page, this.filterForm(param));
      },
      handleOpenBefore(show, type) {
        fetchTree().then(response => {
          this.dsScopeData = response.data.data;
          if (this.form.dsScope) {
            this.checkedDsScope = (this.form.dsScope).split(",")
          } else {
            this.checkedDsScope = []
          }
        });
        show();
      },
      handlePermission(row) {
        fetchRoleTree(row.id)
          .then(response => {
            this.checkedKeys = response.data.data
            return fetchMenuTree()
          })
          .then(response => {
            this.treeData = response.data.data
            // 解析出所有的太监节点
            this.checkedKeys = this.resolveAllEunuchNodeId(this.treeData, this.checkedKeys, [])
            this.dialogPermissionVisible = true
            this.id = row.id
            this.roleCode = row.roleCode
          })
      },
      /**
       * 解析出所有的节点id
       * @param json 待解析的json串
       * @param idArr 原始节点数组
       * @param temp 临时存放节点id的数组
       * @return 太监节点id数组
       */
      resolveAllEunuchNodeId(json, idArr, temp) {
        for (let i = 0; i < json.length; i++) {
          const item = json[i]
          // 存在子节点，递归遍历;不存在子节点，将json的id添加到临时数组中
          if (item.children && item.children.length !== 0) {
            this.resolveAllEunuchNodeId(item.children, idArr, temp)
          } else {
            temp.push(idArr.filter(id => id === item.id))
          }
        }
        return temp
      },
      filterNode(value, data) {
        if (!value) return true
        return data.label.indexOf(value) !== -1
      },
      getNodeData(data, done) {
        done();
      },
      handleDel(row, index) {
        var _this = this
        this.$confirm('是否确认删除?', '警告', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function () {
          return delObj(row.id)
        }).then(() => {
          this.getList(this.page)
          this.list.splice(index, 1);
          _this.$message({
            showClose: true,
            message: '删除成功',
            type: 'success'
          })
        }).catch(function () {
        })
      },
      handleSave(row, done) {
        if (this.form.dsType === 1){
          this.form.dsScope = this.$refs.scopeTree.getCheckedKeys().join(',')
        }
        addObj(this.form).then(() => {
          this.getList(this.page)
          done()
          this.$notify({
            title: '成功',
            message: '创建成功',
            type: 'success',
            duration: 2000
          })
        }).catch(() => {
        })
      },
      handleUpdate(row, index, done) {
        if (this.form.dsType === 1){
          this.form.dsScope = this.$refs.scopeTree.getCheckedKeys().join(',')
        }
        putObj(this.form).then(() => {
          this.getList(this.page)
          done();
          this.$notify({
            title: '成功',
            message: '修改成功',
            type: 'success',
            duration: 2000
          })
        }).catch(() => {
        })
      },
      updatePermession(id, roleCode) {
        this.menuIds = ''
        this.menuIds = this.$refs.menuTree.getCheckedKeys().join(',').concat(',').concat(this.$refs.menuTree.getHalfCheckedKeys().join(','))
        permissionUpd(id, this.menuIds).then(() => {
          this.dialogPermissionVisible = false
          fetchMenuTree()
            .then(response => {
              this.form = response.data.data
              return fetchRoleTree(id)
            })
            .then(response => {
              this.checkedKeys = response.data
              this.$notify({
                title: '成功',
                message: '修改成功',
                type: 'success',
                duration: 2000
              })
            })
        })
      }
    }
  }
</script>
