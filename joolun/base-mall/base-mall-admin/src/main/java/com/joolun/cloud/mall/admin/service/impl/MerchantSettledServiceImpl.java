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
import com.joolun.cloud.mall.admin.mapper.MerchantSettledMapper;
import com.joolun.cloud.mall.admin.service.MerchantSettledService;
import com.joolun.cloud.mall.common.entity.MerchantSettled;
import org.springframework.stereotype.Service;

/**
 * 商城入驻信息表
 *
 * @author zq
 * @date 2020-07-16 13:10:38
 */
@Service
public class MerchantSettledServiceImpl extends ServiceImpl<MerchantSettledMapper, MerchantSettled> implements MerchantSettledService {

    @Override
    public Integer getStep(MerchantSettled merchantSettled) {
        return baseMapper.selectStep(merchantSettled);
    }
}
