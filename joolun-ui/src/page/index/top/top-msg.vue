<template>
  <el-popover placement="bottom"
              trigger="hover">
    <avue-crud :data="tableData"
               :option="option"
               :permission="permissionList"
               @refresh-change="refreshChange"
               @row-click="showMsg">
      <template slot="appName" slot-scope="scope" >
        <el-tag type="success" size="mini">{{scope.row.appName}}</el-tag>
      </template>
      <template slot="headimgUrl" slot-scope="scope" >
        <el-badge :value="scope.row.countMsg" class="count-msg">
          <img class="head-img" :src="scope.row.headimgUrl"/>
        </el-badge>
      </template>
      <template slot="repContent" slot-scope="scope" >
        <div class="nick-name">{{scope.row.nickName}}</div>
        <div v-if="scope.row.repType == 'event' && scope.row.repEvent == 'subscribe'"><el-tag type="success" size="mini">关注</el-tag></div>
        <div v-if="scope.row.repType == 'event' && scope.row.repEvent == 'unsubscribe'"><el-tag type="danger" size="mini">取消关注</el-tag></div>
        <div v-if="scope.row.repType == 'event' && scope.row.repEvent == 'CLICK'"><el-tag size="mini">点击菜单</el-tag>：【{{scope.row.repName}}】</div>
        <div v-if="scope.row.repType == 'event' && scope.row.repEvent == 'VIEW'"><el-tag size="mini">点击菜单链接</el-tag>：【{{scope.row.repUrl}}】</div>
        <div v-if="scope.row.repType == 'text'">{{scope.row.repContent}}</div>
        <div v-if="scope.row.repType == 'image'"><el-tag size="mini">图片</el-tag></div>
        <div v-if="scope.row.repType == 'voice'"><el-tag size="mini">语音</el-tag></div>
        <div v-if="scope.row.repType == 'video'"><el-tag size="mini">视频</el-tag></div>
        <div v-if="scope.row.repType == 'shortvideo'"><el-tag size="mini">小视频</el-tag></div>
        <div v-if="scope.row.repType == 'location'"><el-tag size="mini">地理位置</el-tag>：
          <a :href="'https://map.qq.com/?type=marker&isopeninfowin=1&markertype=1&pointx='+scope.row.repLocationY+'&pointy='+scope.row.repLocationX+'&name='+scope.row.repContent+'&ref=joolun'" target="_blank">{{scope.row.repContent}}</a>
        </div>
        <div v-if="scope.row.repType == 'link'"><el-tag size="mini">链接</el-tag>：<a :href="scope.row.repUrl" target="_blank">{{scope.row.repName}}</a></div>
      </template>
    </avue-crud>
    <router-link class="top-mag__menu"
                 :to="{path:'/views/wxmp/wxmsg/index'}">
      <el-button type="text"
                 size="mini">查看全部</el-button>
    </router-link>
    <div slot="reference"
         class="top-bar__item top-bar__item--show">
      <el-badge :value="tableData.length">
        <i class="el-icon-bell"></i>
      </el-badge>
    </div>
  </el-popover>
</template>

<script>
  import { mapGetters } from 'vuex'
  import { getPage } from '@/api/wxmp/wxmsg'
  export default {
    name: "top-mag",
    props: {
    },
    data () {
      return {
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 10, // 每页显示多少条
          ascs:[],//升序字段
          descs:[]//降序字段
        },
        tableData: [],
        option: {
          size: 'mini',
          addBtn: false,
          page: false,
          menu: false,
          delBtn: false,
          editBtn: false,
          column: [{
            width:100,
            label: '公众号',
            prop: 'appName',
            overHidden: false,
            slot:true
          },{
            width:60,
            label: '用户',
            prop: 'headimgUrl',
            overHidden: false,
            slot:true
          },{
            width: 200,
            label: '内容',
            prop: 'repContent',
            overHidden: true,
            slot:true
          },{
            width: 90,
            label: '时间',
            type: 'date',
            align: 'right',
            prop: 'createTime',
            format: 'MM-dd HH:mm'
          }]
        }
      }
    },
    created() {
      if(this.permissions['wxmp:wxmsg:index']){
        this.refreshChange()
      }
    },
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
      showMsg(row, event, column){
        this.$emit('showMsg', {
          appId: row.appId,
          wxUserId: row.wxUserId
        })
        this.tableData.splice(row.$index, 1)
      },
      getPage(page, params) {
        getPage(Object.assign({
          current: page.currentPage,
          size: page.pageSize,
          descs: page.descs,
          ascs: page.ascs,
          notInRepType: 'event'
        }, params)).then(response => {
          this.tableData = response.data.data.records
          this.page.total = response.data.data.total
          this.page.currentPage = page.currentPage
          this.page.pageSize = page.pageSize
        })
      },
      /**
       * 刷新回调
       */
      refreshChange() {
        this.page.descs = 'create_time'
        this.getPage(this.page,{
          type:'1',
          readFlag:"0"
        })
      }
    }
  }
</script>

<style lang="scss">
  .top-mag {
    &__menu {
      float: right;
    }
  }
  .head-img{
    width: 40px;
    height: 40px;
  }
  .count-msg {
    margin-top: 10px;
  }
  .nick-name{
    color: #000;
    font-weight: bold;
  }
</style>
