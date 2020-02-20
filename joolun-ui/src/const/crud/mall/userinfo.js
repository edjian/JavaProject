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
  index: false,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuType: 'text',
  searchShow: false,
  excelBtn: true,
  printBtn: true,
  addBtn: false,
  delBtn: false,
  viewBtn: true,
  column: [
    {
      label: '用户编码',
      prop: 'userCode',
      sortable: true,
      search: true,
      editDisabled: true
    },
    {
      label: '昵称',
      prop: 'nickName'
    },
    {
      label: '头像',
      prop: 'headimgUrl',
      type: 'upload',
      imgWidth:50,
      listType:'picture-img',
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
      label: '性别',
      prop: 'sex',
      sortable: true,
      type: 'select',
      dicUrl: '/admin/dict/type/wx_sex'
    },
    {
      label: '当前积分',
      prop: 'pointsCurrent',
      sortable: true,
      editDisabled: true,
      slot:true
    },
    {
      label: '手机号码',
      prop: 'phone',
      sortable: true,
      search: true
    },
    {
      label: '创建时间',
      prop: 'createTime',
      sortable: true
    },
  ]
}
