/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.admin.mapper.UserMealMapper;
import com.joolun.cloud.mall.admin.service.*;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.dto.WxOpenDataDTO;
import com.joolun.cloud.mall.common.entity.*;
import com.joolun.cloud.mall.admin.mapper.UserInfoMapper;
import com.joolun.cloud.mall.common.feign.FeignWxUserService;
import com.joolun.cloud.weixin.common.entity.WxUser;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import lombok.AllArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商城用户
 *
 * @author JL
 * @date 2019-12-04 11:09:55
 */
@Service
@AllArgsConstructor
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements UserInfoService {

    private final FeignWxUserService feignWxUserService;
    private final PointsConfigService pointsConfigService;
    private final PointsRecordService pointsRecordService;
    private final InviteNewService inviteNewService;
    private final UserMealMapper userMealMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public R saveByWxUser(WxOpenDataDTO wxOpenDataDTO) {
        //修改微信用户信息
        R<WxUser> r = feignWxUserService.save(wxOpenDataDTO, SecurityConstants.FROM_IN);
        if (!r.isOk()) {
            throw new RuntimeException(r.getMsg());
        }
        //修改商城用户信息
        WxUser wxUser = r.getData();
        if (wxUser != null && StrUtil.isNotBlank(wxUser.getMallUserId())) {
            UserInfo userInfo = baseMapper.selectById(wxUser.getMallUserId());
            userInfo.setNickName(wxUser.getNickName());
            userInfo.setHeadimgUrl(wxUser.getHeadimgUrl());
            userInfo.setSex(wxUser.getSex());
            userInfo.setCity(wxUser.getCity());
            userInfo.setCountry(wxUser.getCountry());
            userInfo.setProvince(wxUser.getProvince());
            if (MallConstants.USER_GRADE_0.equals(userInfo.getUserGrade())) {
                userInfo.setUserGrade(MallConstants.USER_GRADE_1);//1：普通会员
                //获取会员初始积分
//                PointsConfig pointsConfig = pointsConfigService.getOne(Wrappers.emptyWrapper());
//                int initVipPosts = pointsConfig != null ? pointsConfig.getInitVipPosts() : 0;
//                userInfo.setPointsCurrent(userInfo.getPointsCurrent() + initVipPosts);
//                if (initVipPosts > 0) {
//                    //新增积分变动记录
//                    PointsRecord pointsRecord = new PointsRecord();
//                    pointsRecord.setUserId(userInfo.getId());
//                    pointsRecord.setAmount(initVipPosts);
//                    pointsRecord.setRecordType(MallConstants.POINTS_RECORD_TYPE_1);
//                    pointsRecord.setDescription("会员初始积分");
//                    pointsRecordService.save(pointsRecord);
//                }
            }
            baseMapper.updateById(userInfo);

            InviteNew existInviteNew = inviteNewService.getOne(Wrappers.<InviteNew>lambdaQuery()
                    .eq(InviteNew::getUserId, wxUser.getMallUserId())
                    .eq(!StringUtils.isEmpty(wxOpenDataDTO.getInviteUserId()),InviteNew::getUserIdFirst, wxOpenDataDTO.getInviteUserId()));
            if (existInviteNew == null) {
                InviteNew inviteNew = new InviteNew();
                inviteNew.setUserId(wxUser.getMallUserId());
                if (wxUser.getMallUserId() != wxOpenDataDTO.getInviteUserId())
                    inviteNew.setUserIdFirst(wxOpenDataDTO.getInviteUserId());
                inviteNew.setCreateTime(LocalDateTime.now());
                //二级邀请人
                InviteNew inviteSecond = inviteNewService.getOne(Wrappers.<InviteNew>lambdaQuery()
                        .eq(InviteNew::getUserId, wxOpenDataDTO.getInviteUserId())
                        .eq(InviteNew::getStatus, CommonConstants.YES));
                if (inviteSecond != null) {
                    inviteNew.setUserIdSecond(inviteSecond.getUserIdFirst());
                }
                inviteNewService.save(inviteNew);
            }
        }
        return r;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean saveInside(UserInfo userInfo) {
        //获取用户初始积分
//        PointsConfig pointsConfig = pointsConfigService.getOne(Wrappers.emptyWrapper());
//        int initPosts = pointsConfig != null ? pointsConfig.getInitPosts() : 0;
        //新增商城用户
        userInfo.setUserGrade(MallConstants.USER_GRADE_0);
//        userInfo.setPointsCurrent(initPosts);
        baseMapper.insert(userInfo);
//        if (initPosts > 0) {
//            //新增积分变动记录
//            PointsRecord pointsRecord = new PointsRecord();
//            pointsRecord.setUserId(userInfo.getId());
//            pointsRecord.setAmount(initPosts);
//            pointsRecord.setRecordType(MallConstants.POINTS_RECORD_TYPE_0);
//            pointsRecord.setDescription("用户初始积分");
//            pointsRecordService.save(pointsRecord);
//        }
        return Boolean.TRUE;
    }

    @Override
    public UserInfo getUserMeal(Serializable id) {
        return baseMapper.getUserMeal(id);
    }

    @Override
    public R assets() {
        List<String> list = new ArrayList<>();
        list.add(MallConstants.POINTS_RECORD_TYPE_2);
        list.add(MallConstants.POINTS_RECORD_TYPE_7);
        list.add(MallConstants.POINTS_RECORD_TYPE_8);
        list.add(MallConstants.POINTS_RECORD_TYPE_9);
//        PointsConfig pointsConfig = pointsConfigService.getOne(Wrappers.emptyWrapper());

        Map<String, Object> map = new HashMap<>();
        map.put("amount", 0);
        map.put("withdrawal", 0);
        map.put("profitToday", 0);

        UserInfo userInfo = baseMapper.selectById(ThirdSessionHolder.getMallUserId());

        if(userInfo != null){
            int amount = userInfo.getPointsCurrent() + userInfo.getPointsWithdraw();
            map.put("amount", amount);
            map.put("withdrawal", userInfo.getPointsWithdraw());
            List<PointsRecord> pointsRecords = pointsRecordService.profitByToday(ThirdSessionHolder.getMallUserId(),list);
            int profitToday = pointsRecords.stream().filter(pointsRecord ->
                    pointsRecordService.getOne(Wrappers.<PointsRecord>lambdaQuery()
                    .eq(PointsRecord::getOrderItemId, pointsRecord.getOrderItemId())
                    .eq(PointsRecord::getUserId, userInfo.getId())
                    .eq(PointsRecord::getRecordType, MallConstants.POINTS_RECORD_TYPE_3)
                    .between(PointsRecord::getCreateTime, LocalDate.now().atTime(LocalTime.MIN), LocalDate.now().atTime(LocalTime.MAX))) == null)
                    .mapToInt(pointsRecord -> pointsRecord.getAmount()).sum();
            map.put("profitToday",profitToday);
            //还有一个升级�的积分没算
            UserMeal userMeal = userMealMapper.selectUserMealByInviteNew(userInfo.getId());

            if(userMeal != null && MallConstants.BASICS_MEAL.equals(userMeal.getSetMeal().getPrice().intValue())){
                map.put("amount", amount + userMeal.getSurplusPoint());
                map.put("withdrawal", userInfo.getPointsWithdraw() + userMeal.getSurplusPoint());
                if(userMeal.getSurplusPoint() != 0){
                    map.put("surplusPoint", userMeal.getSurplusPoint());
                }
            }
        }
        return R.ok(map);
    }
}
