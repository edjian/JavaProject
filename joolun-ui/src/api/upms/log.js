import request from '@/router/axios'

export function getPage(query) {
  return request({
    url: '/upms/log/page',
    method: 'get',
    params: query
  })
}

export function delObj(id) {
  return request({
    url: '/upms/log/' + id,
    method: 'delete'
  })
}

export function addObj(obj) {
  return request({
    url: '/upms/log/',
    method: 'post',
    data: obj
  })
}

export function getObj(id) {
  return request({
    url: '/upms/log/' + id,
    method: 'get'
  })
}

export function putObj(obj) {
  return request({
    url: '/upms/log/',
    method: 'put',
    data: obj
  })
}

export function sendLogs(logsList) {
  return request({
    url: '/upms/log/logs',
    method: 'post',
    data: logsList
  })
}
