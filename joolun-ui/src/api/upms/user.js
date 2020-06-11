import request from '@/router/axios'

export function getPage(query) {
  return request({
    url: '/upms/user/page',
    method: 'get',
    params: query
  })
}

export function getCount(query) {
  return request({
    url: '/upms/user/count',
    method: 'get',
    params: query
  })
}

export function addObj(obj) {
  return request({
    url: '/upms/user',
    method: 'post',
    data: obj
  })
}

export function getObj(id) {
  return request({
    url: '/upms/user/' + id,
    method: 'get'
  })
}

export function delObj(id) {
  return request({
    url: '/upms/user/' + id,
    method: 'delete'
  })
}

export function putObj(obj) {
  return request({
    url: '/upms/user',
    method: 'put',
    data: obj
  })
}

export function editPassword(obj) {
  return request({
    url: '/upms/user/password',
    method: 'put',
    data: obj
  })
}

export function getByUserName(username) {
  return request({
    url: '/upms/user/detail/' + username,
    method: 'get'
  })
}

export function editObj(obj) {
  return request({
    url: '/upms/user/edit',
    method: 'put',
    data: obj
  })
}

export function bindPhone(obj) {
  return request({
    url: '/upms/user/phone',
    method: 'put',
    data: obj
  })
}
