/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.mall.admin.service.OrderInfoService;
import com.joolun.cloud.mall.common.entity.GoodsAppraises;
import com.joolun.cloud.mall.admin.mapper.GoodsAppraisesMapper;
import com.joolun.cloud.mall.admin.service.GoodsAppraisesService;
import com.joolun.cloud.mall.common.entity.OrderInfo;
import com.joolun.cloud.mall.common.enums.OrderInfoEnum;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 商品评价
 *
 * @author JL
 * @date 2019-09-23 15:51:01
 */
@Service
@AllArgsConstructor
public class GoodsAppraisesServiceImpl extends ServiceImpl<GoodsAppraisesMapper, GoodsAppraises> implements GoodsAppraisesService {
	private final OrderInfoService orderInfoService;

	@Override
	public void doAppraises(List<GoodsAppraises> listGoodsAppraises) {
		super.saveBatch(listGoodsAppraises);
		OrderInfo orderInfo = new OrderInfo();
		orderInfo.setId(listGoodsAppraises.get(0).getOrderId());
		orderInfo.setStatus(OrderInfoEnum.STATUS_4.getValue());
		orderInfo.setClosingTime(LocalDateTime.now());
		orderInfoService.updateById(orderInfo);
	}

	@Override
	public IPage<GoodsAppraises> page1(IPage<GoodsAppraises> page, GoodsAppraises godsAppraises) {
		return baseMapper.selectPage1(page,godsAppraises);
	}
}
