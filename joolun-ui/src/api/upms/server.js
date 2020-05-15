import request from '@/router/axios'

export function getObj() {
  return request({
    url: '/upms/sysServer',
    method: 'get'
  })
}
