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
    labelWidth: 150,
    searchMenuSpan: 6,
    group: [
        {
            icon: 'el-icon-s-order',
            label: '基本信息',
            prop: 'group1',
            column: [
                {
                    label: '存储类型',
                    prop: 'storageType',
                    type: 'select',
                    dicUrl: '/admin/dict/type/storage_type',
                    rules: [{
                        required: true,
                        message: '请选择存储类型',
                        trigger: 'blur'
                    }]
                },
                {
                    label: 'endpoint',
                    prop: 'endpoint',
                    rules: [{
                        required: true,
                        message: 'endpoint不能为空',
                        trigger: 'blur'
                    }]
                },
                {
                    label: 'accessKeyId',
                    prop: 'accessKeyId',
                    rules: [{
                        required: true,
                        message: 'accessKeyId不能为空',
                        trigger: 'blur'
                    }]
                },
                {
                    label: 'accessKeySecret',
                    prop: 'accessKeySecret',
                    type:'password',
                    rules: [{
                        required: true,
                        message: 'accessKeySecret不能为空',
                        trigger: 'blur'
                    }]
                },
                {
                    label: 'bucket',
                    prop: 'bucket',
                    rules: [{
                        required: true,
                        message: 'bucket不能为空',
                        trigger: 'blur'
                    }]
                },
            ]
        },
        {
            icon: 'el-icon-picture',
            label: '图片配置',
            prop: 'group2',
            column: [
                {
                    label: '图片水印',
                    prop: 'waterMarkContent'
                }
            ]
        }]
}
