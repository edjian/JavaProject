/**
 * 配置参考:
 * https://cli.vuejs.org/zh/config/
 */
const url = 'https://127.0.0.1:9999'
// const url = 'http://192.168.31.110:9999'
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
  // 配置转发代理
  devServer: {
    disableHostCheck: true,
    port:8082,
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
