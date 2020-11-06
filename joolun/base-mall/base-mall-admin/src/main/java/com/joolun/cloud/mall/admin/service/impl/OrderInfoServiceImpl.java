/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.aliyuncs.exceptions.ClientException;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.binarywang.wxpay.bean.request.WxPayOrderQueryRequest;
import com.github.binarywang.wxpay.bean.result.WxPayOrderQueryResult;
import com.github.binarywang.wxpay.constant.WxPayConstants;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.util.LocalDateTimeUtils;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.data.tenant.TenantContextHolder;
import com.joolun.cloud.common.sms.config.SmsTemplateProperties;
import com.joolun.cloud.common.sms.util.SmsUtils;
import com.joolun.cloud.mall.admin.config.MallConfigProperties;
import com.joolun.cloud.mall.admin.mapper.*;
import com.joolun.cloud.mall.admin.service.*;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.dto.PlaceOrderDTO;
import com.joolun.cloud.mall.common.dto.PlaceOrderSkuDTO;
import com.joolun.cloud.mall.common.entity.*;
import com.joolun.cloud.mall.common.enums.OrderInfoEnum;
import com.joolun.cloud.mall.common.enums.OrderItemEnum;
import com.joolun.cloud.mall.common.enums.OrderLogisticsEnum;
import com.joolun.cloud.mall.common.feign.FeignUpmsAdminService;
import com.joolun.cloud.mall.common.feign.FeignWxPayService;
import com.joolun.cloud.mall.common.feign.FeignWxTemplateMsgService;
import com.joolun.cloud.mall.common.util.Kuaidi100Utils;
import com.joolun.cloud.upms.common.feign.FeignUserService;
import com.joolun.cloud.weixin.common.constant.ConfigConstant;
import com.joolun.cloud.weixin.common.dto.WxTemplateMsgSendDTO;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

/**
 * 商城订单
 *
 * @author JL
 * @date 2019-09-10 15:21:22
 */
@Slf4j
@Service
@AllArgsConstructor
public class OrderInfoServiceImpl extends ServiceImpl<OrderInfoMapper, OrderInfo> implements OrderInfoService {

    private final GoodsSkuService goodsSkuService;
    private final GoodsSpuService goodsSpuService;
    private final OrderItemService orderItemService;
    private final GoodsSkuSpecValueMapper goodsSkuSpecValueMapper;
    private final ShoppingCartService shoppingCartService;
    private final OrderLogisticsService orderLogisticsService;
    private final UserAddressService userAddressService;
    private final RedisTemplate<String, String> redisTemplate;
    private final MallConfigProperties mallConfigProperties;
    private final OrderLogisticsDetailService orderLogisticsDetailService;
    private final PointsRecordService pointsRecordService;
    private final UserInfoService userInfoService;
    private final FeignWxPayService feignWxPayService;
    private final CouponUserService couponUserService;
    private final BargainUserMapper bargainUserMapper;
    private final GrouponInfoMapper grouponInfoMapper;
    private final GrouponUserMapper grouponUserMapper;
    private final FeignWxTemplateMsgService feignWxTemplateMsgService;
    private final GoodsCategoryService goodsCategoryService;
    private final UserInfoMapper userInfoMapper;
    private final UserMealMapper userMealMapper;
    private final SetMealMapper setMealMapper;
    private final InviteNewMapper inviteNewMapper;
    private final FeignUserService feignUserService;
    private final MerchantSettledService merchantSettledService;
    private final SmsTemplateProperties smsTemplateProperties;
    private final SmsUtils smsUtils;
	private final FeignUpmsAdminService feignUpmsAdminService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateById(OrderInfo entity) {
        if (StrUtil.isNotBlank(entity.getLogistics()) && StrUtil.isNotBlank(entity.getLogisticsNo())) {//发货。更新快递单号
            entity.setDeliveryTime(LocalDateTime.now());
            OrderLogistics orderLogistics = orderLogisticsService.getOne(Wrappers.<OrderLogistics>lambdaQuery()
                    .eq(OrderLogistics::getId, entity.getLogisticsId()));
            //第一次发货调起收到倒计时
            boolean sendRedis = false;
            if (StrUtil.isBlank(orderLogistics.getLogistics()) && StrUtil.isBlank(orderLogistics.getLogisticsNo())) {
                sendRedis = true;
            }
            orderLogistics.setLogistics(entity.getLogistics());
            orderLogistics.setLogisticsNo(entity.getLogisticsNo());
            orderLogistics.setStatus(OrderLogisticsEnum.STATUS_1.getValue());
            orderLogisticsService.updateById(orderLogistics);
            //订阅快递100
            String key = mallConfigProperties.getLogisticsKey();                    //企业授权key
            String company = entity.getLogistics();            //快递公司编码
            String number = entity.getLogisticsNo();    //快递单号
            String phone = orderLogistics.getTelNum();                    //手机号
            String callbackurl = StrUtil.format("{}{}{}", mallConfigProperties.getNotifyHost(),
                    "/mall/api/ma/orderinfo/notify-logisticsr?tenantId=" + orderLogistics.getTenantId() + "&logisticsId=", orderLogistics.getId());//回调地址
            String from = "";                    //出发地城市
            String to = "";                        //目的地城市
            String salt = "";                    //加密串
            int resultv2 = 1;                    //行政区域解析
            int autoCom = 0;                    //单号智能识别
            int interCom = 0;                    //开启国际版
            String departureCountry = "";        //出发国
            String departureCom = "";            //出发国快递公司编码
            String destinationCountry = "";        //目的国
            String destinationCom = "";            //目的国快递公司编码

            Kuaidi100Utils kuaidi100Utils = new Kuaidi100Utils(key);
            String result = kuaidi100Utils.subscribeData(company, number, from, to, callbackurl, salt, resultv2, autoCom, interCom, departureCountry, departureCom, destinationCountry, destinationCom, phone);
            JSONObject jSONObject = JSONUtil.parseObj(result);
            if (!(Boolean) jSONObject.get("result")) {
                log.error("快递订阅失败：returnCode：{}；message：{}", jSONObject.get("returnCode"), jSONObject.get("message"));
                throw new RuntimeException(String.valueOf(jSONObject.get("message")));
            }
            if (sendRedis) {
                //加入redis，7天后自动确认收货
                String keyRedis = String.valueOf(StrUtil.format("{}{}:{}", MallConstants.REDIS_ORDER_KEY_STATUS_2, TenantContextHolder.getTenantId(), entity.getId()));
                redisTemplate.opsForValue().set(keyRedis, entity.getOrderNo(), MallConstants.ORDER_TIME_OUT_2, TimeUnit.DAYS);//设置过期时间
            }
            //发送订阅消息
            try {
//                订单号 {{number2.DATA}}
//                物品名称 {{thing1.DATA}}
//                收货人 {{phrase16.DATA}}
//                快递公司 {{thing14.DATA}}
//                快递单号 {{character_string13.DATA}}
                OrderInfo orderInfo = baseMapper.selectById(entity.getId());
                WxTemplateMsgSendDTO wxTemplateMsgSendDTO = new WxTemplateMsgSendDTO();
                wxTemplateMsgSendDTO.setMallUserId(orderInfo.getUserId());
                wxTemplateMsgSendDTO.setUseType(ConfigConstant.WX_TMP_USE_TYPE_3);
                wxTemplateMsgSendDTO.setPage("pages/order/order-detail/index?id=" + orderInfo.getId());
                HashMap<String, HashMap<String, String>> data = new HashMap<>();
                data.put("number2", (HashMap) JSONUtil.toBean("{\"value\": \"" + orderInfo.getOrderNo() + "\"}", Map.class));
                String thing1 = orderInfo.getName();
                thing1 = thing1.length() > 20 ? thing1.substring(0, 19) : thing1;
                data.put("thing1", (HashMap) JSONUtil.toBean("{\"value\": \"" + thing1 + "\"}", Map.class));
                data.put("character_string13", (HashMap) JSONUtil.toBean("{\"value\": \"" + entity.getLogisticsNo() + "\"}", Map.class));
                data.put("phrase16", (HashMap) JSONUtil.toBean("{\"value\": \"" + orderLogistics.getUserName() + "\"}", Map.class));
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy年MM月dd日 HH:mm");
                data.put("thing14", (HashMap) JSONUtil.toBean("{\"value\": \"" + "快递公司" + "\"}", Map.class));
                wxTemplateMsgSendDTO.setData(data);
                feignWxTemplateMsgService.sendTemplateMsg(wxTemplateMsgSendDTO, SecurityConstants.FROM_IN);
            } catch (Exception e) {
                log.error("发送订阅消息发送出错：" + e.getMessage(), e);
            }
        }
        return super.updateById(entity);
    }

    @Override
    public IPage<OrderInfo> page1(IPage<OrderInfo> page, Wrapper<OrderInfo> queryWrapper) {
        return baseMapper.selectPage1(page, queryWrapper.getEntity());
    }

    @Override
    public IPage<OrderInfo> page2(IPage<OrderInfo> page, OrderInfo orderInfo) {
        return baseMapper.selectPage2(page, orderInfo);
    }

    @Override
    public OrderInfo getById2(Serializable id) {
        OrderInfo orderInfo = baseMapper.selectById2(id);
        if (orderInfo != null) {
            String keyRedis = null;
            //获取自动取消倒计时
            if (CommonConstants.NO.equals(orderInfo.getIsPay())) {
                keyRedis = String.valueOf(StrUtil.format("{}{}:{}", MallConstants.REDIS_ORDER_KEY_IS_PAY_0, TenantContextHolder.getTenantId(), orderInfo.getId()));
            }
            //获取自动收货倒计时
            if (OrderInfoEnum.STATUS_2.getValue().equals(orderInfo.getStatus())) {
                keyRedis = String.valueOf(StrUtil.format("{}{}:{}", MallConstants.REDIS_ORDER_KEY_STATUS_2, TenantContextHolder.getTenantId(), orderInfo.getId()));
            }
            if (keyRedis != null) {
                Long outTime = redisTemplate.getExpire(keyRedis);
                if (outTime != null && outTime > 0) {
                    orderInfo.setOutTime(outTime);
                }
            }
        }
        return orderInfo;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void orderCancel(OrderInfo orderInfo) {
        if (CommonConstants.NO.equals(orderInfo.getIsPay()) && !OrderInfoEnum.STATUS_5.getValue().equals(orderInfo.getStatus())) {//校验
            //实时查询订单是否已支付
            WxPayOrderQueryRequest request = new WxPayOrderQueryRequest();
            request.setAppid(orderInfo.getAppId());
            request.setTransactionId(orderInfo.getTransactionId());
            request.setOutTradeNo(orderInfo.getOrderNo());
            R<WxPayOrderQueryResult> r = feignWxPayService.queryOrder(request, SecurityConstants.FROM_IN);
            if (r.isOk()) {
                WxPayOrderQueryResult wxPayOrderQueryResult = r.getData();
                if (!WxPayConstants.WxpayTradeStatus.NOTPAY.equals(wxPayOrderQueryResult.getTradeState())) {//只有未支付的订单能取消
                    throw new RuntimeException("只有未支付的订单能取消");
                }
            }
            orderInfo.setStatus(OrderInfoEnum.STATUS_5.getValue());
            //回滚库存
            List<OrderItem> listOrderItem = orderItemService.list(Wrappers.<OrderItem>lambdaQuery()
                    .eq(OrderItem::getOrderId, orderInfo.getId()));
            listOrderItem.forEach(orderItem -> {
                GoodsSku goodsSku = goodsSkuService.getById(orderItem.getSkuId());
                if (goodsSku != null) {
                    goodsSku.setStock(goodsSku.getStock() + orderItem.getQuantity());
                    if (!goodsSkuService.updateById(goodsSku)) {//更新库存
                        throw new RuntimeException("请重新提交");
                    }
                }
                //回滚积分
                PointsRecord pointsRecord = new PointsRecord();
                pointsRecord.setRecordType(MallConstants.POINTS_RECORD_TYPE_4);
                pointsRecord.setOrderItemId(orderItem.getId());
                pointsRecord = pointsRecordService.getOne(Wrappers.query(pointsRecord));
                //查询该订单详情是否有抵扣积分
                if (pointsRecord != null && StrUtil.isNotBlank(pointsRecord.getId())) {
                    //减回赠送的积分
                    pointsRecord.setId(null);
                    pointsRecord.setTenantId(null);
                    pointsRecord.setCreateTime(null);
                    pointsRecord.setUpdateTime(null);
                    pointsRecord.setDescription("【订单取消】 " + pointsRecord.getDescription());
                    pointsRecord.setAmount(-pointsRecord.getAmount());
                    pointsRecord.setRecordType(MallConstants.POINTS_RECORD_TYPE_5);
                    //新增积分记录
                    pointsRecordService.save(pointsRecord);
                    //减去赠送积分
                    UserInfo userInfo = userInfoService.getById(orderInfo.getUserId());
                    userInfo.setPointsCurrent(userInfo.getPointsCurrent() + pointsRecord.getAmount());
                    userInfoService.updateById(userInfo);
                }
            });
            baseMapper.updateById(orderInfo);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void orderReceive(OrderInfo orderInfo) {
        orderInfo.setStatus(OrderInfoEnum.STATUS_3.getValue());
        orderInfo.setAppraisesStatus(MallConstants.APPRAISES_STATUS_0);
        orderInfo.setReceiverTime(LocalDateTime.now());
        List<OrderItem> listOrderItem = orderItemService.list(Wrappers.<OrderItem>lambdaQuery()
                .eq(OrderItem::getOrderId, orderInfo.getId()));
        Map<String, List<OrderItem>> resultList = listOrderItem.stream().collect(Collectors.groupingBy(OrderItem::getSpuId));
        AtomicReference<Integer> pointsGiveAmount = new AtomicReference<>(0);
        AtomicReference<Integer> orderPointsFirst = new AtomicReference<>(0);
        AtomicReference<Integer> orderPointsSecond = new AtomicReference<>(0);
        AtomicReference<Integer> orderPointsThird = new AtomicReference<>(0);
        List<PointsRecord> listPointsRecord = new ArrayList<>();
        List<UserInfo> listUserInfo = new ArrayList<>();
        List<GoodsSpu> listGoodsSpu = goodsSpuService.listByIds(resultList.keySet());
        UserInfo userInfo = userInfoService.getById(orderInfo.getUserId());

        UserMeal userMeal = userMealMapper.selectOne(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getUserId, userInfo.getId())
                .eq(UserMeal::getAccountStatus, CommonConstants.NO)
                .eq(UserMeal::getStatus, CommonConstants.YES)
                .eq(UserMeal::getIsPay, CommonConstants.YES));

        listGoodsSpu.forEach(goodsSpu -> {
            resultList.get(goodsSpu.getId()).forEach(orderItem -> {
                //更新销量
//                goodsSpu.setSaleNum(goodsSpu.getSaleNum() + orderItem.getQuantity());
                GoodsCategory goodsCategory = goodsCategoryService.getById(goodsSpu.getCategoryFirst());
                //跨界收益
                if (feignUserService.infoByOrganId(goodsSpu.getOrganId(), SecurityConstants.FROM_IN)) {
                    R<com.joolun.cloud.upms.common.dto.UserInfo> result = feignUserService.infoByUser(goodsSpu.getOrganId(), SecurityConstants.FROM_IN);
                    MerchantSettled merchantSettled = merchantSettledService.getOne(Wrappers.<MerchantSettled>lambdaQuery()
                            .eq(MerchantSettled::getPhone, result.getData().getSysUser().getPhone())
                            .eq(MerchantSettled::getStatus, MallConstants.MERCHANT_STATUS_2));
                    if (Optional.ofNullable(merchantSettled).isPresent()) {
                        UserInfo merchantUserInfo = userInfoService.getById(merchantSettled.getUserId());
                        UserMeal userMeal1 = userMealMapper.selectUserMealByInviteNew(merchantUserInfo.getId());

                        InviteNew inviteNew = inviteNewMapper.selectOne(Wrappers.<InviteNew>lambdaQuery()
                                .eq(InviteNew::getUserId, merchantUserInfo.getId())
                                .eq(InviteNew::getStatus, MallConstants.UNDER_WAY)
                        );
                        if (Optional.ofNullable(inviteNew.getUserIdFirst()).isPresent()) {
                            UserInfo inviteUserInfo = userInfoService.getById(inviteNew.getUserIdFirst());
                            UserMeal inviteUserMeal = userMealMapper.selectUserMealByInviteNew(inviteNew.getUserIdFirst());
                            if (!MallConstants.BASICS_MEAL.equals(inviteUserMeal.getSetMeal().getPrice().intValue())) {
                                int amount = orderItem.getSalesPrice().multiply(new BigDecimal(orderItem.getQuantity() * goodsCategory.getRebate() * inviteUserMeal.getSetMeal().getCrossBorderBenefits())).divide(new BigDecimal(10000)).multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();

                                PointsRecord pointsRecord = new PointsRecord();
                                pointsRecord.setUserId(inviteUserInfo.getId());
                                pointsRecord.setDescription("【跨界收益赠送】购买商品【" + goodsSpu.getName() + "】 * " + orderItem.getQuantity());
                                pointsRecord.setSpuId(goodsSpu.getId());
                                pointsRecord.setOrderItemId(orderItem.getId());
                                pointsRecord.setRecordType(MallConstants.POINTS_RECORD_TYPE_2);
                                pointsRecord.setAmount(amount);
                                listPointsRecord.add(pointsRecord);

                                inviteUserInfo.setPointsWithdraw(inviteUserInfo.getPointsWithdraw() + amount);
//                              userInfoService.updateById(merchantUserInfo);
                                listUserInfo.add(inviteUserInfo);

                            }

                        }
                    }
                }

                //处理积分赠送
                if (CommonConstants.YES.equals(goodsSpu.getPointsGiveSwitch())) {
                    PointsRecord pointsRecord = new PointsRecord();
                    pointsRecord.setUserId(orderInfo.getUserId());
                    pointsRecord.setDescription("【赠送】购买商品【" + goodsSpu.getName() + "】 * " + orderItem.getQuantity());
                    pointsRecord.setSpuId(goodsSpu.getId());
                    pointsRecord.setOrderItemId(orderItem.getId());
                    pointsRecord.setRecordType(MallConstants.POINTS_RECORD_TYPE_2);

                    //自然人
                    if (userMeal == null) {
//							pointsRecord.setAmount(orderItem.getQuantity() * goodsSpu.getPointsGiveNum());
                        int amount = orderItem.getSalesPrice().multiply(new BigDecimal(orderItem.getQuantity() * goodsCategory.getRebate() * MallConstants.CONSUME_PROFIT)).divide(new BigDecimal(10000)).multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                        pointsRecord.setAmount(amount);
                        listPointsRecord.add(pointsRecord);
                        pointsGiveAmount.updateAndGet(v -> v + amount);
                        //更新用户积分
                        userInfo.setPointsCurrent(userInfo.getPointsCurrent() + pointsGiveAmount.get());

                        if (StringUtils.isNotEmpty(orderInfo.getInviteUserId())) {
//                          到时候可以根据时间点赠送积分
                            UserInfo userInfoThird = new UserInfo();
                            userInfoThird.setId(orderInfo.getInviteUserId());
                            userInfoThird = userInfoMapper.selectUserInfoByInviteNew(userInfoThird);
                            PointsRecord pointsRecord3 = new PointsRecord();
                            pointsRecord3.setUserId(orderInfo.getInviteUserId());
                            pointsRecord3.setDescription("【赠送】购买商品【" + goodsSpu.getName() + "】 * " + orderItem.getQuantity());
                            pointsRecord3.setSpuId(goodsSpu.getId());
                            pointsRecord3.setOrderItemId(orderItem.getId());
                            pointsRecord3.setRecordType(MallConstants.POINTS_RECORD_TYPE_2);
                            int amountThird = orderItem.getSalesPrice().multiply(new BigDecimal(orderItem.getQuantity() * goodsCategory.getRebate() * userInfoThird.getUserMeal().getSetMeal().getOrderRebateSecond())).divide(new BigDecimal(10000)).multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                            pointsRecord3.setAmount(amountThird);
                            listPointsRecord.add(pointsRecord3);
                            orderPointsThird.updateAndGet(v -> v + amountThird);
                            userInfoThird.setPointsWithdraw(userInfoThird.getPointsWithdraw() + orderPointsThird.get());
//                            userInfoService.updateById(userInfoThird);
                            listUserInfo.add(userInfoThird);
                        }
                    } else {
                        SetMeal setMeal = setMealMapper.selectOne(Wrappers.<SetMeal>lambdaQuery().eq(SetMeal::getId, userMeal.getSetMealId()));
                        InviteNew inviteNew = inviteNewMapper.selectOne(Wrappers.<InviteNew>lambdaQuery()
                                .eq(InviteNew::getUserId, userInfo.getId())
                                .eq(InviteNew::getStatus, CommonConstants.YES));
                        int amount = orderItem.getSalesPrice().multiply(new BigDecimal(orderItem.getQuantity() * goodsCategory.getRebate() * setMeal.getOrderRebateFirst())).divide(new BigDecimal(10000)).multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                        pointsRecord.setAmount(amount);
                        listPointsRecord.add(pointsRecord);
                        pointsGiveAmount.updateAndGet(v -> v + amount);
                        //更新用户积分
                        userInfo.setPointsWithdraw(userInfo.getPointsWithdraw() + pointsGiveAmount.get());

                        if (!MallConstants.CITY_PARTNER.equals(setMeal.getPrice().intValue())) {
                            UserInfo userInfoFirst = StringUtils.isEmpty(inviteNew.getUserIdFirst()) ? null : userInfoMapper.getUserMeal(inviteNew.getUserIdFirst());
                            UserInfo userInfoSecond = StringUtils.isEmpty(inviteNew.getUserIdSecond()) ? null : userInfoMapper.getUserMeal(inviteNew.getUserIdSecond());

                            if (userInfoFirst != null) {
                                PointsRecord pointsRecord1 = new PointsRecord();
                                pointsRecord1.setUserId(userInfoFirst.getId());
                                pointsRecord1.setDescription("【赠送】购买商品【" + goodsSpu.getName() + "】 * " + orderItem.getQuantity());
                                pointsRecord1.setSpuId(goodsSpu.getId());
                                pointsRecord1.setOrderItemId(orderItem.getId());
                                pointsRecord1.setRecordType(MallConstants.POINTS_RECORD_TYPE_2);
                                int amountFirst = orderItem.getSalesPrice().multiply(new BigDecimal(orderItem.getQuantity() * goodsCategory.getRebate() * userInfoFirst.getUserMeal().getSetMeal().getOrderRebateFirst())).divide(new BigDecimal(10000)).multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                                pointsRecord1.setAmount(amountFirst);
                                listPointsRecord.add(pointsRecord1);
                                orderPointsFirst.updateAndGet(v -> v + amountFirst);
                                userInfoFirst.setPointsWithdraw(userInfoFirst.getPointsWithdraw() + orderPointsFirst.get());
//                                userInfoService.updateById(userInfoFirst);
                                listUserInfo.add(userInfoFirst);
                            }
                            if (userInfoSecond != null) {
                                PointsRecord pointsRecord2 = new PointsRecord();
                                pointsRecord2.setUserId(userInfoSecond.getId());
                                pointsRecord2.setDescription("【赠送】购买商品【" + goodsSpu.getName() + "】 * " + orderItem.getQuantity());
                                pointsRecord2.setSpuId(goodsSpu.getId());
                                pointsRecord2.setOrderItemId(orderItem.getId());
                                pointsRecord2.setRecordType(MallConstants.POINTS_RECORD_TYPE_2);
                                int amountSecond = orderItem.getSalesPrice().multiply(new BigDecimal(orderItem.getQuantity() * goodsCategory.getRebate() * userInfoSecond.getUserMeal().getSetMeal().getOrderRebateSecond())).divide(new BigDecimal(10000)).multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                                pointsRecord2.setAmount(amountSecond);
                                listPointsRecord.add(pointsRecord2);
                                orderPointsSecond.updateAndGet(v -> v + amountSecond);
                                userInfoSecond.setPointsWithdraw(userInfoSecond.getPointsWithdraw() + orderPointsSecond.get());
//                                userInfoService.updateById(userInfoSecond);
                                listUserInfo.add(userInfoSecond);
                            }
                        }
                    }
                }
            });
//            goodsSpuService.updateById(goodsSpu);
        });
        //新增积分记录
        pointsRecordService.saveBatch(listPointsRecord);
        //更新用户积分
//        userInfo.setPointsWithdraw(userInfo.getPointsWithdraw() + pointsGiveAmount.get());
//        userInfoService.updateById(userInfo);
        listUserInfo.add(userInfo);
        userInfoService.updateBatchById(listUserInfo);
        baseMapper.updateById(orderInfo);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeById(Serializable id) {
        orderItemService.remove(Wrappers.<OrderItem>lambdaQuery()
                .eq(OrderItem::getOrderId, id));//删除订单详情
        return super.removeById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public OrderInfo orderSub(PlaceOrderDTO placeOrderDTO) {
        OrderInfo orderInfo = new OrderInfo();
        BeanUtil.copyProperties(placeOrderDTO, orderInfo);
        orderInfo.setIsPay(CommonConstants.NO);
        orderInfo.setOrderNo(IdUtil.getSnowflake(0, 0).nextIdStr());
        orderInfo.setSalesPrice(BigDecimal.ZERO);
        orderInfo.setPaymentPrice(BigDecimal.ZERO);
        orderInfo.setFreightPrice(BigDecimal.ZERO);
        orderInfo.setPaymentPoints(0);
        orderInfo.setPaymentCouponPrice(BigDecimal.ZERO);
        orderInfo.setPaymentPointsPrice(BigDecimal.ZERO);
        orderInfo.setCreateTime(LocalDateTime.now());

        UserMeal userMeal = userMealMapper.selectUserMealByInviteNew(orderInfo.getUserId());
        if (userMeal != null) {
            orderInfo.setInviteUserId(placeOrderDTO.getInviteUserId());
        }
        List<OrderItem> listOrderItem = new ArrayList<>();
        List<GoodsSku> listGoodsSku = new ArrayList<>();
        List<CouponUser> listCouponUser = new ArrayList<>();
        List<PointsRecord> listPointsRecord = new ArrayList<>();
        placeOrderDTO.getSkus().forEach(placeOrderSkuDTO -> {//过滤
            GoodsSku goodsSku = goodsSkuService.getOne(Wrappers.<GoodsSku>lambdaQuery()
                    .eq(GoodsSku::getSpuId, placeOrderSkuDTO.getSpuId())
                    .eq(GoodsSku::getId, placeOrderSkuDTO.getSkuId())
                    .ge(GoodsSku::getStock, placeOrderSkuDTO.getQuantity())
                    .eq(GoodsSku::getEnable, CommonConstants.YES));
            if (goodsSku != null) {
                GoodsSpu goodsSpu = goodsSpuService.getOne(Wrappers.<GoodsSpu>lambdaQuery()
                        .eq(GoodsSpu::getId, goodsSku.getSpuId())
                        .eq(GoodsSpu::getShelf, CommonConstants.YES));
                if (goodsSpu != null) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setOrderId(orderInfo.getId());
                    orderItem.setStatus(OrderItemEnum.STATUS_0.getValue());
                    orderItem.setIsRefund(CommonConstants.NO);
                    orderItem.setSpuId(goodsSpu.getId());
                    orderItem.setSkuId(goodsSku.getId());
                    orderItem.setSpuName(goodsSpu.getName());
                    orderItem.setPicUrl(StrUtil.isNotBlank(goodsSku.getPicUrl()) ? goodsSku.getPicUrl() : goodsSpu.getPicUrls()[0]);
                    orderItem.setQuantity(placeOrderSkuDTO.getQuantity());
                    orderItem.setSalesPrice(goodsSku.getSalesPrice());
                    orderItem.setOrganId(goodsSpu.getOrganId());
                    if (MallConstants.DELIVERY_WAY_1.equals(orderInfo.getDeliveryWay())) {//快递配送要算运费
                        orderItem.setFreightPrice(placeOrderSkuDTO.getFreightPrice());
                    } else {//自提配送不算运费
                        orderItem.setFreightPrice(BigDecimal.ZERO);
                    }
                    orderItem.setPaymentPrice(placeOrderSkuDTO.getPaymentPrice().add(orderItem.getFreightPrice()));
                    orderItem.setPaymentPoints(placeOrderSkuDTO.getPaymentPoints());
                    orderItem.setPaymentCouponPrice(placeOrderSkuDTO.getPaymentCouponPrice());
                    orderItem.setPaymentPointsPrice(placeOrderSkuDTO.getPaymentPointsPrice());
                    orderItem.setCouponUserId(placeOrderSkuDTO.getCouponUserId());
                    BigDecimal quantity = new BigDecimal(placeOrderSkuDTO.getQuantity());
                    if (StrUtil.isNotBlank(orderItem.getCouponUserId())) {
                        //校验电子券
                        CouponUser couponUser = couponUserService.getById(orderItem.getCouponUserId());
                        if (couponUser == null) {
                            throw new RuntimeException("非法优惠券");
                        }
                        if (!MallConstants.COUPON_USER_STATUS_0.equals(couponUser.getStatus())) {
                            throw new RuntimeException("优惠券已经使用");
                        }
                        if (couponUser.getValidBeginTime().isAfter(LocalDateTime.now())) {
                            throw new RuntimeException("优惠券未在使用期");
                        }
                        if (couponUser.getValidEndTime().isBefore(LocalDateTime.now())) {
                            throw new RuntimeException("优惠券已过期");
                        }
                        couponUser.setStatus(MallConstants.COUPON_USER_STATUS_1);
                        couponUser.setUsedTime(LocalDateTime.now());
                        listCouponUser.add(couponUser);
                    }
                    List<GoodsSkuSpecValue> listGoodsSkuSpecValue = goodsSkuSpecValueMapper.listGoodsSkuSpecValueBySkuId(goodsSku.getId());
                    listGoodsSkuSpecValue.forEach(goodsSkuSpecValue -> {
                        String specInfo = orderItem.getSpecInfo();
                        specInfo = StrUtil.isNotBlank(specInfo) ? specInfo : "";
                        orderItem.setSpecInfo(specInfo
                                + goodsSkuSpecValue.getSpecValueName()
                                + "，");
                    });
                    String specInfo = orderItem.getSpecInfo();
                    if (StrUtil.isNotBlank(specInfo)) {
                        orderItem.setSpecInfo(specInfo.substring(0, specInfo.length() - 1));
                    }
                    listOrderItem.add(orderItem);
                    orderInfo.setSalesPrice(orderInfo.getSalesPrice().add(goodsSku.getSalesPrice().multiply(quantity)));
                    orderInfo.setFreightPrice(orderInfo.getFreightPrice().add(orderItem.getFreightPrice()));
                    orderInfo.setPaymentPrice(orderInfo.getPaymentPrice().add(orderItem.getPaymentPrice()));
                    orderInfo.setPaymentPoints(orderInfo.getPaymentPoints() + (orderItem.getPaymentPoints() != null ? orderItem.getPaymentPoints() : 0));
                    orderInfo.setPaymentCouponPrice(orderInfo.getPaymentCouponPrice().add((orderItem.getPaymentCouponPrice() != null ? orderItem.getPaymentCouponPrice() : BigDecimal.ZERO)));
                    orderInfo.setPaymentPointsPrice(orderInfo.getPaymentPointsPrice().add((orderItem.getPaymentPointsPrice() != null ? orderItem.getPaymentPointsPrice() : BigDecimal.ZERO)));
                    goodsSku.setStock(goodsSku.getStock() - orderItem.getQuantity());
                    listGoodsSku.add(goodsSku);
                    //删除购物车
                    shoppingCartService.remove(Wrappers.<ShoppingCart>lambdaQuery()
                            .eq(ShoppingCart::getSpuId, goodsSpu.getId())
                            .eq(ShoppingCart::getSkuId, goodsSku.getId())
                            .eq(ShoppingCart::getUserId, placeOrderDTO.getUserId()));
                }
            }
        });
        if (listOrderItem.size() > 0 && listGoodsSku.size() > 0) {
            if (MallConstants.DELIVERY_WAY_1.equals(orderInfo.getDeliveryWay())) {//配送方式1、普通快递的订单要新增订单物流
                UserAddress userAddress = userAddressService.getById(placeOrderDTO.getUserAddressId());
                OrderLogistics orderLogistics = new OrderLogistics();
                orderLogistics.setPostalCode(userAddress.getPostalCode());
                orderLogistics.setUserName(userAddress.getUserName());
                orderLogistics.setTelNum(userAddress.getTelNum());
                orderLogistics.setAddress(userAddress.getProvinceName() + userAddress.getCityName() + userAddress.getCountyName() + userAddress.getDetailInfo());
                //新增订单物流
                orderLogisticsService.save(orderLogistics);
                orderInfo.setLogisticsId(orderLogistics.getId());
            }
            orderInfo.setName(listOrderItem.get(0).getSpuName());
            orderInfo.setOrganId(listOrderItem.get(0).getOrganId());
            super.save(orderInfo);//保存订单
			//当商品库存数量低于5时对店家下发短信提醒
			lowStockNotice(placeOrderDTO.getSkus());
            listOrderItem.forEach(orderItem -> orderItem.setOrderId(orderInfo.getId()));
            //保存订单详情
            orderItemService.saveBatch(listOrderItem);
            //修改用户电子券状态
            if (listCouponUser != null && listCouponUser.size() > 0) {
                couponUserService.updateBatchById(listCouponUser);
            }
            listOrderItem.forEach(orderItem -> {
                if (orderItem.getPaymentPoints() != null && orderItem.getPaymentPoints() > 0) {
                    //处理积分抵扣
                    PointsRecord pointsRecord = new PointsRecord();
                    pointsRecord.setUserId(orderInfo.getUserId());
                    pointsRecord.setDescription("【抵扣】购买商品【" + orderItem.getSpuName() + "】 * " + orderItem.getQuantity());
                    pointsRecord.setSpuId(orderItem.getSpuId());
                    pointsRecord.setOrderItemId(orderItem.getId());
                    pointsRecord.setRecordType(MallConstants.POINTS_RECORD_TYPE_4);
                    pointsRecord.setAmount(-orderItem.getPaymentPoints());
                    listPointsRecord.add(pointsRecord);
                }
            });
            if (!goodsSkuService.updateBatchById(listGoodsSku)) {//更新库存
                throw new RuntimeException("请重新提交");
            }
            if (orderInfo.getPaymentPoints() > 0) {
                //新增积分记录
                pointsRecordService.saveBatch(listPointsRecord);
                //更新用户积分
                UserInfo userInfo = userInfoService.getById(orderInfo.getUserId());
                if (userInfo.getPointsCurrent() + userInfo.getPointsWithdraw() < orderInfo.getPaymentPoints()) {
                    throw new RuntimeException("积分不足");
                } else {
                    if (userInfo.getPointsCurrent() < orderInfo.getPaymentPoints()) {
                        orderInfo.setPointsWithdrawal(userInfo.getPointsCurrent() - orderInfo.getPaymentPoints());
                        userInfo.setPointsWithdraw(userInfo.getPointsCurrent() + userInfo.getPointsWithdraw() - orderInfo.getPaymentPoints());
                        userInfo.setPointsCurrent(0);
                    } else {
                        userInfo.setPointsCurrent(userInfo.getPointsCurrent() - orderInfo.getPaymentPoints());
                    }
                }
                userInfoService.updateById(userInfo);
            }
            //加入redis，30分钟自动取消
            String keyRedis = String.valueOf(StrUtil.format("{}{}:{}", MallConstants.REDIS_ORDER_KEY_IS_PAY_0, TenantContextHolder.getTenantId(), orderInfo.getId()));
            redisTemplate.opsForValue().set(keyRedis, orderInfo.getOrderNo(), MallConstants.ORDER_TIME_OUT_0, TimeUnit.MINUTES);//设置过期时间
        } else {
            return null;
        }
        return orderInfo;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void notifyOrder(OrderInfo orderInfo) {
        if (CommonConstants.NO.equals(orderInfo.getIsPay())) {//只有未支付订单能操作
            orderInfo.setIsPay(CommonConstants.YES);
            orderInfo.setStatus(OrderInfoEnum.STATUS_1.getValue());
            List<OrderItem> listOrderItem = orderItemService.list(Wrappers.<OrderItem>lambdaQuery()
                    .eq(OrderItem::getOrderId, orderInfo.getId()));
            Map<String, List<OrderItem>> resultList = listOrderItem.stream().collect(Collectors.groupingBy(OrderItem::getSpuId));
            List<GoodsSpu> listGoodsSpu = goodsSpuService.listByIds(resultList.keySet());
            UserInfo userInfo = userInfoService.getById(orderInfo.getUserId());
            listGoodsSpu.forEach(goodsSpu -> {
                resultList.get(goodsSpu.getId()).forEach(orderItem -> {
                    //更新销量
                    goodsSpu.setSaleNum(goodsSpu.getSaleNum() + orderItem.getQuantity());
                    //处理积分赠送
                });
                goodsSpuService.updateById(goodsSpu);
            });
//            //新增积分记录
//            pointsRecordService.saveBatch(listPointsRecord);
//            //更新用户积分
//            userInfo.setPointsCurrent(userInfo.getPointsCurrent() + pointsGiveAmount.get());
//            userInfoService.updateById(userInfo);
            //处理砍价订单，更新砍价记录
            if (MallConstants.ORDER_TYPE_1.equals(orderInfo.getOrderType())) {
                BargainUser bargainUser = bargainUserMapper.selectById(orderInfo.getRelationId());
                bargainUser.setIsBuy(CommonConstants.YES);
                bargainUser.setOrderId(orderInfo.getId());
                bargainUserMapper.updateById(bargainUser);
            }
            //处理拼团订单
            if (MallConstants.ORDER_TYPE_2.equals(orderInfo.getOrderType())) {
                GrouponInfo grouponInfo = grouponInfoMapper.selectById(orderInfo.getMarketId());
                //新增拼团记录
                GrouponUser grouponUser = new GrouponUser();
                grouponUser.setGrouponId(grouponInfo.getId());
                grouponUser.setGroupId(orderInfo.getMarketId());
                grouponUser.setUserId(orderInfo.getUserId());
                grouponUser.setNickName(userInfo.getNickName());
                grouponUser.setHeadimgUrl(userInfo.getHeadimgUrl());
                grouponUser.setSpuId(grouponInfo.getSpuId());
                grouponUser.setSkuId(grouponInfo.getSkuId());
                grouponUser.setGrouponNum(grouponInfo.getGrouponNum());
                grouponUser.setGrouponPrice(grouponInfo.getGrouponPrice());
                grouponUser.setStatus(MallConstants.GROUPON_USER_STATUS_0);
                grouponUserMapper.insert(grouponUser);
                if (StrUtil.isBlank(orderInfo.getRelationId())) {//新团，当前用户为团长
                    grouponUser.setValidBeginTime(orderInfo.getPaymentTime());
                    grouponUser.setValidEndTime(orderInfo.getPaymentTime().plusHours(grouponInfo.getDuration()));
                    grouponUser.setIsLeader(CommonConstants.YES);
                    grouponUser.setGroupId(grouponUser.getId());
                    orderInfo.setRelationId(grouponUser.getId());
                    orderInfo.setStatus(OrderInfoEnum.STATUS_10.getValue());
                } else {
                    grouponUser.setGroupId(orderInfo.getRelationId());
                    grouponUser.setIsLeader(CommonConstants.NO);
                    //查出团长拼团记录
                    GrouponUser grouponUser2 = grouponUserMapper.selectById(orderInfo.getRelationId());
                    grouponUser.setValidBeginTime(grouponUser2.getValidBeginTime());
                    grouponUser.setValidEndTime(grouponUser2.getValidEndTime());
                    Integer count = grouponUserMapper.selectCountGrouponing(orderInfo.getRelationId()) + 1;
                    if (count == grouponUser2.getGrouponNum()) {//已满成团
                        GrouponUser grouponUser3 = new GrouponUser();
                        grouponUser.setStatus(MallConstants.GROUPON_USER_STATUS_1);
                        grouponUser3.setStatus(MallConstants.GROUPON_USER_STATUS_1);
                        grouponUserMapper.update(grouponUser3, Wrappers.<GrouponUser>lambdaQuery()
                                .eq(GrouponUser::getGroupId, grouponUser2.getId()));
                        //更新团里所有订单状态
                        OrderInfo orderInfo1 = new OrderInfo();
                        orderInfo1.setStatus(OrderInfoEnum.STATUS_1.getValue());
                        baseMapper.update(orderInfo1, Wrappers.<OrderInfo>lambdaQuery()
                                .eq(OrderInfo::getRelationId, grouponUser2.getId())
                                .eq(OrderInfo::getStatus, OrderInfoEnum.STATUS_10.getValue()));
                    } else if (count > grouponUser2.getGrouponNum()) {//满团开新团
                        grouponUser.setValidBeginTime(orderInfo.getPaymentTime());
                        grouponUser.setValidEndTime(orderInfo.getPaymentTime().plusHours(grouponInfo.getDuration()));
                        grouponUser.setIsLeader(CommonConstants.YES);
                        grouponUser.setGroupId(grouponUser.getId());
                        orderInfo.setRelationId(grouponUser.getId());
                        orderInfo.setStatus(OrderInfoEnum.STATUS_10.getValue());
                    } else {//未满入团
                        orderInfo.setStatus(OrderInfoEnum.STATUS_10.getValue());
                    }
                }
                grouponUser.setOrderId(orderInfo.getId());
                grouponUserMapper.updateById(grouponUser);
                grouponInfo.setLaunchNum(grouponInfo.getLaunchNum() + 1);//参与人数+1
                grouponInfoMapper.updateById(grouponInfo);
            }

            //发货地+商户organId
            Map<String, List<GoodsSpu>> resultGoodsSpu = listGoodsSpu.stream().collect(Collectors.groupingBy(goodsSpu -> goodsSpu.getDeliveryPlaceId() + "#" + goodsSpu.getOrganId()));
            List<OrderInfo> orderInfoList = new ArrayList<>();
            if (resultGoodsSpu.size() <= 1) {//只有一个发货地址
                if (MallConstants.DELIVERY_WAY_2.equals(orderInfo.getDeliveryWay())) {//配送方式2、上门自提，设置自提地址
                    orderInfo.setLogisticsId(listGoodsSpu.get(0).getDeliveryPlaceId());
                }
                baseMapper.updateById(orderInfo);//更新订单
                orderInfoList.add(baseMapper.selectById(orderInfo.getId()));
            } else {//处理订单是否需要拆分（通过不同发货地进行订单拆分）,有多个发货地，要拆分订单
                OrderLogistics orderLogistics = orderLogisticsService.getById(orderInfo.getLogisticsId());
                resultGoodsSpu.forEach((key, value) -> {
                    orderLogistics.setId(null);
                    orderLogistics.setTenantId(null);
                    orderLogisticsService.save(orderLogistics);
                    List<OrderItem> listOrderItem1 = new ArrayList<>();
                    value.forEach(item -> {
                        listOrderItem1.addAll(resultList.get(item.getId()));
                    });
                    OrderInfo orderInfo1 = new OrderInfo();
                    BeanUtil.copyProperties(orderInfo, orderInfo1);
                    orderInfo1.setOrderNo(IdUtil.getSnowflake(0, 0).nextIdStr());
                    orderInfo1.setTenantId(null);
                    orderInfo1.setId(null);
                    orderInfo1.setSalesPrice(BigDecimal.ZERO);
                    orderInfo1.setPaymentPrice(BigDecimal.ZERO);
                    orderInfo1.setFreightPrice(BigDecimal.ZERO);
                    orderInfo1.setPaymentPoints(0);
                    orderInfo1.setPaymentCouponPrice(BigDecimal.ZERO);
                    orderInfo1.setPaymentPointsPrice(BigDecimal.ZERO);
                    orderInfo1.setLogisticsId(orderLogistics.getId());
                    listOrderItem1.forEach(item -> {
                        GoodsSku goodsSku = goodsSkuService.getById(item.getSkuId());
                        orderInfo1.setSalesPrice(orderInfo1.getSalesPrice().add(goodsSku.getSalesPrice().multiply(new BigDecimal(item.getQuantity()))));
                        orderInfo1.setFreightPrice(orderInfo1.getFreightPrice().add(item.getFreightPrice()));
                        orderInfo1.setPaymentPrice(orderInfo1.getPaymentPrice().add(item.getPaymentPrice()));
                        orderInfo1.setPaymentPoints(orderInfo1.getPaymentPoints() + (item.getPaymentPoints() != null ? item.getPaymentPoints() : 0));
                        orderInfo1.setPaymentCouponPrice(orderInfo1.getPaymentCouponPrice().add((item.getPaymentCouponPrice() != null ? item.getPaymentCouponPrice() : BigDecimal.ZERO)));
                        orderInfo1.setPaymentPointsPrice(orderInfo1.getPaymentPointsPrice().add((item.getPaymentPointsPrice() != null ? item.getPaymentPointsPrice() : BigDecimal.ZERO)));
                    });
                    if (MallConstants.DELIVERY_WAY_2.equals(orderInfo1.getDeliveryWay())) {//配送方式2、上门自提，设置自提地址
                        orderInfo1.setLogisticsId(key);
                    }
                    //新建订单
                    baseMapper.insert(orderInfo1);
                    //更新订单详情
                    listOrderItem1.forEach(item -> item.setOrderId(orderInfo1.getId()));
                    orderItemService.updateBatchById(listOrderItem1);

                    orderInfoList.add(orderInfo1);
                });
                //删除旧订单、旧订单物流
                baseMapper.deleteById(orderInfo.getId());
                orderLogisticsService.removeById(orderInfo.getLogisticsId());
            }
            orderInfoList.stream().forEach(info -> {
                try {

                    if (feignUserService.isRoleAdmin(info.getOrganId(), SecurityConstants.FROM_IN)) {
                        smsUtils.sendSms(smsTemplateProperties.getSignName4(), "18838966603", smsTemplateProperties.getTemplateCode4(), "{\"code\":\"" + info.getOrderNo() + "\"}");
                    }

                    if (feignUserService.infoByOrganId(info.getOrganId(), SecurityConstants.FROM_IN)) {
                        R<com.joolun.cloud.upms.common.dto.UserInfo> result = feignUserService.infoByUser(info.getOrganId(), SecurityConstants.FROM_IN);
                        MerchantSettled merchantSettled = merchantSettledService.getOne(Wrappers.<MerchantSettled>lambdaQuery()
                                .eq(MerchantSettled::getPhone, result.getData().getSysUser().getPhone())
                                .eq(MerchantSettled::getStatus, MallConstants.MERCHANT_STATUS_2));
                        if (Optional.ofNullable(merchantSettled).isPresent()) {
                            UserInfo merchantUserInfo = userInfoService.getById(merchantSettled.getUserId());
                            smsUtils.sendSms(smsTemplateProperties.getSignName4(), merchantUserInfo.getPhone(), smsTemplateProperties.getTemplateCode4(), "{\"code\":\"" + info.getOrderNo() + "\"}");
                        }
                    }

                } catch (Exception e) {
                    log.error("短信发送失败:" + e.getMessage(), e);
                }
            });
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void notifyLogisticsr(String logisticsId, JSONObject jsonObject) {
        OrderLogistics orderLogistics = orderLogisticsService.getById(logisticsId);
        if (orderLogistics != null) {
            String status = jsonObject.getStr("status");
            if ("abort".equals(status)) {//中止
                orderLogistics.setStatus(OrderLogisticsEnum.STATUS_ER.getValue());
                orderLogistics.setMessage(jsonObject.getStr("message"));
            } else {
                orderLogisticsDetailService.remove(Wrappers.<OrderLogisticsDetail>lambdaQuery()
                        .eq(OrderLogisticsDetail::getLogisticsId, logisticsId));//先删除
                JSONObject jsonResult = (JSONObject) jsonObject.get("lastResult");
                orderLogistics.setStatus(jsonResult.getStr("state"));
                orderLogistics.setIsCheck(jsonResult.getStr("ischeck"));
                JSONArray jSONArray = jsonResult.getJSONArray("data");
                List<OrderLogisticsDetail> listOrderLogisticsDetail = new ArrayList<>();
                jSONArray.forEach(object -> {
                    JSONObject jsonData = JSONUtil.parseObj(object);
                    OrderLogisticsDetail orderLogisticsDetail = new OrderLogisticsDetail();
                    orderLogisticsDetail.setLogisticsId(logisticsId);
                    orderLogisticsDetail.setLogisticsTime(LocalDateTimeUtils.parse(jsonData.getStr("time")));
                    orderLogisticsDetail.setLogisticsInformation(jsonData.getStr("context"));
                    listOrderLogisticsDetail.add(orderLogisticsDetail);
                });
                orderLogisticsDetailService.saveBatch(listOrderLogisticsDetail);
                //获取最近一条物流信息
                Optional<OrderLogisticsDetail> orderLogisticsDetail = listOrderLogisticsDetail.stream().collect(Collectors.maxBy(Comparator.comparing(OrderLogisticsDetail::getLogisticsTime)));
                orderLogistics.setMessage(orderLogisticsDetail.get().getLogisticsInformation());
            }
            orderLogisticsService.updateById(orderLogistics);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void editPrice(OrderItem orderItem) {
        BigDecimal editPrice = orderItem.getPaymentPrice();
        orderItem = orderItemService.getById(orderItem.getId());
        BigDecimal oldPrice = orderItem.getPaymentPrice();
        orderItem.setPaymentPrice(editPrice);
        OrderInfo orderInfo = baseMapper.selectById(orderItem.getOrderId());
        orderInfo.setPaymentPrice(orderInfo.getPaymentPrice().add(editPrice.subtract(oldPrice)));
        orderItemService.updateById(orderItem);
        orderInfo.setOrderNo(IdUtil.getSnowflake(0, 0).nextIdStr());
        baseMapper.updateById(orderInfo);
    }

    @Override
    public List<OrderInfo> selectByForge(String i) {
        return baseMapper.selectByForge(i);
    }

    @Override
    public List<OrderInfo> page1(Wrapper<OrderInfo> queryWrapper) {
        return baseMapper.selectPage1(queryWrapper.getEntity());
    }

	@Override
	public void lowStockNotice(List<PlaceOrderSkuDTO> skus) {
		List<String> skuIdList = skus.stream().map(x->x.getSkuId()).collect(Collectors.toList());
		for (String skuId : skuIdList) {
			//库存小于5给商家发短信通知
			GoodsSku goodsSku = goodsSkuService.getById(skuId);
			if (goodsSku.getStock() < 5) {
				String organId = goodsSpuService.getById(goodsSkuService.getById(skuId).getSpuId()).getOrganId();
				String phone = feignUpmsAdminService.getPhoneById(organId, SecurityConstants.FROM_IN);
				List<GoodsSkuSpecValue> listGoodsSkuSpecValue = goodsSkuSpecValueMapper.listGoodsSkuSpecValueBySkuId(goodsSku.getId());
				String skuSpec = "";
				for (GoodsSkuSpecValue goodsSkuSpecValue : listGoodsSkuSpecValue) {
					skuSpec = skuSpec + goodsSkuSpecValue.getSpecValueName() + "，";
				}
				String fullSkuName = goodsSpuService.getById(goodsSku.getSpuId()).getName() + " " + skuSpec;
				String skuName = fullSkuName;
				if (fullSkuName.length() > 20) {
					skuName = fullSkuName.substring(0, 20);
				}
				try {
					smsUtils.sendSms(smsTemplateProperties.getSignName6(), phone, smsTemplateProperties.getTemplateCode6(), "{\"skuName\":\"" + skuName + "\"}");
				} catch (ClientException e) {
					log.error("短信发送失败:" + e.getMessage(), e);
				}
			}
		}
	}
}
