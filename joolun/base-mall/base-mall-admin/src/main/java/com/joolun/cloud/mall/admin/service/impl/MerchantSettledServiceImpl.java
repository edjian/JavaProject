/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.mall.admin.mapper.MerchantSettledMapper;
import com.joolun.cloud.mall.admin.mapper.OrderInfoMapper;
import com.joolun.cloud.mall.admin.mapper.SetMealMapper;
import com.joolun.cloud.mall.admin.mapper.UserMealMapper;
import com.joolun.cloud.mall.admin.service.MerchantSettledService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.constant.MyReturnCode;
import com.joolun.cloud.mall.common.entity.*;
import com.joolun.cloud.mall.common.feign.FeignWxTemplateMsgService;
import com.joolun.cloud.weixin.common.constant.ConfigConstant;
import com.joolun.cloud.weixin.common.dto.WxTemplateMsgSendDTO;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商城入驻信息表
 *
 * @author zq
 * @date 2020-07-16 13:10:38
 */
@Service
@Slf4j
@AllArgsConstructor
public class MerchantSettledServiceImpl extends ServiceImpl<MerchantSettledMapper, MerchantSettled> implements MerchantSettledService {

	private final FeignWxTemplateMsgService feignWxTemplateMsgService;
	private final UserMealMapper userMealMapper;
	private final SetMealMapper setMealMapper;
	private final OrderInfoMapper orderInfoMapper;
    @Override
    public Integer getStep(MerchantSettled merchantSettled) {
        return baseMapper.selectStep(merchantSettled);
    }
	/*
	* 入驻审核功能
	* @param result
	* */

	@Override
	public boolean updateMerchantSettled(MerchantSettled merchantSettled) {
			baseMapper.updateById(merchantSettled);
		//				发布订阅审核消息
		try {
//					商家名称  {{thing1.DATA}}
//					审核结果 {{phrase2.DATA}}
//  				审核日期  {{date3.DATA}}
//					备注 {{thing4.DATA}}
			MerchantSettled merchantSettledInfo1 = baseMapper.selectById(merchantSettled.getUserId());
//			根据商城用户查出用户套餐信息
			UserMeal userMeal = userMealMapper.selectOne(Wrappers.<UserMeal>lambdaQuery()
					.eq(UserMeal::getUserId, merchantSettledInfo1.getUserId()));
//			根据用户的套餐ID查出套餐信息
			SetMeal setMeal = setMealMapper.selectOne(Wrappers.<SetMeal>lambdaQuery()
					.eq(SetMeal::getId, userMeal.getSetMealId()));
			WxTemplateMsgSendDTO wxTemplateMsgSendDTO = new WxTemplateMsgSendDTO();
			wxTemplateMsgSendDTO.setMallUserId(ThirdSessionHolder.getMallUserId());
			wxTemplateMsgSendDTO.setPage("pages/order/order-detail/index?id=" + merchantSettledInfo1.getId());
			wxTemplateMsgSendDTO.setUseType(ConfigConstant.WX_TMP_USE_TYPE_6);
			HashMap<String, HashMap<String, String>> data = new HashMap<>();
			data.put("thing1", (HashMap)JSONUtil.toBean("{\"value\": \""+merchantSettledInfo1.getMerchantsSettled() + "\"}", Map.class));
//			根据 商户的审核状态 去做判断  2、审核通过，3、审核失败
			if (merchantSettledInfo1.getStatus()==2){
//          根据用户套餐的支付状态 再做判断  0、未支付 1、已支付
				if (CommonConstants.IS_PAY_SUCCESS.equals(userMeal.getStatus())){
//					判断用户套餐的价格是不是 980  如果是需要补差价
					if (MallConstants.BASICS_MEAL==(setMeal.getPrice().intValue())){
						int price=(MallConstants.FLAGSHIP_MEAL-(MallConstants.BASICS_MEAL.intValue()));
						data.put("phrase2", (HashMap)JSONUtil.toBean("{\"value\": \""+"审核通过" + "\"}", Map.class));
						data.put("thing4",(HashMap)JSONUtil.toBean("{\"value\": \""+"您还差"+price+ "元，请尽快补尾款哦，"+ "\"}", Map.class));
					}
					//	不是就直接通过
					data.put("thing4",(HashMap)JSONUtil.toBean("{\"value\": \""+"快去发布商品吧！"+ "\"}", Map.class));
					data.put("phrase2", (HashMap)JSONUtil.toBean("{\"value\": \""+"审核通过" + "\"}", Map.class));
				}
				else if (CommonConstants.IS_PAY_FAIL.equals(userMeal.getStatus())){
//					判断用户套餐价格是 3980
					if (MallConstants.FLAGSHIP_MEAL==(setMeal.getPrice().intValue())){
						data.put("thing4",(HashMap)JSONUtil.toBean("{\"value\": \""+"您还未支付，请尽快付款哦,付款金额为"+MallConstants.FLAGSHIP_MEAL+"元" +"\"}", Map.class));
						data.put("phrase2", (HashMap)JSONUtil.toBean("{\"value\": \""+"审核通过" + "\"}", Map.class));
					}
//					判断用户套餐价格是59800
					else if (MallConstants.CITY_PARTNER==(setMeal.getPrice().intValue())){
						data.put("thing4",(HashMap)JSONUtil.toBean("{\"value\": \""+"您还未支付，请尽快付款哦,付款金额为"+MallConstants.CITY_PARTNER+"元" +"\"}", Map.class));
						data.put("phrase2", (HashMap)JSONUtil.toBean("{\"value\": \""+"审核通过" + "\"}", Map.class));
					}
				}
			}
			if (merchantSettledInfo1.getStatus()==3){
				data.put("phrase2", (HashMap)JSONUtil.toBean("{\"value\": \""+"审核失败" + "\"}", Map.class));
				data.put("thing4",(HashMap)JSONUtil.toBean("{\"value\": \""+"请检查信息后重新申请" + "\"}", Map.class));
			}
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy年MM月dd日");
			data.put("date3",(HashMap)JSONUtil.toBean("{\"value\": \""+dtf.format(merchantSettledInfo1.getUpdateTime()) + "\"}", Map.class));
			wxTemplateMsgSendDTO.setData(data);
			feignWxTemplateMsgService.sendTemplateMsg(wxTemplateMsgSendDTO, SecurityConstants.FROM_IN);
		}catch (Exception e){
			log.error("审核失败: "+e.getMessage(),e);
		}
		return Boolean.TRUE;
	}

//展示商家信息
	@Override
	public List<MerchantSettled> getMerchants(IPage<GoodsSpu> page, MerchantSettled merchantSettled) {
//		根据商城用户ID查出用户套餐
		UserMeal userMeal = userMealMapper.selectOne(Wrappers.<UserMeal>lambdaQuery()
				.eq(UserMeal::getUserId, merchantSettled.getUserId()));
//根据用户套餐的信息 去查 套餐信息
		SetMeal setMeal = setMealMapper.selectOne(Wrappers.<SetMeal>lambdaQuery()
				.eq(SetMeal::getId, userMeal.getSetMealId()));
//		根据用户套餐的订单号 去查用户的支付金额
		OrderInfo orderInfo = orderInfoMapper.selectOne(Wrappers.<OrderInfo>lambdaQuery()
				.eq(OrderInfo::getOrderNo, userMeal.getOrderNo()));
		if ( "1".equals(userMeal.getStatus())){
//			if (orderInfo.getPaymentPrice().compareTo(setMeal.getPrice())==0){
//				BigDecimal result=	setMeal.getPrice().subtract(orderInfo.getPaymentPrice());
//				map=result.intValue();
//			}
//			if (orderInfo.getPaymentPrice().compareTo(setMeal.getPrice())==-1){
//				BigDecimal result=	setMeal.getPrice().subtract(orderInfo.getPaymentPrice());
//				map=result.intValue();
//			}
			userMeal.setIsPay("1");
			userMealMapper.updateById(userMeal);
			baseMapper.getMerchants(page,merchantSettled);
		}
		else if ( "0".equals(userMeal.getStatus())){
			userMeal.setIsPay("0");
			userMealMapper.updateById(userMeal);
				baseMapper.getMerchants(page,merchantSettled);
		}
		else if ( "2".equals(userMeal.getStatus())){
			userMeal.setIsPay("2");
			userMealMapper.updateById(userMeal);
			baseMapper.getMerchants(page,merchantSettled);
		}
		return baseMapper.getMerchants(page,merchantSettled);
	}

}
