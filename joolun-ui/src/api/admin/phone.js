import request from '@/router/axios'

export function sendCode(obj) {
  return request({
    url: '/admin/phone/code',
    method: 'put',
    params: obj
  })
}
