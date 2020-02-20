import request from '@/router/axios'

export function sendSms(obj) {
  return request({
    url: '/admin/sms/send',
    method: 'post',
    data: obj
  })
}

