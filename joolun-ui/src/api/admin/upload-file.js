import request from '@/router/axios'

export function getSignature (query) {
  return request({
    url: '/admin/file/signature',
    method: 'get',
    params: query
  })
}
