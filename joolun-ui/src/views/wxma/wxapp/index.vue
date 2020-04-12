<!--
  - Copyright (C) 2018-2019
  - All rights reserved, Designed By www.joolun.com
  - 注意：
  - 本软件为www.joolun.com开发研制，未经购买不得使用
  - 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
  - 一经发现盗用、分享等行为，将追究法律责任，后果自负
-->
<template>
  <div class="execution">
    <basic-container>
      <el-row :span="24" :gutter="10">
        <el-col :xs="24"
                :sm="24"
                :md="3">
          <el-card class="box-card" shadow="never">
            <div slot="header" class="clearfix">
              <span>机构名称</span>
            </div>
            <avue-tree :option="treeOption"
                       :data="treeOrganData"
                       @node-click="nodeClick"></avue-tree>
          </el-card>
        </el-col>
        <el-col :xs="24"
                :sm="24"
                :md="20"
                class="user__main">
          <avue-crud ref="crud"
                 v-model="form"
                 :page="page"
                 :data="tableData"
                 :table-loading="tableLoading"
                 :option="tableOption"
                 :permission="permissionList"
                 @on-load="getPage"
                 @refresh-change="refreshChange"
                 @row-update="handleUpdate"
                 @row-save="handleSave"
                 @row-del="handleDel"
                 @sort-change="sortChange"
                 @search-change="searchChange">
            <template slot="menuLeft">
<!--              <el-button type="warning" size="small" icon="el-icon-connection" v-if="permissions['wxmp:wxapp:add']" @click="toAuth">-->
<!--                一键授权添加-->
<!--              </el-button>-->
            </template>
            <template slot="keyPathForm"
                      slot-scope="scope">
              <div v-if="scope.row.keyPath">
                <el-tag closable @close="keyPathRemove">
                  {{scope.row.keyPath}}
                </el-tag>
              </div>
              <el-upload
                      v-if="!scope.row.keyPath"
                      :action="'/weixin/wxapp/cert/upload?appId='+form.id"
                      :headers="headers"
                      :limit="1"
                      :on-success="uploadCertSuccess">
                <el-button size="small" type="primary">点击上传</el-button>
                <div slot="tip" class="el-upload__tip">请上传apiclient_cert.p12</div>
              </el-upload>
            </template>
            <template slot="name" slot-scope="scope">
              <div style="font-weight: bolder">
                <i class="el-icon-s-cooperation"></i> {{scope.row.name}}
              </div>
            </template>
            <template slot-scope="props" slot="expand">
              <el-row>
                <el-col :span="4" style="text-align: center" v-if="props.row.isComponent == '0'">
                  <el-image
                    style="width: 160px; height: 160px"
                    :src="props.row.qrCode"></el-image><p/>
                </el-col>
                <el-col :span="6" style="text-align: center" v-if="props.row.isComponent == '1'">
                  <el-image
                    style="width: 160px; height: 160px"
                    :src="props.row.qrCode"></el-image><p/>
                  <el-button type="warning" size="small" icon="el-icon-connection" v-if="permissions['wxmp:wxapp:add']" @click="toAuth">
                    重新授权
                  </el-button>
                  <el-button type="success" size="small" icon="el-icon-connection" @click="getAuthorizerInfo(props.row.id)">
                    授权信息
                  </el-button>
                </el-col>
                <el-col :span="18">
                  <div class="expand-left">
                    <div>
                      <el-form ref="form" :model="props.row" label-width="80px" size="mini" label-position="left">
                        <el-form-item label="AppID">
                          ：{{props.row.id}}
                          <el-button type="warning"
                                     icon="el-icon-key"
                                     size="small"
                                     plain
                                     class="mag_left"
                                     @click="getAccessToken(props.row.id)">查看access-token</el-button>
                          <el-button type="warning"
                                     icon="el-icon-refresh"
                                     size="small"
                                     plain
                                     class="mag_left"
                                     @click="clearQuota(props.row.id)">api次数清零</el-button>
                        </el-form-item>
                        <el-form-item label="主体名称">
                          ：{{props.row.principalName}}
                        </el-form-item>
                        <el-form-item label="创建时间">
                          ：{{props.row.createTime}}
                        </el-form-item>
                      </el-form>
                    </div>
                  </div>
                </el-col>
              </el-row>
            </template>
          </avue-crud>
        </el-col>
      </el-row>
      <el-dialog
        title="查看权限集"
        :visible.sync="dialogAuthorizerInfo"
        width="30%">
        <el-checkbox-group v-model="authorizerList">
          <el-checkbox label="1" disabled>消息管理权限</el-checkbox>
          <el-checkbox label="2" disabled>用户管理权限</el-checkbox>
          <el-checkbox label="3" disabled>帐号服务权限</el-checkbox>
          <el-checkbox label="4" disabled>网页服务权限</el-checkbox>
          <el-checkbox label="5" disabled>微信小店权限</el-checkbox>
          <el-checkbox label="6" disabled>微信多客服权限</el-checkbox>
          <el-checkbox label="7" disabled>群发与通知权限</el-checkbox>
          <el-checkbox label="8" disabled>微信卡券权限</el-checkbox>
          <el-checkbox label="9" disabled>微信扫一扫权限</el-checkbox>
          <el-checkbox label="10" disabled>微信连 WI-FI 权限</el-checkbox>
          <el-checkbox label="11" disabled>素材管理权限</el-checkbox>
          <el-checkbox label="12" disabled>微信摇周边权限</el-checkbox>
          <el-checkbox label="13" disabled>微信门店权限</el-checkbox>
          <el-checkbox label="15" disabled>自定义菜单权限</el-checkbox>
          <el-checkbox label="22" disabled>城市服务接口权限</el-checkbox>
          <el-checkbox label="26" disabled>微信电子发票权限</el-checkbox>
          <el-checkbox label="24" disabled>微信开放平台帐号管理权限</el-checkbox>
          <el-checkbox label="17" disabled>帐号管理权限</el-checkbox>
          <el-checkbox label="18" disabled>开发管理与数据分析权限  </el-checkbox>
          <el-checkbox label="19" disabled>客服消息管理权限</el-checkbox>
          <el-checkbox label="24" disabled>微信开放平台帐号管理权限</el-checkbox>
          <el-checkbox label="30" disabled>小程序基本信息设置权限</el-checkbox>
          <el-checkbox label="37" disabled>小程序附近地点权限集</el-checkbox>
          <el-checkbox label="40" disabled>小程序插件管理权限集</el-checkbox>
        </el-checkbox-group>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
  import { getPage, getObj, addObj, putObj, delObj, createQrCode, clearQuota, getAccessToken, getAuthorizerInfo } from '@/api/wxma/wxapp'
  import { tableOption } from '@/const/crud/wxma/wxapp'
  import {fetchTree} from "@/api/admin/organ"
  import { mapGetters, mapState } from 'vuex'
  import store from "@/store"

  export default {
    name: 'wxapp',
    data() {
      return {
        headers: {
          Authorization: 'Bearer ' + store.getters.access_token
        },
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
        form: {},
        authorizerList: [],
        dialogAuthorizerInfo: false,
        host: window.location.href.split('#')[0],
        tableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20, // 每页显示多少条
          ascs:[],
          descs: 'create_time'
        },
        paramsSearch:{},
        tableLoading: false,
        tableOption: tableOption,
        treeOrganData: [],
        organProps: {
          label: 'name',
          value: 'id',
        },
      }
    },
    created() {
      this.handleOrgan()
    },
    mounted: function() { },
    computed: {
      ...mapGetters(['permissions']),
      ...mapState({
        userInfo: state => state.user.userInfo
      }),
      permissionList() {
        return {
          addBtn: this.permissions['wxmp:wxapp:add'] ? true : false,
          delBtn: this.permissions['wxmp:wxapp:del'] ? true : false,
          editBtn: this.permissions['wxmp:wxapp:edit'] ? true : false,
          viewBtn: this.permissions['wxmp:wxapp:get'] ? true : false
        }
      }
    },
    methods: {
      keyPathRemove(){
        this.form.keyPath = ''
      },
      uploadCertSuccess(response, file, fileList){
        this.form.keyPath = response.link
      },
      nodeClick(data) {
        this.page.currentPage = 1
        this.getPage(this.page, {organId: data.id})
      },
      handleOrgan() {
        fetchTree().then(response => {
          this.treeOrganData = response.data.data;
        });
      },
      getAuthorizerInfo(appId){
        this.tableLoading = true
        getAuthorizerInfo(appId)
          .then(response => {
            this.tableLoading = false
            this.dialogAuthorizerInfo = true
            let funcInfo = response.data.data.authorizationInfo.funcInfo
            funcInfo.forEach(function (val,index) {
              funcInfo[index] = val+''
            })
            this.authorizerList = funcInfo
        }).catch(() => {
          this.tableLoading = false
        })
      },
      toAuth(){
        window.open('view/wxopen/auth.html?authType=2&tenantId='+this.userInfo.tenantId+'&organId='+this.userInfo.organId+'&host='+this.host)
        this.$confirm('请在新打开的窗口中完成授权', '确认信息', {
          distinguishCancelAndClose: true,
          confirmButtonText: '授权成功',
          cancelButtonText: '授权失败'
        })
          .then(() => {
            this.getPage(this.page)
          })
          .catch(action => {
            this.getPage(this.page)
          })
      },
      toAccess(row){
        this.$alert('<textarea rows="3" style="width: 100%">'+ this.host + 'wxmp/portal/'+ row.id +'</textarea>', '接入地址', {
          dangerouslyUseHTMLString: true
        })
      },
      clearQuota(val){
        let _this = this
        this.$confirm('是否确认要清零微信接口次数', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function() {
          _this.tableLoading = true
          clearQuota({
            id : val
          }).then(response => {
            _this.tableLoading = false
            if(response.data.code == '0'){
              _this.$message({
                showClose: true,
                message: '清零成功',
                type: 'success'
              })
            }
          }).catch(() => {
            _this.tableLoading = false
          })
        })
      },
      createQrCode(val){
        this.tableLoading = true
        createQrCode({
          id : val,
          sceneStr : '1'//默认场景值
        }).then(response => {
          this.tableLoading = false
          this.getPage(this.page)
        }).catch(() => {
          this.tableLoading = false
        })
      },
      searchChange(params,done){
        params = this.filterForm(params)
        this.paramsSearch = params
        this.page.currentPage = 1
        this.getPage(this.page,params)
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
          appType: '1'
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
      handleDel: function(row, index) {
        var _this = this
        this.$confirm('是否确认删除【' + row.name+'】', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function() {
            return delObj(row.id)
          }).then(data => {
          _this.$message({
            showClose: true,
            message: '删除成功',
            type: 'success'
          })
          this.getPage(this.page)
        }).catch(function(err) { })
      },
      /**
       * @title 数据更新
       * @param row 为当前的数据
       * @param index 为当前更新数据的行数
       * @param done 为表单关闭函数
       *
       **/
      handleUpdate: function(row, index, done, loading) {
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
      handleSave: function(row, done, loading) {
        addObj(Object.assign(row,{
          isComponent: '0',
          appType: '1'
        })).then(data => {
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
        this.getPage(this.page)
      },
      getAccessToken(appId){
        this.tableLoading = true
        getAccessToken({
          id: appId
        }).then(response => {
          this.tableLoading = false
          const h = this.$createElement
          this.$alert('<textarea rows="5" style="width: 100%">'+response.data.data+'</textarea>', 'AccessToken', {
            dangerouslyUseHTMLString: true
          })
        }).catch(() => {
          this.tableLoading = false
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  .mag_left{margin-left: 10px}
  .expand-left{
    margin-left: 50px
  }
  .el-form-item{
    margin-bottom:10px;
  }
  img{
    width: unset;
  }
</style>
