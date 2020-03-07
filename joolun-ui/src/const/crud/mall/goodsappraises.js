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
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuType: 'text',
  searchShow: false,
  excelBtn: false,
  printBtn: false,
  delBtn: false,
  addBtn: false,
  viewBtn: false,
  editBtn: false,
  menu: false,
  searchMenuSpan: 6,
  column: [
	  {
      label: '用户',
      prop: 'nickName',
      editDisplay: false,
      slot:true,
    },
	  {
      label: '商品信息',
      prop: 'specInfo',
      width: 200,
      slot: true,
      editDisplay: false,
      align: 'left'
    },
    {
      label: '订单信息',
      prop: 'orderItem',
      width: 300,
      slot: true,
      editDisplay: false,
      align: 'left'
    },
	  {
      label: '商品评分',
      prop: 'goodsScore',
      sortable:true,
      slot:true,
      editDisplay: false,
      align: 'left'
    },
	  {
      label: '评论内容',
      prop: 'content',
      slot:true,
      formslot: true,
      align: 'left'
    },
    {
      label: '回复内容',
      prop: 'sellerReply',
      align: 'left',
      type: 'textarea',
      span: 24,
      hide: true
    }
  ]
}
