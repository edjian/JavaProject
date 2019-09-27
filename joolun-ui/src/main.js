import Vue from 'vue'
import axios from './router/axios'
import VueAxios from 'vue-axios'
import App from './App'
import router from './router/router'
import store from './store'
import Element from 'element-ui'
import Avue from '@smallwei/avue'
import '@smallwei/avue/lib/index.css'
import 'babel-polyfill'
import 'classlist-polyfill'
import './permission' // 权限
import './error' // 日志
import 'element-ui/lib/theme-chalk/index.css'
import {loadStyle,filterForm} from './util/util'
import * as urls from '@/config/env'
import {iconfontUrl, iconfontVersion, aliOss} from '@/config/env'
import * as filters from './filters' // 全局filter
import './styles/common.scss'
import basicContainer from './components/basic-container/main'
// 插件 json 展示
import vueJsonTreeView from 'vue-json-tree-view'
import VueQr from 'vue-qr'
import VideoPlayer from 'vue-video-player'
//时间插件
import moment from 'moment'//导入文件
import AvueUeditor from 'avue-plugin-ueditor'
//引入 Froala Editor js file.
require('froala-editor/js/froala_editor.pkgd.min.js')
//引入中文语言包
require('froala-editor/js/languages/zh_cn')
//引入 Froala Editor css files.
require('froala-editor/css/froala_editor.pkgd.min.css')
require('froala-editor/css/froala_style.min.css')
require('font-awesome/css/font-awesome.css')
// Import and use Vue Froala lib.
import VueFroala from 'vue-froala-wysiwyg'
import animate from 'animate.css'
Vue.use(Element)
Vue.use(router)
Vue.use(VueAxios, axios)
Vue.use(animate)
Vue.use(VueQr)
Vue.use(VideoPlayer)
Vue.prototype.$moment = moment//赋值使用
Vue.use(vueJsonTreeView)
// 注册全局容器
Vue.component('basicContainer', basicContainer)
// 加载相关url地址
Object.keys(urls).forEach(key => {
  Vue.prototype[key] = urls[key]
})
//空值过滤器
Vue.prototype.filterForm = filterForm
//加载过滤器
Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key])
})
// 动态加载阿里云字体库
iconfontVersion.forEach(ele => {
  loadStyle(iconfontUrl.replace('$key', ele))
})
Vue.config.productionTip = false
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
Vue.use(Avue, {
  ali: aliOss
})
Vue.use(VueFroala)
Vue.use(AvueUeditor)
