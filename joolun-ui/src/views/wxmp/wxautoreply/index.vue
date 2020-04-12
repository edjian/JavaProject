<!--
  - Copyright (C) 2018-2019
  - All rights reserved, Designed By www.joolun.com
  - 注意：
  - 本软件为www.joolun.com开发研制，未经购买不得使用
  - 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
  - 一经发现盗用、分享等行为，将追究法律责任，后果自负
-->
<template>
  <div class="execution wxautoreply">
    <basic-container>
      <el-row :span="24" :gutter="10">
        <el-col :xs="24"
                :sm="24"
                :md="3">
          <el-card shadow="never">
            <div slot="header">
              <span>公众号名称</span>
            </div>
            <el-input
                    placeholder="输入关键字进行过滤"
                    size="mini"
                    v-model="filterText">
            </el-input>
            <el-tree
                    style="margin-top: 5px"
                    :data="treeWxAppData"
                    :props="treeWxAppProps"
                    :filter-node-method="filterNode"
                    node-key="id"
                    default-expand-all
                    ref="tree"
                    @node-click="nodeClick">
            </el-tree>
          </el-card>
        </el-col>
        <el-col :xs="24"
                :sm="24"
                :md="21">
          <el-tabs v-model="type" @tab-click="handleClick">
            <el-tab-pane name="1">
              <span slot="label"><i class="el-icon-star-off"></i> 关注时回复</span>
              <avue-crud ref="crud"
                         :page="page"
                         :data="tableData"
                         :permission="permissionList"
                         :table-loading="tableLoading"
                         :option="tableOption1"
                         @refresh-change="refreshChange">
                <template slot-scope="scope" slot="menuLeft">
                  <div class="add_but" v-if="tableData.length<=0">
                    <el-button type="primary"
                               @click="handleAdd"
                               size="mini"
                               v-if="permissions['wxmp:wxautoreply:add']">新 增</el-button>
                  </div>
                </template>
                <template slot-scope="scope" slot="menu">
                  <el-button type="text"
                             v-if="permissions['wxmp:wxautoreply:edit']"
                             icon="el-icon-edit"
                             size="small"
                             plain
                             @click="handleEdit(scope.row)">编辑</el-button>
                  <el-button type="text"
                             v-if="permissions['wxmp:wxautoreply:del']"
                             icon="el-icon-delete"
                             size="small"
                             plain
                             @click="handleDel(scope.row)">删除</el-button>
                </template>
              </avue-crud>
            </el-tab-pane>
            <el-tab-pane name="2">
              <span slot="label"><i class="el-icon-chat-line-round"></i> 消息回复</span>
              <avue-crud ref="crud"
                         :page="page"
                         :data="tableData"
                         :permission="permissionList"
                         :table-loading="tableLoading"
                         :option="tableOption2"
                         @refresh-change="refreshChange"
                         @sort-change="sortChange">
                <template slot-scope="scope" slot="menuLeft">
                  <div class="add_but">
                    <el-button type="primary"
                               @click="handleAdd"
                               size="mini"
                               v-if="permissions['wxmp:wxautoreply:add']">新 增</el-button>
                  </div>
                </template>
                <template slot-scope="scope" slot="menu">
                  <el-button type="text"
                             v-if="permissions['wxmp:wxautoreply:edit']"
                             icon="el-icon-edit"
                             size="small"
                             plain
                             @click="handleEdit(scope.row)">编辑</el-button>
                  <el-button type="text"
                             v-if="permissions['wxmp:wxautoreply:del']"
                             icon="el-icon-delete"
                             size="small"
                             plain
                             @click="handleDel(scope.row)">删除</el-button>
                </template>
              </avue-crud>
            </el-tab-pane>
            <el-tab-pane name="3">
              <span slot="label"><i class="el-icon-news"></i> 关键词回复</span>
              <avue-crud ref="crud"
                         :page="page"
                         :data="tableData"
                         :permission="permissionList"
                         :table-loading="tableLoading"
                         :option="tableOption3"
                         @refresh-change="refreshChange"
                         @sort-change="sortChange"
                         @search-change="searchChange">
                <template slot-scope="scope" slot="menuLeft">
                  <div class="add_but">
                    <el-button type="primary"
                               @click="handleAdd"
                               size="mini"
                               v-if="permissions['wxmp:wxautoreply:add']">新 增</el-button>
                  </div>
                </template>
                <template slot-scope="scope" slot="menu">
                  <el-button type="text"
                             v-if="permissions['wxmp:wxautoreply:edit']"
                             icon="el-icon-edit"
                             size="small"
                             plain
                             @click="handleEdit(scope.row)">编辑</el-button>
                  <el-button type="text"
                             v-if="permissions['wxmp:wxautoreply:del']"
                             icon="el-icon-delete"
                             size="small"
                             plain
                             @click="handleDel(scope.row)">删除</el-button>
                </template>
              </avue-crud>
            </el-tab-pane>
          </el-tabs>
        </el-col>
      </el-row>
      <el-dialog :title="handleType == 'add' ? '新增回复消息' : '修改回复消息'" :visible.sync="dialog1Visible" width="50%">
        <el-form label-width="100px">
          <el-form-item label="请求消息类型" v-if="type == '2'">
            <el-select v-model="objData.reqType" placeholder="请选择">
              <el-option
                v-for="item in dictData.get('wx_req_type')"
                :key="item.value"
                :label="item.label"
                :value="item.value"
                :disabled="item.disabled"
                v-if="item.value !== 'event'">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="匹配类型" v-if="type == '3'">
            <el-select v-model="objData.repMate" placeholder="请选择" style="width: 100px">
              <el-option
                v-for="item in dictData.get('wx_rep_mate')"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="关键词" v-if="type == '3'">
            <el-input placeholder="请输入内容" v-model="objData.reqKey" clearable> </el-input>
          </el-form-item>
          <el-form-item label="回复消息">
            <WxReplySelect :appId="appId" :objData="objData" :oneNews="type != '1'" v-if="hackResetWxReplySelect"></WxReplySelect>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialog1Visible = false">取 消</el-button>
          <el-button type="primary" @click="handleSubmit">确 定</el-button>
        </span>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
  import { getPage, getObj, addObj, putObj, delObj } from '@/api/wxmp/wxautoreply'
  import { getList as getWxAppList } from '@/api/wxmp/wxapp'
  import { remote } from '@/api/admin/dict.js'
  import { tableOption1, tableOption2, tableOption3 } from '@/const/crud/wxmp/wxautoreply'
  import { mapGetters } from 'vuex'
  import WxReplySelect from '@/components/wx-reply/main.vue'

  export default {
    name: 'wxautoreply',
    components: {
      WxReplySelect
    },
    data() {
      return {
        filterText: '',
        treeWxAppProps: {
          label: 'name',
          value: 'id'
        },
        treeWxAppData: [],
        appId: null,
        tableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20, // 每页显示多少条
          ascs:[],//升序字段
          descs:[]//降序字段
        },
        paramsSearch:{},
        tableLoading: false,
        tableOption1:tableOption1,
        tableOption2:tableOption2,
        tableOption3: tableOption3,
        dialog1Visible:false,
        type:'1',//类型（1、关注时回复；2、消息回复；3、关键词回复）
        objData:{
          repType : 'text'
        },
        handleType:null,
        dictData:new Map(),
        hackResetWxReplySelect:false
      }
    },
    watch: {
      filterText(val) {
        this.$refs.tree.filter(val)
      }
    },
    created() {
      this.remoteDict('wx_req_type')
      this.remoteDict('wx_rep_mate')
      this.getWxAppList()
    },
    mounted: function() { },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.permissions['wxmp:wxautoreply:add'] ? true : false,
          delBtn: this.permissions['wxmp:wxautoreply:del'] ? true : false,
          editBtn: this.permissions['wxmp:wxautoreply:edit'] ? true : false,
          viewBtn: this.permissions['wxmp:wxautoreply:get'] ? true : false
        };
      }
    },
    methods: {
      filterNode(value, data) {
        if (!value) return true
        return data.name.indexOf(value) !== -1
      },
      //加载公众号列表
      getWxAppList(){
        getWxAppList({
          appType: '2'
        }).then(response => {
          let data = response.data
          this.treeWxAppData = data
          if(data && data.length > 0){
            //默认加载第一个公众号的素材
            this.nodeClick({
              id: data[0].id
            })
          }
        }).catch(() => {

        })
      },
      nodeClick(data) {
        if(this.appId != data.id){
          this.$nextTick(() => {
            this.$refs.tree.setCurrentKey(data.id)
          })
          this.page.currentPage = 1
          this.appId = data.id
          this.paramsSearch = {}
          this.$refs.crud.searchReset()
          this.getPage(this.page)
        }
      },
      remoteDict(type){
        remote(type).then(response => {
          this.dictData.set(type,response.data.data)
        })
      },
      handleAdd(){
        this.hackResetWxReplySelect = false//销毁组件
        this.$nextTick(() => {
          this.hackResetWxReplySelect = true//重建组件
        })
        this.handleType = 'add'
        this.dialog1Visible = true
        this.objData = {
          repType : 'text'
        }
      },
      handleEdit(row){
        this.hackResetWxReplySelect = false//销毁组件
        this.$nextTick(() => {
          this.hackResetWxReplySelect = true//重建组件
        })
        this.handleType = 'edit'
        this.dialog1Visible = true
        this.objData = Object.assign({}, row)
      },
      handleClick(tab, event){
        this.tableData = []
        this.page.currentPage = 1
        this.type = tab.name
        this.getPage(this.page)
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
        if(this.appId){
          this.tableLoading = true
          getPage(Object.assign({
            current: page.currentPage,
            size: page.pageSize,
            descs: this.page.descs,
            ascs: this.page.ascs,
            appId: this.appId,
            type: this.type
          }, params, this.paramsSearch)).then(response => {
            this.tableData = response.data.data.records
            this.page.total = response.data.data.total
            this.page.currentPage = page.currentPage
            this.page.pageSize = page.pageSize
            this.tableLoading = false
            if(this.type == '2'){
              let wxReqType = this.dictData.get('wx_req_type')
              for (let i=0;i<wxReqType.length;i++) {
                wxReqType[i].disabled = false
                for(let j=0;j<this.tableData.length;j++){
                  if(wxReqType[i].value == this.tableData[j].reqType){
                    wxReqType[i].disabled = true
                  }
                }
              }
            }
          }).catch(() => {
            this.tableLoading = false
          })
        }
      },
      handleDel: function(row, index) {
        var _this = this
        this.$confirm('是否确认删除此数据', '提示', {
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
      handleSubmit(row){
        if(this.handleType == 'add'){
          addObj(Object.assign({
            appId:this.appId,
            type:this.type
          }, this.objData)).then(data => {
            this.$message({
              showClose: true,
              message: '添加成功',
              type: 'success'
            })
            this.getPage(this.page)
            this.dialog1Visible = false
          })
        }
        if(this.handleType == 'edit'){
          putObj(this.objData).then(data => {
            this.$message({
              showClose: true,
              message: '修改成功',
              type: 'success'
            })
            this.getPage(this.page)
            this.dialog1Visible = false
          })
        }
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
       *
       **/
      handleSave: function(row, done, loading) {
        addObj(Object.assign({
          appId:this.appId,
          type:this.type
        }, this.objData)).then(data => {
          this.$message({
            showClose: true,
            message: '添加成功',
            type: 'success'
          })
          this.getPage(this.page)
          this.dialog1Visible = false
        }).catch(() => {
          done()
        })
      },
      /**
       * 刷新回调
       */
      refreshChange(page) {
        this.objData={
            repType : 'text'
        }
        this.getPage(this.page)
      }
    }
  }
</script>

<style lang="scss">
  .wxautoreply .el-form-item__content{
    line-height:unset!important;
  }
</style>
