import request from '@/router/axios'

export function fetchTree(query) {
  return request({
    url: '/admin/organ/tree',
    method: 'get',
    params: query
  })
}

export function getList(query) {
  return request({
    url: '/admin/organ/list',
    method: 'get',
    params: query
  })
}

export function addObj(obj) {
  return request({
    url: '/admin/organ/',
    method: 'post',
    data: obj
  })
}

export function getObj(id) {
  return request({
    url: '/admin/organ/' + id,
    method: 'get'
  })
}

export function delObj(id) {
  return request({
    url: '/admin/organ/' + id,
    method: 'delete'
  })
}

export function putObj(obj) {
  return request({
    url: '/admin/organ/',
    method: 'put',
    data: obj
  })
}
