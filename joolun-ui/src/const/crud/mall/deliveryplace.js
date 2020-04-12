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
    searchMenuSpan: 6,
    column: [
        {
            label: '地方',
            prop: 'place',
            rules: [{
                required: true,
                message: '请输入发货地',
                trigger: 'blur'
            }],
        },{
            label: '电话号码',
            prop: 'telNum',
            rules: [{
                required: true,
                message: '请输入电话号码',
                trigger: 'blur'
            }],
        },{
            label: '详细地址',
            prop: 'address',
            type: 'textarea',
            rules: [{
                required: true,
                message: '请输入详细地址',
                trigger: 'blur'
            }],
        },
    ]
}
