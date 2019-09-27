/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
const WxParse = require('../../../public/wxParse/wxParse.js');
const app = getApp()

Page({
  data: {
    goodsDetail: [],
    goodsSpecData: [],
    goodsAppraises: [],
    currents: 1,
    modalSku: false,
    modalSkuType: '',
    shoppingCartCount: 0
  },
  onLoad(options) {
    let id = options.id
    this.setData({
      id: id
    })
    app.initPage()
      .then(res => {
        this.goodsGet(id)
        this.goodsSpecGet(id)
        this.shoppingCartCount()
        this.goodsAppraisesPage()
      })
  },
  onShareAppMessage: function () {
    let goodsDetail = this.data.goodsDetail
    let title = goodsDetail.name
    let imageUrl = goodsDetail.picUrls[0]
    let path = 'pages/goods/goods-detail/index?id=' + goodsDetail.id
    return {
      title: title,
      path: path,
      imageUrl: imageUrl,
      success: function (res) {
        if (res.errMsg == 'shareAppMessage:ok') {
          console.log(res.errMsg)
        }
      },
      fail: function (res) {
        // 转发失败
      }
    }
  },
  goodsGet(id) {
    app.api.goodsGet(id)
      .then(res => {
        let goodsDetail = res.data
        this.setData({
          goodsDetail: goodsDetail
        })
        //html转wxml
        WxParse.wxParse('description', 'html', goodsDetail.description, this, 0)
      })
  },
  goodsSpecGet(spuId){
    app.api.goodsSpecGet({
      spuId: spuId
    })
      .then(res => {
        let goodsSpecData = res.data
        this.setData({
          goodsSpecData: goodsSpecData
        })
      })
  },
  goodsAppraisesPage() {
    app.api.goodsAppraisesPage({
      current: 1,
      size: 3,
      descs: 'create_time',
      spuId: this.data.id
    })
      .then(res => {
        let goodsAppraises = res.data
        this.setData({
          goodsAppraises: goodsAppraises
        })
      })
  },
  change: function (e) {
    this.setData({
      currents: e.detail.current + 1
    })
  },
  showModalSku(e) {
    this.setData({
      modalSku: true,
      modalSkuType: e.target.dataset.type ? e.target.dataset.type : ''
    })
  },
  shoppingCartCount(){
    app.api.shoppingCartCount()
      .then(res => {
        let shoppingCartCount = res.data
        this.setData({
          shoppingCartCount: shoppingCartCount
        })
      })
  },
  operateCartEvent(){
    this.shoppingCartCount()
  },
  changeSpec(e) {
    this.setData({
      goodsSpecData: e.detail.goodsSpecData
    })
  },
  //收藏
  userCollect(){
    let goodsDetail = this.data.goodsDetail
    let collectId = goodsDetail.collectId
    if (collectId){
      app.api.userCollectDel(collectId)
        .then(res => {
          wx.showToast({
            title: '已取消收藏',
            icon: 'success',
            duration: 2000
          })
          goodsDetail.collectId = null
          this.setData({
            goodsDetail: goodsDetail
          })
        })
    }else{
      app.api.userCollectAdd({
        type: '1',
        relationIds: [goodsDetail.id]
      })
        .then(res => {
          wx.showToast({
            title: '收藏成功',
            icon: 'success',
            duration: 2000
          })
          goodsDetail.collectId = res.data[0].id
          this.setData({
            goodsDetail: goodsDetail
          })
        })
    }
  }
})
