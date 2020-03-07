import {getByUserName} from '@/api/admin/user'


const validateUserName = (rule, value, callback) => {
    if (window.openType === 'edit'){
        callback()
    }else{
        getByUserName(value).then(response => {
            let data = response.data.data
            if (data !== null) {
                callback(new Error('账号已经存在'))
            } else {
                callback()
            }
        })
    }
}

export const tableOption = {
    dialogDrag: true,
    border: true,
    index: true,
    indexLabel: '序号',
    stripe: true,
    menuAlign: 'center',
    align: 'center',
    viewBtn: true,
    excelBtn: true,
    printBtn: true,
    searchMenuSpan: 6,
    column: [{
        fixed: true,
        label: 'id',
        prop: 'id',
        span: 24,
        hide: true,
        editDisabled: true,
        addDisplay: false
    }, {
        fixed: true,
        label: '账号',
        prop: 'username',
        editDisabled: true,
        search: true,
        span: 24,
        rules: [{
            required: true,
            message: '请输入账号'
        },
        {
            min: 3,
            max: 20,
            message: '长度在 3 到 20 个字符',
            trigger: 'blur'
        },{
                validator: validateUserName,
                trigger: 'blur'
        }]
    }, {
        label: '密码',
        prop: 'password',
        type: 'password',
        value: '',
        hide: true,
        viewDisplay: false,
        editDisplay: false,
        span: 24,
        rules: [{
            required: true,
            min: 6,
            max: 20,
            message: '长度在 6 到 20 个字符',
            trigger: 'blur'
        }]
    }, {
        label: '所属机构',
        prop: 'organId',
        span: 24,
        sortable: true,
        rules: [{
            required: true,
            message: '请选择机构',
            trigger: 'change'
        }],
        type: 'tree',
        search: true,
        props: {
            label: 'name',
            value: 'id'
        },
        defaultExpandAll: true,
        dicUrl: '/admin/organ/tree'
    }, {
        label: '角色',
        prop: 'roleIds',
        overHidden: true,
        dataType: 'array',
        span: 24,
        type: 'checkbox',
        rules: [{
            required: true,
            message: '请选择角色',
            trigger: 'blur'
        }],
        props: {
            label: 'roleName',
            value: 'id'
        },
        dicUrl: '/admin/role/list'
    }, {
        label: '允许登录',
        prop: 'lockFlag',
        type: 'radio',
        slot: true,
        sortable: true,
        span: 24,
        rules: [{
            required: true,
            message: '请选择状态',
            trigger: 'blur'
        }],
        dicData: [{
            label: '是',
            value: '0'
        }, {
            label: '否',
            value: '9'
        }]
    }, {
        width: 180,
        label: '创建时间',
        prop: 'createTime',
        type: 'datetime',
        format: 'yyyy-MM-dd HH:mm',
        valueFormat: 'yyyy-MM-dd HH:mm:ss',
        editDisabled: true,
        sortable: true,
        addDisplay: false,
        span: 24
    }, {
        label: '邮箱',
        prop: 'email',
        type: 'email',
        rules: [{
            required: true,
            message: '请输入邮箱'
        }]
    }, {
        label: '手机号',
        prop: 'phone',
        type: 'tel',
        value: '',
        span: 24,
        rules: [{
            min: 11,
            max: 11,
            message: '长度在 11 个字符',
            trigger: 'blur'
        }]
    }]
}
