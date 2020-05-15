import request from '@/router/axios'

export function sendCode(obj) {
  return request({
    url: '/upms/phone/code',
    method: 'put',
    params: obj
  })
}
