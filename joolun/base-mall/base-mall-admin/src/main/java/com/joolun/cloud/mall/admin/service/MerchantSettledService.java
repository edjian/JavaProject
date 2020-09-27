/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.joolun.cloud.mall.common.entity.GoodsSpu;
import com.joolun.cloud.mall.common.entity.MerchantSettled;

import java.util.List;
import java.util.Map;

/**
 * 商城入驻信息表
 *
 * @author zq
 * @date 2020-07-16 13:10:38
 */
public interface MerchantSettledService extends IService<MerchantSettled> {

    Integer getStep(MerchantSettled merchantSettled);
	/**
	 * 审核结果更改并通知
	 * @param merchantSettled
	 */
    boolean updateMerchantSettled(MerchantSettled merchantSettled);
	/**
	 * 商家基本信息查询
	 *
	 */
	List<MerchantSettled> getMerchants(IPage<GoodsSpu> page,MerchantSettled merchantSettled);




}
