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
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.mall.admin.mapper.MerchantSettledMapper;
import com.joolun.cloud.mall.admin.mapper.PointsRecordMapper;
import com.joolun.cloud.mall.admin.mapper.UserInfoMapper;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.*;
import com.joolun.cloud.mall.admin.mapper.BankWithdrawalMapper;
import com.joolun.cloud.mall.admin.service.BankWithdrawalService;
import com.joolun.cloud.mall.common.feign.FeignWxTemplateMsgService;
import com.joolun.cloud.weixin.common.constant.ConfigConstant;
import com.joolun.cloud.weixin.common.dto.WxTemplateMsgSendDTO;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Wrapper;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

/**
 * 银行提现表
 *
 * @author zq
 * @date 2020-08-21 10:41:42
 */
@Slf4j
@Service
@AllArgsConstructor
public class BankWithdrawalServiceImpl extends ServiceImpl<BankWithdrawalMapper, BankWithdrawal> implements BankWithdrawalService {

	private final UserInfoMapper userInfoMapper;
	private final PointsRecordMapper pointsRecordMapper;
	private final MerchantSettledMapper merchantSettledMapper;
	private final FeignWxTemplateMsgService feignWxTemplateMsgService;

	@Override
	@Transactional
	public boolean save1(BankWithdrawal bankWithdrawal) {
		bankWithdrawal.setUserId(ThirdSessionHolder.getMallUserId());
		UserInfo userInfo = userInfoMapper.selectById(ThirdSessionHolder.getMallUserId());
		int balance = userInfo.getPointsWithdraw() - bankWithdrawal.getSum().multiply(new BigDecimal(100)).intValue();
		if (balance < 0){
			bankWithdrawal.setStatus("2");
			baseMapper.updateById(bankWithdrawal);
			throw new RuntimeException("提现金额不足");
		}
		bankWithdrawal.setStatus("4");
		baseMapper.updateById(bankWithdrawal);
		userInfo.setPointsWithdraw(balance);
		userInfoMapper.updateById(userInfo);
		PointsRecord pointsRecord = new PointsRecord();
		pointsRecord.setAmount(-bankWithdrawal.getSum().multiply(new BigDecimal(100)).intValue());
		pointsRecord.setDescription("提现积分");
		pointsRecord.setUserId(ThirdSessionHolder.getMallUserId());
		pointsRecord.setRecordType(MallConstants.POINTS_RECORD_TYPE_10);
		pointsRecordMapper.insert(pointsRecord);
//		查出提现人
		MerchantSettled merchantSettled = merchantSettledMapper.selectById(bankWithdrawal.getUserId());

		//		发布订阅提现结果消息
		try {
//					提现人  {{thing5.DATA}}
//					提现金额 {{amount1.DATA}}
//  				提现结果  {{phrase2.DATA}}
//					申请时间 {{date3.DATA}}
//			        温馨提醒 {{thing4.DATA}}
			BankWithdrawal bankWithdrawal1 = baseMapper.selectById(bankWithdrawal.getUserId());
			WxTemplateMsgSendDTO wxTemplateMsgSendDTO = new WxTemplateMsgSendDTO();
			wxTemplateMsgSendDTO.setMallUserId(bankWithdrawal1.getUserId());
			wxTemplateMsgSendDTO.setPage("pages/order/order-detail/index?id=" + bankWithdrawal1.getId());
			wxTemplateMsgSendDTO.setUseType(ConfigConstant.WX_TMP_USE_TYPE_13);
			HashMap<String, HashMap<String, String>> data = new HashMap<>();
			data.put("thing5", (HashMap) JSONUtil.toBean("{\"value\": \"" + merchantSettled.getUserName() + "\"}", Map.class));
			data.put("amount1", (HashMap) JSONUtil.toBean("{\"value\": \"" + bankWithdrawal1.getSum() + "\"}", Map.class));
			if ("2".equals(bankWithdrawal1.getStatus())) {
				data.put("phrase2", (HashMap) JSONUtil.toBean("{\"value\": \"" + "提现失败" + "\"}", Map.class));
				data.put("thing4", (HashMap) JSONUtil.toBean("{\"value\": \"" + "卡内金额不足，请检查后重新申请" + "\"}", Map.class));
			}
			if ("4".equals(bankWithdrawal1.getStatus())) {
				data.put("phrase2", (HashMap) JSONUtil.toBean("{\"value\": \"" + "提现成功" + "\"}", Map.class));
				data.put("thing4", (HashMap) JSONUtil.toBean("{\"value\": \"" + "提现金额已转入申请的收款账户" + "\"}", Map.class));
			}
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			data.put("date3", (HashMap) JSONUtil.toBean("{\"value\": \"" + dtf.format(bankWithdrawal1.getCreateTime()) + "\"}", Map.class));
			wxTemplateMsgSendDTO.setData(data);
			feignWxTemplateMsgService.sendTemplateMsg(wxTemplateMsgSendDTO, SecurityConstants.FROM_IN);
		} catch (Exception e) {
			log.error("提现失败: " + e.getMessage(), e);
		}
		return baseMapper.insert(bankWithdrawal) == 1;
	}

//	审核结果通知
	@Override
	public boolean drawalAuditResult(BankWithdrawal bankWithdrawal) {
		baseMapper.updateById(bankWithdrawal);
//		根据不同状态设置审核结果  1、放款中，2、驳回重新申请，3、驳回已重新申请，
		if ("1".equals(bankWithdrawal.getStatus())){
			bankWithdrawal.setStatus("1");
				baseMapper.updateById(bankWithdrawal);
			}
			if ("2".equals(bankWithdrawal.getStatus())){
				bankWithdrawal.setStatus("2");
				baseMapper.updateById(bankWithdrawal);
			}
			if ("3".equals(bankWithdrawal.getStatus())){
				bankWithdrawal.setStatus("3");
				baseMapper.updateById(bankWithdrawal);
			}
//		发布订阅提现审核结果消息
		try {
//			审核结果 {{phrase1.DATA}}
//			审核内容 {{thing2.DATA}}
//			审核时间 {{date3.DATA}}
//			温馨提示 {{thing4.DATA}}
			BankWithdrawal bankWithdrawal1 = baseMapper.selectById(bankWithdrawal.getUserId());
			WxTemplateMsgSendDTO wxTemplateMsgSendDTO = new WxTemplateMsgSendDTO();
			wxTemplateMsgSendDTO.setMallUserId(ThirdSessionHolder.getMallUserId());
			wxTemplateMsgSendDTO.setPage("pages/order/order-detail/index?id=" + bankWithdrawal1.getId());
			wxTemplateMsgSendDTO.setUseType(ConfigConstant.WX_TMP_USE_TYPE_15);
			HashMap<String, HashMap<String, String>> data = new HashMap<>();

			if ("1".equals(bankWithdrawal1.getStatus())) {
				data.put("phrase1", (HashMap) JSONUtil.toBean("{\"value\": \"" + "审核成功" + "\"}", Map.class));
				data.put("thing2", (HashMap) JSONUtil.toBean("{\"value\": \"" + "您的信息已审核通过" + "\"}", Map.class));
				data.put("thing4", (HashMap) JSONUtil.toBean("{\"value\": \"" + "1分可兑换1元" + "\"}", Map.class));
			}
			if ("2".equals(bankWithdrawal1.getStatus())) {
				data.put("phrase1", (HashMap) JSONUtil.toBean("{\"value\": \"" + "审核失败" + "\"}", Map.class));
				data.put("thing4", (HashMap) JSONUtil.toBean("{\"value\": \"" + "1分可兑换1元" + "\"}", Map.class));
				data.put("thing2", (HashMap) JSONUtil.toBean("{\"value\": \"" + "您的信息未审核通过" + "\"}", Map.class));
			}
			if ("3".equals(bankWithdrawal1.getStatus())) {
				data.put("phrase1", (HashMap) JSONUtil.toBean("{\"value\": \"" + "重新审核中" + "\"}", Map.class));
				data.put("thing4", (HashMap) JSONUtil.toBean("{\"value\": \"" + "1分可兑换1元" + "\"}", Map.class));
				data.put("thing2", (HashMap) JSONUtil.toBean("{\"value\": \"" + "您的信息已重新提交" + "\"}", Map.class));
			}
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			data.put("date3", (HashMap) JSONUtil.toBean("{\"value\": \"" + dtf.format(bankWithdrawal1.getCreateTime()) + "\"}", Map.class));
			wxTemplateMsgSendDTO.setData(data);
			feignWxTemplateMsgService.sendTemplateMsg(wxTemplateMsgSendDTO, SecurityConstants.FROM_IN);
		} catch (Exception e) {
			log.error("审核失败: " + e.getMessage(), e);
		}
		return Boolean.TRUE;
	}
}
