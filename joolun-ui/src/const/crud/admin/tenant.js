export const tableOption = {
  dialogDrag:true,
  headerAlign: 'center',
  align: 'center',
  border: true,
  index: true,
  viewBtn: true,
  delBtn: false,
  defaultExpandAll:true,
  column: [
    {
      label: '租户名称',
      prop: 'name',
      width: 200,
      rules: [{
        required: true,
        message: '机构名称不能为空',
        trigger: 'blur'
      }]
    },
    {
      label: '租户类型',
      prop: 'type',
      type: 'select',
      dicUrl: '/admin/dict/type/organ_type',
      rules: [{
        required: true,
        message: '请选择机构类型',
        trigger: 'blur'
      }]
    },
    {
      label: '租户编码',
      hide:true,
      prop: 'code',
      rules: [{
        required: true,
        message: '机构编码不能为空',
        trigger: 'blur'
      }]
    },
    {
      label: '排序',
      hide:true,
      type: 'number',
      prop: 'sort',
      rules: [{
        required: true,
        message: '排序不能为空',
        trigger: 'blur'
      }]
    },
    {
      label: '电话',
      hide:true,
      prop: 'phone'
    },
    {
      label: '传真',
      hide:true,
      prop: 'fax'
    },
    {
      label: '邮箱',
      hide:true,
      prop: 'email'
    },
    {
      label: '地址',
      hide:true,
      prop: 'address'
    },
    {
      label: '创建时间',
      prop: 'createTime',
      editDisplay:false,
      addDisplay:false
    },
    {
      label: '修改时间',
      prop: 'updateTime',
      hide:true,
      editDisplay:false,
      addDisplay:false
    },
    {
      label: '管理员用户名',
      prop: 'username',
      hide:true,
      viewDisplay: false,
      editDisplay:false,
      rules: [{
        required: true,
        message: '管理员用户名',
        trigger: 'blur'
      }]
    },
    {
      label: '管理员密码',
      prop: 'password',
      hide: true,
      viewDisplay: false,
      editDisplay: false,
      rules: [{
        required: true,
        message: '管理员密码',
        trigger: 'blur'
      }]
    }
  ]
}
