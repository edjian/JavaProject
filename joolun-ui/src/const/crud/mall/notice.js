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
  index: true,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuType: 'text',
  searchShow: false,
  excelBtn: true,
  printBtn: true,
  viewBtn: true,
  searchMenuSpan: 6,
  column: [
	  {
      label: 'PK',
      prop: 'id',
      sortable:true
    },
	  {
      label: '所属租户',
      prop: 'tenantId',
      sortable:true
    },
	  {
      label: '逻辑删除标记（0：显示；1：隐藏）',
      prop: 'delFlag',
      sortable:true
    },
	  {
      label: '创建时间',
      prop: 'createTime',
      sortable:true
    },
	  {
      label: '最后更新时间',
      prop: 'updateTime',
      sortable:true
    },
	  {
      label: '创建者ID',
      prop: 'createId',
      sortable:true
    },
	  {
      label: '通知名',
      prop: 'name',
      sortable:true
    },
	  {
      label: '备注',
      prop: 'remarks',
      sortable:true
    },
  ]
}
