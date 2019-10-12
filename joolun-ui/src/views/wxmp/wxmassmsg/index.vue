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
                 @search-change="searchChange"
                 @current-change="currentChange">
        <template slot-scope="scope" slot="menuLeft">
          <el-button type="primary"
                     @click="handleAdd"
                     size="small"
                     icon="el-icon-s-promotion"
                     v-if="permissions.wxmp_wxmassmsg_add">新增群发</el-button>
        </template>
        <template slot-scope="scope" slot="menu">
          <el-button type="text"
                     v-if="permissions.wxmp_wxmassmsg_del && scope.row.msgStatus=='SEND_SUCCESS' && (scope.row.repType == 'news' || scope.row.repType == 'video')"
                     icon="el-icon-delete"
                     size="small"
                     plain
                     @click="handleDel(scope.row)">删除</el-button>
        </template>
        <template slot="repContent" slot-scope="scope" >
          <div class="nick-name">{{scope.row.nickName}}</div>
          <div v-if="scope.row.repType == 'text'">{{scope.row.repContent}}</div>
          <div v-if="scope.row.repType == 'news'">
            <WxNews :objData="scope.row.content.articles"></WxNews>
          </div>
          <div v-if="scope.row.repType == 'image'">
            <a target="_blank" :href="scope.row.repUrl"><img :src="scope.row.repUrl" style="width: 100px"></a>
          </div>
          <div v-if="scope.row.repType == 'voice'">
            <WxVoicePlayer :appId="appId" :objData="Object.assign({type: '2'},scope.row)"></WxVoicePlayer>
          </div>
          <div v-if="scope.row.repType == 'video'">
            <WxVideoPlayer :appId="appId" :objData="Object.assign({type: '2'},scope.row)" style="margin-top: 40px"></WxVideoPlayer>
          </div>
          <div v-if="scope.row.repType == 'shortvideo'">
            <WxVideoPlayer :appId="appId" :objData="Object.assign({type: '2'},scope.row)" style="margin-top: 40px"></WxVideoPlayer>
          </div>
          <el-link type="primary" v-if="scope.row.repType == 'location'" target="_blank" :href="'https://map.qq.com/?type=marker&isopeninfowin=1&markertype=1&pointx='+scope.row.repLocationY+'&pointy='+scope.row.repLocationX+'&name='+scope.row.repContent+'&ref=joolun'">
            <img :src="'https://apis.map.qq.com/ws/staticmap/v2/?zoom=10&markers=color:blue|label:A|'+scope.row.repLocationX+','+scope.row.repLocationY+'&key='+ qqMapKey +'&size=200*150'">
            <p/><i class="el-icon-map-location"></i>{{scope.row.repContent}}
          </el-link>
          <div v-if="scope.row.repType == 'link'"><el-tag size="mini">链接</el-tag>：<a :href="scope.row.repUrl" target="_blank">{{scope.row.repName}}</a></div>
        </template>
      </avue-crud>
      <el-dialog :title="handleType == 'add' ? '新增群发消息' : '修改群发消息'" :visible.sync="dialog1Visible" width="50%">
        <el-form label-width="100px">
          <el-form-item label="全部用户发送">
            <el-select v-model="objData.isToAll" placeholder="请选择">
              <el-option
                key="1"
                label="是"
                value="1">
              </el-option>
              <el-option
                key="0"
                label="否"
                value="0">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="发送类型" v-if="objData.isToAll == '0'">
            <el-select v-model="objData.sendType" placeholder="请选择">
              <el-option
                key="1"
                label="指定标签"
                value="1">
              </el-option>
              <el-option
                key="2"
                label="指定用户"
                value="2">
              </el-option>
            </el-select>
            <el-select v-model="objData.tagId" placeholder="请选择标签" v-if="objData.sendType == '1'" style="margin-left: 10px">
              <el-option
                v-for="item in userTagsData"
                :key="item.id"
                :label="item.name"
                :value="item.id">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="用户" v-if="objData.sendType == '2'">
            <span v-for="item in selectionData" :key="item.id" style="margin: 5px">
              <el-avatar size="mini" :src="item.headimgUrl"></el-avatar>
              <span class="title">{{item.nickName}}</span>
            </span>
            <p/><el-button type="primary" size="mini" icon="el-icon-plus" @click="selectUser">选择用户</el-button><p/>
          </el-form-item>
          <el-form-item label="回复消息">
            <WxReplySelect :appId="appId" :objData="objData" v-if="hackResetWxReplySelect"></WxReplySelect>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialog1Visible = false">取 消</el-button>
          <el-button type="primary" @click="handleSubmit" :loading="loadingSub">提交并发送</el-button>
        </span>
      </el-dialog>
      <el-dialog title="请选择用户" :visible.sync="dialog1VisibleUser" width="80%">
        <avue-crud ref="crud"
                   :page="page2"
                   :data="tableData2"
                   :table-loading="tableLoading2"
                   :option="tableOption2"
                   @on-load="getPage2"
                   @refresh-change="refreshChange2"
                   @sort-change="sortChange2"
                   @search-change="searchChange2"
                   @selection-change="selectionChange2">
          <template slot="sex" slot-scope="scope" >
            <el-tag size="mini" effect="light" :type="scope.row.sex == '1' ? '' : scope.row.sex == '2' ? 'danger' : 'warning'">{{scope.row.$sex}}</el-tag>
          </template>
        </avue-crud>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialog1Visible = false">取 消</el-button>
          <el-button type="primary" @click="subUser">确 定</el-button>
        </span>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
  import { getPage, getObj, addObj, putObj, delObj } from '@/api/wxmp/wxmassmsg'
  import { getPage as getPage2 } from '@/api/wxmp/wxuser'
  import { listUserTags} from '@/api/wxmp/wxuser'
  import { tableOption } from '@/const/crud/wxmp/wxmassmsg'
  import { mapGetters } from 'vuex'
  import WxReplySelect from '@/components/wx-reply/main.vue'
  import WxNews from '@/components/wx-news/main.vue'
  import WxVideoPlayer from '@/components/wx-video-play/main.vue'
  import WxVoicePlayer from '@/components/wx-voice-play/main.vue'
  export default {
    name: 'wxmassmsg',
    components: {
      WxReplySelect,
      WxNews,
      WxVideoPlayer,
      WxVoicePlayer
    },
    data() {
      return {
        tableOption2: {
          border: true,
          index: false,
          indexLabel: '序号',
          stripe: true,
          selection: true,
          menuAlign: 'center',
          align: 'center',
          editBtn: false,
          delBtn: false,
          addBtn: false,
          excelBtn: false,
          printBtn: false,
          viewBtn: false,
          searchShow: true,
          menu: false,
          menuWidth: 150,
          menuType:'text',
          defaultSort:{
            prop: 'subscribeTime',
            order: 'descending'
          },
          column: [
            {
              label: '头像',
              prop: 'headimgUrl',
              type:'upload',
              imgWidth:50,
              listType:'picture-img',
              editDisplay:false
            },
            {
              label: '昵称',
              prop: 'nickName',
              width:100,
              sortable:true,
              search:true,
              editDisplay:false
            },
            {
              label: '关注渠道',
              prop: 'subscribeScene',
              type: 'select',
              sortable:true,
              search:true,
              editDisplay:false,
              dicUrl: '/admin/dict/type/wx_subscribe_scene'
            },
            {
              label: '关注时间',
              prop: 'subscribeTime',
              type: 'datetime',
              width:95,
              sortable:true,
              editDisplay:false
            },
            {
              label: '性别',
              prop: 'sex',
              width: 60,
              type: 'select',
              sortable:true,
              search:true,
              editDisplay:false,
              slot:true,
              dicUrl: '/admin/dict/type/wx_sex'
            },
            {
              label: '所在国家',
              prop: 'country',
              sortable:true,
              search:true,
              editDisplay:false
            },
            {
              label: '所在省份',
              prop: 'province',
              sortable:true,
              editDisplay:false
            },
            {
              label: '所在城市',
              prop: 'city',
              sortable:true,
              search:true,
              editDisplay:false
            },
            {
              label: '用户语言',
              prop: 'language',
              sortable:true,
              search:true,
              editDisplay:false
            },
            {
              label: '二维码扫码场景',
              prop: 'qrSceneStr',
              type: 'select',
              dicUrl: '/admin/dict/type/wx_qr_scene_str',
              sortable:true,
              search:true,
              editDisplay:false
            },
            {
              label: '用户标识',
              prop: 'openId',
              hide:true,
              editDisplay:false
            },
            {
              label: 'union_id',
              prop: 'unionId',
              hide:true,
              editDisplay:false
            },
            {
              label: '关注次数',
              prop: 'subscribeNum',
              width:50,
              sortable:true,
              editDisplay:false
            }
          ]
        },
        tableData2: [],
        page2: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 10, // 每页显示多少条
          ascs:[],//升序字段
          descs:'subscribe_time'//降序字段
        },
        tableLoading2: false,
        dialog1VisibleUser: false,
        loadingSub: false,
        userTagsData:[],
        appId:this.$route.query.id,
        handleType:null,
        hackResetWxReplySelect: false,
        dialog1Visible: false,
        objData:{
          repType : 'text',
          isToAll: '1'
        },
        tableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20, // 每页显示多少条
          ascs:[],//升序字段
          descs:'create_time'//降序字段
        },
        paramsSearch:{},
        paramsSearch2:{},
        tableLoading: false,
        tableOption: tableOption,
        selectionData: [],
        openIdList: []
      }
    },
    created() {
      this.listUserTags()
    },
    mounted: function() { },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.vaildData(this.permissions.wxmp_wxmassmsg_add, false),
          delBtn: this.vaildData(this.permissions.wxmp_wxmassmsg_del, false),
          editBtn: this.vaildData(this.permissions.wxmp_wxmassmsg_edit, false),
          viewBtn: this.vaildData(this.permissions.wxmp_wxmassmsg_get, false)
        };
      }
    },
    methods: {
      subUser(){
        this.openIdList = []
        for(let i=0;i<this.selectionData.length;i++){
          this.openIdList.push(this.selectionData[i].openId)
        }
        this.dialog1VisibleUser = false
      },
      selectionChange2(list){
        this.selectionData = list
      },
      getPage2(page, params) {
        this.tableLoading2 = true
        getPage2(Object.assign({
          current: page.currentPage,
          size: page.pageSize,
          descs: this.page2.descs,
          ascs: this.page2.ascs,
          appId: this.appId,
          subscribe: '1'
        }, params, this.paramsSearch)).then(response => {
          this.tableData2 = response.data.data.records
          this.page2.total = response.data.data.total
          this.tableLoading2 = false
        }).catch(() => {
          this.tableLoading2 = false
        })
      },
      selectUser(){
        this.dialog1VisibleUser = true
      },
      listUserTags() {
        listUserTags({
          appId:this.appId
        }).then(response => {
          if(response.data.code == '0'){
            this.userTagsData = response.data.data
          }else{
            this.$message.error('获取用户标签出错：' + response.data.msg)
          }
        })
      },
      handleSubmit(row){
        this.loadingSub = true
        if(this.handleType == 'add'){
          addObj(Object.assign({
            appId:this.appId,
            type:this.type,
            openIds:this.openIdList
          }, this.objData)).then(data => {
            this.$message({
              showClose: true,
              message: '添加成功',
              type: 'success'
            })
            this.refreshChange()
            this.dialog1Visible = false
            this.loadingSub = false
          }).catch(() => {
            this.loadingSub=false
          })
        }
        if(this.handleType == 'edit'){
          putObj(this.objData).then(data => {
            this.$message({
              showClose: true,
              message: '修改成功',
              type: 'success'
            })
            this.refreshChange()
            this.dialog1Visible = false
            this.loadingSub = false
          })
        }
      },
      handleAdd(){
        this.hackResetWxReplySelect = false//销毁组件
        this.$nextTick(() => {
          this.hackResetWxReplySelect = true//重建组件
        })
        this.handleType = 'add'
        this.dialog1Visible = true
        this.objData = {
          repType : 'text',
          isToAll: '1'
        }
      },
      currentChange(currentPage){
        this.page.currentPage = currentPage
      },
      searchChange(params){
        params = this.filterForm(params)
        this.paramsSearch = params
        this.page.currentPage = 1
        this.getPage(this.page,params)
      },
      searchChange2(params){
        params = this.filterForm(params)
        this.paramsSearch2 = params
        this.page2.currentPage = 1
        this.getPage2(this.page2,params)
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
      sortChange2(val){
        let prop = val.prop ? val.prop.replace(/([A-Z])/g,"_$1").toLowerCase() : '';
        if(val.order=='ascending'){
          this.page2.descs = []
          this.page2.ascs = prop
        }else if(val.order=='descending'){
          this.page2.ascs = []
          this.page2.descs = prop
        }else{
          this.page2.ascs = []
          this.page2.descs = []
        }
        this.getPage2(this.page2)
      },
      getPage(page, params) {
        this.tableLoading = true
        getPage(Object.assign({
          current: page.currentPage,
          size: page.pageSize,
          descs: this.page.descs,
          ascs: this.page.ascs,
          appId: this.appId,
        }, params, this.paramsSearch)).then(response => {
          this.tableData = response.data.data.records
          this.page.total = response.data.data.total
          this.tableLoading = false
        }).catch(() => {
          this.tableLoading=false
        })
      },
      /**
       * @title 数据删除
       * @param row 为当前的数据
       * @param index 为当前删除数据的行数
       *
       **/
      handleDel: function(row, index) {
        var _this = this
        this.$confirm('是否确认删除此条群发消息吗？删除后用户将不能看到此消息', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function() {
            return delObj(row.id)
          }).then(data => {
          _this.tableData.splice(index, 1)
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
      handleUpdate: function(row, index, done) {
        putObj(row).then(data => {
          this.tableData.splice(index, 1, Object.assign({}, row))
          this.$message({
            showClose: true,
            message: '修改成功',
            type: 'success'
          })
          done()
          this.getPage(this.page)
        })
      },
      /**
       * @title 数据添加
       * @param row 为当前的数据
       * @param done 为表单关闭函数
       *
       **/
      handleSave: function(row, done) {
        addObj(row).then(data => {
          this.tableData.push(Object.assign({}, row))
          this.$message({
            showClose: true,
            message: '添加成功',
            type: 'success'
          })
          done()
          this.getPage(this.page)
        })
      },
      /**
       * 刷新回调
       */
      refreshChange() {
        this.getPage(this.page)
      },
      refreshChange2() {
        this.getPage2(this.page2)
      }
    }
  }
</script>

<style lang="scss" scoped>
</style>
