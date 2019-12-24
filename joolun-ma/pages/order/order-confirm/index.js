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
    paymentPrice: 0,
    userAddress: null,
    orderSubParm: {
      paymentType: '1'
    },
    loading: false,
    userInfo: null,
    pointsConfig: null,
    totalPointsDeduct: 0,
    totalPointsDeductPriceTemp: 0,
    totalPointsDeductPrice: 0,
    modalCoupon: '',
    spuIds: [],
    couponUserList: [],
    couponUser: null,
    totalCouponDeductPrice: 0
  },
  onShow() {
    
  },
  onLoad: function () {
    this.userAddressPage()
    this.pointsConfigGet()
    this.userInfoGet()
    // 本地获取参数信息
    let that = this
    wx.getStorage({
      key: 'param-orderConfirm',
      success: function (res) {
        let orderConfirmData = res.data
        let totalPrice = 0
        let totalPointsDeduct = 0 //最多可用积分数
        let totalPointsDeductPriceTemp = 0 //最多可用积分数抵扣金额
        let spuIds = null
        orderConfirmData.forEach((orderConfirm, index) => {
          if (spuIds){
            spuIds = spuIds + ',' + orderConfirm.spuId
          }else{
            spuIds = orderConfirm.spuId
          }
          totalPrice = (Number(totalPrice) + orderConfirm.salesPrice * orderConfirm.quantity).toFixed(2)
          orderConfirm.paymentPrice = (orderConfirm.salesPrice * orderConfirm.quantity).toFixed(2)
          if (orderConfirm.pointsDeductSwitch == '1'){
            let pointsDeductPrice = Math.floor(orderConfirm.salesPrice * orderConfirm.pointsDeductScale / 100 * orderConfirm.quantity)
            let pointsDeduct = pointsDeductPrice / orderConfirm.pointsDeductAmount
            orderConfirm.paymentPointsPrice2 = pointsDeductPrice
            orderConfirm.paymentPrice2 = (orderConfirm.salesPrice * orderConfirm.quantity).toFixed(2) - pointsDeductPrice
            if (pointsDeductPrice >= 1){
              orderConfirm.paymentPoints2 = pointsDeduct
              totalPointsDeductPriceTemp = Number(totalPointsDeductPriceTemp) + Number(pointsDeductPrice)
              totalPointsDeduct = Number(totalPointsDeduct) + Number(pointsDeduct)
            }
          }
        })
        that.setData({
          orderConfirmData: orderConfirmData,
          totalPrice: totalPrice,
          paymentPrice: totalPrice,
          totalPointsDeduct: totalPointsDeduct,
          totalPointsDeductPriceTemp: totalPointsDeductPriceTemp,
          spuIds: spuIds
        })
        that.couponUserPage()
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
  //获取积分设置
  pointsConfigGet() {
    app.api.pointsConfigGet()
      .then(res => {
        this.setData({
          pointsConfig: res.data
        })
      })
  },
  //获取商城用户信息
  userInfoGet() {
    app.api.userInfoGet()
      .then(res => {
        this.setData({
          userInfo: res.data
        })
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
  },
  pointsCheckedChange: function (e) {
    if (e.detail.value == 'true'){
      let orderConfirmData = this.data.orderConfirmData
      let that = this
      orderConfirmData.forEach(function (orderConfirm) {
        if (orderConfirm.pointsDeductSwitch == '1') {
          orderConfirm.paymentPrice = orderConfirm.paymentPrice2 - that.data.totalCouponDeductPrice
          orderConfirm.paymentPoints = orderConfirm.paymentPoints2
          orderConfirm.paymentPointsPrice = orderConfirm.paymentPointsPrice2
        }
      })
      this.setData({
        totalPointsDeductPrice: this.data.totalPointsDeductPriceTemp,
        paymentPrice: (Number(this.data.totalPrice) - Number(this.data.totalCouponDeductPrice) - Number(this.data.totalPointsDeductPriceTemp)).toFixed(2),
        orderConfirmData: orderConfirmData
      })
    }else{
      let orderConfirmData = this.data.orderConfirmData
      let that = this
      orderConfirmData.forEach(function (orderConfirm) {
        if (orderConfirm.pointsDeductSwitch == '1') {
          orderConfirm.paymentPrice = (orderConfirm.salesPrice * orderConfirm.quantity - that.data.totalCouponDeductPrice).toFixed(2)
          orderConfirm.paymentPoints = 0
          orderConfirm.paymentPointsPrice = 0
        }
      })
      this.setData({
        totalPointsDeductPrice: 0,
        paymentPrice: (Number(this.data.totalPrice) - Number(this.data.totalCouponDeductPrice)).toFixed(2),
        orderConfirmData: orderConfirmData
      })
    }
  },
  //查询可用电子券
  couponUserPage() {
    app.api.couponUserPage({
      searchCount: false,
      current: 1,
      size: 50,
      descs: 'create_time',
      spuIds: this.data.spuIds
    })
      .then(res => {
        let couponUserList = res.data.records
        this.setData({
          couponUserList: couponUserList
        })
      })
  },
  showModalCoupon(e) {
    this.setData({
      modalCoupon: 'show'
    })
  },
  hideModalCoupon() {
    this.setData({
      modalCoupon: ''
    })
  },
  couponUserChange(e){
    let couponUser = this.data.couponUserList[e.detail.value]
    let orderConfirmData = this.data.orderConfirmData
    //计算优惠金额
    if (couponUser.suitType == '1') {//1、全部商品适用，默认优惠第一个商品
      let orderConfirm = orderConfirmData[0]
      this.setPaymentCouponPrice(orderConfirm, couponUser)
      let temp = "orderConfirmData[0]"
      this.setData({
        [temp]: orderConfirm,
        totalCouponDeductPrice: orderConfirm.paymentCouponPrice
      })
    } else if (couponUser.suitType == '2') {//2、指定商品可用，默认优惠第一个指定商品
      try {
        orderConfirmData.forEach((orderConfirm, index) => {
          if (orderConfirm.spuId == couponUser.goodsSpu.id) {
            this.setPaymentCouponPrice(orderConfirm, couponUser)
            this.setData({
              totalCouponDeductPrice: orderConfirm.paymentCouponPrice
            })
            throw("")
          }
        })
      } catch (e) { }
      this.setData({
        orderConfirmData: orderConfirmData
      })
    }
    this.setData({
      couponUser: couponUser,
      paymentPrice: (Number(this.data.totalPrice) - Number(this.data.totalCouponDeductPrice) - Number(this.data.totalPointsDeductPrice)).toFixed(2)
    })
  },
  setPaymentCouponPrice(orderConfirm, couponUser){
    orderConfirm.couponUserId = couponUser.id
    let salesPrice = orderConfirm.salesPrice * orderConfirm.quantity
    if (couponUser.type == '1') {//代金券
      orderConfirm.paymentPrice = Number(salesPrice - couponUser.reduceAmount - this.data.totalPointsDeductPrice).toFixed(2)
      orderConfirm.paymentCouponPrice = couponUser.reduceAmount
    }
    if (couponUser.type == '2') {//折扣券
      let paymentCouponPrice = Number(salesPrice * (1 - couponUser.discount / 10)).toFixed(2)
      orderConfirm.paymentPrice = Number(salesPrice - paymentCouponPrice - this.data.totalPointsDeductPrice).toFixed(2)
      orderConfirm.paymentCouponPrice = paymentCouponPrice
    }
  }
})