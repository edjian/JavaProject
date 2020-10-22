/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.mall.admin.mapper.GoodsCategoryMapper;
import com.joolun.cloud.mall.admin.mapper.GoodsSpuMapper;
import com.joolun.cloud.mall.admin.mapper.OrderItemMapper;
import com.joolun.cloud.mall.admin.service.OrderInfoService;
import com.joolun.cloud.mall.admin.service.OrderItemService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.*;
import com.joolun.cloud.mall.admin.mapper.GoodsAppraisesMapper;
import com.joolun.cloud.mall.admin.service.GoodsAppraisesService;
import com.joolun.cloud.upms.common.entity.SysUser;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	private final  OrderItemService orderItemService;
	private final OrderItemMapper orderItemMapper;
	private final GoodsSpuMapper goodsSpuMapper;
	private final GoodsCategoryMapper goodsCategoryMapper;
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void doAppraises(List<GoodsAppraises> listGoodsAppraises) {
		super.saveBatch(listGoodsAppraises);
		OrderInfo orderInfo = new OrderInfo();
		orderInfo.setId(listGoodsAppraises.get(0).getOrderId());
		orderInfo.setAppraisesStatus(MallConstants.APPRAISES_STATUS_1);
		orderInfo.setClosingTime(LocalDateTime.now());
		orderInfoService.updateById(orderInfo);
	}

	@Override
	public IPage<GoodsAppraises> page1(IPage<GoodsAppraises> page, GoodsAppraises godsAppraises) {
		return baseMapper.selectPage1(page,godsAppraises);
	}

	//审核
	@Override
	public Integer CommentsAudit(GoodsAppraises goodsAppraises1) {
		baseMapper.updateById(goodsAppraises1);
//		根据状态去设置审核状态  1 审核成功  2 审核失败
//		是否非法评论  0为否  1为是
		if ("1".equals(goodsAppraises1.getStatus())){
			goodsAppraises1.setStatus("1");
			goodsAppraises1.setIsItIllegal("0");
			baseMapper.updateById(goodsAppraises1);
		}else if ("2".equals(goodsAppraises1.getStatus())){
			goodsAppraises1.setIsItIllegal("1");
			goodsAppraises1.setStatus("2");
			baseMapper.updateById(goodsAppraises1);
		}
		return baseMapper.updateById(goodsAppraises1);
	}
	/*
	* 根据查询条件 租户ID和审核状态
	* */
	@Override
	public IPage<GoodsAppraises> page2(IPage<GoodsAppraises> page, GoodsAppraises godsAppraises) {
//		查出订单信息
		OrderItem orderItem = orderItemMapper.selectById(godsAppraises.getOrderItemId());
		//
		//	根据订单的spuId查出商品信息
		GoodsSpu goodsSpu = goodsSpuMapper.selectOne(Wrappers.<GoodsSpu>lambdaQuery()
				.eq(GoodsSpu::getId, orderItem.getSpuId()));
//		查出一级分类
		GoodsCategory category1 = goodsCategoryMapper.selectOne(Wrappers.<GoodsCategory>lambdaQuery()
				.eq(GoodsCategory::getParentId, CommonConstants.PARENT_ID));
		//		查出一级下的二级分类
		GoodsCategory category2 = goodsCategoryMapper.selectOne(Wrappers.<GoodsCategory>lambdaQuery()
				.eq(GoodsCategory::getParentId, category1.getId()));
//  根据分类的id 与 商品的一级分类 来比较 ，如果相等并且 商品的 一级就是那个最大父类
		if (category1.getId().equals(goodsSpu.getCategoryFirst())&& goodsSpu.getCategoryFirst().equals(category1.getId())){
//			如果分类的二级Id 与 商品的 二级分类相等  并且 商品的父分类 等于一级的 分类id  就会形成一个级联
			if (category1.getId().equals(goodsSpu.getCategorySecond()) && category2.getParentId().equals(category1.getId())){
				baseMapper.selectPage2(page,godsAppraises);
			}
//			如果只选了一级 就查一级的
			baseMapper.selectPage2(page,godsAppraises);
		}
		return baseMapper.selectPage2(page,godsAppraises);
	}
}
