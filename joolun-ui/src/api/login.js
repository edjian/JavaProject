import request from '@/router/axios'
const scope = 'server'

export const loginByUsername = (username, password, code, randomStr) => {
  const grant_type = 'password'

  return request({
    url: '/auth/oauth/token',
    headers: {
      isToken:false,
      'Authorization': 'Basic YWRtaW46YWRtaW4='
    },
    method: 'post',
    params: { username, password, randomStr, code, grant_type, scope }
  })
}

export const refreshToken = (refresh_token) => {
  const grant_type = 'refresh_token'
  return request({
    url: '/auth/oauth/token',
    headers: {
      'isToken': false,
      'Authorization': 'Basic YWRtaW46YWRtaW4=',
    },
    method: 'post',
    params: { refresh_token, grant_type, scope }
  })
}

export const loginByPhone = (phone, code) => {
  const grant_type = 'sms_login'
  return request({
    url: '/auth/phone/token/sms',
    headers: {
      'Authorization': 'Basic YWRtaW46YWRtaW4='
    },
    method: 'post',
    params: { phone: phone, code: code, grant_type }
  })
}

export const loginByThirdParty = (state, code) => {
  const grant_type = 'phone'
  return request({
    url: '/auth/phone/token/thirdparty',
    headers: {
      'Authorization': 'Basic YWRtaW46YWRtaW4='
    },
    method: 'post',
    params: { phone: state + '@' + code, grant_type }
  })
}

export const getUserInfo = () => {
  return request({
    url: '/admin/user/info',
    method: 'get'
  })
}

export const logout = () => {
  return request({
    url: '/auth/token/logout',
    method: 'delete'
  })
}

export function register(obj) {
  return request({
    url: '/admin/user/register',
    method: 'post',
    data: obj
  })
}
