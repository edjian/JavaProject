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
  menuType:'text',
  searchShow:false,
  addBtn:false,
  excelBtn: true,
  editBtn: false,
  delBtn: false,
  viewBtn: true,
  printBtn: true,
  searchMenuSpan: 6,
  defaultSort:{
    prop:'createTime',
    order:'descending'
  },
  column: [
	  {
      label: '创建时间',
      prop: 'createTime',
      width: 180,
      sortable:true
    },
	  {
      label: '是否全部用户',
      prop: 'isToAll',
      type: 'select',
      dicUrl: '/upms/dict/type/yes_no',
      search:true,
      sortable:true
    },
	  {
      label: '消息类型',
      prop: 'repType',
      type: 'select',
      dicUrl: '/upms/dict/type/wx_rep_type',
      search:true,
      sortable:true
    },
    {
      label: '内容',
      prop: 'repContent',
      overHidden: true,
      align: 'left',
      width: 350,
      slot:true
    },
	  {
      label: 'mediaID',
      prop: 'repMediaId',
      hide:true,
      sortable:true
    },
	  {
      label: '标题',
      prop: 'repName',
      hide:true,
      sortable:true
    },
	  {
      label: '描述',
      prop: 'repDesc',
      hide:true,
      sortable:true
    },
	  {
      label: '链接',
      prop: 'repUrl',
      hide:true,
      sortable:true
    },
	  {
      label: '高质量链接',
      prop: 'repHqUrl',
      hide:true,
      sortable:true
    },
	  {
      label: '缩略图的媒体id',
      prop: 'repThumbMediaId',
      hide:true,
      sortable:true
    },
	  {
      label: '缩略图url',
      prop: 'repThumbUrl',
      hide:true,
      sortable:true
    },
	  {
      label: '图文消息的内容',
      prop: 'content',
      hide:true,
      sortable:true
    },
	  {
      label: '群发消息后返回的消息id',
      prop: 'msgId',
      hide:true,
      sortable:true
    },
	  {
      label: '消息发送状态',
      prop: 'msgStatus',
      type: 'select',
      dicUrl: '/upms/dict/type/wx_mass_msg_status',
      search:true,
      sortable:true
    },
	  {
      label: '发送的总数',
      prop: 'totalCount',
      sortable:true
    },
    {
      label: '过滤后总数',
      prop: 'filterCount',
      sortable:true
    },
	  {
      label: '发送成功数',
      prop: 'sentCount',
      sortable:true
    },
	  {
      label: '发送失败数',
      prop: 'errorCount',
      sortable:true
    }
  ]
}
