/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码，并且可以商用（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.wxmp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.joolun.cloud.weixin.common.entity.WxApp;

/**
 * 微信应用
 *
 * @author JL
 * @date 2019-03-15 10:26:44
 */
public interface WxAppService extends IService<WxApp> {

	/**
	 * 微信原始标识查找
	 * @param weixinSign
	 * @return
	 */
	WxApp findByWeixinSign(String weixinSign);
}
