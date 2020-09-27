/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.mapper.*;
import com.joolun.cloud.mall.admin.service.InviteNewService;
import com.joolun.cloud.mall.admin.service.PointsRecordService;
import com.joolun.cloud.mall.admin.service.UserInfoService;
import com.joolun.cloud.mall.admin.service.UserMealService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.constant.MyReturnCode;
import com.joolun.cloud.mall.common.entity.*;
import com.joolun.cloud.mall.common.feign.FeignWxTemplateMsgService;
import com.joolun.cloud.mall.common.util.StringUtil;
import com.joolun.cloud.weixin.common.constant.ConfigConstant;
import com.joolun.cloud.weixin.common.dto.WxTemplateMsgSendDTO;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

/**
 * 用户套餐表
 *
 * @author zq
 * @date 2020-07-17 15:24:20
 */
@Slf4j
@Service
@AllArgsConstructor
public class UserMealServiceImpl extends ServiceImpl<UserMealMapper, UserMeal> implements UserMealService {

    private final UserInfoMapper userInfoMapper;
    private final PointsRecordMapper pointsRecordMapper;
    private final InviteNewMapper inviteNewMapper;
    private final MerchantSettledMapper merchantSettledMapper;
    private final UserMealMapper userMealMapper;
    private final SetMealMapper setMealMapper;
	private final FeignWxTemplateMsgService feignWxTemplateMsgService;

    @Override
    public UserMeal getByConditional(UserMeal userMeal) {
        return baseMapper.getByConditional(userMeal);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public UserMeal userMealSave(UserMeal userMeal, String inviteUserId) {
        baseMapper.delete(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getUserId, ThirdSessionHolder.getMallUserId())
                .eq(UserMeal::getStatus, MallConstants.UNPAID));
        userMeal.setUserId(ThirdSessionHolder.getMallUserId());
        userMeal.setOrderNo(IdUtil.getSnowflake(0, 0).nextIdStr());
        userMeal.setCreateTime(LocalDateTime.now());
        baseMapper.insert(userMeal);
        return userMeal;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void notifyOrder(UserMeal userMeal, String inviteUserId) {
        UserMeal oldUserMeal = baseMapper.selectOne(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getStatus, MallConstants.UNDER_WAY)
                .eq(UserMeal::getAccountStatus, CommonConstants.NO)
                .eq(UserMeal::getUserId, userMeal.getUserId()));

        if (CommonConstants.NO.equals(userMeal.getIsPay())) {
            userMeal.setIsPay(CommonConstants.YES);
            userMeal.setStatus(CommonConstants.YES);
            baseMapper.updateById(userMeal);
            //商家入驻信息处理
            MerchantSettled merchantSettled = merchantSettledMapper.selectOne(Wrappers.<MerchantSettled>lambdaQuery()
                    .eq(MerchantSettled::getUserId, userMeal.getUserId())
                    .eq(MerchantSettled::getStatus, 3));
            if (merchantSettled != null) {
                merchantSettled.setStep(4);
                merchantSettledMapper.update(merchantSettled, Wrappers.<MerchantSettled>lambdaUpdate().eq(MerchantSettled::getId, merchantSettled.getId()));
            }

            //升级套餐
            if (oldUserMeal != null) {
                oldUserMeal.setAccountStatus(CommonConstants.YES);
                baseMapper.updateById(oldUserMeal);
                InviteNew existInviteNew = inviteNewMapper.selectOne(Wrappers.<InviteNew>lambdaQuery()
                        .eq(InviteNew::getUserId, userMeal.getUserId())
                        .eq(InviteNew::getStatus, CommonConstants.YES));
                //判断是否有邀请人
                UserInfo userInfo = userInfoMapper.getUserMeal(userMeal.getUserId());
                userMeal.setStartTime(oldUserMeal.getEndTime());
                userMeal.setEndTime(oldUserMeal.getEndTime().plusDays(MallConstants.MINE_UPGRADE_TIME));
                userMeal.setInviteDay(MallConstants.MINE_UPGRADE_TIME);
//                userInfo.setPointsCurrent(userInfo.getPointsCurrent() + oldUserMeal.getSurplusPoint());
                userInfo.setPointsWithdraw(userInfo.getPointsWithdraw() + oldUserMeal.getSurplusPoint());
                userInfoMapper.updateById(userInfo);

                //邀新成功后一级邀请人信息
                if (StringUtils.isNotBlank(existInviteNew.getUserIdFirst())) {
                    UserInfo upgradeUserInfoFirst = userInfoMapper.getUserMeal(existInviteNew.getUserIdFirst());//升级套餐一级用户信息
                    if (upgradeUserInfoFirst != null) {
                        if (MallConstants.FLAGSHIP_MEAL.equals(upgradeUserInfoFirst.getUserMeal().getSetMeal().getPrice().intValue())) {
                            upgradeUserInfoFirst.getUserMeal().setEndTime(upgradeUserInfoFirst.getUserMeal().getEndTime().plusDays(MallConstants.FLAGSHIP_INVITE_BASIC_UPGRADE_TIME));
                            baseMapper.updateById(upgradeUserInfoFirst.getUserMeal());
                        }
                    }
                }
                inviteNewMapper.selectList(Wrappers.<InviteNew>lambdaQuery()
                        .eq(InviteNew::getUserIdFirst, userMeal.getUserId())
                        .eq(InviteNew::getStatus, CommonConstants.YES))
                        .stream().filter(inviteNew ->
                        baseMapper.selectOne(Wrappers.<UserMeal>lambdaQuery()
                                .eq(UserMeal::getSetMealId, userMeal.getSetMealId())
                                .eq(UserMeal::getUserId, inviteNew.getUserId())) != null)
                        .forEach(inviteNew -> userMeal.setEndTime(userMeal.getEndTime().plusDays(MallConstants.BASIC_INVITE_FLAGSHIP_UPGRADE_TIME)));
                baseMapper.updateById(userMeal);

//		查出套餐过期的用户信息
				UserMeal OldUserMeal = baseMapper.selectOne(Wrappers.<UserMeal>lambdaQuery()
						.eq(UserMeal::getStatus, MallConstants.FINISHED)
						.eq(UserMeal::getAccountStatus, CommonConstants.YES)
						.eq(UserMeal::getUserId, userMeal.getUserId()));
				SetMeal setMeal = setMealMapper.selectById(OldUserMeal.getSetMealId());
//		查出新套餐的用户信息
				UserMeal NewUserMeal = baseMapper.selectOne(Wrappers.<UserMeal>lambdaQuery()
						.eq(UserMeal::getStatus, MallConstants.UNDER_WAY)
						.eq(UserMeal::getAccountStatus, CommonConstants.NO)
						.eq(UserMeal::getIsPay,MallConstants.PAID)
						.eq(UserMeal::getUserId, userMeal.getUserId()));
				if (!OldUserMeal.getSetMealId().equals(NewUserMeal.getSetMealId())){
					userMeal.setCreateTime(NewUserMeal.getCreateTime());
					userMeal.setAccountStatus(NewUserMeal.getAccountStatus());
					userMeal.setEndTime(NewUserMeal.getEndTime());
					userMeal.setOrderNo(NewUserMeal.getOrderNo());
					userMeal.setSetMealId(NewUserMeal.getSetMealId());
					userMeal.setId(NewUserMeal.getId());
					userMeal.setStartTime(NewUserMeal.getStartTime());
					userMeal.setSurplusPoint(OldUserMeal.getSurplusPoint()+NewUserMeal.getSurplusPoint());
					userMealMapper.updateById(userMeal);
				}
				SetMeal setMeal1 = setMealMapper.selectById(NewUserMeal.getSetMealId());

				//发布订阅会员等级变更通知消息
				try {
//					会员等级 {{phrase1.DATA}}
//					变更时间 {{date2.DATA}}
//					备注说明 {{thing3.DATA}}
					UserMeal userMeal1 = baseMapper.selectById(userMeal.getUserId());
					WxTemplateMsgSendDTO wxTemplateMsgSendDTO = new WxTemplateMsgSendDTO();
					wxTemplateMsgSendDTO.setMallUserId(ThirdSessionHolder.getMallUserId());
					wxTemplateMsgSendDTO.setPage("pages/order/order-detail/index?id=" + userMeal1.getId());
					wxTemplateMsgSendDTO.setUseType(ConfigConstant.WX_TMP_USE_TYPE_17);
					HashMap<String, HashMap<String, String>> data = new HashMap<>();
					if (!OldUserMeal.getSetMealId().equals(NewUserMeal.getSetMealId())){
						data.put("phrase1", (HashMap) JSONUtil.toBean("{\"value\": \""+ setMeal1.getName()+ "\"}", Map.class));
						data.put("thing3", (HashMap) JSONUtil.toBean("{\"value\": \""+ "由"+setMeal.getName()+"升级为"+setMeal1.getName()+ "\"}", Map.class));
					}
					DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
					data.put("date2",(HashMap)JSONUtil.toBean("{\"value\": \""+dtf.format(userMeal1.getUpdateTime()) + "\"}", Map.class));
					wxTemplateMsgSendDTO.setData(data);
					feignWxTemplateMsgService.sendTemplateMsg(wxTemplateMsgSendDTO, SecurityConstants.FROM_IN);
				}catch (Exception e){
					log.error("等级变更失败: "+e.getMessage(),e);
				}
			} else {
                InviteNew inviteNew = inviteNewMapper.selectOne(Wrappers.<InviteNew>lambdaQuery()
                        .eq(InviteNew::getUserId, userMeal.getUserId())
                        .eq(StringUtils.isNotEmpty(inviteUserId), InviteNew::getUserIdFirst, inviteUserId));
                if (inviteNew != null) {
                    inviteNew.setStatus(CommonConstants.YES);
                    inviteNewMapper.update(inviteNew, Wrappers.<InviteNew>lambdaUpdate().eq(InviteNew::getId, inviteNew.getId()));

                    UserInfo userInfo = userInfoMapper.getUserMeal(inviteNew.getUserId());

                    //邀新成功后一级邀请人信息
                    if (StringUtils.isNotEmpty(inviteUserId)) {
                        UserInfo userInfoFirst = userInfoMapper.getUserMeal(inviteUserId);
                        if (userInfoFirst != null) {
                            BigDecimal firstPoint = BigDecimal.ZERO;

                            if (MallConstants.CITY_PARTNER.equals(userInfo.getUserMeal().getSetMeal().getPrice().intValue())) {
                                if (MallConstants.CITY_PARTNER.equals(userInfoFirst.getUserMeal().getSetMeal().getPrice().intValue())) {
                                    firstPoint = MallConstants.SET_MEAL_59800.multiply(new BigDecimal(MallConstants.CITY_PARTNER.toString())).multiply(new BigDecimal("100")).divide(new BigDecimal("2"));
                                } else if (MallConstants.FLAGSHIP_MEAL.equals(userInfoFirst.getUserMeal().getSetMeal().getPrice().intValue())) {
                                    firstPoint = MallConstants.SET_MEAL_3980.multiply(new BigDecimal(MallConstants.CITY_PARTNER.toString())).multiply(new BigDecimal("100")).divide(new BigDecimal("2"));
                                } else {
                                    firstPoint = MallConstants.SET_MEAL_980.multiply(new BigDecimal(MallConstants.CITY_PARTNER.toString())).multiply(new BigDecimal("100")).divide(new BigDecimal("2"));
                                }
                                userInfoFirst.setPointsWithdraw(userInfoFirst.getPointsWithdraw() + firstPoint.intValue() * 2);
                            } else {
                                BigDecimal balanceFirst = new BigDecimal(MallConstants.FLAGSHIP_MEAL - MallConstants.BASICS_MEAL);
                                if (userInfoFirst.getUserMeal().getSetMeal().getPrice().compareTo(userInfo.getUserMeal().getSetMeal().getPrice()) >= 0) {
                                    firstPoint = userInfo.getUserMeal().getSetMeal().getPrice().multiply(new BigDecimal(userInfo.getUserMeal().getSetMeal().getInviteRebateFirst().toString()).divide(new BigDecimal("100")).multiply(new BigDecimal("100")));
                                    if (MallConstants.BASICS_MEAL.equals(userInfoFirst.getUserMeal().getSetMeal().getPrice().intValue())) {
                                        userInfoFirst.getUserMeal().setEndTime(userInfoFirst.getUserMeal().getEndTime().plusDays(MallConstants.DEFAULT_INVITE_TIME));
                                    } else if (MallConstants.FLAGSHIP_MEAL.equals(userInfoFirst.getUserMeal().getSetMeal().getPrice().intValue())) {
                                        userInfoFirst.getUserMeal().setEndTime(userInfoFirst.getUserMeal().getEndTime().plusDays(MallConstants.FLAGSHIP_INVITE_BASIC_TIME));
                                    }
                                } else {
                                    firstPoint = userInfoFirst.getUserMeal().getSetMeal().getPrice().multiply(new BigDecimal(userInfoFirst.getUserMeal().getSetMeal().getInviteRebateFirst().toString()).divide(new BigDecimal("100")).multiply(new BigDecimal("100")));
                                    userInfoFirst.getUserMeal().setSurplusPoint(userInfoFirst.getUserMeal().getSurplusPoint() + balanceFirst.multiply(new BigDecimal(userInfoFirst.getUserMeal().getSetMeal().getInviteRebateFirst().toString()).divide(new BigDecimal("100")).multiply(new BigDecimal("100"))).intValue());
                                    userInfoFirst.getUserMeal().setEndTime(userInfoFirst.getUserMeal().getEndTime().plusDays(MallConstants.DEFAULT_INVITE_TIME));
                                }
//                                userInfoFirst.setPointsCurrent(userInfoFirst.getPointsCurrent() + firstPoint.intValue());
                                userInfoFirst.setPointsWithdraw(userInfoFirst.getPointsWithdraw() + firstPoint.intValue());
                            }

                            userInfoMapper.update(userInfoFirst, Wrappers.<UserInfo>lambdaUpdate().eq(UserInfo::getId, userInfoFirst.getId()));
                            userMealMapper.update(userInfoFirst.getUserMeal(), Wrappers.<UserMeal>lambdaUpdate().eq(UserMeal::getId, userInfoFirst.getUserMeal().getId()));
                            //邀新一级积分记录
                            PointsRecord pointsRecord = new PointsRecord();
                            pointsRecord.setUserId(userInfoFirst.getId());
                            pointsRecord.setAmount(firstPoint.intValue());
                            pointsRecord.setRecordType(MallConstants.POINTS_RECORD_TYPE_7);
                            pointsRecord.setDescription("邀新一级积分");
                            pointsRecord.setOrderItemId(userMeal.getOrderNo());
                            pointsRecordMapper.insert(pointsRecord);
                            //邀新成功后二级邀请人信息
                            UserInfo userInfoSecond = null;
                            if (StringUtils.isNotEmpty(inviteNew.getUserIdSecond()))
                                userInfoSecond = userInfoMapper.getUserMeal(inviteNew.getUserIdSecond());
                            if (userInfoSecond != null) {
                                BigDecimal secondPoint = BigDecimal.ZERO;
                                if (!MallConstants.CITY_PARTNER.equals(userInfo.getUserMeal().getSetMeal().getPrice().intValue())) {
                                    BigDecimal balanceSecond = new BigDecimal(MallConstants.FLAGSHIP_MEAL - MallConstants.BASICS_MEAL);
                                    if (userInfoSecond.getUserMeal().getSetMeal().getPrice().compareTo(userInfo.getUserMeal().getSetMeal().getPrice()) >= 0) {
                                        secondPoint = userInfo.getUserMeal().getSetMeal().getPrice().multiply(new BigDecimal(userInfo.getUserMeal().getSetMeal().getInviteRebateSecond().toString()).divide(new BigDecimal("100")).multiply(new BigDecimal("100")));
//                                        if (MallConstants.BASICS_MEAL.equals(userInfoSecond.getUserMeal().getSetMeal().getPrice().intValue())) {
//                                            userInfoSecond.getUserMeal().setSurplusPoint(userInfoSecond.getUserMeal().getSurplusPoint() + balanceSecond.multiply(new BigDecimal(userInfoSecond.getUserMeal().getSetMeal().getInviteRebateFirst().toString()).divide(new BigDecimal("100")).multiply(new BigDecimal("100"))).intValue());
//                                        }
                                    } else {
                                        secondPoint = userInfoSecond.getUserMeal().getSetMeal().getPrice().multiply(new BigDecimal(userInfoSecond.getUserMeal().getSetMeal().getInviteRebateSecond().toString()).divide(new BigDecimal("100")).multiply(new BigDecimal("100")));
                                        userInfoSecond.getUserMeal().setSurplusPoint(userInfoSecond.getUserMeal().getSurplusPoint() + balanceSecond.multiply(new BigDecimal(userInfoSecond.getUserMeal().getSetMeal().getInviteRebateSecond().toString()).divide(new BigDecimal("100")).multiply(new BigDecimal("100"))).intValue());
                                    }
//                                    userInfoSecond.setPointsCurrent(userInfoSecond.getPointsCurrent() + secondPoint.intValue());
                                    userInfoSecond.setPointsWithdraw(userInfoSecond.getPointsWithdraw() + secondPoint.intValue());
                                    userInfoMapper.update(userInfoSecond, Wrappers.<UserInfo>lambdaUpdate().eq(UserInfo::getId, userInfoSecond.getId()));
                                    userMealMapper.update(userInfoSecond.getUserMeal(), Wrappers.<UserMeal>lambdaUpdate().eq(UserMeal::getId, userInfoSecond.getUserMeal().getId()));
                                    //邀新二级积分记录
                                    PointsRecord pointsRecord2 = new PointsRecord();
                                    pointsRecord2.setUserId(userInfoSecond.getId());
                                    pointsRecord2.setAmount(secondPoint.intValue());
                                    pointsRecord2.setRecordType(MallConstants.POINTS_RECORD_TYPE_8);
                                    pointsRecord2.setDescription("邀新二级积分");
                                    pointsRecord2.setOrderItemId(userMeal.getOrderNo());
                                    pointsRecordMapper.insert(pointsRecord2);
                                }

                            }
                        }
                    }
                }
            }
        }
    }

    @Override
    public R getUserMealIsPay(UserMeal userMeal) {
        userMeal = baseMapper.getByConditional(userMeal);
        if (userMeal != null) {
            if (CommonConstants.IS_PAY_SUCCESS.equals(userMeal.getIsPay()) && CommonConstants.YES.equals(userMeal.getStatus())) {
                if (CommonConstants.YES.equals(userMeal.getSetMeal().getMerchantStatus()))
                    return R.ok();
                return R.ok(MyReturnCode.ERR_10001.getCode(), MyReturnCode.ERR_10001.getMsg());
            }
        }
        return R.ok(MyReturnCode.ERR_10000.getCode(), MyReturnCode.ERR_10000.getMsg());
    }
//待付款提醒
	@Override
	public void obligation(UserMeal userMeal) {
    	baseMapper.updateById(userMeal);
		try {
//			商品名称 {{thing1.DATA}}
//			订单金额 {{amount5.DATA}}
//			下单时间 {{date2.DATA}}
//			支付提醒 {{thing6.DATA}}
//			温馨提示 {{thing7.DATA}}
			//    	根据用户Id 查出 商户信息
			MerchantSettled merchantSettled = merchantSettledMapper.selectOne(Wrappers.<MerchantSettled>lambdaQuery()
					.eq(MerchantSettled::getUserId, userMeal.getUserId()));
//		根据用户套餐Id 查  套餐信息
			SetMeal setMeal = setMealMapper.selectOne(Wrappers.<SetMeal>lambdaQuery()
					.eq(SetMeal::getId, userMeal.getSetMealId()));
			//		发布订阅待付款提醒
			WxTemplateMsgSendDTO wxTemplateMsgSendDTO = new WxTemplateMsgSendDTO();
			wxTemplateMsgSendDTO.setMallUserId(userMeal.getUserId());
			wxTemplateMsgSendDTO.setPage("pages/order/order-detail/index?id=" + userMeal.getId());
			wxTemplateMsgSendDTO.setUseType(ConfigConstant.WX_TMP_USE_TYPE_13);
			HashMap<String, HashMap<String, String>> data = new HashMap<>();
			data.put("thing1", (HashMap) JSONUtil.toBean("{\"value\": \"" + merchantSettled.getUserName() + "\"}", Map.class));
			//		根据用户套餐的支付状态 再做判断  0、未支付 1、已支付
			if (CommonConstants.IS_PAY_SUCCESS.equals(userMeal.getStatus())){
//					判断用户套餐的价格是不是 980  如果是需要补差价
				if (MallConstants.BASICS_MEAL==(setMeal.getPrice().intValue())){
					int price=(MallConstants.FLAGSHIP_MEAL-(MallConstants.BASICS_MEAL.intValue()));
					data.put("amount5",(HashMap)JSONUtil.toBean("{\"value\": \""+"￥"+price+ "\"}", Map.class));
					data.put("thing6",(HashMap)JSONUtil.toBean("{\"value\": \""+"请在18点前完成支付"+ "\"}", Map.class));
					data.put("thing7",(HashMap)JSONUtil.toBean("{\"value\": \""+"您有未支付订单！请尽快支付，逾期订单将自动取消。"+ "\"}", Map.class));
				}
			}
			else if (CommonConstants.IS_PAY_FAIL.equals(userMeal.getStatus())){
//					判断用户套餐价格是 3980
				if (MallConstants.FLAGSHIP_MEAL==(setMeal.getPrice().intValue())){
					data.put("amount5",(HashMap)JSONUtil.toBean("{\"value\": \""+"￥"+MallConstants.FLAGSHIP_MEAL+ "\"}", Map.class));
					data.put("thing6",(HashMap)JSONUtil.toBean("{\"value\": \""+"请在18点前完成支付"+ "\"}", Map.class));
					data.put("thing7",(HashMap)JSONUtil.toBean("{\"value\": \""+"您有未支付订单！请尽快支付，逾期订单将自动取消。"+ "\"}", Map.class));
				}
//					判断用户套餐价格是59800
				else if (MallConstants.CITY_PARTNER==(setMeal.getPrice().intValue())){
					data.put("amount5",(HashMap)JSONUtil.toBean("{\"value\": \""+"￥"+MallConstants.CITY_PARTNER+ "\"}", Map.class));
					data.put("thing6",(HashMap)JSONUtil.toBean("{\"value\": \""+"请在18点前完成支付"+ "\"}", Map.class));
					data.put("thing7",(HashMap)JSONUtil.toBean("{\"value\": \""+"您有未支付订单！请尽快支付，逾期订单将自动取消。"+ "\"}", Map.class));
				}
			}
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			data.put("date3", (HashMap) JSONUtil.toBean("{\"value\": \"" + dtf.format(userMeal.getCreateTime()) + "\"}", Map.class));
			wxTemplateMsgSendDTO.setData(data);
			feignWxTemplateMsgService.sendTemplateMsg(wxTemplateMsgSendDTO, SecurityConstants.FROM_IN);
		} catch (Exception e) {
			log.error("提现失败: " + e.getMessage(), e);
		}
	}

}
