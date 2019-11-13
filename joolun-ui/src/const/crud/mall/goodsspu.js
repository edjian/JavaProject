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
      sortable: true
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
      icon: 'el-icon-goods',
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
          dataType: 'array',
          formslot: true,
          span: 24
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
          editDisplay: false,
          addDisplay: false
        },
        {
          label: '商品编码',
          prop: 'spuCode'
        },{
          label: '虚拟销量',
          prop: 'saleNum',
          type: 'number',
          tip: '可以按自己需求设置，系统会按销售情况自动累加'
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
    // {
    //   icon: 'el-icon-medal',
    //   label: '积分赠送',
    //   prop: 'group3',
    //   column: [
    //     {
    //       label: '是否开启',
    //       prop: 'pointsGiveSwitch',
    //       type: 'radio',
    //       rules: [{
    //         required: true,
    //         message: '请选择是否开启积分赠送',
    //         trigger: 'blur'
    //       }],
    //       dicData: [{
    //         label: '是',
    //         value: '1'
    //       },{
    //         label: '否',
    //         value: '0'
    //       }]
    //     },
    //     {
    //       label: '赠送数量',
    //       prop: 'pointsGiveNum',
    //       type: 'number',
    //       minRows: 0,
    //       tip: '购买该商品赠送的积分数'
    //     }]
    // },
    // {
    //   icon: 'el-icon-medal-1',
    //   label: '积分抵扣',
    //   prop: 'group4',
    //   column: [
    //     {
    //       label: '是否开启',
    //       prop: 'pointsDeductSwitch',
    //       type: 'radio',
    //       rules: [{
    //         required: true,
    //         message: '请选择是否开启积分抵扣',
    //         trigger: 'blur'
    //       }],
    //       dicData: [{
    //         label: '是',
    //         value: '1'
    //       },{
    //         label: '否',
    //         value: '0'
    //       }]
    //     },
    //     {
    //       label: '抵扣比例',
    //       prop: 'pointsDeductScale',
    //       type: 'number',
    //       tip: '积分可抵扣商品金额比例（0~100）',
    //       minRows: 0,
    //       maxRows: 100,
    //     },
    //     {
    //       label: '抵扣规则',
    //       prop: 'pointsDeductAmount',
    //       type: 'number',
    //       minRows: 0,
    //       precision: '2',
    //       tip: '1积分数可抵多少元'
    //     }]
    // },
    {
      icon: 'el-icon-grape',
      label: '辅助信息',
      prop: 'group5',
      column: [
        {
          label: '描述',
          prop: 'description',
          formslot: true,
          span: 12
        }]
    }]
}
