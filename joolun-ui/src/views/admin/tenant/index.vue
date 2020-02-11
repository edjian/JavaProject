<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <avue-crud
        @on-load="getPage"
        :option="tableOption"
        :data="tableData"
        :permission="permissionList"
        :table-loading="tableLoading"
        @refresh-change="refreshChange"
        @row-update="handleUpdate"
        @row-save="handleSave"
        @row-del="handleDel">
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
                     @click="updatePermession(id, roleCode)"
                     v-loading = "dialogLoading">更 新
          </el-button>
        </div>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
    import {addObj, delObj, getPage, getObj, putObj} from '@/api/admin/tenant'
    import {fetchRoleTreeTenant, permissionUpdTenant} from '@/api/admin/role'
    import {tableOption} from '@/const/crud/admin/tenant'
    import {fetchMenuTree} from '@/api/admin/menu'
    import {mapGetters} from 'vuex'

    export default {
        name: 'tenant',
        data() {
            return {
                dialogPermissionVisible: false,
                tableOption: tableOption,
                tableData: [],
                checkedKeys: [],
                tableLoading: false,
                page: {
                    total: 0, // 总页数
                    currentPage: 1, // 当前页数
                    pageSize: 20, // 每页显示多少条
                    ascs: [],//升序字段
                    descs: 'create_time'//降序字段
                },
                paramsSearch: {},
                defaultProps: {
                    label: "name",
                    value: 'id'
                },
                treeData: [],
                dialogLoading: false,
            }
        },
        created() {
        },
        computed: {
            ...mapGetters(['permissions']),
            permissionList() {
                return {
                    addBtn: this.vaildData(this.permissions.sys_tenant_add, false),
                    delBtn: this.vaildData(this.permissions.sys_tenant_del, false),
                    editBtn: this.vaildData(this.permissions.sys_tenant_edit, false),
                    viewBtn: this.vaildData(this.permissions.sys_tenant_get, false)
                }
            }
        },
        methods: {
            getPage(page, params) {
                this.tableLoading = true
                getPage(Object.assign({
                    current: page.currentPage,
                    size: page.pageSize,
                    descs: this.page.descs,
                    ascs: this.page.ascs,
                }, params, this.paramsSearch)).then(response => {
                    this.tableData = response.data.data.records
                    this.page.total = response.data.data.total
                    this.page.currentPage = page.currentPage
                    this.page.pageSize = page.pageSize
                    this.tableLoading = false
                }).catch(() => {
                    this.tableLoading = false
                })
            },
            handleDel: function (row, index) {
                var _this = this
                this.$confirm('是否确认删除此数据', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(function () {
                    return delObj(row.id)
                }).then(data => {
                    _this.$message({
                        showClose: true,
                        message: '删除成功',
                        type: 'success'
                    })
                    this.getPage(this.page)
                }).catch(function (err) {
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
                putObj(row).then(data => {
                    this.$message({
                        showClose: true,
                        message: '修改成功',
                        type: 'success'
                    })
                    done()
                    this.getPage(this.page)
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
                addObj(row).then(data => {
                    this.$message({
                        showClose: true,
                        message: '添加成功',
                        type: 'success'
                    })
                    done()
                    this.getPage(this.page)
                }).catch(() => {
                    loading()
                })
            },
            /**
             * 刷新回调
             */
            refreshChange(page) {
              this.getPage(page)
            },
            handlePermission(row) {
                this.tableLoading = true
                fetchRoleTreeTenant(row.id)
                    .then(response => {
                        this.checkedKeys = response.data.data.listMenuVO
                        this.checkedDysRole = response.data.data.sysRole
                        return fetchMenuTree()
                    })
                    .then(response => {
                        this.treeData = response.data.data
                        // 解析出所有的太监节点
                        this.checkedKeys = this.resolveAllEunuchNodeId(this.treeData, this.checkedKeys, [])
                        this.dialogPermissionVisible = true
                        this.id = this.checkedDysRole.id
                        this.roleCode = this.checkedDysRole.roleCode
                        this.tableLoading = false
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
            updatePermession(id, roleCode) {
                this.dialogLoading = true
                this.menuIds = ''
                this.menuIds = this.$refs.menuTree.getCheckedKeys().join(',').concat(',').concat(this.$refs.menuTree.getHalfCheckedKeys().join(','))
                permissionUpdTenant({
                  tenantId: this.checkedDysRole.tenantId,
                  roleId: id,
                  menuId: this.menuIds
                }).then(() => {
                    this.dialogLoading = false
                    this.dialogPermissionVisible = false
                    fetchMenuTree()
                        .then(response => {
                            this.form = response.data.data
                            return fetchRoleTreeTenant(this.checkedDysRole.tenantId)
                        })
                        .then(response => {
                            this.checkedKeys = response.data.data.listMenuVO
                            this.$notify({
                                title: '成功',
                                message: '修改成功',
                                type: 'success',
                                duration: 2000
                            })
                        })
                }).catch(() => {
                  this.dialogLoading = false
                })
            }
        }
    }
</script>

