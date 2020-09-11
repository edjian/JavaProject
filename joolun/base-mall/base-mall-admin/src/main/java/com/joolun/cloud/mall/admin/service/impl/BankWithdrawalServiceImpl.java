/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.mall.admin.mapper.PointsRecordMapper;
import com.joolun.cloud.mall.admin.mapper.UserInfoMapper;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.BankWithdrawal;
import com.joolun.cloud.mall.admin.mapper.BankWithdrawalMapper;
import com.joolun.cloud.mall.admin.service.BankWithdrawalService;
import com.joolun.cloud.mall.common.entity.PointsRecord;
import com.joolun.cloud.mall.common.entity.UserInfo;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

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

    @Override
    @Transactional
    public boolean save1(BankWithdrawal bankWithdrawal) {
        bankWithdrawal.setUserId(ThirdSessionHolder.getMallUserId());
        UserInfo userInfo = userInfoMapper.selectById(ThirdSessionHolder.getMallUserId());
        int balance=userInfo.getPointsWithdraw()-bankWithdrawal.getSum().multiply(new BigDecimal(100)).intValue();
        if(balance<0)
            throw new RuntimeException("提现金额不足");
        userInfo.setPointsWithdraw(balance);
        userInfoMapper.updateById(userInfo);
        PointsRecord pointsRecord = new PointsRecord();
        pointsRecord.setAmount(-bankWithdrawal.getSum().multiply(new BigDecimal(100)).intValue());
        pointsRecord.setDescription("提现积分");
        pointsRecord.setUserId(ThirdSessionHolder.getMallUserId());
        pointsRecord.setRecordType(MallConstants.POINTS_RECORD_TYPE_10);
        pointsRecordMapper.insert(pointsRecord);
        return baseMapper.insert(bankWithdrawal) == 1;
    }
}
