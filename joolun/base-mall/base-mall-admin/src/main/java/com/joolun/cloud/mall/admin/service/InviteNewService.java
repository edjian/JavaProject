/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.joolun.cloud.mall.common.entity.InviteNew;
import com.joolun.cloud.mall.common.entity.OrderInfo;
import com.joolun.cloud.mall.common.entity.UserInfo;
import com.joolun.cloud.mall.common.entity.UserMeal;

import java.util.List;
import java.util.Map;

/**
 * 邀新表
 *
 * @author zq
 * @date 2020-07-09 15:06:47
 */
public interface InviteNewService extends IService<InviteNew> {

    IPage<InviteNew> page1(IPage<InviteNew> page, InviteNew inviteNew);

    Map<String,Object> myInviteNew(InviteNew inviteNew);

    JSONObject successMyInviteNew();

    List<UserInfo> myInviteNewDetail(String level, IPage<InviteNew> page);
}
