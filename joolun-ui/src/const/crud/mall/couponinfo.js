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
            label: '创建时间',
            prop: 'createTime',
            sortable: true,
            addDisplay: false,
            editDisplay: false
        },
        {
            label: '名称',
            prop: 'name',
            sortable: true,
            rules: [{
                required: true,
                message: '请输入电子全名称',
                trigger: 'blur'
            }]
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
            label: '库存',
            type: 'number',
            prop: 'stock',
            sortable: true,
            rules: [{
                required: true,
                message: '请输入库存',
                trigger: 'blur'
            }],
            tip: '限制领取的优惠券数量'
        },
        {
            label: '订单金额',
            prop: 'premiseAmount',
            type: 'number',
            minRows: 0,
            precision: 2,
            sortable: true,
            rules: [{
                required: true,
                message: '请输入订单金额',
                trigger: 'blur'
            }],
            tip: '订单金额（不包含运费，包含积分抵扣金额）满多少可使用'
        },
        {
            label: '类型',
            prop: 'type',
            type: 'radio',
            search: true,
            sortable:true,
            rules: [{
                required: true,
                message: '请选择类型',
                trigger: 'blur'
            }],
            dicData: [{
                label: '代金券',
                value: '1'
            },{
                label: '折扣券',
                value: '2'
            }]
        },
        {
            label: '减免金额',
            prop: 'reduceAmount',
            type: 'number',
            minRows: 0,
            precision: 2,
            sortable: true,
            display: false,
            hide: true,
            rules: [{
                required: true,
                message: '请输入减免金额',
                trigger: 'blur'
            }]
        },
        {
            label: '折扣率',
            prop: 'discount',
            type: 'number',
            minRows: 0.1,
            maxRows: 9.9,
            precision: 1,
            sortable: true,
            display: false,
            hide: true,
            rules: [{
                required: true,
                message: '请输入折扣率',
                trigger: 'blur'
            }],
            tip: '折扣率范围0-10，9.5代表9.5折'
        },
        {
            label: '到期类型',
            prop: 'expireType',
            type: 'radio',
            search: true,
            sortable:true,
            rules: [{
                required: true,
                message: '请选择到期类型',
                trigger: 'blur'
            }],
            dicData: [{
                label: '领券后生效',
                value: '1'
            },{
                label: '固定时间段',
                value: '2'
            }]
        },
        {
            label: '有效天数',
            prop: 'validDays',
            type: 'number',
            sortable: true,
            display: false,
            hide: true,
            rules: [{
                required: true,
                message: '请输入有效天数',
                trigger: 'blur'
            }],
        },
        {
            label: '时间范围',
            prop: 'validTime',
            sortable: true,
            type: 'datetimerange',
            display: false,
            hide: true,
            valueFormat: 'yyyy-MM-dd HH:mm:ss',
            rules: [{
                type: 'array',
                required: true,
                message: '请选择时间范围',
                trigger: 'change'
            }],
        },
        {
            label: '是否启用',
            prop: 'enable',
            type: 'radio',
            search: true,
            sortable: true,
            span: 24,
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
            label: '适用商品',
            prop: 'suitType',
            type: 'radio',
            search: true,
            sortable:true,
            span: 24,
            editDisabled: true,
            rules: [{
                required: true,
                message: '请选择适用类型',
                trigger: 'blur'
            }],
            dicData: [{
                label: '全部商品',
                value: '1'
            },{
                label: '指定商品可用',
                value: '2'
            }]
        },
        {
            label: '指定商品',
            prop: 'listGoodsSpu',
            formslot: true,
            display: false,
            hide: true,
            span: 24
        },
    ]
}
