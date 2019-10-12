<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-tabs @tab-click="switchTab" v-model="switchStatus" tabPosition="left">
        <el-tab-pane label='基本信息' name='userManager'>
          <el-form :model="ruleForm2"
                   ref="ruleForm2"
                   label-width="100px"
                   v-if="switchStatus==='userManager'"
                   class="demo-ruleForm">
            <el-form-item label="用户名"
                          prop="username">
              <el-input type="text"
                        v-model="ruleForm2.username"
                        disabled></el-input>
            </el-form-item>
            <el-form-item label="机构"
                          prop="organId">
              <avue-input v-model="ruleForm2.organId"
                          type="tree"
                          placeholder="请选择所属机构"
                          :dic="treeOrganData"
                          :props="organProps"
                          disabled></avue-input>
            </el-form-item>
            <el-form-item label="手机号" prop="phone">
              <el-input v-model="ruleForm2.phone" placeholder="请输入手机号"></el-input>
            </el-form-item>
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="ruleForm2.email" placeholder="请输入邮箱"></el-input>
            </el-form-item>
            <!--<el-form-item label="社交登录"
                          prop="thirdparty">
              <a href="#"
                 style="color: blue"
                 @click="handleClick('wechat')">绑定微信</a>
               | <a href="#"
                 style="color: blue"
                 @click="handleClick('gitee')">绑定码云</a> |
              <a href="#"
                 style="color: blue"
                 @click="handleClick('osc')">开源中国</a>
            </el-form-item>-->
            <el-form-item label="">
              <avue-form :option="optionAvatar" v-model="ruleForm2" :upload-after="handleAvatarSuccess"></avue-form>
            </el-form-item>
            <el-form-item>
              <el-button type="primary"
                         @click="submitForm('ruleForm2')">提交
              </el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label='修改密码' name='passwordManager'>
          <el-form :model="ruleForm2"
                   :rules="rules2"
                   ref="ruleForm2"
                   label-width="100px"
                   v-if="switchStatus==='passwordManager'"
                   class="demo-ruleForm">
            <el-form-item label="原密码"
                          prop="password">
              <el-input type="password"
                        v-model="ruleForm2.password"></el-input>
            </el-form-item>
            <el-form-item label="密码"
                          prop="newpassword1">
              <el-input type="password"
                        v-model="ruleForm2.newpassword1"></el-input>
            </el-form-item>
            <el-form-item label="确认密码"
                          prop="newpassword2">
              <el-input type="password"
                        v-model="ruleForm2.newpassword2"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary"
                         @click="submitForm('ruleForm2')">提交
              </el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label='我的日志' name='logManager'>
          <avue-crud ref="crud"
                     :page="page"
                     :data="tableData"
                     :table-loading="tableLoading"
                     :option="tableOption"
                     :permission="permissionList"
                     @on-load="getPage"
                     @search-change="searchChange"
                     @refresh-change="refreshChange"
                     @sort-change="sortChange"
                     @row-del="handleDel">
          </avue-crud>
        </el-tab-pane>
      </el-tabs>
    </basic-container>
  </div>
</template>


<script>
  import {openWindow} from '@/util/util'
  import {mapState,mapGetters} from 'vuex'
  import store from "@/store"
  import request from '@/router/axios'
  import {fetchTree} from "@/api/admin/organ"
  import {delObj, getPage} from '@/api/admin/log'
  import {tableOption} from '@/const/crud/admin/log'

  export default {
    data() {
      var validatePass = (rule, value, callback) => {
        if (this.ruleForm2.password !== '') {
          if (value !== this.ruleForm2.newpassword1) {
            callback(new Error('两次输入密码不一致!'))
          } else {
            callback()
          }
        } else {
          callback()
        }
      }
      return {
        tableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20, // 每页显示多少条
          ascs:[],
          descs: 'create_time'
        },
        tableLoading: false,
        tableOption: tableOption,
        treeOrganData: [],
        organProps: {
          label: 'name',
          value: 'id',
        },
        optionAvatar: {
          emptyBtn: false,
          submitBtn: false,
          labelWidth: 120,
          column: [
            {
              prop: 'avatar',
              type: 'upload',
              listType: 'picture-img',
              canvasOption: {
                text: 'www.joolun.com',
                ratio: 0.1
              },
              oss: 'ali',
              loadText: '附件上传中，请稍等',
              span: 24,
              tip: '只能上传jpg/png文件，且不超过500kb',
            }
          ]
        },
        switchStatus: '',
        show: false,
        headers: {
          Authorization: 'Bearer ' + store.getters.access_token
        },
        ruleForm2: {
          username: '',
          password: '',
          newpassword1: '',
          newpassword2: '',
          avatar: '',
          phone: '',
          email: '',
        },
        rules2: {
          password: [{required: true, min: 6, message: '原密码不能为空且不少于6位', trigger: 'change'}],
          newpassword1: [{required: true, min: 6, message: '不少于6位', trigger: 'change'}],
          newpassword2: [{required: true, validator: validatePass, trigger: 'blur'}]
        }
      }
    },
    created() {
      this.ruleForm2.organId = this.userInfo.organId
      this.ruleForm2.username = this.userInfo.username
      this.ruleForm2.phone = this.userInfo.phone
      this.ruleForm2.email = this.userInfo.email
      this.ruleForm2.avatar = this.userInfo.avatar != null ? this.userInfo.avatar : ''
      this.switchStatus = 'userManager'
      this.handleOrgan()
    },
    computed: {
      ...mapState({
        userInfo: state => state.user.userInfo
      }),
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          delBtn: this.vaildData(this.permissions.sys_log_del, false),
        };
      }
    },
    methods: {
      handleOrgan() {
        fetchTree().then(response => {
          this.treeOrganData = response.data.data;
        });
      },
      switchTab(tab, event) {
        this.switchStatus = tab.name
      },
      submitForm(formName) {
        this.$refs[formName].validate(valid => {
          if (valid) {
            request({
              url: '/admin/user/edit',
              method: 'put',
              data: this.ruleForm2
            }).then(response => {
              if (response.data.data) {
                this.$notify({
                  title: '成功',
                  message: '修改成功',
                  type: 'success',
                  duration: 2000
                })
                // 修改密码之后强制重新登录
                if (this.switchStatus === 'passwordManager') {
                  this.$store.dispatch('LogOut').then(() => {
                    location.reload() // 为了重新实例化vue-router对象 避免bug
                  })
                }
              } else {
                this.$notify({
                  title: '失败',
                  message: response.data.msg,
                  type: 'error',
                  duration: 2000
                })
              }
            }).catch(() => {
              this.$notify({
                title: '失败',
                message: '修改失败',
                type: 'error',
                duration: 2000
              })
            })
          } else {
            return false
          }
        })
      },
      handleClick(thirdpart) {
        let appid, client_id, redirect_uri, url
        redirect_uri = encodeURIComponent(window.location.origin + '/#/authredirect')
        if (thirdpart === 'wechat') {
          appid = ''
          url = 'https://open.weixin.qq.com/connect/qrconnect?appid=' + appid + '&redirect_uri=' + redirect_uri + '&state=WX-BIND&response_type=code&scope=snsapi_login#wechat_redirect'
        }
        openWindow(url, thirdpart, 540, 540)
      },
      handleAvatarSuccess(res, done, loading) {
        this.ruleForm2.avatar = res.url;
        done()
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
        this.tableLoading = true
        getPage(Object.assign({
          current: page.currentPage,
          size: page.pageSize,
          descs: this.page.descs,
          ascs: this.page.ascs,
          createId: this.userInfo.id
        }, params)).then(response => {
          this.tableData = response.data.data.records
          this.page.total = response.data.data.total
          this.tableLoading = false
        })
      },
      handleDel: function (row, index) {
        var _this = this
        this.$confirm('是否确认删除?', '警告', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function () {
          return delObj(row.id)
        }).then(data => {
          this.getPage(this.page)
          _this.$message({
            showClose: true,
            message: '删除成功',
            type: 'success'
          })
        }).catch(function (err) {
        })
      },
      /**
       * 搜索回调
       */
      searchChange(form) {
        this.getPage(this.page, form)
      },
      /**
       * 刷新回调
       */
      refreshChange() {
        this.getPage(this.page)
      }
    }
  }
</script>
<style>
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }

  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }

  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
</style>
