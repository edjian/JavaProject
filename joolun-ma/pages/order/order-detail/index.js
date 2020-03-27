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
  orderCancel(){
    let id = this.data.orderInfo.id
    this.orderGet(id)
  },
  orderDel(){
    wx.navigateBack()
  },
  unifiedOrder() {
    this.onShow()
  },
  countDownDone(){
    this.orderGet(this.data.id)
  }
})