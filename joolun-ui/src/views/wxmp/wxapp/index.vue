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
                :md="4">
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
              <el-button type="warning" size="small" icon="el-icon-connection" v-if="permissions['wxmp:wxapp:add']" @click="toAuth">
                一键授权添加
              </el-button>
            </template>
            <template slot="name" slot-scope="scope">
              <div style="font-weight: bolder">
                <i class="el-icon-s-cooperation"></i> {{scope.row.name}}
              </div>
            </template>
            <template slot="verifyType" slot-scope="scope">
              <div v-if="scope.row.verifyType=='-1'">
                <el-tag type="danger" effect="dark" size="mini"> {{ scope.row.$verifyType }} </el-tag>&nbsp;
                <el-link type="danger" href="https://mp.weixin.qq.com/cgi-bin/loginpage?t=wxm2-login&lang=zh_CN">部份功能不能正常使用，请前去认证</el-link>
              </div>
              <el-tag type="success" effect="dark" size="mini" v-if="scope.row.verifyType=='0' || scope.row.verifyType=='1' || scope.row.verifyType=='2'"> {{ scope.row.$verifyType }} </el-tag>
              <el-tag type="warning" effect="dark" size="mini" v-if="scope.row.verifyType=='3' || scope.row.verifyType=='4' || scope.row.verifyType=='5'"> {{ scope.row.$verifyType }} </el-tag>
            </template>
            <template slot="weixinType" slot-scope="scope" >
              <div style="font-weight: bolder">
                {{scope.row.$weixinType}}
              </div>
            </template>
            <template slot-scope="props" slot="expand">
              <el-row>
                <el-col :span="6" style="text-align: center" v-if="props.row.isComponent == '0'">
                  <vue-qr v-if="props.row.qrCode" :text="props.row.qrCode" :size="160" :dotScale = 1></vue-qr><p/>
                  <el-button type="success"
                             size="small"
                             icon="el-icon-s-grid"
                             v-if="!props.row.qrCode" @click="createQrCode(props.row.id)" style="margin-top: 30%">生成二维码</el-button>
                  <el-button type="warning"
                             v-if="permissions['wxmp:wxapp:edit'] && props.row.isComponent == '0'"
                             icon="el-icon-s-promotion"
                             size="small"
                             @click="toAccess(props.row)">接入系统</el-button>
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
                          <el-button type="warning"
                                     icon="el-icon-s-grid"
                                     size="small"
                                     plain
                                     class="mag_left"
                                     @click="getQrCode(props.row.id)">场景二维码</el-button>
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
      <el-dialog
              :title="'场景值'+scene"
              :visible.sync="qrCodeSceneDialog"
              center
              width="50%">
        <el-row>
          <el-col :span="8">
            <vue-qr :text="qrCodeScene" :size="160" :dotScale = 1></vue-qr>
            <p>160x160</p>
          </el-col>
          <el-col :span="8">
            <vue-qr :text="qrCodeScene" :size="200" :dotScale = 1></vue-qr>
            <p>200x200</p>
          </el-col>
          <el-col :span="8">
            <vue-qr :text="qrCodeScene" :size="320" :dotScale = 1></vue-qr>
            <p>320x320</p>
          </el-col>
        </el-row>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
  import { getPage, getObj, addObj, putObj, delObj, createQrCode, clearQuota, getAccessToken, getAuthorizerInfo, getQrCode } from '@/api/wxmp/wxapp'
  import { tableOption } from '@/const/crud/wxmp/wxapp'
  import {fetchTree} from "@/api/admin/organ"
  import { mapGetters, mapState } from 'vuex'
  export default {
    name: 'wxapp',
    data() {
      return {
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
        qrCodeSceneDialog: false,
        scene: null,
        qrCodeScene: null
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
        window.open('view/wxopen/auth.html?authType=1&tenantId='+this.userInfo.tenantId+'&organId='+this.userInfo.organId+'&host='+this.host)
        this.$confirm('请在新打开的窗口中完成授权？', '确认信息', {
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
        this.$alert('<textarea rows="3" style="width: 100%">'+ this.host + 'weixin/portal/'+ row.id +'</textarea>', '接入地址', {
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
      getQrCode(val){
        let that = this
        this.$prompt('请输入场景值', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消'
        }).then(({ value }) => {
          getQrCode({
            id: val,
            sceneStr: value
          }).then(response => {
            that.scene = value
            that.qrCodeSceneDialog = true
            that.qrCodeScene = response.data.data
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
          appType: '2'
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
          appType: '2'
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
