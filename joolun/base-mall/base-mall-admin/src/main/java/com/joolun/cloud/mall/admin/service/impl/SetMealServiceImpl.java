/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.mall.common.entity.SetMeal;
import com.joolun.cloud.mall.admin.mapper.SetMealMapper;
import com.joolun.cloud.mall.admin.service.SetMealService;
import org.springframework.stereotype.Service;

/**
 * 套餐
 *
 * @author zq
 * @date 2020-07-08 13:53:21
 */
@Service
public class SetMealServiceImpl extends ServiceImpl<SetMealMapper, SetMeal> implements SetMealService {

    @Override
    public Object getSetMealList(QueryWrapper queryWrapper) {
        return baseMapper.selectList(queryWrapper);
    }
}
