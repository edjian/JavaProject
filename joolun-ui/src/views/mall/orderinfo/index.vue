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
            <el-tabs v-model="status" type="card" @tab-click="handleClickStatus">
                <el-tab-pane name="-1">
                    <span slot="label"><i class="el-icon-s-order"></i> 全部订单</span>
                </el-tab-pane>
                <el-tab-pane name="0">
                    <span slot="label"><i class="el-icon-refrigerator"></i> 待付款</span>
                </el-tab-pane>
                <el-tab-pane name="1">
                    <span slot="label"><i class="el-icon-refrigerator"></i> 待发货</span>
                </el-tab-pane>
                <el-tab-pane name="2">
                    <span slot="label"><i class="el-icon-truck"></i> 待收货</span>
                </el-tab-pane>
                <el-tab-pane name="3">
                    <span slot="label"><i class="el-icon-document"></i> 已完成</span>
                </el-tab-pane>
                <el-tab-pane name="4">
                    <span slot="label"><i class="el-icon-document"></i> 待评价</span>
                </el-tab-pane>
                <el-tab-pane name="5">
                    <span slot="label"><i class="el-icon-circle-close"></i> 已取消</span>
                </el-tab-pane>
            </el-tabs>
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
                <template slot-scope="scope" slot="status">
                    <div style="text-align: left">
                        <div class="grid-content">订单状态：
                            <el-tag :type="scope.row.status=='2' ||scope.row.status=='3' || scope.row.status=='4' ? 'success' : 'danger'"
                                    effect="dark" size="mini"> {{ scope.row.statusDesc}}
                            </el-tag>
                        </div>
                        <div class="grid-content">支付状态：
                            <el-tag :type="scope.row.isPay=='1' ? 'success' : 'danger'"
                                    effect="dark" size="mini">{{scope.row.isPay == '1' ? '已支付' : '未支付'}}
                            </el-tag>
                        </div>
                        <div class="grid-content" v-if="scope.row.appraisesStatus">评价状态：
                            <el-tag :type="scope.row.appraisesStatus != '0' ? 'success' : 'danger'"
                                    effect="dark" size="mini">{{scope.row.appraisesStatus == '0' ? '未评价' :
                                scope.row.appraisesStatus == '1' ? '已评价' : scope.row.appraisesStatus == '2' ? '已追评' :
                                ''}}
                            </el-tag>
                        </div>
                    </div>
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
                                    <img v-if="scope.row.app.qrCode" :src="scope.row.app.qrCode" width="100"
                                         height="100"/>
                                    <div>{{scope.row.app.name}}</div>
                                    <div>
                                        <el-tag size="mini"> {{ scope.row.appType=='1' ? '小程序' : ''}}
                                        </el-tag>
                                    </div>
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
                                <div>销售金额：￥{{scope.row.salesPrice}}</div>
                                <div>物流金额：￥{{scope.row.logisticsPrice}}</div>
                                <div style="color: red">支付金额：￥{{scope.row.paymentPrice}}</div>
                                <div style="color: red">优惠券抵扣金额：￥{{scope.row.paymentCouponPrice}}</div>
                                <div style="color: red">积分抵扣金额：￥{{scope.row.paymentPointsPrice}}</div>
                                <div style="color: red">支付积分：{{scope.row.paymentPoints}}</div>
                            </template>
                        </el-table-column>
                        <el-table-column
                                align="center"
                                prop="paymentType"
                                label="订单状态">
                            <template slot-scope="scope">
                                <div style="text-align: left">
                                    <div class="grid-content">订单状态：
                                        <el-tag :type="scope.row.status=='2' ||scope.row.status=='3' || scope.row.status=='4' ? 'success' : 'danger'"
                                                effect="dark" size="mini"> {{ scope.row.statusDesc}}
                                        </el-tag>
                                    </div>
                                    <div class="grid-content">支付状态：
                                        <el-tag :type="scope.row.isPay=='1' ? 'success' : 'danger'"
                                                effect="dark" size="mini">{{scope.row.isPay == '1' ? '已支付' : '未支付'}}
                                        </el-tag>
                                    </div>
                                    <div class="grid-content" v-if="scope.row.appraisesStatus">评价状态：
                                        <el-tag :type="scope.row.appraisesStatus != '0' ? 'success' : 'danger'"
                                                effect="dark" size="mini">{{scope.row.appraisesStatus == '0' ? '未评价' :
                                            scope.row.appraisesStatus == '1' ? '已评价' : scope.row.appraisesStatus == '2'
                                            ? '已追评' : ''}}
                                        </el-tag>
                                    </div>
                                </div>
                            </template>
                        </el-table-column>
                        <el-table-column
                                align="center"
                                prop="paymentType"
                                label="支付方式">
                            <template slot-scope="scope">
                                <div>{{scope.row.$paymentType}}</div>
                                <div>
                                    <el-tag size="mini"> {{ scope.row.paymentWay == '2' ? '在线支付' : ''}}
                                    </el-tag>
                                </div>
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
                                <img :src="scope.row.picUrl" width="100" height="100"/>
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
                                width="50">
                        </el-table-column>
                        <el-table-column
                                align="center"
                                prop="salesPriceTotal"
                                label="商品总价"
                                width="80">
                            <template slot-scope="scope">
                                ￥{{(scope.row.salesPrice * scope.row.quantity).toFixed(2)}}
                            </template>
                        </el-table-column>
                        <el-table-column
                          align="center"
                          prop="salesPriceTotal"
                          label="支付金额"
                          width="80">
                          <template slot-scope="scope">
                            ￥{{scope.row.paymentPrice}}
                          </template>
                        </el-table-column>
                        <el-table-column
                                align="center"
                                prop="paymentCouponPrice"
                                label="优惠券抵扣金额"
                                width="80">
                            <template slot-scope="scope">
                                ￥{{scope.row.paymentCouponPrice}}
                            </template>
                        </el-table-column>
                        <el-table-column
                                align="center"
                                prop="paymentPointsPrice"
                                label="积分抵扣金额"
                                width="80">
                            <template slot-scope="scope">
                                ￥{{scope.row.paymentPointsPrice}}
                            </template>
                        </el-table-column>
                        <el-table-column
                          align="center"
                          prop="salesPriceTotal"
                          label="支付积分"
                          width="80">
                          <template slot-scope="scope">
                            {{scope.row.paymentPoints}}
                          </template>
                        </el-table-column>
                        <el-table-column
                                align="center"
                                prop="status"
                                label="状态"
                                width="200">
                            <template slot-scope="scope">
                                <div class="grid-content" v-if="scope.row.status != '0'">
                                    <el-tag type="danger" @click="handleOrderItemStatus(scope.row)">
                                        {{scope.row.statusDesc}}
                                    </el-tag>
                                </div>
                            </template>
                        </el-table-column>
                    </el-table>
                </template>
                <template slot-scope="scope" slot="userIdForm">
                    <el-table
                            :data="[scope.row.userInfo]"
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
                          prop="sex"
                          label="性别">
                            <template slot-scope="scope">
                                <div>{{scope.row.sex == '1' ? '男' : scope.row.sex == '2' ? '女' : '未知'}}</div>
                            </template>
                        </el-table-column>
                        <el-table-column
                                align="center"
                                prop="userCode"
                                label="用户编号">
                        </el-table-column>
                        <el-table-column
                          align="center"
                          prop="pointsCurrent"
                          label="当前积分">
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
                            <el-timeline :reverse="false"
                                         v-if="scope.row.orderLogistics.listOrderLogisticsDetail.length > 0">
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
                <template slot-scope="scope" slot="goodsInfo">
                    <el-row :gutter="10" v-for="(item, index) in scope.row.listOrderItem" :key="index"
                            style="border:1px solid #eaeaea;padding: 5px">
                        <el-col :span="3">
                            <img :src="item.picUrl" width="100%"/>
                        </el-col>
                        <el-col :span="13" style="text-align: left">
                            <div class="spu-name">{{item.spuName}}</div>
                            <div class="spec-info">{{item.specInfo}}</div>
                        </el-col>
                        <el-col :span="8">
                            <div class="grid-content" style="color:red;">￥{{item.paymentPrice}}{{item.paymentCouponPrice ? ' + 优惠券￥'+item.paymentCouponPrice : ''}}{{item.paymentPoints ? ' + 积分'+item.paymentPoints : ''}}</div>
                            <div class="grid-content">×{{item.quantity}}件</div>
                            <div class="grid-content" v-if="item.status != '0'">
                                <el-tag type="danger" @click="handleOrderItemStatus(item)">{{item.statusDesc}}</el-tag>
                            </div>
                        </el-col>
                    </el-row>
                </template>
                <template slot-scope="scope" slot="createTime">
                    <div>
                        <div class="grid-content">{{scope.row.createTime}}</div>
                        <div class="grid-content">{{scope.row.orderNo}}</div>
                    </div>
                </template>
                <template slot-scope="scope" slot="salesPrice">
                    <div style="text-align: left">
                        <div class="grid-content">销售金额：￥{{scope.row.salesPrice}}</div>
                        <div class="grid-content">物流金额：￥{{scope.row.logisticsPrice}}</div>
                        <div class="grid-content" style="color: red">支付金额：￥{{scope.row.paymentPrice}}</div>
                        <div class="grid-content" style="color: red">优惠券抵扣金额：￥{{scope.row.paymentCouponPrice}}</div>
                        <div class="grid-content" style="color: red">积分抵扣金额：￥{{scope.row.paymentPointsPrice}}</div>
                        <div class="grid-content" style="color: red">支付积分：{{scope.row.paymentPoints}}</div>
                    </div>
                </template>
                <template slot-scope="scope" slot="menu">
                    <el-button icon="el-icon-edit"
                               size="small"
                               type="text"
                               v-if="permissions.mall_orderinfo_get"
                               @click="openView(scope.row,scope.index)">订单详情
                    </el-button>
                    <el-button icon="el-icon-position"
                               size="small"
                               type="text"
                               v-if="permissions.mall_orderinfo_edit && scope.row.status == '1'"
                               @click="showDialogLogistics(scope.row,scope.index)">发货
                    </el-button>
                </template>
            </avue-crud>
            <el-dialog
                    title="发货"
                    :visible.sync="dialogLogistics"
                    width="30%">
                <avue-form :option="logisticsOption" v-model="logisticsForm" @submit="delivery"></avue-form>
            </el-dialog>
            <el-dialog
                    title="退款管理"
                    :visible.sync="dialogRefunds"
                    width="40%">
                <el-card>
                    <div slot="header">
                        <span>退款信息</span>
                    </div>
                    <el-row :gutter="10"
                            style="border:1px solid #eaeaea;padding: 5px">
                        <el-col :span="3">
                            <img :src="orderItemObj.picUrl" width="100%"/>
                        </el-col>
                        <el-col :span="13" style="text-align: left">
                            <div class="spu-name">{{orderItemObj.spuName}}</div>
                            <div class="spec-info">{{orderItemObj.specInfo}}</div>
                        </el-col>
                        <el-col :span="8">
                            <div class="grid-content">￥{{orderItemObj.salesPrice}}</div>
                            <div class="grid-content">×{{orderItemObj.quantity}}件</div>
                        </el-col>
                    </el-row>
                    <div style="margin-top: 20px">
                        退款状态：
                        <el-tag type="danger" size="small" v-if="orderItemObj.listOrderRefunds">
                            {{orderItemObj.listOrderRefunds[0].statusDesc}}
                        </el-tag>
                    </div>
                    <div style="margin-top: 20px">
                        是否退款：
                        <el-tag :type="orderItemObj.isRefund == '1' ? 'success' : 'danger'" size="small">
                            {{orderItemObj.isRefund == '1' ? '是' : '否'}}
                        </el-tag>
                        <el-tooltip style="margin-left: 10px" effect="dark" content="“是”则代表退款金额已成功到达用户账上" placement="top-start">
                            <i class="el-icon-info"></i>
                        </el-tooltip>
                    </div>
                    <div style="margin-top: 20px">
                        销售总额：￥{{(orderItemObj.quantity * orderItemObj.salesPrice).toFixed(2)}}
                    </div>
                    <div style="margin-top: 20px; color: red">
                        退款金额：￥{{orderItemObj.paymentPrice}}
                    </div>
                    <div style="margin-top: 20px; color: red">
                        退款积分：{{orderItemObj.paymentPoints}}
                    </div>
                    <div style="margin-top: 20px">
                        退款数量：x{{orderItemObj.quantity}}
                    </div>
                    <div style="margin-top: 20px" v-if="orderItemObj.listOrderRefunds">
                        退款原因：{{orderItemObj.listOrderRefunds[0].refundReson}}
                    </div>
                    <div style="margin-top: 20px" v-if="orderItemObj.listOrderRefunds">
                        拒绝原因：{{orderItemObj.listOrderRefunds[0].refuseRefundReson}}
                    </div>
                </el-card>
                <el-card style="margin-top: 10px" v-if="orderRefundsStatusList.length > 0">
                    <div slot="header">
                        <span>退款操作</span>
                    </div>
                    <el-form ref="orderRefunds" :model="orderRefunds" :rules="orderRefundsRules" label-width="80px">
                        <el-form-item label="退款状态" prop="status">
                            <el-select v-model="orderRefunds.status" placeholder="请选择">
                                <el-option
                                        v-for="item in orderRefundsStatusList"
                                        :key="item.value"
                                        :label="item.label"
                                        :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="拒绝原因" prop="refuseRefundReson" v-if="orderRefunds.status == '12' || orderRefunds.status == '22' || orderRefunds.status == '212'">
                            <el-input type="textarea" v-model="orderRefunds.refuseRefundReson" placeholder="请填写拒绝原因"></el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" v-loading="orderRefundsSubmitLoading" @click="orderRefundsSubmit(orderItemObj.listOrderRefunds[0])">确认提交</el-button>
                        </el-form-item>
                    </el-form>
                </el-card>
            </el-dialog>
        </basic-container>
    </div>
</template>

<script>
    import {getPage, getObj, addObj, putObj, delObj} from '@/api/mall/orderinfo'
    import {getObj as getOrderItem} from '@/api/mall/orderitem'
    import {doOrderRefunds} from '@/api/mall/orderrefunds'
    import {getObj as getWxUser} from '@/api/wxmp/wxuser'
    import {tableOption} from '@/const/crud/mall/orderinfo'
    import {mapGetters} from 'vuex'

    export default {
        name: 'orderinfo',
        data() {
            return {
                status: '-1',
                tableData: [],
                page: {
                    total: 0, // 总页数
                    currentPage: 1, // 当前页数
                    pageSize: 20, // 每页显示多少条
                    ascs: [],//升序字段
                    descs: 'create_time'//降序字段
                },
                paramsSearch: {},
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
                    card: true,
                    group: [
                        {
                            icon: 'el-icon-user',
                            label: '收货人信息',
                            prop: 'group1',
                            column: [{
                                label: '收货人名字',
                                prop: 'userName',
                                span: 24,
                                readonly: true
                            }, {
                                label: '电话号码',
                                prop: 'telNum',
                                span: 24,
                                readonly: true
                            }, {
                                label: '收货地址',
                                prop: 'address',
                                type: 'textarea',
                                span: 24,
                                readonly: true
                            }]
                        }, {
                            icon: 'el-icon-truck',
                            label: '快递信息',
                            prop: 'group2',
                            column: [{
                                label: '快递公司',
                                prop: 'logistics',
                                dicUrl: '/mall/orderlogistics/dict/LOGISTICS',
                                span: 24,
                                type: 'select',
                                rules: [{
                                    required: true,
                                    message: "请选择快递公司",
                                    trigger: "blur"
                                }]
                            },
                                {
                                    label: '快递单号',
                                    prop: 'logisticsNo',
                                    span: 24,
                                    rules: [{
                                        required: true,
                                        message: "请输入快递单号",
                                        trigger: "blur"
                                    }]
                                }]
                        }
                    ]
                },
                dialogRefunds: false,
                orderItemObj: {},
                orderRefunds: {},
                orderRefundsStatusList: [],
                orderRefundsRules: {
                  status: [
                    { required: true, message: '请选择退款状态', trigger: 'change' }
                  ]
                },
                orderRefundsSubmitLoading: false
            }
        },
        created() {
        },
        mounted: function () {
        },
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
            orderRefundsSubmit(orderRefunds) {
                this.orderRefunds.id = orderRefunds.id
                this.$refs['orderRefunds'].validate((valid) => {
                    if (valid) {
                        this.orderRefundsSubmitLoading = true
                        doOrderRefunds(this.orderRefunds).then(res => {
                            this.orderRefundsSubmitLoading = false
                            getOrderItem(orderRefunds.orderItemId).then(response => {
                                let orderItemObj = response.data.data
                                this.handleOrderItemStatus(orderItemObj)
                            }).catch(() => {
                                this.orderRefundsSubmitLoading = false
                            })
                        })
                    } else {
                        return false
                    }
                })
            },
            handleOrderItemStatus(obj) {
                this.dialogRefunds = true
                this.orderRefunds = {}
                this.orderItemObj = {}
                getOrderItem(obj.id).then(response => {
                    this.orderItemObj = response.data.data
                    let orderRefunds = this.orderItemObj.listOrderRefunds[0]
                    this.orderRefundsStatusList = []
                    if (obj.status == '1') {//处理退款申请
                        if(orderRefunds.status == '1'){
                            this.orderRefundsStatusList = [{
                                label: '同意退款',
                                value: '11'
                            }, {
                                label: '拒绝退款',
                                value: '12'
                            }]
                        }
                    }
                    if (obj.status == '2') {//处理退货退款申请
                        if(orderRefunds.status == '2'){
                            this.orderRefundsStatusList = [{
                                label: '等待退货',
                                value: '21'
                            }, {
                                label: '拒绝退货退款',
                                value: '22'
                            }]
                        }
                        if(orderRefunds.status == '21'){
                            this.orderRefundsStatusList = [{
                                label: '收到退货同意退款',
                                value: '211'
                            }, {
                                label: '收到退货拒绝退款',
                                value: '212'
                            }]
                        }
                    }
                })
            },
            handleClickStatus(tab, event) {
                this.status = tab.name
                this.page.currentPage = 1
                this.getPage(this.page)
            },
            openView(row, index) {
                this.tableLoading = true
                getObj(row.id).then(response => {
                    row.userInfo = response.data.data.userInfo
                    row.app = response.data.data.app
                    row.orderLogistics = response.data.data.orderLogistics
                    this.$refs.crud.rowView(row, index)
                    this.tableLoading = false
                })
            },
            showDialogLogistics(row, index, done) {
                this.logisticsForm.row = row
                this.logisticsForm.address = row.orderLogistics.address
                this.logisticsForm.userName = row.orderLogistics.userName
                this.logisticsForm.telNum = row.orderLogistics.telNum
                this.dialogLogistics = true
            },
            delivery(form, done) {
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
            searchChange(params,done) {
                params = this.filterForm(params)
                this.paramsSearch = params
                this.page.currentPage = 1
                this.getPage(this.page, params)
                done()
            },
            sortChange(val) {
                let prop = val.prop ? val.prop.replace(/([A-Z])/g, "_$1").toLowerCase() : '';
                if (val.order == 'ascending') {
                    this.page.descs = []
                    this.page.ascs = prop
                } else if (val.order == 'descending') {
                    this.page.ascs = []
                    this.page.descs = prop
                } else {
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
                    status: this.status != '-1' ? this.status : null
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
            /**
             * @title 数据删除
             * @param row 为当前的数据
             * @param index 为当前删除数据的行数
             *
             **/
            handleDel: function (row, index) {
                var _this = this
                this.$confirm('是否确认删除此数据', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(function () {
                    return delObj(row.id)
                }).then(data => {
                    _this.tableData.splice(index, 1)
                    _this.$message({
                        showClose: true,
                        message: '删除成功',
                        type: 'success'
                    })
                    this.getPage(this.page)
                }).catch(function (err) {
                })
            },
            /**
             * @title 数据更新
             * @param row 为当前的数据
             * @param index 为当前更新数据的行数
             * @param done 为表单关闭函数
             *
             **/
            handleUpdate: function (row, index, done) {
                putObj(row).then(data => {
                    this.tableData.splice(index, 1, Object.assign({}, row))
                    this.$message({
                        showClose: true,
                        message: '修改成功',
                        type: 'success'
                    })
                    done()
                    this.getPage(this.page)
                }).catch(() => {
                    done()
                })
            },
            /**
             * @title 数据添加
             * @param row 为当前的数据
             * @param done 为表单关闭函数
             *
             **/
            handleSave: function (row, done) {
                addObj(row).then(data => {
                    this.tableData.push(Object.assign({}, row))
                    this.$message({
                        showClose: true,
                        message: '添加成功',
                        type: 'success'
                    })
                    done()
                    this.getPage(this.page)
                }).catch(() => {
                    done()
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
<style>
    .spu-name {
        font-size: 13px;
    }

    .spec-info {
        margin-top: 10px;
        font-size: 12px;
        color: #7b7b7b;
    }
</style>
