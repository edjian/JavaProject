/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
export const tableOption = {
  dialogDrag:true,
  border: true,
  index: false,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  editBtn: false,
  delBtn: false,
  addBtn: false,
  excelBtn: true,
  printBtn: true,
  viewBtn: true,
  searchShow: false,
  menuWidth: 150,
  menuType:'text',
  searchMenuSpan: 6,
  defaultSort:{
    prop: 'createTime',
    order: 'descending'
  },
  column: [
    {
      label: '用户标识',
      prop: 'openId',
      editDisplay:false
    },
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
      editDisplay:false
    },
    {
      label: '用户备注',
      prop: 'remark',
      hide:true
    },
    {
      label: 'union_id',
      prop: 'unionId',
      hide:true,
      editDisplay:false
    },
    {
      label: '创建时间',
      prop: 'createTime',
      type: 'datetime',
      sortable:true,
      editDisplay:false
    },
    {
      label: '更新时间',
      prop: 'updateTime',
      type: 'datetime',
      sortable:true,
      hide:true,
      editDisplay:false
    }
  ]
}
