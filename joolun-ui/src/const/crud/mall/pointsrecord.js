/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
export const tableOption = {
  dialogDrag: true,
  border: true,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuType: 'text',
  searchShow: false,
  excelBtn: true,
  printBtn: true,
  addBtn: false,
  editBtn: false,
  delBtn: false,
  viewBtn: true,
  menu: false,
  searchMenuSpan: 6,
  column: [
    {
      label: '用户编号',
      prop: 'userCode',
      search: true,
      slot: true
    },
    {
      label: '数量',
      prop: 'amount',
      sortable: true
    },
    {
      label: '描述',
      prop: 'description'
    },
    {
      label: '创建时间',
      prop: 'createTime',
      sortable: true
    },
  ]
}

export const tableOption2 = {
  dialogDrag: true,
  border: true,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuType: 'text',
  searchShow: false,
  addBtn: false,
  editBtn: false,
  delBtn: false,
  menu: false,
  refreshBtn: false,
  column: [
    {
      label: '数量',
      prop: 'amount',
      sortable: true
    },
    {
      label: '描述',
      prop: 'description'
    },
    {
      label: '创建时间',
      prop: 'createTime',
      sortable: true
    },
  ]
}