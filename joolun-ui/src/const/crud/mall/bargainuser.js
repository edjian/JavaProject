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
    searchMenuSpan: 6,
    column: [
        {
            label: '创建时间',
            prop: 'createTime',
            sortable: true
        },
        {
            label: '用户信息',
            prop: 'userId',
            slot: true,
            width: 160
        },
        {
            label: '砍价信息',
            prop: 'bargainId',
            sortable: true,
            type: 'select',
            search: true,
            props: {
                label: 'name',
                value: 'id'
            },
            dicUrl: '/mall/bargaininfo/list'
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
            label: '状态',
            prop: 'status',
            sortable: true,
            slot: true,
            dicData: [{
                label: '砍价中',
                value: '0'
            },{
                label: '完成砍价',
                value: '1'
            },{
                label: '已过期',
                value: '2'
            }],
        },
        {
            label: '开始时间',
            prop: 'validBeginTime',
            sortable: true,
            width: 160
        },
        {
            label: '结束时间',
            prop: 'validEndTime',
            sortable: true,
            width: 160
        },
        {
            label: '砍价底价¥',
            prop: 'bargainPrice',
            sortable: true
        },
        {
            label: '已砍金额¥',
            prop: 'havBargainAmount',
            slot: true,
            sortable: true
        },
        {
            label: '必须底价购买',
            prop: 'floorBuy',
            sortable: true,
            dicData: [{
                label: '否',
                value: '0'
            },{
                label: '是',
                value: '1'
            }],
        },
        {
            label: '是否购买',
            prop: 'isBuy',
            sortable: true,
            dicData: [{
                label: '否',
                value: '0'
            },{
                label: '是',
                value: '1'
            }],
        },
    ]
}
