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
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuWidth: 200,
  menuType: 'text',
  searchShow: false,
  excelBtn: true,
  printBtn: true,
  viewBtn: true,
  expand: true,
  defaultExpandAll: true,
  column: [
    {
      label: '所属机构',
      prop: 'organId',
      formslot: true,
      hide: true,
      span: 24,
      sortable:true,
      rules: [{
        required: true,
        message: '请选择机构',
        trigger: 'change'
      }]
    },
    {
      label: '小程序名称',
      prop: 'name',
      align:'left',
      search:true,
      slot:true,
      rules: [{
        required: true,
        message: "请输入小程序名称",
        trigger: "blur"
      }]
    },
    {
      label: '微信原始标识',
      prop: 'weixinSign',
      search:true,
      hide:true,
      rules: [{
        required: true,
        message: "请输入微信原始标识",
        trigger: "blur"
      }]
    },
    {
      label: 'AppID',
      prop: 'id',
      search:true,
      hide:true,
      rules: [{
        required: true,
        message: "请输入AppID",
        trigger: "blur"
      }]
    },
    {
      label: 'AppSecret',
      prop: 'secret',
      hide:true
    },
    {
      label: '创建时间',
      prop: 'createTime',
      type: 'datetime',
      sortable:true,
      hide:true,
      editDisplay:false,
      addDisplay:false
    },
    {
      label: '更新时间',
      prop: 'updateTime',
      type: 'datetime',
      sortable:true,
      hide:true,
      editDisplay:false,
      addDisplay:false
    },
    {
      label: 'token',
      prop: 'token',
      hide:true
    },
    {
      label: 'EncodingAESKey',
      prop: 'aesKey',
      hide:true
    },
    {
      label: '主体名称',
      prop: 'principalName',
      hide:true
    },
    {
      label: '微社区URL',
      prop: 'community',
      hide:true
    },
    {
      label: '支付商户号',
      prop: 'mchId',
      hide:true
    },
    {
      label: '支付商户密钥',
      prop: 'mchKey',
      hide:true
    },
    {
      label: '备注信息',
      prop: 'remarks',
      hide:true
    },
  ]
}
