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
    viewBtn: true,
    searchMenuSpan: 6,
    column: [
        {
            label: '图片',
            prop: 'url',
            dataType: 'array',
            slot: true,
            formslot: true
        },
        {
            label: '是否启用',
            prop: 'enable',
            type: 'radio',
            slot: true,
            rules: [{
                required: true,
                message: '请选择是否启用',
                trigger: 'blur'
            }],
            dicData: [{
                label: '关闭',
                value: '0'
            }, {
                label: '启用',
                value: '1'
            }]
        },
        {
            label: '排序',
            prop: 'sort',
            type: 'number',
            rules: [{
                required: true,
                message: '请输入排序',
                trigger: 'blur'
            }]
        },
        {
            label: '跳转页面',
            prop: 'page',
            type: 'textarea'
        },
        {
            label: '创建时间',
            prop: 'createTime',
            editDisplay: false,
            addDisplay: false
        }
    ]
}
export const tableOption2 = {
    dialogDrag: true,
    border: true,
    index: true,
    indexLabel: '序号',
    stripe: true,
    menuAlign: 'center',
    align: 'center',
    menuType: 'text',
    searchShow: false,
    column: [
        {
            label: '标签',
            prop: 'tag',
            rules: [{
                required: true,
                message: '请输入标签',
                trigger: 'blur'
            }]
        },
        {
            label: '内容',
            prop: 'content',
            span: 24,
            rules: [{
                required: true,
                message: '请输入内容',
                trigger: 'blur'
            }]
        },
        {
            label: '是否启用',
            prop: 'enable',
            type: 'radio',
            slot: true,
            rules: [{
                required: true,
                message: '请选择是否启用',
                trigger: 'blur'
            }],
            dicData: [{
                label: '关闭',
                value: '0'
            }, {
                label: '启用',
                value: '1'
            }]
        },
        {
            label: '排序',
            prop: 'sort',
            type: 'number',
            rules: [{
                required: true,
                message: '请输入排序',
                trigger: 'blur'
            }]
        },
        {
            label: '跳转页面',
            prop: 'page',
            type: 'textarea'
        },
        {
            label: '创建时间',
            prop: 'createTime',
            editDisplay: false,
            addDisplay: false
        }
    ]
}
