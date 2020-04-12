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
                       v-model="form"
                       @on-load="getPage"
                       @refresh-change="refreshChange"
                       @row-update="handleUpdate"
                       @row-save="handleSave"
                       @row-del="handleDel"
                       @sort-change="sortChange"
                       @search-change="searchChange">
                <template slot-scope="scope" slot="status">
                    <el-tag type="warning" @click="handleOrderItemStatus(scope.row)">{{scope.row.statusDesc}}</el-tag>
                </template>
                <template slot-scope="scope" slot="isRefund" v-if="scope.row.orderItem">
                    <el-tag type="success" v-if="scope.row.orderItem.isRefund == '1'">是</el-tag>
                    <el-tag type="danger" v-if="scope.row.orderItem.isRefund == '0'">否</el-tag>
                </template>
                <template slot-scope="scope" slot="orderId" v-if="scope.row.orderInfo">
                    <div style="text-align: left">
                        <div class="grid-content">订单编号：{{scope.row.orderInfo.orderNo}}</div>
                        <div class="grid-content">销售金额：￥{{scope.row.orderInfo.salesPrice}}</div>
                        <div class="grid-content">运费金额：￥{{scope.row.orderInfo.freightPrice}}</div>
                        <div class="grid-content">支付金额：￥{{scope.row.orderInfo.paymentPrice}}</div>
                        <div class="grid-content">支付积分：{{scope.row.orderInfo.paymentPoints}}</div>
                    </div>
                </template>
                <template slot-scope="scope" slot="orderItemId" v-if="scope.row.orderItem">
                    <el-card>
                        <img :src="scope.row.orderItem.picUrl" class="image">
                        <div style="margin-top: 10px; text-align: left;">
                            <span>{{scope.row.orderItem.spuName}}</span>
                            <div class="bottom clearfix">
                                <div class="time">{{ scope.row.orderItem.specInfo }}</div>
                            </div>
                        </div>
                    </el-card>
                </template>
            </avue-crud>
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
                    <div style="margin-top: 20px;">
                        商品数量：x{{orderItemObj.quantity}}
                    </div>
                    <div style="margin-top: 20px">
                        订单金额：￥{{(orderItemObj.quantity * orderItemObj.salesPrice).toFixed(2)}}
                    </div>
                    <div style="margin-top: 20px">
                        运费金额：￥{{orderItemObj.freightPrice}}
                    </div>
                    <div style="margin-top: 20px; color: red" v-if="orderItemObj.listOrderRefunds">
                        退款金额：￥{{orderItemObj.listOrderRefunds[0].refundAmount}}
                    </div>
                    <div style="margin-top: 20px; color: red">
                        退款积分：{{orderItemObj.paymentPoints}}
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
    import {getPage, getObj, addObj, putObj, delObj} from '@/api/mall/orderrefunds'
    import {tableOption} from '@/const/crud/mall/orderrefunds'
    import {getObj as getOrderItem} from '@/api/mall/orderitem'
    import {doOrderRefunds} from '@/api/mall/orderrefunds'
    import {mapGetters} from 'vuex'

    export default {
        name: 'orderrefunds',
        data() {
            return {
                form: {},
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
                dialogRefunds: false,
                orderRefunds: {},
                orderItemObj: {},
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
                    addBtn: this.permissions['mall:orderrefunds:add'] ? true : false,
                    delBtn: this.permissions['mall:orderrefunds:del'] ? true : false,
                    editBtn: this.permissions['mall:orderrefunds:edit'] ? true : false,
                    viewBtn: this.permissions['mall:orderrefunds:get'] ? true : false
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
                            this.dialogRefunds = false
                            this.getPage(this.page)
                        }).catch(() => {
                            this.orderRefundsSubmitLoading = false
                        })
                    } else {
                        return false
                    }
                })
            },
            handleOrderItemStatus(obj) {
                this.dialogRefunds = true
                this.orderItemObj = {}
                this.orderRefunds = {}
                getOrderItem(obj.orderItemId).then(response => {
                    this.orderItemObj = response.data.data
                    let orderRefunds = this.orderItemObj.listOrderRefunds[0]
                    this.orderRefundsStatusList = []
                    if (this.orderItemObj.status == '1') {//处理退款申请
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
                    if (this.orderItemObj.status == '2') {//处理退货退款申请
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
                }, params, this.paramsSearch)).then(response => {
                    this.tableData = response.data.data.records
                    this.page.total = response.data.data.total
                    this.page.currentPage = page.currentPage
                    this.page.pageSize = page.pageSize
                    this.tableLoading = false
                }
            ).catch(() => {
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
                    _this.$message({
                        showClose: true,
                        message: '删除成功',
                        type: 'success'
                    })
                    this.getPage(this.page)
                }
            ).catch(function (err) {
                })
            },
            /**
             * @title 数据更新
             * @param row 为当前的数据
             * @param index 为当前更新数据的行数
             * @param done 为表单关闭函数
             *
             **/
            handleUpdate: function (row, index, done, loading) {
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
            handleSave: function (row, done, loading) {
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
