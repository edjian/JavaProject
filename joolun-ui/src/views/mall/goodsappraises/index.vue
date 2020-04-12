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
                 @search-change="searchChange">
        <template slot="nickName" slot-scope="scope">
          <el-avatar icon="el-icon-user-solid" :src="scope.row.headimgUrl"></el-avatar>
          <div>{{scope.row.nickName ? scope.row.nickName : '匿名'}}</div>
        </template>
        <template slot="specInfo" slot-scope="scope" v-if="scope.row.orderItem">
            <el-card>
              <img :src="scope.row.orderItem.picUrl" class="image">
              <div>
                <span>{{scope.row.orderItem.spuName}}</span>
                <div class="bottom clearfix">
                  <div class="time">{{ scope.row.orderItem.specInfo }}</div>
                </div>
              </div>
            </el-card>
        </template>
        <template slot="orderItem" slot-scope="scope" v-if="scope.row.orderItem">
          <div>订单号：{{scope.row.orderInfo.orderNo}}</div>
          <div>购买价格：￥{{scope.row.orderItem.salesPrice}}</div>
          <div>购买数量：{{scope.row.orderItem.quantity}}</div>
        </template>
        <template slot="goodsScore" slot-scope="scope">
          <div>商品评分：
            <el-rate
              disabled
              v-model="scope.row.goodsScore"
              show-text>
          </el-rate></div>
          <div>服务评分：
            <el-rate
              disabled
              v-model="scope.row.serviceScore"
              show-text>
            </el-rate></div>
          <div>物流评分：
            <el-rate
              disabled
              v-model="scope.row.logisticsScore"
              show-text>
            </el-rate></div>
        </template>
        <template slot="content" slot-scope="scope">
          <div>
            <div style="color:red" class="el-icon-chat-dot-round"> 买家留言：</div><div class="time">{{scope.row.createTime}}</div>
            <div>{{scope.row.content ? scope.row.content : '此人很懒，什么也没写'}}</div>
          </div>

          <div v-if="scope.row.replyTime">
            <div style="color:red" class="el-icon-chat-dot-round"> 卖家回复：</div><div class="time">{{scope.row.replyTime}}</div>
            <div>{{scope.row.sellerReply}} <el-button type="warning" icon="el-icon-edit" circle size="mini" @click="reply(scope.row,scope.index)"></el-button></div>
          </div>
          <div v-if="!scope.row.replyTime"><br>
            <el-button size="mini" type="primary" @click="reply(scope.row,scope.index)">立即回复</el-button>
          </div>
        </template>
        <template slot="contentForm" slot-scope="scope">
          <div>
            <div class="time">{{scope.row.createTime}}</div>
            <div>{{scope.row.content ? scope.row.content : '此人很懒，什么也没写'}}</div>
          </div>
        </template>
      </avue-crud>
    </basic-container>
  </div>
</template>

<script>
  import { getPage, getObj, addObj, putObj, delObj } from '@/api/mall/goodsappraises'
  import { tableOption } from '@/const/crud/mall/goodsappraises'
  import { mapGetters } from 'vuex'
  export default {
    name: 'goodsappraises',
    data() {
      return {
        tableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20, // 每页显示多少条
          ascs: [],//升序字段
          descs: 'create_time'//降序字段
        },
        paramsSearch:{},
        tableLoading: false,
        tableOption: tableOption
      }
    },
    created() {
    },
    mounted: function() { },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.permissions['mall:goodsappraises:add'] ? true : false,
          delBtn: this.permissions['mall:goodsappraises:del'] ? true : false,
          editBtn: this.permissions['mall:goodsappraises:edit'] ? true : false,
          viewBtn: this.permissions['mall:goodsappraises:get'] ? true : false
        };
      }
    },
    methods: {
      reply(row, index){
        this.$refs.crud.rowEdit(row,index)
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
        }, params, this.paramsSearch)).then(response => {
          this.tableData = response.data.data.records
          this.page.total = response.data.data.total
          this.page.currentPage = page.currentPage
          this.page.pageSize = page.pageSize
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
        row.replyTime = this.$moment(new Date()).format('YYYY-MM-DD hh:mm:ss')
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
  .time {
    font-size: 13px;
    color: #999;
  }

  .bottom {
    margin-top: 13px;
    line-height: 12px;
  }

  .button {
    padding: 0;
    float: right;
  }

  .image {
    width: 100%;
    display: block;
  }

  .clearfix:before,
  .clearfix:after {
    display: table;
    content: "";
  }

  .clearfix:after {
    clear: both
  }
</style>
