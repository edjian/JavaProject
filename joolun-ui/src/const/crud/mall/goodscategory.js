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
  column: [
	  {
      label: '父分类',
      prop: 'parentId',
      formslot: true,
      hide: true,
      sortable: true,
      rules: [{
        required: true,
        message: '请选择父分类',
        trigger: 'change'
      }]
    },
	  {
      label: '名称',
      prop: 'name',
      align: 'left',
    },
	  {
      label: '排序',
      type: 'number',
      prop: 'sort',
      rules: [{
        required: true,
        message: '排序不能为空',
        trigger: 'blur'
      }]
    },
    {
      label: '描述',
      prop: 'description',
      hide: true
    },
    {
      label: '图片',
      prop: 'picUrl',
      width: 120,
      type: 'upload',
      listType: 'picture-img',
      canvasOption: {
        text: 'JooLun',
        ratio: 1
      },
      oss: 'ali',
      loadText: '图上上传中，请稍等',
      span: 24,
      tip: '只能上传jpg/png文件，且不超过100kb',
    },
	  {
      label: '创建时间',
      prop: 'createTime',
      editDisplay:false,
      addDisplay:false
    },
	  {
      label: '更新时间',
      prop: 'updateTime',
      editDisplay:false,
      addDisplay:false
    },
  ]
}
