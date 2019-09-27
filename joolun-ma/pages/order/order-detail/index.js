/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
const app = getApp()

Page({
  data: {
    orderInfo: null,
    id: null,
    callPay: false//是否直接调起支付
  },
  onShow() {
    app.initPage()
      .then(res => {
        this.orderGet(this.data.id)
      })
  },
  onLoad(options) {
    this.setData({
      id: options.id
    })
    if (options.callPay){
      this.setData({
        callPay: true
      })
    }
  },
  orderGet(id){
    let that = this
    app.api.orderGet(id)
      .then(res => {
        let orderInfo = res.data
        if (!orderInfo){
          wx.showToast({
            title: '无效订单',
            icon: 'none',
            duration: 5000
          })
          return
        }
        this.setData({
          orderInfo: orderInfo
        })
        if (orderInfo.status == '0'){
          this.countDown()
        }
        setTimeout(function () {
          that.setData({
            callPay: false
          })
        }, 4000)
      })
  },
  //复制内容
  copyData(e) {
    wx.setClipboardData({
      data: e.currentTarget.dataset.data
    })
  },
  countDown() { //倒计时函数
    // 获取当前时间，同时得到活动结束时间数组
    let newTime = new Date().getTime()
    //30分钟后过期
    let endTime = new Date(this.data.orderInfo.createTime.replace(/-/g, '/')).getTime() + 1800000
    // 对结束时间进行处理渲染到页面
    let obj = null
    // 如果活动未结束，对时间进行处理
    if (endTime - newTime > 0) {
      let time = (endTime - newTime) / 1000
      // 获取天、时、分、秒
      let day = parseInt(time / (60 * 60 * 24))
      let hou = parseInt(time % (60 * 60 * 24) / 3600)
      let min = parseInt(time % (60 * 60 * 24) % 3600 / 60)
      let sec = parseInt(time % (60 * 60 * 24) % 3600 % 60)
      obj = {
        day: this.timeFormat(day),
        hou: this.timeFormat(hou),
        min: this.timeFormat(min),
        sec: this.timeFormat(sec)
      }
    } else { //活动已结束，全部设置为'00'
      obj = {
        day: '00',
        hou: '00',
        min: '00',
        sec: '00'
      }
    }
    // 渲染，然后每隔一秒执行一次倒计时函数
    this.setData({
      countDown: obj
    })
    this.setData({
      setTimeoutNumber: setTimeout(this.countDown, 1000)
    })
  },
  timeFormat(param) { //小于10的格式化函数
    return param < 10 ? '0' + param : param
  },
  orderCancel(){
    let id = this.data.orderInfo.id
    this.orderGet(id)
  },
  orderDel(){
    wx.navigateBack()
  },
  unifiedOrder() {
    this.onShow()
  }
})