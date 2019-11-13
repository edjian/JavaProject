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
  dialogWidth: '88%',
  dialogDrag: true,
  border: true,
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuType: 'text',
  searchShow: false,
  excelBtn: true,
  printBtn: true,
  editBtn: false,
  // addBtn: false,
  column: [
    {
      label: '图片',
      prop: 'thumbnail',
      width: 200,
      type: 'upload',
      listType: 'picture-img',
      canvasOption: {
        text: 'JooLun',
        ratio: 1
      },
      action: '/admin/file/upload?dir=cms/',
      propsHttp: {
        url: 'link'
      },
      loadText: '图上上传中，请稍等',
      span: 12,
      tip: '只能上传jpg/png文件，且不超过100kb',
    },
    {
      label: '排序',
      prop: 'sort',
      sortable:true,
      type: 'number',
      rules: [{
        required: true,
        message: '请输入排序',
        trigger: 'blur'
      }]
    },
	  {
      label: '频道',
      prop: 'channelId',
      sortable:true,
      type: 'select',
      rules: [{
        required: true,
        message: '请选择频道',
        trigger: 'blur'
      }],
      dicData: [{
        label: '资讯',
        value: '11'
      }, {
        label: '教程',
        value: '6'
      }, {
        label: '框架介绍',
        value: '10'
      }]
    },
    {
      label: '标题',
      prop: 'title',
      span: 24,
      rules: [{
        required: true,
        message: '标题不能为空',
        trigger: 'blur'
      }]
    },
    {
      label: '简要',
      prop: 'summary',
      span: 24,
      rules: [{
        required: true,
        message: '简要不能为空',
        trigger: 'blur'
      }]
    },
	  {
      label: '创建时间',
      prop: 'createTime',
      sortable:true,
      editDisplay:false,
      addDisplay:false
    },
    {
      label: '内容',
      prop: 'content',
      hide: true,
      formslot: true,
      span: 24
    }
  ]
}
