/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
export const tableOption = {
  // dateBtn:true,
  dialogType: 'drawer',
  dialogWidth: '80%',
  border: true,
  index: false,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuWidth: 150,
  menuType: 'text',
  searchShow: true,
  excelBtn: true,
  printBtn: true,
  editBtn: false,
  delBtn: false,
  addBtn: false,
  viewBtn: false,
  defaultExpandAll: true,
  column: [
	  {
      label: '用户id',
      prop: 'userId',
      sortable:true,
      hide: true
    },
    {
      label: '是否支付',
      prop: 'isPay',
      type: 'radio',
      hide: true,
      search:true,
      dicData: [{
        label: '是',
        value: '1'
      },
        {
        label: '否',
        value: '0'
      }]
    },
    {
      label: '订单号',
      prop: 'orderNo',
      search:true,
      hide: true
    },
	  {
      label: '商品信息',
      prop: 'goodsInfo',
      width: 700,
      slot:true
    },
    {
      label: '时间/订单号',
      prop: 'createTime',
      sortable:true,
      width: 250,
      slot:true
    },
    {
      label: '付款方式',
      prop: 'paymentType',
      search:true,
      type: 'radio',
      sortable:true,
      dicData: [{
        label: '微信支付',
        value: '1'
      }]
    },
    {
      label: '状态',
      prop: 'status',
      type: 'radio',
      sortable:true,
      slot:true,
      width: 150,
    },
	  {
      label: '订单金额(￥)',
      prop: 'salesPrice',
      sortable:true,
      slot:true,
      width: 200,
    },
	  {
      label: '付款时间',
      prop: 'paymentTime',
      sortable:true,
      hide: true
    },
	  {
      label: '发货时间',
      prop: 'deliveryTime',
      sortable:true,
      hide: true
    },
	  {
      label: '收货时间',
      prop: 'receiverTime',
      sortable:true,
      hide: true
    },
	  {
      label: '成交时间',
      prop: 'closingTime',
      sortable:true,
      hide: true
    },
    {
      label: '最后更新时间',
      prop: 'updateTime',
      sortable:true,
      hide: true
    },
	  {
      label: '备注',
      prop: 'remark',
      hide: true
    }
  ],
  group:[
    {
      icon:'el-icon-s-order',
      label: '基本信息',
      prop: 'group1',
      column: [
        {
          prop: 'orderNo',
          formslot: true,
          span: 24
        }]
    },{
      icon:'el-icon-order',
      label: '订单明细',
      prop: 'group2',
      column: [{
        prop: 'userId',
        formslot: true,
        span: 24
      }]
    },{
      icon:'el-icon-goods',
      label: '商品信息',
      prop: 'group3',
      column: [
        {
          prop: 'listOrderItem',
          formslot: true,
          span: 24
        }
        ]
    }, {
      icon:'el-icon-location-outline',
      label: '收货信息',
      prop: 'group4',
      column: [{
        prop: 'orderLogistics',
        formslot: true,
        span: 24
      }]
    }]
}
