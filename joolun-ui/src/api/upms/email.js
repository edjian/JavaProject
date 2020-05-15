import request from '@/router/axios'

export function sendEmail(obj) {
  return request({
    url: '/upms/email/send',
    method: 'post',
    data: obj
  })
}

