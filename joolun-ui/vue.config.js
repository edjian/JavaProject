/**
 * 配置参考:
 * https://cli.vuejs.org/zh/config/
 */
// const url = 'http://192.168.31.110:9999'
//后台网关地址
const url = 'http://localhost:9999'
const fs = require('fs')
module.exports = {
  lintOnSave: true,
  productionSourceMap: false,
  chainWebpack: config => {
    // 忽略的打包文件
    config.externals({
      'axios': 'axios'
    })
    const entry = config.entry('app')
    entry
      .add('babel-polyfill')
      .end()
    entry
      .add('classlist-polyfill')
      .end()
  },
  // 本地开发环境配置
  devServer: {
    //https相关配置
    // https: {
    //   key: fs.readFileSync('E:/JL/GIT/all/file/2881827_test.joolun.com_nginx/2881827_test.joolun.com.key'),
    //   cert: fs.readFileSync('E:/JL/GIT/all/file/2881827_test.joolun.com_nginx/2881827_test.joolun.com.pem')
    // },
    disableHostCheck: true,
    port:8082,
    //转发代理
    proxy: {
      '/auth': {
        target: url,
        ws: true,
        pathRewrite: {
          '^/auth': '/auth'
        }
      },
      '/admin': {
        target: url,
        ws: true,
        pathRewrite: {
          '^/admin': '/admin'
        }
      },
      '/code': {
        target: url,
        ws: true,
        pathRewrite: {
          '^/code': '/code'
        }
      },
      '/gen': {
        target: url,
        ws: true,
        pathRewrite: {
          '^/gen': '/gen'
        }
      },
      '/doc': {
        target: url,
        ws: true,
        pathRewrite: {
          '^/doc': '/doc'
        }
      },
      '/webjars': {
        target: url,
        ws: true,
        pathRewrite: {
          '^/webjars': '/webjars'
        }
      },
      '/swagger-resources': {
        target: url,
        ws: true,
        pathRewrite: {
          '^/swagger-resources': '/swagger-resources'
        }
      },
      '/weixin': {
        target: url,
        ws: true,
        pathRewrite: {
          '^/weixin': '/weixin'
        }
      },
      '/wxma': {
        target: url,
        ws: true,
        pathRewrite: {
          '^/wxma': '/wxma'
        }
      },
      '/mall': {
        target: url,
        ws: true,
        pathRewrite: {
          '^/mall': '/mall'
        }
      }
    }
  }
}
