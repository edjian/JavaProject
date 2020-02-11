import request from '@/router/axios'

export function getPage(query) {
  return request({
    url: '/admin/dict/page',
    method: 'get',
    params: query
  })
}

export function addObj(obj) {
  return request({
    url: '/admin/dict/',
    method: 'post',
    data: obj
  })
}

export function getObj(id) {
  return request({
    url: '/admin/dict/' + id,
    method: 'get'
  })
}

export function delObj(row) {
  return request({
    url: '/admin/dict/' + row.id,
    method: 'delete'
  })
}

export function putObj(obj) {
  return request({
    url: '/admin/dict/',
    method: 'put',
    data: obj
  })
}

export function getPage2(query) {
  return request({
    url: '/admin/dict/item/page',
    method: 'get',
    params: query
  })
}

export function addObj2(obj) {
  return request({
    url: '/admin/dict/item',
    method: 'post',
    data: obj
  })
}

export function getObj2(id) {
  return request({
    url: '/admin/dict/item/' + id,
    method: 'get'
  })
}

export function delObj2(id) {
  return request({
    url: '/admin/dict/item/' + id,
    method: 'delete'
  })
}

export function putObj2(obj) {
  return request({
    url: '/admin/dict/item',
    method: 'put',
    data: obj
  })
}

export function remote(type) {
  return request({
    url: '/admin/dict/type/' + type,
    method: 'get'
  })
}
