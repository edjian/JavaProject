import request from '@/router/axios'

export function sendEmail(obj) {
  return request({
    url: '/admin/email/send',
    method: 'post',
    data: obj
  })
}

