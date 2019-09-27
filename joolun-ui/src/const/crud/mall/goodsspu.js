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
  dialogDrag: true,
  border: true,
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  menuType:'text',
  searchShow:false,
  excelBtn: true,
  printBtn: true,
  dialogWidth: '88%',
  editBtn: false,
  delBtn: false,
  addBtn: false,
  card:true,
  column: [
	  {
      label: '商品名称',
      prop: 'name',
      search: true
    },
    {
      label: '商品图片',
      prop: 'picUrls',
      width: 120,
      dataType: 'array',
      type: 'upload',
      listType: 'picture-card',
      slot:true
    },
    {
      label: '类目',
      prop: 'categoryId',
      type: 'cascader',
      search: true,
      props: {
        label: 'name',
        value: 'id'
      },
      dicUrl: '/mall/goodscategory/tree'
    },
    {
      label: '是否上架',
      prop: 'shelf',
      type: 'radio',
      search: true,
      sortable:true,
      slot:true,
      dicData: [{
        label: '上架',
        value: '0'
      }, {
        label: '下架',
        value: '1'
      }]
    },
    {
      label: '卖点',
      prop: 'sellPoint',
      sortable:true
    },
    {
      label: '价位',
      prop: 'price',
      slot:true
    },
    {
      label: '商品编码',
      prop: 'spuCode',
      search: true,
      sortable:true
    },
    {
      label: '规格类型',
      prop: 'specType',
      search: true,
      type: 'radio',
      dicData: [{
        label: '统一规格',
        value: '0'
      }, {
        label: '多规格',
        value: '1'
      }]
    },
    {
      label: '虚拟销量',
      prop: 'saleNum',
      sortable:true
    },
	  {
      label: '创建时间',
      prop: 'createTime',
      sortable:true
    },
	  {
      label: '更新时间',
      prop: 'updateTime',
      sortable:true
    },
  ],
  group:[
    {
      icon: 'el-icon-s-order',
      label: '基本信息',
      prop: 'group1',
      column: [
        {
          label: '商品名称',
          prop: 'name',
          rules: [{
            required: true,
            message: '商品名称不能为空',
            trigger: 'blur'
          }]
        },
        {
          label: '商品图片',
          prop: 'picUrls',
          width: 120,
          dataType: 'array',
          type: 'upload',
          listType: 'picture-card',
          canvasOption: {
            text: 'JooLun',
            ratio: 1
          },
          oss: 'ali',
          loadText: '图上上传中，请稍等',
          span: 24,
          tip: '默认第一张为商品主图',
        },
        {
          label: '类目',
          prop: 'categoryId',
          type: 'cascader',
          props: {
            label: 'name',
            value: 'id'
          },
          dicUrl: '/mall/goodscategory/tree',
          rules: [{
            required: true,
            message: '请选择类目',
            trigger: 'blur'
          }]
        },
        {
          label: '是否上架',
          prop: 'shelf',
          type: 'radio',
          rules: [{
            required: true,
            message: '请选择是否上架',
            trigger: 'blur'
          }],
          dicData: [{
            label: '上架',
            value: '0'
          }, {
            label: '下架',
            value: '1'
          }]
        },
        {
          label: '卖点',
          prop: 'sellPoint'
        },
        {
          label: '价位',
          prop: 'price',
          editDisplay:false,
          addDisplay:false
        },
        {
          label: '商品编码',
          prop: 'spuCode'
        },{
          label: '虚拟销量',
          prop: 'saleNum'
        },]
    },
    {
      icon: 'el-icon-s-order',
      label: '规格信息',
      prop: 'group2',
      column: [
        {
          label: '规格类型',
          prop: 'specType',
          type: 'radio',
          rules: [{
            required: true,
            message: '请选择规格类型',
            trigger: 'blur'
          }],
          dicData: [{
            label: '统一规格',
            value: '0'
          }, {
            label: '多规格',
            value: '1'
          }]
        },
        {
          prop: 'skus',
          formslot: true,
          span: 24
        },]
    },
    {
      icon: 'el-icon-s-order',
      label: '辅助信息',
      prop: 'group3',
      column: [
        {
          label: '描述',
          prop: 'description',
          formslot: true,
          span: 12
        }]
    }]
}
