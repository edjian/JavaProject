package com.joolun.cloud.mall.admin.listener;

import cn.hutool.core.util.StrUtil;
import com.joolun.cloud.common.data.tenant.TenantContextHolder;
import com.joolun.cloud.mall.admin.config.RedisConfigProperties;
import com.joolun.cloud.mall.admin.service.OrderInfoService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.OrderInfo;
import com.joolun.cloud.mall.common.enums.OrderInfoEnum;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.stereotype.Component;

/**
 * redis过期监听
 * 1、自动取消订单
 *
 */
@Component
public class RedisKeyExpirationListener implements MessageListener {

	private RedisTemplate<String, String> redisTemplate;
	private RedisConfigProperties redisConfigProperties;
	private OrderInfoService orderInfoService;

	public RedisKeyExpirationListener(RedisTemplate<String, String> redisTemplate,
									  RedisConfigProperties redisConfigProperties,
									  OrderInfoService orderInfoService){
		this.redisTemplate = redisTemplate;
		this.redisConfigProperties = redisConfigProperties;
		this.orderInfoService = orderInfoService;
	}
	@Override
	public void onMessage(Message message, byte[] bytes) {
		RedisSerializer<?> serializer = redisTemplate.getValueSerializer();
		String channel = String.valueOf(serializer.deserialize(message.getChannel()));
		String body = String.valueOf(serializer.deserialize(message.getBody()));
		//key过期监听
		if(StrUtil.format("__keyevent@{}__:expired", redisConfigProperties.getDatabase()).equals(channel)){
			//订单自动取消
			if(body.contains(MallConstants.REDIS_ORDER_KEY_STATUS_0)) {
				body = body.replace(MallConstants.REDIS_ORDER_KEY_STATUS_0, "");
				String[] str = body.split(":");
				String wxOrderId = str[1];
				TenantContextHolder.setTenantId(str[0]);
				OrderInfo orderInfo = orderInfoService.getById(wxOrderId);
				if(orderInfo != null && OrderInfoEnum.STATUS_0.getValue().equals(orderInfo.getStatus())){//只有待支付的订单能取消
					orderInfoService.orderCancel(orderInfo);
				}
			}
			//订单自动收货
			if(body.contains(MallConstants.REDIS_ORDER_KEY_STATUS_2)) {
				body = body.replace(MallConstants.REDIS_ORDER_KEY_STATUS_2, "");
				String[] str = body.split(":");
				String orderId = str[1];
				TenantContextHolder.setTenantId(str[0]);
				OrderInfo orderInfo = orderInfoService.getById(orderId);
				if(orderInfo != null && OrderInfoEnum.STATUS_2.getValue().equals(orderInfo.getStatus())){//只有待收货的订单能收货
					orderInfoService.orderReceive(orderInfo);
				}
			}
		}
	}
}
