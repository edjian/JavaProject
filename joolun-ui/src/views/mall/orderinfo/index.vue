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
        <template slot="status" slot-scope="scope">
          <el-tag :type="scope.row.status=='2' ||scope.row.status=='3' || scope.row.status=='4' ? 'success' : 'danger'" effect="dark" size="mini"> {{ scope.row.$status}} </el-tag>
        </template>
        <template slot-scope="scope" slot="orderNoForm">
          <el-table
            :data="[scope.row]"
            border
            style="width: 100%; margin-top: 20px; margin-top: -10px">
            <el-table-column
              align="center"
              prop="salesPrice"
              label="订单来源">
              <template slot-scope="scope">
                <div v-if="scope.row.app">
                  <img v-if="scope.row.app.qrCode" :src="scope.row.app.qrCode" width="100" height="100" />
                  <div>{{scope.row.app.name}}</div>
                </div>
              </template>
            </el-table-column>
            <el-table-column
              align="center"
              prop="orderNo"
              label="订单单号">
            </el-table-column>
            <el-table-column
              align="center"
              prop="salesPrice"
              label="订单总额">
              <template slot-scope="scope">
                <div>订单金额：￥{{scope.row.salesPrice}}</div>
                <div>物流金额：￥{{scope.row.logisticsPrice}}</div>
                <div>支付金额：￥{{scope.row.paymentPrice}}</div>
              </template>
            </el-table-column>
            <el-table-column
              align="center"
              prop="paymentType"
              label="订单状态">
              <template slot-scope="scope">
                {{scope.row.$status}}
              </template>
            </el-table-column>
            <el-table-column
              align="center"
              prop="paymentType"
              label="支付方式">
              <template slot-scope="scope">
                {{scope.row.$paymentType}}
              </template>
            </el-table-column>
            <el-table-column
              align="center"
              prop="salesPrice"
              label="订单时间"
              width="250">
              <template slot-scope="scope">
                <div>创建时间：{{scope.row.createTime}}</div>
                <div v-if="scope.row.paymentTime">付款时间：{{scope.row.paymentTime}}</div>
                <div v-if="scope.row.deliveryTime">发货时间：{{scope.row.deliveryTime}}</div>
                <div v-if="scope.row.receiverTime">收货时间：{{scope.row.receiverTime}}</div>
                <div v-if="scope.row.closingTime">成交时间：{{scope.row.closingTime}}</div>
              </template>
            </el-table-column>
            <el-table-column
              align="center"
              prop="transactionId"
              label="支付流水号">
            </el-table-column>
            <el-table-column
              align="center"
              prop="userMessage"
              label="买家留言">
            </el-table-column>
          </el-table>
        </template>
        <template slot-scope="scope" slot="listOrderItemForm">
          <el-table
            :data="scope.row.listOrderItem"
            border
            style="width: 100%; margin-top: 20px; margin-top: -10px">
            <el-table-column
              align="center"
              prop="picUrl"
              label="图片"
              width="120">
              <template slot-scope="scope">
                <img :src="scope.row.picUrl" width="100" height="100" />
              </template>
            </el-table-column>
            <el-table-column
              align="center"
              prop="spuName"
              label="商品名">
            </el-table-column>
            <el-table-column
              align="center"
              prop="specInfo"
              label="规格">
            </el-table-column>
            <el-table-column
              align="center"
              prop="salesPrice"
              label="商品单价"
              width="100">
              <template slot-scope="scope">
                ￥{{scope.row.salesPrice}}
              </template>
            </el-table-column>
            <el-table-column
              align="center"
              prop="quantity"
              label="数量"
              width="200">
            </el-table-column>
            <el-table-column
              align="center"
              prop="salesPriceTotal"
              label="商品总价"
              width="200">
              <template slot-scope="scope">
                ￥{{scope.row.salesPrice * scope.row.quantity}}
              </template>
            </el-table-column>
          </el-table>
        </template>
        <template slot-scope="scope" slot="userIdForm">
          <el-table
            :data="[scope.row.user]"
            border
            style="width: 100%">
            <el-table-column
              align="center"
              prop="nickName"
              label="用户名">
              <template slot-scope="scope">
                <el-avatar icon="el-icon-user-solid" :src="scope.row.headimgUrl"></el-avatar>
                <div>{{scope.row.nickName}}</div>
              </template>
            </el-table-column>
            <el-table-column
              align="center"
              prop="country"
              label="国家">
            </el-table-column>
            <el-table-column
              align="center"
              prop="province"
              label="省份">
            </el-table-column>
            <el-table-column
              align="center"
              prop="city"
              label="城市">
            </el-table-column>
          </el-table>
        </template>
        <template slot-scope="scope" slot="orderLogisticsForm">
          <div>
            <el-table
              :data="[scope.row.orderLogistics]"
              border
              style="width: 100%">
              <el-table-column
                align="center"
                prop="userName"
                label="姓名">
              </el-table-column>
              <el-table-column
                align="center"
                prop="telNum"
                label="电话">
              </el-table-column>
              <el-table-column
                align="center"
                prop="address"
                label="地址">
              </el-table-column>
            </el-table>
            <el-card class="box-card">
              <el-timeline :reverse="false" v-if="scope.row.orderLogistics.listOrderLogisticsDetail.length > 0">
                <el-timeline-item
                  v-for="(obj, index) in scope.row.orderLogistics.listOrderLogisticsDetail"
                  :key="index"
                  :timestamp="obj.logisticsTime">
                  {{obj.logisticsInformation}}
                </el-timeline-item>
              </el-timeline>
              <el-timeline :reverse="false" v-else>
                <el-timeline-item>
                  暂无物流信息
                </el-timeline-item>
              </el-timeline>
            </el-card>
          </div>
        </template>
        <template slot-scope="props" slot="expand">
          <el-table
            :data="props.row.listOrderItem"
            border
            :show-header="false"
            style="width: 100%; margin-top: 20px; margin-top: -10px">
            <el-table-column
              prop="picUrl"
              label="图片"
              width="120">
              <template slot-scope="scope">
                <img :src="scope.row.picUrl" width="100" height="100" />
              </template>
            </el-table-column>
            <el-table-column
              prop="spuName"
              label="商品名">
            </el-table-column>
            <el-table-column
              prop="specInfo"
              label="规格">
            </el-table-column>
            <el-table-column
              prop="salesPrice"
              label="单价"
              width="200"
              align="center">
              <template slot-scope="scope">
                单价：￥{{scope.row.salesPrice}}
              </template>
            </el-table-column>
            <el-table-column
              prop="quantity"
              label="数量"
              width="200"
              align="center">
              <template slot-scope="scope">
                数量：{{scope.row.quantity}}
              </template>
            </el-table-column>
          </el-table>
        </template>
        <template slot-scope="scope" slot="menu">
          <el-button icon="el-icon-edit"
                     size="small"
                     type="text"
                     v-if="permissions.mall_orderinfo_get"
                     @click="openView(scope.row,scope.index)">订单详情</el-button>
          <el-button icon="el-icon-position"
                     size="small"
                     type="text"
                     v-if="permissions.mall_orderinfo_edit && scope.row.status == '1'"
                     @click="showDialogLogistics(scope.row,scope.index)">发货</el-button>
        </template>
      </avue-crud>
      <el-dialog
        title="发货"
        :visible.sync="dialogLogistics"
        width="30%">
        <avue-form :option="logisticsOption" v-model="logisticsForm" @submit="delivery"></avue-form>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
  import { getPage, getObj, addObj, putObj, delObj } from '@/api/mall/orderinfo'
  import { getObj as getWxUser } from '@/api/wxmp/wxuser'
  import { tableOption } from '@/const/crud/mall/orderinfo'
  import { mapGetters } from 'vuex'
  export default {
    name: 'orderinfo',
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
        tableOption: tableOption,
        dialogLogistics: false,
        logisticsForm: {
          row: {},
          logistics: null,
          logisticsNo: null,
          address: null
        },
        logisticsOption: {
          emptyBtn: false,
          card:true,
          group:[
            {
              icon:'el-icon-user',
              label: '收货人信息',
              prop: 'group1',
              column: [{
                label: '收货人名字',
                prop: 'userName',
                span:24,
                readonly: true
              },{
                label: '电话号码',
                prop: 'telNum',
                span:24,
                readonly: true
              },{
                label: '收货地址',
                prop: 'address',
                type: 'textarea',
                span:24,
                readonly: true
              }]
            },{
              icon:'el-icon-truck',
              label: '快递信息',
              prop: 'group2',
              column: [{
                label: '快递公司',
                prop: 'logistics',
                dicUrl:'/mall/orderlogistics/dict/LOGISTICS',
                span:24,
                type:'select',
                rules: [{
                  required: true,
                  message: "请选择快递公司",
                  trigger: "blur"
                }]
              },
                {
                  label: '快递单号',
                  prop: 'logisticsNo',
                  span:24,
                  rules: [{
                    required: true,
                    message: "请输入快递单号",
                    trigger: "blur"
                  }]
                }]
            }
          ]
        }
      }
    },
    created() {
    },
    mounted: function() { },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.vaildData(this.permissions.mall_orderinfo_add, false),
          delBtn: this.vaildData(this.permissions.mall_orderinfo_del, false),
          editBtn: this.vaildData(this.permissions.mall_orderinfo_edit, false),
          viewBtn: this.vaildData(this.permissions.mall_orderinfo_get, false)
        };
      }
    },
    methods: {
      currentChange(currentPage){
        this.page.currentPage = currentPage
      },
      openView(row,index){
        getObj(row.id).then(response => {
          row.user = response.data.data.user
          row.app = response.data.data.app
          row.orderLogistics = response.data.data.orderLogistics
          this.$refs.crud.rowView(row,index)
        })
      },
      showDialogLogistics(row, index, done){
        this.logisticsForm.row = row
        this.logisticsForm.address = row.orderLogistics.address
        this.logisticsForm.userName = row.orderLogistics.userName
        this.logisticsForm.telNum = row.orderLogistics.telNum
        this.dialogLogistics = true
      },
      delivery(form,done){
        let row = this.logisticsForm.row
        row.status = '2',
        row.logistics = form.logistics,
        row.logisticsNo = form.logisticsNo
        putObj(row).then(data => {
          this.$message({
            showClose: true,
            message: '发货成功',
            type: 'success'
          })
          done()
          this.getPage(this.page)
          this.dialogLogistics = false
        }).catch(() => {
          done()
        })
      },
      searchChange(params){
        params = this.filterForm(params)
        this.paramsSearch = params
        this.page.currentPage = 1
        this.getPage(this.page,params)
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
      }
    }
  }
</script>
<style>

</style>
