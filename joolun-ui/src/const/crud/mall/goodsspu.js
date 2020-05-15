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
    border: true,
    stripe: true,
    menuAlign: 'center',
    align: 'center',
    menuType: 'text',
    searchShow: false,
    excelBtn: true,
    printBtn: true,
    dialogWidth: '88%',
    selection: true,
    searchMenuSpan: 6,
    column: [
        {
            label: '商品名称',
            prop: 'name',
            search: true,
            display: false
        },
        {
            label: '商品图片',
            prop: 'picUrls',
            width: 120,
            slot: true,
            display: false
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
            dicUrl: '/mall/goodscategory/tree',
            display: false
        },
        {
            label: '卖点',
            prop: 'sellPoint',
            sortable: true,
            display: false
        },
        {
            label: '价位',
            prop: 'price',
            slot: true,
            display: false
        },
        {
            label: '商品编码',
            prop: 'spuCode',
            search: true,
            sortable: true,
            display: false
        },
        {
            label: '规格类型',
            prop: 'specType',
            search: true,
            type: 'radio',
            display: false,
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
            sortable: true,
            display: false
        },
        {
            label: '创建时间',
            prop: 'createTime',
            sortable: true,
            display: false
        },
        {
            label: '更新时间',
            prop: 'updateTime',
            sortable: true,
            display: false
        },
        {
            label: '是否上架',
            prop: 'shelf',
            type: 'radio',
            search: true,
            sortable: true,
            slot: true,
            display: false,
            dicData: [{
                label: '下架',
                value: '0'
            }, {
                label: '上架',
                value: '1'
            }]
        },
        {
            label: '积分赠送',
            prop: 'pointsGiveSwitch',
            type: 'radio',
            search: true,
            sortable: true,
            display: false,
            dicData: [{
                label: '开启',
                value: '1'
            }, {
                label: '关闭',
                value: '0'
            }]
        },
        {
            label: '积分抵扣',
            prop: 'pointsDeductSwitch',
            type: 'radio',
            search: true,
            sortable: true,
            display: false,
            dicData: [{
                label: '开启',
                value: '1'
            }, {
                label: '关闭',
                value: '0'
            }]
        }
    ],
    group: [
        {
            icon: 'el-icon-goods',
            label: '基本信息',
            prop: 'group1',
            column: [
                {
                    label: '商品名称',
                    prop: 'name',
                    span: 24,
                    rules: [{
                        required: true,
                        message: '商品名称不能为空',
                        trigger: 'blur'
                    },{
                      max: 100,
                      message: '长度在不能超过100个字符'
                    }]
                },
                {
                    label: '商品图片',
                    prop: 'picUrls',
                    dataType: 'array',
                    formslot: true,
                    span: 24,
                    rules: [{
                        required: true,
                        message: '请上传商品图片',
                        trigger: 'blur'
                    }]
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
                        label: '下架',
                        value: '0'
                    }, {
                        label: '上架',
                        value: '1'
                    }]
                },
                {
                    label: '商品编码',
                    prop: 'spuCode',
                    rules: [{
                      max: 32,
                      message: '长度在不能超过32个字符'
                    }]
                },
                {
                    label: '虚拟销量',
                    prop: 'saleNum',
                    type: 'number',
                    tip: '可以按自己需求设置，系统会按销售情况自动累加'
                },
                {
                    label: '卖点',
                    prop: 'sellPoint',
                    span: 24,
                    rules: [{
                      max: 500,
                      message: '长度在不能超过500个字符'
                    }]
                },
                {
                    label: '运费模板',
                    prop: 'freightTemplatId',
                    type: 'select',
                    rules: [{
                        required: true,
                        message: '请选择运费模板',
                        trigger: 'blur'
                    }],
                    props: {
                        label: 'name',
                        value: 'id'
                    },
                    dicUrl: '/mall/freighttemplat/list'
                },{
                    label: '发货地',
                    prop: 'deliveryPlaceId',
                    type: 'select',
                    rules: [{
                        required: true,
                        message: '请选择发货地',
                        trigger: 'blur'
                    }],
                    props: {
                        label: 'place',
                        value: 'id'
                    },
                    dicUrl: '/mall/deliveryplace/list'
                },{
                    label: '保障服务',
                    prop: 'ensureIds',
                    type: 'checkbox',
                    props: {
                        label: 'name',
                        value: 'id'
                    },
                    dicUrl: '/mall/ensure/list'
                }]
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
            icon: 'el-icon-medal',
            label: '积分赠送',
            prop: 'group3',
            column: [
                {
                    label: '是否开启',
                    prop: 'pointsGiveSwitch',
                    type: 'radio',
                    rules: [{
                        required: true,
                        message: '请选择是否开启积分赠送',
                        trigger: 'blur'
                    }],
                    dicData: [{
                        label: '是',
                        value: '1'
                    }, {
                        label: '否',
                        value: '0'
                    }]
                },
                {
                    label: '赠送数量',
                    prop: 'pointsGiveNum',
                    type: 'number',
                    minRows: 0,
                    tip: '购买该商品赠送的积分数',
                    rules: [{
                        required: true,
                        message: '赠送数量不能为空',
                        trigger: 'blur'
                    }],
                    display: false
                }]
        },
        {
            icon: 'el-icon-medal-1',
            label: '积分抵扣',
            prop: 'group4',
            column: [
                {
                    label: '是否开启',
                    prop: 'pointsDeductSwitch',
                    type: 'radio',
                    rules: [{
                        required: true,
                        message: '请选择是否开启积分抵扣',
                        trigger: 'blur'
                    }],
                    dicData: [{
                        label: '是',
                        value: '1'
                    }, {
                        label: '否',
                        value: '0'
                    }]
                },
                {
                    label: '抵扣比例',
                    prop: 'pointsDeductScale',
                    type: 'number',
                    minRows: 0,
                    maxRows: 100,
                    tip: '积分可抵扣商品金额比例（0~100）%',
                    rules: [{
                        required: true,
                        message: '抵扣比例不能为空',
                        trigger: 'blur'
                    }],
                    display: false
                },
                {
                    label: '抵扣规则',
                    prop: 'pointsDeductAmount',
                    type: 'number',
                    minRows: 0,
                    precision: 2,
                    tip: '1积分数可抵多少元，不同商品可设置不同抵扣规则',
                    rules: [{
                        required: true,
                        message: '抵扣规则不能为空',
                        trigger: 'blur'
                    }],
                    display: false
                }]
        },
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

export const tableOption2 = {
    dialogType: 'drawer',
    border: true,
    stripe: true,
    menuAlign: 'center',
    align: 'center',
    searchShow: false,
    dialogWidth: '88%',
    editBtn: false,
    delBtn: false,
    addBtn: false,
    selection: true,
    menu: false,
    maxHeight: 450,
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
            slot: true
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
            label: '卖点',
            prop: 'sellPoint',
            sortable: true
        },
        {
            label: '价位',
            prop: 'price',
            slot: true
        },
        {
            label: '商品编码',
            prop: 'spuCode',
            search: true,
            sortable: true
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
            sortable: true
        },
        {
            label: '更新时间',
            prop: 'updateTime',
            sortable: true
        },
        {
            label: '是否上架',
            prop: 'shelf',
            type: 'radio',
            search: true,
            sortable: true,
            slot: true
        },
        {
            label: '积分赠送',
            prop: 'pointsGiveSwitch',
            type: 'radio',
            search: true,
            sortable: true,
            dicData: [{
                label: '开启',
                value: '1'
            }, {
                label: '关闭',
                value: '0'
            }]
        },
        {
            label: '积分抵扣',
            prop: 'pointsDeductSwitch',
            type: 'radio',
            search: true,
            sortable: true,
            dicData: [{
                label: '开启',
                value: '1'
            }, {
                label: '关闭',
                value: '0'
            }]
        }
    ]
}
