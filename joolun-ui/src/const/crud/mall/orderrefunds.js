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
    menu: false,
    viewBtn: true,
    searchMenuSpan: 6,
    column: [
        {
            label: '创建时间',
            prop: 'createTime',
            sortable: true
        },
        {
            label: '订单信息',
            prop: 'orderId',
            slot: true,
            width: 280
        },
        {
            label: '商品信息',
            prop: 'orderItemId',
            slot: true,
            width: 200
        },
        {
            label: '退款状态',
            prop: 'status',
            slot: true,
            sortable: true
        },
        {
            label: '是否退款',
            prop: 'isRefund',
            slot: true
        },
        {
            label: '退款金额',
            prop: 'refundAmount',
            sortable: true
        },
        {
            label: '退款流水号',
            prop: 'refundTradeNo',
            sortable: true
        },
        {
            label: '退款原因',
            prop: 'refundReson'
        },
        {
            label: '拒绝退款原因',
            prop: 'refuseRefundReson'
        },
    ]
}
