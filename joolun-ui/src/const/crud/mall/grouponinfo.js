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
    indexLabel: '序号',
    stripe: true,
    menuAlign: 'center',
    align: 'center',
    menuType: 'text',
    searchShow: false,
    excelBtn: true,
    printBtn: true,
    viewBtn: true,
    enter: false,
    column: [
        {
            label: '创建时间',
            prop: 'createTime',
            sortable: true,
            addDisplay: false,
            editDisplay: false
        },
        {
            label: '图片',
            prop: 'picUrl',
            width: 250,
            dataType: 'array',
            slot: true,
            formslot: true,
            span: 24,
            rules: [{
                type: 'array',
                required: true,
                message: '图片不能为空',
                trigger: 'change'
            }]
        },
        {
            label: '商品',
            prop: 'spuId',
            type: 'select',
            filterable: true,
            editDisabled: true,
            props: {
                label: 'name',
                value: 'id'
            },
            cascaderItem: ['skuId'],
            dicUrl: '/mall/goodsspu/list',
            rules: [
                {
                    required: true,
                    message: '请选择商品',
                    trigger: 'blur'
                }
            ]
        },
        {
            label: '商品规格',
            prop: 'skuId',
            type: 'select',
            dicFlag: false,
            filterable: true,
            editDisabled: true,
            props: {
                label: 'name',
                value: 'id'
            },
            dicUrl: `/mall/goodssku/list/{{key}}`,
            rules: [
                {
                    required: true,
                    message: '请选择商品规格',
                    trigger: 'blur'
                }
            ]
        },
        {
            label: '时间范围',
            prop: 'validTime',
            type: 'datetimerange',
            hide: true,
            editDisabled: true,
            valueFormat: 'yyyy-MM-dd HH:mm:ss',
            rules: [{
                type: 'array',
                required: true,
                message: '请选择时间范围',
                trigger: 'change'
            }],
            tip: '拼团有效时间段'
        },
        {
            label: '排序',
            prop: 'sort',
            type: 'number',
            sortable: true,
            rules: [{
                required: true,
                message: '请输入排序',
                trigger: 'blur'
            }]
        },
        {
            label: '是否启用',
            prop: 'enable',
            type: 'radio',
            search: true,
            sortable: true,
            slot: true,
            rules: [{
                required: true,
                message: '请选择启用状态',
                trigger: 'blur'
            }],
            dicData: [{
                label: '关闭',
                value: '0'
            },{
                label: '启用',
                value: '1'
            }]
        },
        {
            label: '拼团名称',
            prop: 'name',
            slot: true,
            rules: [{
                required: true,
                message: '请输入拼团名称',
                trigger: 'blur'
            }]
        },
        {
            label: '拼团时长（小时）',
            prop: 'duration',
            type: 'number',
            minRows: 0,
            precision: 0,
            sortable: true,
            rules: [{
                required: true,
                message: '请输入拼团时长',
                trigger: 'blur'
            }],
        },
        {
            label: '分享标题 ',
            prop: 'shareTitle',
            hide: true,
            rules: [{
                required: true,
                message: '请输入分享标题',
                trigger: 'blur'
            }],
        },
        {
            label: '拼团人数',
            prop: 'grouponNum',
            type: 'number',
            minRows: 2,
            maxRows: 10,
            precision: 0,
            sortable: true,
            editDisabled: true,
            rules: [{
                required: true,
                message: '请输入拼团人数',
                trigger: 'blur'
            }],
        },
        {
            label: '拼团价',
            prop: 'grouponPrice',
            type: 'number',
            minRows: 0,
            precision: 2,
            sortable: true,
            editDisabled: true,
            rules: [{
                required: true,
                message: '请输入拼团价',
                trigger: 'blur'
            }],
        },
        {
            label: '发起人数',
            prop: 'launchNum',
            type: 'number',
            minRows: 0,
            precision: 0,
            sortable: true,
            tip: '发起过该拼团的人数，数量会根据实际情况自动累加'
        },
        {
            label: '拼团规则',
            prop: 'grouponRule',
            type: 'textarea',
            hide: true,
            rules: [{
                required: true,
                message: '请输入拼团规则',
                trigger: 'blur'
            }],
        }
    ]
}
