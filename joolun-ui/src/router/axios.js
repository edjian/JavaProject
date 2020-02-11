/**
 * 全站http配置
 *
 * header参数说明
 * serialize是否开启form表单提交
 * isToken是否需要token
 */
import axios from 'axios'
import store from '@/store'
import router from '@/router/router'
import { serialize } from '@/util/util'
import NProgress from 'nprogress' // progress bar
import errorCode from '@/const/errorCode'
import { Message, MessageBox } from 'element-ui'
import 'nprogress/nprogress.css'
import { switchDemon } from '@/config/env'

axios.defaults.timeout = 30000
// 返回其他状态吗
axios.defaults.validateStatus = function (status) {
  return status >= 200 && status <= 500 // 默认的
}
// 跨域请求，允许保存cookie
axios.defaults.withCredentials = true
// NProgress Configuration
NProgress.configure({
  showSpinner: false
})

// HTTPrequest拦截
axios.interceptors.request.use(config => {
  if(switchDemon){
    if(config.url && config.url.indexOf("/auth/") == -1 &&
      config.url.indexOf("/register") == -1 &&
        (store.getters.userInfo.id == '5' || store.getters.userInfo.id == '6') &&
      config.method !== 'get'){
      MessageBox.confirm('演示账号，不能操作。<a href="http://www.joolun.com" target="_blank" style="color: red">前去官网获取源码</a><br>客服QQ（1023530620）', '提示',{
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        dangerouslyUseHTMLString: true,
        type: 'warning'
      }).then(() => {
        // store.dispatch("LogOut").then(() => {
        //   router.push({ path: '/register' })
        // })
      }).catch(() => {

      })
      return Promise.reject('演示环境')
    }
  }
  NProgress.start() // start progress bar
  const isToken = (config.headers || {}).isToken === false
  let token = store.getters.access_token
  if (token && !isToken) {
    config.headers['Authorization'] = 'Bearer ' + token// token
  }
  return config
}, error => {
  return Promise.reject(error)
})


// HTTPresponse拦截
axios.interceptors.response.use(res => {
  NProgress.done()
  const status = Number(res.status) || 200
  const message = res.data.msg || errorCode[status] || errorCode['default']
  if (status === 401) {
    // Message({
    //   message: message,
    //   type: 'error'
    // })
    store.dispatch('FedLogOut').then(() => {
      router.push({ path: '/login' })
    })
    return
  }

  if (status !== 200 || res.data.code === 1) {
    Message({
      message: message,
      type: 'error'
    })
    return Promise.reject(new Error(message))
  }

  return res
}, error => {
  NProgress.done()
  return Promise.reject(new Error(error))
})

export default axios
