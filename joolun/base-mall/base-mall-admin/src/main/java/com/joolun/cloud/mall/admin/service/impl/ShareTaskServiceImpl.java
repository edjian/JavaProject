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
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.mall.admin.mapper.*;
import com.joolun.cloud.mall.admin.service.ShareTaskService;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.*;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 分享任务表
 *
 * @author zq
 * @date 2020-07-09 15:36:56
 */
@Slf4j
@Service
@AllArgsConstructor
public class ShareTaskServiceImpl extends ServiceImpl<ShareTaskMapper, ShareTask> implements ShareTaskService {

    private final PointsRecordMapper pointsRecordMapper;
    private final UserInfoMapper userInfoMapper;
    private final UserMealMapper userMealMapper;
    private final SetMealMapper setMealMapper;
    private final InviteNewMapper inviteNewMapper;
    private final ShareRecordMapper shareRecordMapper;

    @Override
    public IPage<ShareTask> page1(IPage<ShareTask> page, ShareTask shareTask) {
        return baseMapper.selectPage1(page, shareTask);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void shareCallback() {
        UserInfo userInfo = userInfoMapper.selectById(ThirdSessionHolder.getMallUserId());
        UserMeal userMeal = userMealMapper.selectOne(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getUserId, ThirdSessionHolder.getMallUserId())
                .eq(UserMeal::getStatus, MallConstants.UNDER_WAY)
                .eq(UserMeal::getAccountStatus, CommonConstants.YES));
        userMeal = userMeal != null ? userMeal : userMealMapper.selectOne(Wrappers.<UserMeal>lambdaQuery()
                .eq(UserMeal::getUserId, ThirdSessionHolder.getMallUserId())
                .eq(UserMeal::getStatus, MallConstants.UNDER_WAY)
                .eq(UserMeal::getAccountStatus, CommonConstants.NO));
//        InviteNew inviteNew = inviteNewMapper.selectOne(Wrappers.<InviteNew>lambdaQuery()
//                .eq(InviteNew::getUserId, userInfo.getId())
//                .eq(InviteNew::getStatus, CommonConstants.YES));

        if (userMeal != null) {
            SetMeal setMeal = setMealMapper.selectOne(Wrappers.<SetMeal>lambdaQuery().eq(SetMeal::getId, userMeal.getSetMealId()));
            if (setMeal.getPrice().compareTo(new BigDecimal(MallConstants.CITY_PARTNER)) != 0) {
                userInfo.setPointsCurrent(userInfo.getPointsCurrent() + setMeal.getSharePoint() / 2);
                userInfo.setPointsWithdraw(userInfo.getPointsWithdraw() + setMeal.getSharePoint() / 2);
                userInfoMapper.updateById(userInfo);
                PointsRecord pointsRecord = new PointsRecord();
                pointsRecord.setAmount(setMeal.getSharePoint());
                pointsRecord.setCreateTime(LocalDateTime.now());
                pointsRecord.setUserId(ThirdSessionHolder.getMallUserId());
                pointsRecord.setDescription(MallConstants.DAILY_TASKS);
                pointsRecord.setRecordType(MallConstants.POINTS_RECORD_TYPE_9);
                pointsRecordMapper.insert(pointsRecord);
                //邀请人套餐
                if (StringUtils.isNotEmpty(userMeal.getCityPartner())) {
                    UserMeal userMeal1 = userMealMapper.selectUserMealByInviteNew(userMeal.getCityPartner());
                    UserInfo userInfo1 = userInfoMapper.selectById(userMeal.getCityPartner());
                    if (userMeal1 != null && MallConstants.CITY_PARTNER.equals(userMeal1.getSetMeal().getPrice().intValue())) {
                        int amount = new BigDecimal(setMeal.getSharePoint()).multiply(MallConstants.CITY_PARTNER_SHARE).intValue();
                        userInfo1.setPointsWithdraw(userInfo1.getPointsWithdraw() + amount);
                        userInfoMapper.updateById(userInfo1);
                        PointsRecord pointsRecord1 = new PointsRecord();
                        pointsRecord1.setAmount(amount);
                        pointsRecord1.setCreateTime(LocalDateTime.now());
                        pointsRecord1.setUserId(userInfo1.getId());
                        pointsRecord1.setDescription(MallConstants.DAILY_TASKS);
                        pointsRecord1.setRecordType(MallConstants.POINTS_RECORD_TYPE_9);
                        pointsRecordMapper.insert(pointsRecord1);
                    }
                }
            }
        }
    }

    @Override
    public boolean completeTask() {
        return MallConstants.SHARE_COUNT.equals(shareRecordMapper.selectCount(Wrappers.<ShareRecord>lambdaQuery()
                .eq(ShareRecord::getUserId, ThirdSessionHolder.getMallUserId())
                .between(ShareRecord::getCreateTime, LocalDate.now().atTime(LocalTime.MIN), LocalDate.now().atTime(LocalTime.MAX))));
    }
}
