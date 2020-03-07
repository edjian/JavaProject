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
    labelWidth: 120,
    viewBtn: true,
    searchMenuSpan: 6,
    column: [
        {
            label: '用户初始积分',
            prop: 'initPosts',
            tip: '新用户的初始积分数',
            type: 'number',
            minRows: 0,
            rules: [{
                required: true,
                message: '请输入初始积分',
                trigger: 'blur'
            }],
        },
        {
          label: '会员初始积分',
          prop: 'initVipPosts',
          tip: '新会员的初始积分数',
          type: 'number',
          minRows: 0,
          rules: [{
            required: true,
            message: '请输入初始积分',
            trigger: 'blur'
          }],
        },
        {
            label: '订单满',
            prop: 'premiseAmount',
            tip: '订单金额（不包含运费）满多少可使用抵扣',
            type: 'number',
            minRows: 0,
            precision: 2,
            rules: [{
                required: true,
                message: '请输入最少使用金额',
                trigger: 'blur'
            }],
        },
        {
            label: '抵扣比例',
            prop: 'defaultDeductScale',
            type: 'number',
            minRows: 0,
            maxRows: 100,
            tip: '积分可抵扣商品金额比例（0~100）%，可在不同的商品中设置不同的抵扣比例',
            rules: [{
                required: true,
                message: '请输入抵扣比例',
                trigger: 'blur'
            }],
        },
        {
            label: '抵扣规则',
            prop: 'defaultDeductAmount',
            tip: '默认1积分数可抵多少元，可在不同的商品中设置不同的抵扣规则',
            type: 'number',
            minRows: 0,
            precision: 2,
            rules: [{
                required: true,
                message: '请输入抵扣规则',
                trigger: 'blur'
            }],
        },
    ]
}
