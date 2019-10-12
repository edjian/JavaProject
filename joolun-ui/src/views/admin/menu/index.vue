<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <div class="filter-container">
        <el-button-group>
          <el-button type="primary"
                     v-if="permissions.sys_menu_add"
                     icon="el-icon-plus"
		     size="small"
                     @click="handleSave">添加
          </el-button>
          <el-button type="primary"
                     v-if="permissions.sys_menu_edit"
                     icon="el-icon-edit"
                     size="small"
                     @click="handleUpdate">编辑
          </el-button>
          <el-button type="primary"
                     v-if="permissions.sys_menu_del"
                     icon="el-icon-delete"
		     size="small"
                     @click="handleDel">删除
          </el-button>
        </el-button-group>
      </div>

      <el-row>
        <el-col :span="6"
                style='margin-top:15px; padding-right: 10px;'>
          <el-tree class="filter-tree"
                   node-key="id"
                   highlight-current
                   :data="treeData"
                   :default-expanded-keys="aExpandedKeys"
                   :filter-node-method="filterNode"
                   :props="defaultProps"
                   @node-click="getNodeData"
                   @node-expand="nodeExpand"
                   @node-collapse="nodeCollapse">
          </el-tree>
        </el-col>
        <el-col :span="18"
                style='margin-top:15px;'>
          <el-card class="box-card">
            <el-form :label-position="labelPosition"
                     label-width="80px"
                     :model="form"
                     :rules="rules"
                     ref="form">
              <el-form-item label="父级"
                            prop="parentId">
                <avue-input v-model="form.parentId"
                            type="tree"
                            :disabled="formEdit"
                            placeholder="请选择父级"
                            :dic="treeData"
                            :props="defaultProps2"></avue-input>
              </el-form-item>
              <el-form-item label="菜单ID"
                            prop="id">
                <el-input v-model="form.id"
                          :disabled="true"
                          placeholder="请输入菜单ID"></el-input>
              </el-form-item>
              <el-form-item label="标题"
                            prop="name">
                <el-input v-model="form.name"
                          :disabled="formEdit"
                          placeholder="请输入标题"></el-input>
              </el-form-item>
              <el-form-item label="类型"
                            prop="type">
                <el-select class="filter-item"
                           v-model="form.type"
                           :disabled="formEdit"
                           placeholder="请输入资源请求类型">
                  <el-option v-for="item in  typeOptions"
                             :key="item"
                             :label="item | typeFilter"
                             :value="item"></el-option>
                </el-select>
              </el-form-item>

              <el-form-item label="权限标识"
                            prop="permission">
                <el-input v-model="form.permission"
                          :disabled="formEdit"
                          placeholder="请输入权限标识"></el-input>
              </el-form-item>
              <el-form-item label="图标" v-if="form.type === '0'"
                            prop="icon">
                <avue-icon-select v-model="form.icon"
                                       :iconList="iconList"
                                       :disabled="formEdit"
                                       placeholder="请输入图标"></avue-icon-select>
              </el-form-item>
              <el-form-item label="排序" v-if="form.type === '0'"
                            prop="sort">
                <el-input type="number"
                          v-model="form.sort"
                          :disabled="formEdit"
                          placeholder="请输入排序"></el-input>
              </el-form-item>
              <el-form-item label="资源路径" v-if="form.type === '0'"
                            prop="component">
                <el-input v-model="form.component"
                          :disabled="formEdit"
                          placeholder="请输入资源路径"></el-input>
              </el-form-item>
              <el-form-item label="路径编码" v-if="form.type === '0'"
                            prop="component">
                <el-input v-model="form.path"
                          :disabled="formEdit"
                          placeholder="请输入路径编码"></el-input>
              </el-form-item>
              <el-form-item label="赋权角色" v-if="formStatus == 'create'"
                            prop="component">
                <avue-select v-model="form.roleId"
                             placeholder="请选择角色"
                             :dic="rolesOptions"
                             :props="roleProps"></avue-select>
              </el-form-item>
              <el-form-item v-if="formStatus === 'update'">
                <el-button type="primary"
                           @click="update">更新
                </el-button>
                <el-button @click="onCancel">取消</el-button>
              </el-form-item>
              <el-form-item v-if="formStatus === 'create'">
                <el-button type="primary"
                           @click="create">保存
                </el-button>
                <el-button @click="onCancel">取消</el-button>
              </el-form-item>
            </el-form>
          </el-card>
        </el-col>
      </el-row>
    </basic-container>
  </div>
</template>

<script>
  import {addObj, delObj, fetchMenuTree, getObj, putObj} from "@/api/admin/menu";
  import {organRoleList} from "@/api/admin/role"
  import {mapGetters} from "vuex";
  import iconList from "@/const/iconList";

  export default {
    name: "sysMenu",
    data() {
      return {
        rolesOptions: [],
        roleProps: {
          label: 'roleName',
          value: 'id'
        },
        defaultProps2: {
          label: 'name',
          value: 'id',
        },
        iconList: iconList,
        list: null,
        total: null,
        formEdit: true,
        formAdd: true,
        formStatus: "",
        showElement: false,
        typeOptions: ["0", "1"],
        listQuery: {
          name: undefined
        },
        treeData: [],
        oExpandedKey: {
          // key (from tree id) : expandedOrNot boolean
        },
        oTreeNodeChildren: {
          // id1 : [children] (from tree node id1)
          // id2 : [children] (from tree node id2)
        },
        aExpandedKeys: [],
        defaultProps: {
          children: "children",
          label: "name"
        },
        labelPosition: "right",
        form: {
          permission: undefined,
          name: undefined,
          id: undefined,
          parentId: undefined,
          icon: undefined,
          sort: undefined,
          component: undefined,
          type: undefined,
          path: undefined
        },
        currentId: -1,
        rules: {
          name: [{required: true, message: '标题不合法', trigger: 'blur'}],
          type: [{required: true, message: '标题不合法', trigger: 'blur'}],
          roleId: [{required: true, message: '必须选择一个赋权角色', trigger: 'blur'}],
        }
      };
    },
    filters: {
      typeFilter(type) {
        const typeMap = {
          0: "菜单",
          1: "按钮"
        };
        return typeMap[type];
      }
    },
    created() {
      this.getPage();
      this.organRoleList()
    },
    computed: {
      ...mapGetters(["elements", "permissions"]),
      permissionList() {
        return {
          addBtn: this.vaildData(this.permissions.sys_menu_add, false),
          delBtn: this.vaildData(this.permissions.sys_menu_del, false),
          editBtn: this.vaildData(this.permissions.sys_menu_edit, false),
          viewBtn: this.vaildData(this.permissions.sys_menu_get, false)
        }
      }
    },
    methods: {
      organRoleList() {
        organRoleList().then(response => {
          this.rolesOptions = response.data.data
        })
      },
      getPage() {
        fetchMenuTree(this.listQuery).then(response => {
          this.treeData = response.data.data
        })
      },
      filterNode(value, data) {
        if (!value) return true
        return data.label.indexOf(value) !== -1
      },

      nodeExpand(data) {
        let aChildren = data.children
        if (aChildren.length > 0) {
          this.oExpandedKey[data.id] = true
          this.oTreeNodeChildren[data.id] = aChildren
        }
        this.setExpandedKeys()
      },
      nodeCollapse(data) {
        this.oExpandedKey[data.id] = false
        // 如果有子节点
        this.treeRecursion(this.oTreeNodeChildren[data.id], oNode => {
          this.oExpandedKey[oNode.id] = false
        });
        this.setExpandedKeys()
      },
      setExpandedKeys() {
        let oTemp = this.oExpandedKey
        this.aExpandedKeys = []
        for (let sKey in oTemp) {
          if (oTemp[sKey]) {
            this.aExpandedKeys.push(parseInt(sKey))
          }
        }
      },
      treeRecursion(aChildren, fnCallback) {
        if (aChildren) {
          for (let i = 0; i < aChildren.length; ++i) {
            let oNode = aChildren[i];
            fnCallback && fnCallback(oNode);
            this.treeRecursion(oNode.children, fnCallback)
          }
        }
      },

      getNodeData(data) {
        if (!this.formEdit) {
          this.formStatus = "update"
        }
        getObj(data.id).then(response => {
          this.form = response.data.data
        });
        this.currentId = data.id
        this.showElement = true
      },
      handleUpdate() {
        if (this.form.id) {
          this.formEdit = false
          this.formStatus = "update"
        }
      },
      handleSave() {
        this.resetForm()
        this.formEdit = false
        this.formStatus = "create"
      },
      handleDel() {
        this.$confirm("此操作将永久删除, 是否继续?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(() => {
          delObj(this.currentId).then(() => {
            this.getPage()
            this.resetForm()
            this.onCancel()
            this.$notify({
              title: "成功",
              message: "删除成功",
              type: "success",
              duration: 2000
            })
          })
        })
      },
      update() {
        this.$refs.form.validate((valid) => {
          if (valid) {
            putObj(this.form).then(() => {
              this.getPage();
              this.$notify({
                title: "成功",
                message: "更新成功",
                type: "success",
                duration: 2000
              })
            })
          }
        })
      },
      create() {
        this.$refs.form.validate((valid) => {
          if (valid) {
            if(!this.form.roleId){
              this.$message({
                message: "请选择角色",
                type: "error"
              })
              return
            }
            addObj(this.form).then(() => {
              this.getPage()
              this.$notify({
                title: "成功",
                message: "创建成功",
                type: "success",
                duration: 2000
              })
            })
          }
        })
      },
      onCancel() {
        this.formEdit = true
        this.formStatus = ""
      },
      resetForm() {
        this.form = {
          permission: undefined,
          name: undefined,
          id: undefined,
          parentId: this.currentId,
          icon: undefined,
          sort: undefined,
          component: undefined,
          type: undefined,
          path: undefined,
          roleId: undefined
        }
      }
    }
  }
</script>

