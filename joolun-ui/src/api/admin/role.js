import request from '@/router/axios'

export function getPage(query) {
  return request({
    url: '/admin/role/page',
    method: 'get',
    params: query
  })
}

export function getList(query) {
  return request({
    url: '/admin/role/list',
    method: 'get',
    params: query
  })
}

export function getObj(id) {
  return request({
    url: '/admin/role/' + id,
    method: 'get'
  })
}

export function addObj(obj) {
  return request({
    url: '/admin/role',
    method: 'post',
    data: obj
  })
}

export function putObj(obj) {
  return request({
    url: '/admin/role',
    method: 'put',
    data: obj
  })
}

export function delObj(id) {
  return request({
    url: '/admin/role/' + id,
    method: 'delete'
  })
}

export function permissionUpd(obj) {
  return request({
    url: '/admin/role/menu',
    method: 'put',
    data: obj
  })
}

export function fetchRoleTree(roleId) {
  return request({
    url: '/admin/menu/tree/' + roleId,
    method: 'get'
  })
}

export function fetchRoleTreeTenant(tenantId) {
  return request({
    url: '/admin/menu/tree/tenant/' + tenantId,
    method: 'get'
  })
}

export function permissionUpdTenant(obj) {
  return request({
    url: '/admin/role/menu/tenant',
    method: 'put',
    data: obj
  })
}
