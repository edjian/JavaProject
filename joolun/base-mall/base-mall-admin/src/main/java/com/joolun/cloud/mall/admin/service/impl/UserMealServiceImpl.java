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
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.mapper.*;
import com.joolun.cloud.mall.admin.service.InviteNewService;
import com.joolun.cloud.mall.admin.service.PointsRecordService;
import com.joolun.cloud.mall.admin.service.UserInfoService;
import com.joolun.cloud.mall.admin.service.UserMealService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.constant.MyReturnCode;
import com.joolun.cloud.mall.common.entity.*;
import com.joolun.cloud.mall.common.util.StringUtil;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;

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
                userMeal.setEndTime(userMeal.getCreateTime().plusDays(MallConstants.MINE_UPGRADE_TIME));
                userMeal.setInviteDay(MallConstants.MINE_UPGRADE_TIME);
                userInfo.setPointsCurrent(userMeal.getSurplusPoint() / 2);
                userInfo.setPointsWithdraw(userMeal.getSurplusPoint() / 2);

                //邀新成功后一级邀请人信息
                if (StringUtils.isNotBlank(existInviteNew.getUserIdFirst())) {
                    UserInfo upgradeUserInfoFirst = userInfoMapper.getUserMeal(existInviteNew.getUserIdFirst());//升级套餐一级用户信息
                    if (upgradeUserInfoFirst != null) {

                        if (MallConstants.FLAGSHIP_MEAL.equals(upgradeUserInfoFirst.getUserMeal().getSetMeal().getPrice().intValue())) {
                            upgradeUserInfoFirst.getUserMeal().setEndTime(upgradeUserInfoFirst.getUserMeal().getEndTime().plusDays(MallConstants.FLAGSHIP_INVITE_BASIC_UPGRADE_TIME));
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
            } else {
                InviteNew inviteNew = inviteNewMapper.selectOne(Wrappers.<InviteNew>lambdaQuery()
                        .eq(InviteNew::getUserId, userMeal.getUserId())
                        .eq(StringUtils.isNotEmpty(inviteUserId),InviteNew::getUserIdFirst,inviteUserId));
                if (inviteNew != null) {
                    inviteNew.setStatus(CommonConstants.YES);
                    inviteNewMapper.update(inviteNew, Wrappers.<InviteNew>lambdaUpdate().eq(InviteNew::getId,inviteNew.getId()));

                    UserInfo userInfo = userInfoMapper.getUserMeal(inviteNew.getUserId());

                    //邀新成功后一级邀请人信息
                    if(StringUtils.isNotEmpty(inviteUserId)){
                        UserInfo userInfoFirst = userInfoMapper.getUserMeal(inviteUserId);
                        if (userInfoFirst != null) {
                            BigDecimal firstPoint = BigDecimal.ZERO;

                            if(MallConstants.CITY_PARTNER.equals(userInfo.getUserMeal().getSetMeal().getPrice().intValue())){
                                if(MallConstants.CITY_PARTNER.equals(userInfoFirst.getUserMeal().getSetMeal().getPrice().intValue())){
                                    firstPoint = MallConstants.SET_MEAL_59800.multiply(new BigDecimal(MallConstants.CITY_PARTNER)).multiply(new BigDecimal(100)).divide(new BigDecimal(2));
                                }else if(MallConstants.FLAGSHIP_MEAL.equals(userInfoFirst.getUserMeal().getSetMeal().getPrice().intValue())){
                                    firstPoint = MallConstants.SET_MEAL_3980.multiply(new BigDecimal(MallConstants.CITY_PARTNER)).multiply(new BigDecimal(100)).divide(new BigDecimal(2));
                                }else{
                                    firstPoint = MallConstants.SET_MEAL_980.multiply(new BigDecimal(MallConstants.CITY_PARTNER)).multiply(new BigDecimal(100)).divide(new BigDecimal(2));
                                }
                                userInfoFirst.setPointsWithdraw(userInfoFirst.getPointsWithdraw() + firstPoint.intValue()*2);
                            }else{
                                if (userInfoFirst.getUserMeal().getSetMeal().getPrice().compareTo(userInfo.getUserMeal().getSetMeal().getPrice()) >= 0) {
                                    firstPoint = userInfo.getUserMeal().getSetMeal().getPrice().multiply(new BigDecimal(userInfo.getUserMeal().getSetMeal().getInviteRebateFirst()).divide(new BigDecimal(100)).multiply(new BigDecimal(100)).divide(new BigDecimal(2)));
                                    if (MallConstants.BASICS_MEAL.equals(userInfoFirst.getUserMeal().getSetMeal().getPrice().intValue())) {
                                        userInfoFirst.getUserMeal().setEndTime(userInfoFirst.getUserMeal().getEndTime().plusDays(MallConstants.DEFAULT_INVITE_TIME));
                                    } else if (MallConstants.FLAGSHIP_MEAL.equals(userInfoFirst.getUserMeal().getSetMeal().getPrice().intValue())) {
                                        userInfoFirst.getUserMeal().setEndTime(userInfoFirst.getUserMeal().getEndTime().plusDays(MallConstants.FLAGSHIP_INVITE_BASIC_TIME));
                                    }
                                } else {
                                    firstPoint = userInfoFirst.getUserMeal().getSetMeal().getPrice().multiply(new BigDecimal(userInfoFirst.getUserMeal().getSetMeal().getInviteRebateFirst()).divide(new BigDecimal(100)).multiply(new BigDecimal(100)).divide(new BigDecimal(2)));
                                    BigDecimal balanceFirst = new BigDecimal(MallConstants.FLAGSHIP_MEAL - MallConstants.BASICS_MEAL);
                                    userInfoFirst.getUserMeal().setSurplusPoint(balanceFirst.multiply(new BigDecimal(userInfoFirst.getUserMeal().getSetMeal().getInviteRebateFirst()).divide(new BigDecimal(100)).multiply(new BigDecimal(100)).divide(new BigDecimal(2))).intValue());
                                    userInfoFirst.getUserMeal().setEndTime(userInfoFirst.getUserMeal().getEndTime().plusDays(MallConstants.DEFAULT_INVITE_TIME));
                                }
                                userInfoFirst.setPointsCurrent(userInfoFirst.getPointsCurrent() + firstPoint.intValue());
                                userInfoFirst.setPointsWithdraw(userInfoFirst.getPointsWithdraw() + firstPoint.intValue());
                            }

                            userInfoMapper.update(userInfoFirst, Wrappers.<UserInfo>lambdaUpdate().eq(UserInfo::getId, userInfoFirst.getId()));
                            userMealMapper.update(userInfoFirst.getUserMeal(), Wrappers.<UserMeal>lambdaUpdate().eq(UserMeal::getId, userInfoFirst.getUserMeal().getId()));
                            //邀新一级积分记录
                            PointsRecord pointsRecord = new PointsRecord();
                            pointsRecord.setUserId(userInfoFirst.getId());
                            pointsRecord.setAmount(firstPoint.intValue()*2);
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
                                if(!MallConstants.CITY_PARTNER.equals(userInfo.getUserMeal().getSetMeal().getPrice().intValue())){
                                    if (userInfoSecond.getUserMeal().getSetMeal().getPrice().compareTo(userInfoFirst.getUserMeal().getSetMeal().getPrice()) >= 0) {
                                        secondPoint = userInfo.getUserMeal().getSetMeal().getPrice().multiply(new BigDecimal(userInfo.getUserMeal().getSetMeal().getInviteRebateSecond()).divide(new BigDecimal(100)).multiply(new BigDecimal(100)).divide(new BigDecimal(2)));
                                    } else {
                                        secondPoint = userInfoSecond.getUserMeal().getSetMeal().getPrice().multiply(new BigDecimal(userInfoSecond.getUserMeal().getSetMeal().getInviteRebateSecond()).divide(new BigDecimal(100)).multiply(new BigDecimal(100)).divide(new BigDecimal(2)));
                                        BigDecimal balanceSecond = new BigDecimal(MallConstants.FLAGSHIP_MEAL - MallConstants.BASICS_MEAL);
                                        userInfoSecond.getUserMeal().setSurplusPoint(balanceSecond.multiply(new BigDecimal(userInfoSecond.getUserMeal().getSetMeal().getInviteRebateSecond()).divide(new BigDecimal(100)).multiply(new BigDecimal(100)).divide(new BigDecimal(2))).intValue());
                                    }
                                    userInfoSecond.setPointsCurrent(userInfoSecond.getPointsCurrent() + secondPoint.intValue());
                                    userInfoSecond.setPointsWithdraw(userInfoSecond.getPointsWithdraw() + secondPoint.intValue());
                                    userInfoMapper.update(userInfoSecond, Wrappers.<UserInfo>lambdaUpdate().eq(UserInfo::getId, userInfoSecond.getId()));
                                    userMealMapper.update(userInfoSecond.getUserMeal(), Wrappers.<UserMeal>lambdaUpdate().eq(UserMeal::getId, userInfoSecond.getUserMeal().getId()));
                                    //邀新二级积分记录
                                    PointsRecord pointsRecord2 = new PointsRecord();
                                    pointsRecord2.setUserId(userInfoSecond.getId());
                                    pointsRecord2.setAmount(secondPoint.intValue()*2);
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

}
