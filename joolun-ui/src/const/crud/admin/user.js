import { getDetails } from '@/api/admin/user'

var validateUsername = (rule, value, callback) => {
  getDetails(value).then(response => {
    if (window.boxType === 'edit') callback()
    let result = response.data.data
    if (result !== null) {
      callback(new Error('用户名已经存在'))
    } else {
      callback()
    }
  })
}
export const tableOption = {
  dialogDrag:true,
  border: true,
  index: true,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  viewBtn: true,
  excelBtn: true,
  printBtn: true,
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
    label: '用户名',
    prop: 'username',
    editDisabled: true,
    slot: true,
    search: true,
    span: 24,
    rules: [{
      required: true,
      message: '请输入用户名'
    },
    {
      min: 3,
      max: 20,
      message: '长度在 3 到 20 个字符',
      trigger: 'blur'
    },
    { validator: validateUsername, trigger: 'blur' }
    ]
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
    formslot: true,
    slot: true,
    span: 24,
    sortable:true,
    rules: [{
      required: true,
      message: '请选择机构',
      trigger: 'change'
    }]
  }, {
    label: '角色',
    prop: 'role',
    formslot: true,
    slot: true,
    overHidden: true,
    span: 24,
    rules: [{
      required: true,
      message: '请选择角色',
      trigger: 'blur'
    }]
  }, {
    label: '允许登录',
    prop: 'lockFlag',
    type: 'radio',
    slot: true,
    sortable:true,
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
