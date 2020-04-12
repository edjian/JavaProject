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
          <avue-crud ref="crud"
                     :page="page"
                     :data="tableData"
                     :permission="permissionList"
                     :table-loading="tableLoading"
                     :option="tableOption"
                     @on-load="getPage"
                     @refresh-change="refreshChange"
                     @row-update="handleUpdate"
                     @row-save="handleSave"
                     @row-del="handleDel"
                     @sort-change="sortChange"
                     @search-change="searchChange">
            <template slot="appName" slot-scope="scope" >
              <el-tag type="success" size="mini">{{scope.row.appName}}</el-tag>
            </template>
            <template slot="nickName" slot-scope="scope" >
              <el-badge :value="scope.row.countMsg" class="count-msg">
                <img class="head-img" :src="scope.row.headimgUrl"/>
              </el-badge>
            </template>
            <template slot="readFlag" slot-scope="scope" >
              <el-tag :type="scope.row.readFlag == '1' ? 'success' : 'danger'" size="mini">{{scope.row.$readFlag}}</el-tag>
            </template>
            <template slot="repContent" slot-scope="scope" >
              <div class="nick-name">{{scope.row.nickName}}</div>
              <div v-if="scope.row.repType == 'event' && scope.row.repEvent == 'subscribe'"><el-tag type="success" size="mini">关注</el-tag></div>
              <div v-if="scope.row.repType == 'event' && scope.row.repEvent == 'unsubscribe'"><el-tag type="danger" size="mini">取消关注</el-tag></div>
              <div v-if="scope.row.repType == 'event' && scope.row.repEvent == 'CLICK'"><el-tag size="mini">点击菜单</el-tag>：【{{scope.row.repName}}】</div>
              <div v-if="scope.row.repType == 'event' && scope.row.repEvent == 'VIEW'"><el-tag size="mini">点击菜单链接</el-tag>：【{{scope.row.repUrl}}】</div>
              <div v-if="scope.row.repType == 'event' && scope.row.repEvent == 'scancode_waitmsg'"><el-tag size="mini">扫码结果：</el-tag>：【{{scope.row.repContent}}】</div>
              <div v-if="scope.row.repType == 'text'">{{scope.row.repContent}}</div>
              <div v-if="scope.row.repType == 'image'">
                <a target="_blank" :href="scope.row.repUrl"><img :src="scope.row.repUrl" style="width: 100px"></a>
              </div>
              <div v-if="scope.row.repType == 'voice'">
                <WxVoicePlayer :appId="appId" :objData="scope.row"></WxVoicePlayer>
              </div>
              <div v-if="scope.row.repType == 'video'">
                <WxVideoPlayer :appId="appId" :objData="scope.row" style="margin-top: 40px"></WxVideoPlayer>
              </div>
              <div v-if="scope.row.repType == 'shortvideo'">
                <WxVideoPlayer :appId="appId" :objData="scope.row" style="margin-top: 40px"></WxVideoPlayer>
              </div>
              <el-link type="primary" v-if="scope.row.repType == 'location'" target="_blank" :href="'https://map.qq.com/?type=marker&isopeninfowin=1&markertype=1&pointx='+scope.row.repLocationY+'&pointy='+scope.row.repLocationX+'&name='+scope.row.repContent+'&ref=joolun'">
                <img :src="'https://apis.map.qq.com/ws/staticmap/v2/?zoom=10&markers=color:blue|label:A|'+scope.row.repLocationX+','+scope.row.repLocationY+'&key='+ qqMapKey +'&size=200*150'">
                <p/><i class="el-icon-map-location"></i>{{scope.row.repContent}}
              </el-link>
              <div v-if="scope.row.repType == 'link'"><el-tag size="mini">链接</el-tag>：<a :href="scope.row.repUrl" target="_blank">{{scope.row.repName}}</a></div>
            </template>
            <template slot-scope="scope"
                      slot="menu">
              <el-button type="text"
                         v-if="permissions['wxmp:wxmsg:index']"
                         icon="el-icon-chat-line-round"
                         size="small"
                         plain
                         @click="wxMsgDo(scope.row,scope.index)">消息</el-button>
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
  import { getPage, getObj, addObj, putObj, delObj } from '@/api/wxmp/wxmsg'
  import { getList as getWxAppList } from '@/api/wxmp/wxapp'
  import { tableOption } from '@/const/crud/wxmp/wxmsg'
  import { mapGetters } from 'vuex'
  import { qqMapKey } from '@/config/env'
  import WxMsg from '@/components/wx-msg/main.vue'
  import WxVideoPlayer from '@/components/wx-video-play/main.vue'
  import WxVoicePlayer from '@/components/wx-voice-play/main.vue'
  export default {
    name: 'wxmsg',
    components: {
      WxMsg,
      WxVideoPlayer,
      WxVoicePlayer
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
        dialogMsgVisible: false,
        tableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20, // 每页显示多少条
          ascs:[],//升序字段
          descs:"create_time"//降序字段
        },
        paramsSearch:{},
        tableLoading: false,
        tableOption: tableOption,
        wxUserId: ''
      }
    },
    watch: {
      filterText(val) {
        this.$refs.tree.filter(val)
      }
    },
    created() {
      this.getWxAppList()
    },
    mounted: function() { },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.permissions['wxmp:wxmsg:add'] ? true : false,
          delBtn: this.permissions['wxmp:wxmsg:del'] ? true : false,
          editBtn: this.permissions['wxmp:wxmsg:edit'] ? true : false,
          viewBtn: this.permissions['wxmp:wxmsg:get'] ? true : false
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
      wxMsgDo(row){
        this.wxUserId = row.wxUserId
        this.dialogMsgVisible = true
        this.$set(row, 'readFlag', '1')
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
            type: '1'
          }, params, this.paramsSearch)).then(response => {
            this.tableData = response.data.data.records
            this.page.total = response.data.data.total
            this.page.currentPage = page.currentPage
            this.page.pageSize = page.pageSize
            this.tableLoading = false
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
      refreshChange(page) {
        this.getPage(this.page)
      }
    }
  }
</script>

<style lang="scss" scoped>
  .head-img{
    width: 50px;
  }
</style>
