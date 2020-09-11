/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.joolun.cloud.mall.common.entity.InviteNew;
import com.joolun.cloud.mall.common.entity.UserInfo;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;

/**
 * 商城用户
 *
 * @author JL
 * @date 2019-12-04 11:09:55
 */
public interface UserInfoMapper extends BaseMapper<UserInfo> {

    UserInfo getUserMeal(Serializable id);

    /**
     * 我的邀请用户信息
     * @return
     */
    UserInfo selectUserInfoByInviteNew(@Param("query")UserInfo userInfo);
}
