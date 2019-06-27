package com.joolun.cloud.weixin.mp.service;

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
