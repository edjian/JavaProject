import request from '@/router/axios'

export function sendSms(obj) {
  return request({
    url: '/upms/sms/send',
    method: 'post',
    data: obj
  })
}

