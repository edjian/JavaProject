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
    menu: false,
    column: [
        {
            label: '创建时间',
            prop: 'createTime',
            sortable: true
        },
        {
            label: '拼团信息',
            prop: 'grouponId',
            sortable: true,
            type: 'select',
            search: true,
            slot: true,
            props: {
                label: 'name',
                value: 'id'
            },
            dicUrl: '/mall/grouponinfo/list'
        },
        {
            label: '用户信息',
            prop: 'userId',
            slot: true,
            width: 360
        },
        {
            label: '状态',
            prop: 'status',
            slot: true,
            dicData: [{
                label: '拼团中',
                value: '0'
            },{
                label: '完成拼团',
                value: '1'
            },{
                label: '已过期',
                value: '2'
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
            label: '规格',
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
            label: '拼团价¥',
            prop: 'grouponPrice',
            sortable: true
        },
        {
            label: '开始时间',
            prop: 'validBeginTime',
            sortable: true
        },
        {
            label: '结束时间',
            prop: 'validEndTime',
            sortable: true
        }
    ]
}
