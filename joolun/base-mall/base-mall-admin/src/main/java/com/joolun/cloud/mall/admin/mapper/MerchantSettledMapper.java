/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.joolun.cloud.mall.common.entity.MerchantSettled;
import org.apache.ibatis.annotations.Param;

/**
 * 商城入驻信息表
 *
 * @author zq
 * @date 2020-07-16 13:10:38
 */
public interface MerchantSettledMapper extends BaseMapper<MerchantSettled> {

    Integer selectStep(@Param("query") MerchantSettled merchantSettled);
}
