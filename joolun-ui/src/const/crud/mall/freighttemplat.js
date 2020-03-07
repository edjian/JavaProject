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
    labelWidth: 100,
    searchMenuSpan: 6,
    column: [
        {
            label: '名称',
            prop: 'name',
            rules: [{
                required: true,
                message: '请输入名称',
                trigger: 'blur'
            }]
        },
        {
            label: '排序字段',
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
            label: '模板类型',
            prop: 'type',
            type: 'radio',
            search: true,
            sortable: true,
            dicData: [{
                label: '买家承担运费',
                value: '1'
            },{
                label: '卖家包邮',
                value: '2'
            }],
            rules: [{
                required: true,
                message: '请选择模板类型',
                trigger: 'blur'
            }]
        },
        {
            label: '计费方式',
            prop: 'chargeType',
            type: 'radio',
            search: true,
            hide: true,
            sortable: true,
            display: false,
            dicData: [{
                label: '按件数',
                value: '1'
            },{
                label: '按重量',
                value: '2'
            },{
                label: '按体积',
                value: '3'
            }],
            rules: [{
                required: true,
                message: '请输入计费方式',
                trigger: 'blur'
            }]
        },
        {
            label: '首件',
            prop: 'firstNum',
            type: 'number',
            hide: true,
            display: false,
            sortable: true,
            rules: [{
                required: true,
                message: '请输入首件',
                trigger: 'blur'
            }]
        },
        {
            label: '首运费(元)',
            prop: 'firstFreight',
            type: 'number',
            minRows: 0,
            precision: 2,
            hide: true,
            display: false,
            sortable: true,
            rules: [{
                required: true,
                message: '请输入首运费',
                trigger: 'blur'
            }]
        },
        {
            label: '续件',
            prop: 'continueNum',
            type: 'number',
            hide: true,
            display: false,
            sortable: true,
            rules: [{
                required: true,
                message: '请输入续件',
                trigger: 'blur'
            }]
        },
        {
            label: '续运费(元)',
            prop: 'continueFreight',
            type: 'number',
            minRows: 0,
            precision: 2,
            hide: true,
            display: false,
            sortable: true,
            rules: [{
                required: true,
                message: '请输入续运费',
                trigger: 'blur'
            }]
        },
    ]
}
