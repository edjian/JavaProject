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
      <el-row :span="24">
        <el-col :xs="24"
                :sm="24"
                :md="3">
          <avue-tree :option="treeOption"
                     :data="treeData"
                     v-model="treeForm"
                     @update="updateTree"
                     @save="saveTree"
                     @del="delTree"
                     @node-click="nodeClick"></avue-tree>
        </el-col>
        <el-col :xs="24"
                :sm="24"
                :md="21">
          <avue-crud ref="crud"
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
                     @search-change="searchChange"
                     @selection-change="selectionChange">
            <template slot="subscribe" slot-scope="scope" >
              <el-tag size="mini" effect="dark" :type="scope.row.subscribe == '1' ? 'success' : scope.row.subscribe == '0' ? 'danger' : 'warning'">{{scope.row.$subscribe}}</el-tag>
            </template>
            <template slot="sex" slot-scope="scope" >
              <el-tag size="mini" effect="light" :type="scope.row.sex == '1' ? '' : scope.row.sex == '2' ? 'danger' : 'warning'">{{scope.row.$sex}}</el-tag>
            </template>
            <template slot="latitude" slot-scope="scope">
              <el-link v-if="scope.row.longitude" type="primary" target="_blank" :href="'https://map.qq.com/?type=marker&isopeninfowin=1&markertype=1&pointx='+scope.row.longitude+'&pointy='+scope.row.latitude+'&name='+scope.row.nickName+'&ref=joolun'">
                <i class="el-icon-map-location"></i>
              </el-link>
            </template>
            <template slot="menuLeft">
              <el-button type="success"
                         @click="dialogTagging = true; taggingType = 'tagging'"
                         size="small"
                         icon="el-icon-document"
                         v-if="permissions.wxmp_wxuser_tagging">打标签</el-button>
              <el-button type="warning"
                         @click="dialogTagging = true; taggingType = 'unTagging'"
                         size="small"
                         icon="el-icon-document"
                         v-if="permissions.wxmp_wxuser_tagging">去除标签</el-button>
              <el-button type="danger"
                         @click="synchroWxUser"
                         size="small"
                         icon="el-icon-refresh"
                         v-if="permissions.wxmp_wxuser_synchro">同步用户</el-button>
              <el-dialog
                :title='taggingType == "tagging"?"请选择要打的标签":"请选择要去除的标签"'
                :visible.sync="dialogTagging"
                width="30%">
                <el-checkbox-group v-model="checkedTags">
                  <el-checkbox v-for="tag in userTagsData" :label="tag.id" :key="tag.id">{{tag.name}}</el-checkbox>
                </el-checkbox-group>
                <span slot="footer" class="dialog-footer">
                  <el-button @click="dialogTagging = false">取 消</el-button>
                  <el-button type="primary" @click="toTagging">确 定</el-button>
                </span>
              </el-dialog>
            </template>
            <template slot="menu" slot-scope="scope">
              <el-button type="text"
                         v-if="permissions.wxmp_wxuser_edit_remark"
                         icon="el-icon-edit"
                         size="small"
                         plain
                         @click="updateRemark(scope.row,scope.index)">修改备注</el-button>
              <el-button type="text"
                         v-if="permissions.wxmp_wxmsg_index"
                         icon="el-icon-chat-line-round"
                         size="small"
                         plain
                         @click="wxMsgDo(scope.row,scope.index)">消息</el-button>
            </template>
            <template slot="tagidList" slot-scope="scope">
              <span v-html="scope.label"></span>
            </template>
          </avue-crud>
        </el-col>
      </el-row>
      <el-dialog title="用户消息" :visible.sync="dialogMsgVisible" width="40%">
        <WxMsg :appId="appId" :wxUserId="wxUserId" v-if="dialogMsgVisible"></WxMsg>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
  import { getPage, getObj, addObj, putObj, delObj,synchroWxUser, listUserTags, addTags, putTags, delTags, updateRemark, tagging } from '@/api/wxmp/wxuser'
  import { tableOption } from '@/const/crud/wxmp/wxuser'
  import { mapGetters } from 'vuex'
  import WxMsg from '@/components/wx-msg/main.vue'
  export default {
    name: 'wxuser',
    components: {
      WxMsg
    },
    data() {
      return {
        dialogMsgVisible:false,
        wxUserId:'',
        treeForm:{},
        treeOption: {
          nodeKey: 'id',
          props: {
            label: 'name',
            value: 'id'
          }
        },
        treeData: [],
        tableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20, // 每页显示多少条
          ascs: [],
          descs: 'subscribe_time'
        },
        paramsSearch:{},
        tableLoading: false,
        appId: this.$route.query.id,
        tableOption: tableOption,
        selectionData: [],
        dialogTagging: false,
        checkedTags: [],
        userTagsData: [],
        taggingType: '',
        tagId: ''
      }
    },
    created() {
      let column =this.tableOption.column[10]
      column.dicUrl = '/weixin/wxusertags/dict?appId='+this.$route.query.id
      this.listUserTags()
    },
    mounted: function() { },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.vaildData(this.permissions.wxmp_wxuser_add, false),
          delBtn: this.vaildData(this.permissions.wxmp_wxuser_del, false),
          editBtn: this.vaildData(this.permissions.wxmp_wxuser_edit, false),
          viewBtn: this.vaildData(this.permissions.wxmp_wxuser_get, false)
        }
      }
    },
    methods: {
      wxMsgDo(row){
        this.wxUserId = row.id
        this.dialogMsgVisible = true
      },
      toTagging(){
        let openIdList = []
        for(let i=0;i<this.selectionData.length;i++){
          openIdList.push(this.selectionData[i].openId)
        }
        if(this.checkedTags.length<=0){
          this.$message.error('请选择标签')
          return
        }
        if(openIdList.length<=0){
          this.$message.error('请选择用户')
          return
        }
        this.tableLoading = true
        tagging({
          taggingType:this.taggingType,
          appId:this.appId,
          tagIds:this.checkedTags,
          openIds:openIdList
        }).then(response => {
          this.tableLoading = false
          this.checkedTags = []
          if(response.data.code == '0'){
            this.getPage(this.page)
          }else{
            this.$message.error('打标签出错：' + response.data.msg)
          }
        }).catch(() => {
          this.tableLoading = false
        })
        this.dialogTagging = false
      },
      selectionChange(list){
        this.selectionData = list
      },
      updateTree(data, node, done){
        if(this.treeForm.id!=-1){
          putTags({
            appId:this.appId,
            id:this.treeForm.id,
            name:this.treeForm.name
          }).then(response => {
            if(response.data.code == '0'){
              done()
              this.listUserTags()
            }else{
              this.$message.error('修改用户标签出错：' + response.data.msg)
            }
          })
        }
      },
      saveTree(data, node, done){
        addTags({
          appId:this.appId,
          name:this.treeForm.name
        }).then(response => {
          if(response.data.code == '0'){
            done()
            this.listUserTags()
          }else{
            this.$message.error('新增用户标签出错：' + response.data.msg)
          }
        })
      },
      delTree(data, node, done){
        if(data.id!=-1){
          delTags({
            appId:this.appId,
            id:data.id
          }).then(response => {
            if(response.data.code == '0'){
              done()
              this.listUserTags()
            }else{
              this.$message.error('删除用户标签出错：' + response.data.msg)
            }
          })
        }
      },
      listUserTags() {
        listUserTags({
          appId:this.appId
        }).then(response => {
          if(response.data.code == '0'){
            let userTagsData = response.data.data
            this.userTagsData = userTagsData
            this.treeData = [{
              id:'-1',
              name:'全部标签',
              children:userTagsData
            }]
          }else{
            this.$message.error('获取用户标签出错：' + response.data.msg)
          }
        })
      },
      nodeClick(val){
        let params = []
        if(val.id != -1){
          this.tagId = val.id
        }else{
          this.tagId = ''
        }
        this.page.currentPage = 1
        this.getPage(this.page, params)
      },
      searchChange(params,done){
        params = this.filterForm(params)
        this.paramsSearch = params
        this.page.currentPage = 1
        this.getPage(this.page,params)
        done()
      },
      synchroWxUser(){
        this.$confirm('同步用户需要一定时间，用户量越大、用时越久，请耐心等待，勿重复提交；确认此操作吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.tableLoading = true
          synchroWxUser({
            appId:this.appId
          }).then(response => {
            this.tableLoading = false
            if(response.data.code == '0'){
              this.getPage(this.page)
            }else{
              this.$message.error('同步微信用户出错：' + response.data.msg)
            }
          }).catch(() => {
            this.tableLoading = false
          })
          setTimeout(() =>{
            if(this.tableLoading){
              this.tableLoading = false
              this.$alert('同步请求发送成功，系统正在处理中，请稍后刷新查看同步结果，用户量越大用时越久，请耐心等待，勿重复提交', '提示', {
                confirmButtonText: '确定'
              })
            }
          },3000)
        }).catch(() => {
        })
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
          appId:this.appId,
          tagId: this.tagId
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
      updateRemark(row, index){
        this.$prompt('请输入备注', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          inputPattern: /\S/,
          inputErrorMessage: '输入不能为空'
        }).then(({ value }) => {
          this.tableLoading = true
          row.remark = value
          updateRemark(row).then(response => {
            this.tableLoading = false
            if(response.data.code == '0'){
              this.tableData.splice(index, 1, Object.assign({}, row))
              this.$message({
                showClose: true,
                message: '修改成功',
                type: 'success'
              })
              this.getPage(this.page)
            }else{
              this.$message.error(response.data.msg)
            }
          }).catch(() => {
            this.tableLoading = false
          })
        })
      },
      handleDel: function(row, index) {
        var _this = this
        this.$confirm('是否确认删除', '提示', {
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
      refreshChange(val) {
        this.getPage(val.page)
      }
    }
  }
</script>

<style lang="scss" scoped>
</style>
