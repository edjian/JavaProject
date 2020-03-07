import request from '@/router/axios'

export function getObj() {
  return request({
    url: '/admin/sysServer',
    method: 'get'
  })
}
