/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.common.entity.UserInfo;
import com.joolun.cloud.mall.common.entity.UserMeal;

import java.io.Serializable;

/**
 * 用户套餐表
 *
 * @author zq
 * @date 2020-07-17 15:24:20
 */
public interface UserMealService extends IService<UserMeal> {

    UserMeal getByConditional(UserMeal UserMeal);

    UserMeal userMealSave(UserMeal userMeal,String inviteUserId);

    void notifyOrder(UserMeal userMeal, String inviteUserId);

    R getUserMealIsPay(UserMeal userMeal);

}
