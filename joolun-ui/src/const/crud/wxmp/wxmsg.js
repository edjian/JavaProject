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
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuType:'text',
  editBtn: false,
  delBtn: false,
  addBtn: false,
  viewBtn: false,
  searchBtn: true,
  excelBtn: true,
  printBtn: true,
  defaultSort:{
    prop:'createTime',
    order:'descending'
  },
  column: [
    {
      label: '消息类型',
      prop: 'repType',
      type: 'select',
      dicUrl: '/admin/dict/type/wx_req_type',
      search:true,
      sortable:true
    },
    {
      label: '用户',
      prop: 'headimgUrl',
      overHidden: false,
      align: 'right',
      search:true,
      slot:true
    },{
      label: '内容',
      prop: 'repContent',
      overHidden: true,
      align: 'left',
      slot:true
    },{
      label: '时间',
      type: 'date',
      align: 'right',
      prop: 'createTime',
      sortable:true
    },
	  {
      label: '是否已读',
      prop: 'readFlag',
      type: 'select',
      dicUrl: '/admin/dict/type/yes_no',
      search:true,
      sortable:true,
      slot:true
    }
  ]
}
