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
      hide:true
    },
    {
      label: 'AppID',
      prop: 'id',
      search:true,
      hide:true
    }
  ],
  group:[
    {
      icon: 'el-icon-s-order',
      label: '基本信息',
      prop: 'group1',
      column: [
        {
          label: '小程序码',
          prop: 'qrCode',
          type:'upload',
          span: 24,
          listType: 'picture-img',
          action: '/admin/file/upload?dir=wx/',
          propsHttp: {
            url: 'link'
          },
          loadText: '图上上传中，请稍等',
          tip: '只能上传jpg/png文件，且不超过100kb'
        },
        {
          label: '所属机构',
          prop: 'organId',
          formslot: true,
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
          rules: [{
            required: true,
            message: "请输入小程序名称",
            trigger: "blur"
          }]
        },
        {
          label: '微信原始标识',
          prop: 'weixinSign',
          rules: [{
            required: true,
            message: "请输入微信原始标识",
            trigger: "blur"
          }]
        },
        {
          label: 'AppID',
          prop: 'id',
          rules: [{
            required: true,
            message: "请输入AppID",
            trigger: "blur"
          }]
        },
        {
          label: 'AppSecret',
          prop: 'secret',
          rules: [{
            required: true,
            message: "请输入AppID",
            trigger: "blur"
          }]
        },
        {
          label: '主体名称',
          prop: 'principalName'
        },
        {
          label: '备注信息',
          prop: 'remarks'
        },
      ]
    },
    {
      icon: 'el-icon-s-order',
      label: '支付配置',
      prop: 'group2',
      column: [
        {
          label: '商户号',
          prop: 'mchId'
        },
        {
          label: '商户密钥',
          prop: 'mchKey'
        },
      ]
    }]
}
