export const tableOption = {
  dialogDrag:true,
  headerAlign: 'center',
  align: 'center',
  border: true,
  index: true,
  viewBtn: true,
  defaultExpandAll:true,
  column: [
    {
      label: '父类机构',
      prop: 'parentId',
      formslot: true,
      hide: true,
      sortable:true,
      rules: [{
        required: true,
        message: '请选择父类机构',
        trigger: 'change'
      }]
    },
    {
      label: '机构名称',
      prop: 'name',
      align: 'left',
      width: 200,
      rules: [{
        required: true,
        message: '机构名称不能为空',
        trigger: 'blur'
      }]
    },
    {
      label: '机构类型',
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
      label: '机构编码',
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
      label: '备注',
      hide:true,
      prop: 'comment'
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
    }
  ]
}
