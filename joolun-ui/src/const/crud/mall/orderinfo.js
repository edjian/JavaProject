/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
export const tableOption = {
  dialogType: 'drawer',
  dialogWidth: '80%',
  dialogDrag: true,
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
  expand: true,
  defaultExpandAll: true,
  card:true,
  column: [
	  {
      label: '用户id',
      prop: 'userId',
      sortable:true,
      hide: true
    },
	  {
      label: '订单单号',
      prop: 'orderNo',
      search:true,
      sortable:true
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
      search:true,
      sortable:true,
      slot:true,
      dicData: [{
        label: '待付款',
        value: '0'
      },{
        label: '待发货',
        value: '1'
      },{
        label: '待收货',
        value: '2'
      },{
        label: '待评价',
        value: '3'
      },{
        label: '已完成',
        value: '4'
      },{
        label: '已取消',
        value: '5'
      }]
    },
    {
      label: '创建时间',
      prop: 'createTime',
      sortable:true
    },
	  {
      label: '订单金额(￥)',
      prop: 'salesPrice',
      sortable:true
    },
	  {
      label: '物流金额(￥)',
      prop: 'logisticsPrice',
      sortable:true
    },
    {
      label: '支付金额(￥)',
      prop: 'paymentPrice',
      sortable:true
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
      icon:'el-icon-user',
      label: '用户信息',
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
