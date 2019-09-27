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
    orderConfirmData: [],
    totalPrice: 0,
    userAddress: null,
    orderSubParm: {
      paymentType: '1'
    },
    loading: false
  },
  onShow() {
    
  },
  onLoad: function () {
    this.userAddressPage()
    // 本地获取参数信息
    let that = this
    wx.getStorage({
      key: 'param-orderConfirm',
      success: function (res) {
        let orderConfirmData = res.data
        let totalPrice = 0
        orderConfirmData.forEach(function (orderConfirm) {
          totalPrice = totalPrice + orderConfirm.salesPrice * orderConfirm.quantity
        })
        that.setData({
          orderConfirmData: orderConfirmData,
          totalPrice: totalPrice
        })
      }
    })
  },
  userAddressPage() {
    app.api.userAddressPage(
      {
        searchCount: false,
        current: 1,
        size: 1,
        isDefault: '1'
    })
      .then(res => {
        let records = res.data.records
        if (records && records.length > 0){
          this.setData({
            userAddress: records[0]
          })
        }
      })
  },
  userMessageInput(e){
    this.setData({
      [`orderSubParm.userMessage`]: e.detail.value
    })
  },
  //提交订单
  orderSub(){
    let userAddress = this.data.userAddress
    if (userAddress == null){
      wx.showToast({
        title: '请选择收货地址',
        icon: 'none',
        duration: 2000
      })
      return
    }
    let that = this
    this.setData({
      loading: true
    })
    let orderSubParm = this.data.orderSubParm
    orderSubParm.skus = this.data.orderConfirmData
    app.api.orderSub(Object.assign(
      {},
      { userAddressId: userAddress.id},
      orderSubParm
    ))
      .then(res => {
        wx.redirectTo({
          url: '/pages/order/order-detail/index?callPay=true&id=' + res.data.id
        })
      }).catch(() => {
        this.setData({
          loading: false
        })
      })
  }
})