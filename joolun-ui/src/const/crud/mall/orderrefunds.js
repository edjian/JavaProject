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
    column: [
                    {
                label: 'PK',
                prop: 'id',
                sortable: true
            },
                    {
                label: '所属租户',
                prop: 'tenantId',
                sortable: true
            },
                    {
                label: '逻辑删除标记（0：显示；1：隐藏）',
                prop: 'delFlag',
                sortable: true
            },
                    {
                label: '创建时间',
                prop: 'createTime',
                sortable: true
            },
                    {
                label: '最后更新时间',
                prop: 'updateTime',
                sortable: true
            },
                    {
                label: '创建者ID',
                prop: 'createId',
                sortable: true
            },
                    {
                label: '订单ID',
                prop: 'orderId',
                sortable: true
            },
                    {
                label: '订单详情ID',
                prop: 'orderItemId',
                sortable: true
            },
                    {
                label: '退款状态0：撤销退换申请；1：退款申请中；11、同意退款；12、拒绝退款；2：退货退款申请中；21：同意退货退款/退货中；22：拒绝退货退款；211：收到退货同意退款；212：收到退货拒绝退款',
                prop: 'status',
                sortable: true
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
                prop: 'refundReson',
                sortable: true
            },
                    {
                label: '拒绝退款原因',
                prop: 'refuseRefundReson',
                sortable: true
            },
            ]
}
