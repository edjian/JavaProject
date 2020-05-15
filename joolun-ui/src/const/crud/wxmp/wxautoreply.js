/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
export const tableOption1 = {
  dialogDrag:true,
  border: true,
  index: true,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuType:'text',
  addBtn:false,
  delBtn:false,
  editBtn:false,
  searchShow:false,
  searchMenuSpan: 6,
  // defaultSort:{
  //    prop: 'id',
  //    order: 'descending'
  // },
  column: [
    {
      label: '回复消息类型',
      prop: 'repType',
      type: 'select',
      dicUrl: '/upms/dict/type/wx_rep_type'
    }
  ]
}
export const tableOption2 = {
  dialogDrag:true,
  border: true,
  index: true,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuType:'text',
  searchShow:false,
  addBtn:false,
  delBtn:false,
  editBtn:false,
  searchMenuSpan: 6,
  // defaultSort:{
  //    prop: 'id',
  //    order: 'descending'
  // },
  column: [
    {
      label: '请求消息类型',
      prop: 'reqType',
      type: 'select',
      dicUrl: '/upms/dict/type/wx_req_type',
      sortable:true
    },
    {
      label: '回复消息类型',
      prop: 'repType',
      type: 'select',
      dicUrl: '/upms/dict/type/wx_rep_type',
      sortable:true
    }
  ]
}
export const tableOption3 = {
  dialogDrag:true,
  border: true,
  index: true,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuType:'text',
  searchShow:false,
  addBtn:false,
  delBtn:false,
  editBtn:false,
  searchMenuSpan: 6,
  // defaultSort:{
  //    prop: 'id',
  //    order: 'descending'
  // },
  column: [
	  {
      label: '关键词',
      prop: 'reqKey',
      search:true,
      sortable:true
    },
    {
      label: '匹配类型',
      prop: 'repMate',
      type: 'select',
      dicUrl: '/upms/dict/type/wx_rep_mate',
      sortable:true
    },
	  {
      label: '回复消息类型',
      prop: 'repType',
      type: 'select',
      dicUrl: '/upms/dict/type/wx_rep_type',
      sortable:true
    }
  ]
}
