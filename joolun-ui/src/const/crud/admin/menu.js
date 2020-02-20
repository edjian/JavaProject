import iconList from "@/const/iconList";

export const tableOption = {
  dialogDrag: true,
  headerAlign: 'center',
  align: 'center',
  border: true,
  viewBtn: true,
  column: [
    {
      label: '上级菜单',
      prop: 'parentId',
      type: 'tree',
      hide: true,
      props: {
        label: 'name',
        value: 'id'
      },
      rules: [{
        required: true,
        message: '请选择上级菜单',
        trigger: 'change'
      }]
    },
    {
      label: '名称',
      prop: 'name',
      align: 'left',
      width: 200,
      rules: [{
        required: true,
        message: '名称不能为空',
        trigger: 'blur'
      }]
    },
    {
      label: '类型',
      prop: 'type',
      type: 'select',
      slot: true,
      dicData: [{
        label: '菜单',
        value: '0'
      },{
        label: '按钮',
        value: '1'
      }],
      rules: [{
        required: true,
        message: '请选择类型',
        trigger: 'blur'
      }]
    },
    {
      label: '权限标识',
      prop: 'permission'
    },
    {
      label: '排序',
      type: 'number',
      prop: 'sort',
      rules: [{
        required: true,
        message: '排序不能为空',
        trigger: 'blur'
      }],
      display: false
    },
    {
      label: '图标',
      prop: 'icon',
      type: 'icon-select',
      iconList: iconList,
      slot: true,
      display: false
    },
    {
      label: '菜单路径',
      prop: 'component',
      display: false
    },
    {
      label: '菜单编码',
      prop: 'path',
      display: false
    },
    {
      label: '赋权角色',
      prop: 'roleId',
      type: 'select',
      hide: true,
      sortable:true,
      dicUrl: '/admin/role/list',
      props: {
        label: 'roleName',
        value: 'id'
      },
      rules: [{
        required: true,
        message: '请选择赋权角色',
        trigger: 'change'
      }],
      editDisplay: false,
      viewDisplay: false
    },
    {
      label: '创建时间',
      prop: 'createTime',
      hide: true,
      editDisplay: false,
      addDisplay: false
    },
    {
      label: '修改时间',
      prop: 'updateTime',
      hide: true,
      editDisplay: false,
      addDisplay: false
    }
  ]
}
