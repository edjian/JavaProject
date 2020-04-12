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
    column: [
        {
            label: '登录者ID',
            prop: 'createId',
            sortable: true
        },
        {
            label: '登录者',
            prop: 'createBy',
            sortable: true
        },
        {
            label: '创建时间',
            prop: 'createTime',
            sortable: true
        },
        {
            label: 'IP地址',
            prop: 'remoteAddr',
            sortable: true
        },
        {
            label: '地址信息',
            prop: 'address',
            sortable: true
        },
        {
            label: '用户代理',
            prop: 'userAgent',
            sortable: true,
            overHidden: true
        },
        {
            label: '登录方式',
            prop: 'requestUri',
            sortable: true,
            type: 'radio',
            dicData: [{
                label: '账号密码登录',
                value: '/oauth/token'
            }, {
                label: '手机号登录',
                value: '/phone/token/sms'
            }]
        },
        {
            label: '操作提交的数据',
            prop: 'params',
            sortable: true,
            overHidden: true
        }
    ]
}
