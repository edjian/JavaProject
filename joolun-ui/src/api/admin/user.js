import request from '@/router/axios'

export function getPage(query) {
  return request({
    url: '/admin/user/page',
    method: 'get',
    params: query
  })
}

export function addObj(obj) {
  return request({
    url: '/admin/user',
    method: 'post',
    data: obj
  })
}

export function getObj(id) {
  return request({
    url: '/admin/user/' + id,
    method: 'get'
  })
}

export function delObj(id) {
  return request({
    url: '/admin/user/' + id,
    method: 'delete'
  })
}

export function putObj(obj) {
  return request({
    url: '/admin/user',
    method: 'put',
    data: obj
  })
}

export function editPassword(obj) {
  return request({
    url: '/admin/user/password',
    method: 'put',
    data: obj
  })
}

export function getByUserName(username) {
  return request({
    url: '/admin/user/detail/' + username,
    method: 'get'
  })
}

export function editObj(obj) {
  return request({
    url: '/admin/user/edit',
    method: 'put',
    data: obj
  })
}

export function bindPhone(obj) {
  return request({
    url: '/admin/user/phone',
    method: 'put',
    data: obj
  })
}