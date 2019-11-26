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
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.binarywang.wxpay.bean.request.WxPayRefundRequest;
import com.github.binarywang.wxpay.bean.result.WxPayRefundResult;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.config.MallConfigProperties;
import com.joolun.cloud.mall.admin.service.GoodsSkuService;
import com.joolun.cloud.mall.admin.service.OrderInfoService;
import com.joolun.cloud.mall.admin.service.OrderItemService;
import com.joolun.cloud.mall.common.entity.GoodsSku;
import com.joolun.cloud.mall.common.entity.OrderInfo;
import com.joolun.cloud.mall.common.entity.OrderItem;
import com.joolun.cloud.mall.common.entity.OrderRefunds;
import com.joolun.cloud.mall.admin.mapper.OrderRefundsMapper;
import com.joolun.cloud.mall.admin.service.OrderRefundsService;
import com.joolun.cloud.mall.common.enums.OrderInfoEnum;
import com.joolun.cloud.mall.common.enums.OrderItemEnum;
import com.joolun.cloud.mall.common.enums.OrderRefundsEnum;
import com.joolun.cloud.mall.common.feign.FeignWxPayService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 退款详情
 *
 * @author JL
 * @date 2019-11-14 16:35:25
 */
@Slf4j
@Service
@AllArgsConstructor
public class OrderRefundsServiceImpl extends ServiceImpl<OrderRefundsMapper, OrderRefunds> implements OrderRefundsService {

	private final OrderItemService orderItemService;
	private final OrderInfoService orderInfoService;
	private final FeignWxPayService feignWxPayService;
	private final MallConfigProperties mallConfigProperties;
	private final GoodsSkuService goodsSkuService;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean saveRefunds(OrderRefunds entity) {
		OrderItem orderItem = orderItemService.getById(entity.getOrderItemId());
		if(StrUtil.isNotBlank(entity.getStatus())
				&& orderItem != null
				&& CommonConstants.NO.equals(orderItem.getIsRefund())
		 		&& OrderItemEnum.STATUS_0.getValue().equals(orderItem.getStatus())){//只有未退款的订单才能发起退款
			//修改订单详情状态为退款中
			orderItem.setStatus(entity.getStatus());
			orderItem.setIsRefund(CommonConstants.NO);
			orderItemService.updateById(orderItem);
			//新增退款记录
			entity.setOrderId(orderItem.getOrderId());
			entity.setOrderItemId(orderItem.getId());
			entity.setRefundAmount(orderItem.getSalesPrice());
			baseMapper.insert(entity);
		}
		return Boolean.TRUE;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean doOrderRefunds(OrderRefunds entity) {
		OrderRefunds orderRefunds = baseMapper.selectById(entity.getId());
		if(orderRefunds != null){
			//更新退款
			baseMapper.updateById(entity);
			//发起微信退款申请
			if(OrderRefundsEnum.STATUS_11.getValue().equals(entity.getStatus()) || OrderRefundsEnum.STATUS_211.getValue().equals(entity.getStatus())){
				OrderItem orderItem = orderItemService.getById2(orderRefunds.getOrderItemId());
				OrderInfo orderInfo = orderInfoService.getById(orderItem.getOrderId());
				//校验数据，只有已支付的订单、未退款的订单详情才能退款
				if(CommonConstants.YES.equals(orderInfo.getIsPay()) && CommonConstants.NO.equals(orderItem.getIsRefund())){
					WxPayRefundRequest request = new WxPayRefundRequest();
					request.setAppid(orderInfo.getAppId());
					request.setTransactionId(orderInfo.getTransactionId());
					request.setOutRefundNo(orderRefunds.getId());
					request.setTotalFee(orderInfo.getPaymentPrice().multiply(new BigDecimal(100)).intValue());
					request.setRefundFee((orderItem.getSalesPrice().multiply(new BigDecimal(orderItem.getQuantity()))).multiply(new BigDecimal(100)).intValue());
					request.setNotifyUrl(mallConfigProperties.getNotifyHost()+"/mall/api/ma/orderrefunds/notify-refunds");
					R r = feignWxPayService.refundOrder(request, SecurityConstants.FROM_IN);
					if(r.isOk()){
						WxPayRefundResult wxPayRefundResult = BeanUtil.mapToBean((Map<Object, Object>) r.getData(),WxPayRefundResult.class,true);
						entity.setRefundTradeNo(wxPayRefundResult.getRefundId());
					}else{
						throw new RuntimeException(r.getMsg());
					}
				}
			}
		}
		return Boolean.TRUE;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void notifyRefunds(OrderRefunds orderRefunds) {
		//修改订单详情退款状态为已退款
		OrderItem orderItem = orderItemService.getById(orderRefunds.getOrderItemId());
		orderItem.setIsRefund(CommonConstants.YES);
		String status = "";
		if(OrderRefundsEnum.STATUS_11.getValue().equals(orderRefunds.getStatus())){
			status = OrderItemEnum.STATUS_3.getValue();
		}
		if(OrderRefundsEnum.STATUS_211.getValue().equals(orderRefunds.getStatus())){
			status = OrderItemEnum.STATUS_4.getValue();
		}
		orderItem.setStatus(status);
		orderItemService.updateById(orderItem);
		baseMapper.updateById(orderRefunds);

		//回滚库存
		GoodsSku goodsSku = goodsSkuService.getById(orderItem.getSkuId());
		if(goodsSku != null){
			goodsSku.setStock(goodsSku.getStock() + orderItem.getQuantity());
			goodsSkuService.updateById(goodsSku);
		}

		List<OrderItem> listOrderItem = orderItemService.list(Wrappers.<OrderItem>query().lambda()
				.eq(OrderItem::getOrderId,orderItem.getOrderId()));
		List<OrderItem> listOrderItem2 = listOrderItem.stream()
				.filter(obj -> !obj.getId().equals(orderRefunds.getOrderItemId()) && CommonConstants.NO.equals(obj.getIsRefund())).collect(Collectors.toList());
		//如果订单下面所有订单详情都退款了，则取消订单
		if(listOrderItem2.size() <= 0){
			OrderInfo orderInfo = new OrderInfo();
			orderInfo.setId(orderItem.getOrderId());
			orderInfo.setStatus(OrderInfoEnum.STATUS_5.getValue());
			orderInfoService.updateById(orderInfo);
		}
	}
}
