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
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.mall.admin.mapper.PointsRecordMapper;
import com.joolun.cloud.mall.admin.mapper.UserInfoMapper;
import com.joolun.cloud.mall.admin.mapper.UserMealMapper;
import com.joolun.cloud.mall.common.constant.MallConstants;
import com.joolun.cloud.mall.common.entity.*;
import com.joolun.cloud.mall.admin.mapper.InviteNewMapper;
import com.joolun.cloud.mall.admin.service.InviteNewService;
import com.joolun.cloud.mall.common.feign.FeignWxTemplateMsgService;
import com.joolun.cloud.weixin.common.constant.ConfigConstant;
import com.joolun.cloud.weixin.common.dto.WxTemplateMsgSendDTO;
import com.joolun.cloud.weixin.common.util.ThirdSessionHolder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collector;
import java.util.stream.Collectors;

/**
 * 邀新表
 *
 * @author zq
 * @date 2020-07-09 15:06:47
 */
@Slf4j
@AllArgsConstructor
@Service
public class InviteNewServiceImpl extends ServiceImpl<InviteNewMapper, InviteNew> implements InviteNewService {

    private final PointsRecordMapper pointsRecordMapper;
    private final UserInfoMapper userInfoMapper;
	private final UserMealMapper userMealMapper;
	private final FeignWxTemplateMsgService feignWxTemplateMsgService;

    @Override
    public IPage<InviteNew> page1(IPage<InviteNew> page, InviteNew inviteNew) {
        return baseMapper.selectPage1(page, inviteNew);
    }

    @Override
    public Map<String, Object> myInviteNew(InviteNew inviteNew) {
		HashMap<String, Object> map = new HashMap<>();
        List<PointsRecord> pointsRecords = pointsRecordMapper.selectList(Wrappers.<PointsRecord>lambdaQuery()
                .in(PointsRecord::getRecordType, new String[]{MallConstants.POINTS_RECORD_TYPE_7, MallConstants.POINTS_RECORD_TYPE_8})
                .eq(PointsRecord::getUserId, ThirdSessionHolder.getMallUserId()));
        Integer sum = pointsRecords.stream().mapToInt((pointsRecord) -> pointsRecord.getAmount()).sum();
        Integer count = baseMapper.selectCount(Wrappers.<InviteNew>lambdaQuery()
                .eq(InviteNew::getUserIdFirst, ThirdSessionHolder.getMallUserId())
                .eq(InviteNew::getStatus, CommonConstants.YES));
        Integer failUserCount = baseMapper.selectCount(Wrappers.<InviteNew>lambdaQuery()
                .eq(InviteNew::getUserIdFirst, ThirdSessionHolder.getMallUserId())
                .eq(InviteNew::getStatus, CommonConstants.NO));
        map.put("sum", sum);
        map.put("count", count);
        map.put("failUserCount", failUserCount);
        return map;
    }

    @Override
    public JSONObject successMyInviteNew() {
        JSONObject jsonObject = new JSONObject();
        List<InviteNew> firstInviteNew = baseMapper.selectList(Wrappers.<InviteNew>lambdaQuery()
                .eq(InviteNew::getUserIdFirst, ThirdSessionHolder.getMallUserId())
                .eq(InviteNew::getStatus, CommonConstants.YES));
        List<InviteNew> secondInviteNew = baseMapper.selectList(Wrappers.<InviteNew>lambdaQuery()
                .eq(InviteNew::getUserIdSecond, ThirdSessionHolder.getMallUserId())
                .eq(InviteNew::getStatus, CommonConstants.YES));
        Integer firstCount = firstInviteNew.size();
        Integer secondCount = secondInviteNew.size();
        jsonObject.put("all", firstCount + secondCount);
        jsonObject.put("first", firstCount);
        jsonObject.put("second", secondCount);
		//发布订阅邀请成功通知消息
		try {
//					已邀请人数{{number1.DATA}}
//					邀请时间{{time2.DATA}}
//  				温馨提示{{thing3.DATA}}
			InviteNew inviteNew1 = baseMapper.selectById(Wrappers.<InviteNew>lambdaQuery().eq(InviteNew::getUserId,ThirdSessionHolder.getMallUserId()));
			WxTemplateMsgSendDTO wxTemplateMsgSendDTO = new WxTemplateMsgSendDTO();
			wxTemplateMsgSendDTO.setMallUserId(ThirdSessionHolder.getMallUserId());
			wxTemplateMsgSendDTO.setPage("pages/order/order-detail/index?id=" + inviteNew1.getId());
			wxTemplateMsgSendDTO.setUseType(ConfigConstant.WX_TMP_USE_TYPE_14);
			HashMap<String, HashMap<String, String>> data = new HashMap<>();
			data.put("number1", (HashMap) JSONUtil.toBean("{\"value\": \""+firstCount + secondCount + "\"}", Map.class));
			data.put("thing3",(HashMap)JSONUtil.toBean("{\"value\": \""+"注意查收" + "\"}", Map.class));
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss yyyy-MM-dd");
			data.put("date3",(HashMap)JSONUtil.toBean("{\"value\": \""+dtf.format(inviteNew1.getCreateTime()) + "\"}", Map.class));
			wxTemplateMsgSendDTO.setData(data);
			feignWxTemplateMsgService.sendTemplateMsg(wxTemplateMsgSendDTO, SecurityConstants.FROM_IN);
		}catch (Exception e){
			log.error("邀请失败: "+e.getMessage(),e);
		}
        return jsonObject;
    }

    @Override
    public List<UserInfo> myInviteNewDetail(String level, IPage<InviteNew> page) {
        IPage<InviteNew> inviteNewIPage = null;
        UserInfo userInfo = new UserInfo();
        if(MallConstants.MY_INVITE_STAT_FIRST.equals(level)){
            inviteNewIPage = baseMapper.selectPage(page,Wrappers.<InviteNew>lambdaQuery()
                    .eq(InviteNew::getUserIdFirst, ThirdSessionHolder.getMallUserId())
                    .eq(InviteNew::getStatus, CommonConstants.YES));
        }else if(MallConstants.MY_INVITE_STAT_SECOND.equals(level)){
            inviteNewIPage = baseMapper.selectPage(page,Wrappers.<InviteNew>lambdaQuery()
                    .eq(InviteNew::getUserIdSecond, ThirdSessionHolder.getMallUserId())
                    .eq(InviteNew::getStatus, CommonConstants.YES));
        }else if(MallConstants.MY_INVITE_STAT_ALL.equals(level)){
            inviteNewIPage = baseMapper.selectPage(page,Wrappers.<InviteNew>lambdaQuery()
                    .eq(InviteNew::getStatus, CommonConstants.YES)
                    .and(wrapper->
                        wrapper.eq(InviteNew::getUserIdSecond, ThirdSessionHolder.getMallUserId())
                                .or()
                                .eq(InviteNew::getUserIdFirst, ThirdSessionHolder.getMallUserId())
                    ));
        }
        return inviteNewIPage.getRecords().stream().map(inviteNew -> {
            userInfo.setId(inviteNew.getUserId());
            UserInfo userInfo1=userInfoMapper.selectUserInfoByInviteNew(userInfo);
            userInfo1.setInviteNew(inviteNew);
            return userInfo1;
        }).collect(Collectors.toList());
    }
}
