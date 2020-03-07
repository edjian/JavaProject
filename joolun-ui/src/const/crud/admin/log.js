export const tableOption = {
  dialogDrag:true,
  border: true,
  index: true,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  menuWidth: 150,
  align: 'center',
  refreshBtn: true,
  showColumnBtn: false,
  searchSize: 'mini',
  addBtn: false,
  editBtn: false,
  viewBtn: true,
  excelBtn: true,
  printBtn: true,
  menuType:'text',
  searchMenuSpan: 6,
  props: {
    label: 'label',
    value: 'value'
  },
  column: [{
    label: '类型',
    prop: 'type',
    type: 'select',
    sortable:true,
    dicUrl: '/admin/dict/type/log_type',
    search: true
  }, {
    label: '标题',
    prop: 'title'
  }, {
    label: 'IP地址',
    prop: 'remoteAddr'
  }, {
    label: '资源路径',
    prop: 'requestUri'
  }, {
    label: '请求方式',
    prop: 'method',
    type: 'select',
    sortable:true,
    dicUrl: '/admin/dict/type/request_method',
    search: true
  }, {
    label: '操作人',
    sortable:true,
    prop: 'createBy'
  }, {
    label: '客户端',
    sortable:true,
    prop: 'serviceId',
    hide: true
  }, {
    width: 80,
    label: '请求时间',
    prop: 'time'
  }, {
    width: 150,
    label: '创建时间',
    prop: 'createTime',
    type: 'datetime',
    sortable:true,
    format: 'yyyy-MM-dd HH:mm',
    valueFormat: 'yyyy-MM-dd HH:mm:ss'
  }]
}
