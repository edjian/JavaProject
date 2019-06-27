package com.joolun.cloud.weixin.mp.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.weixin.common.entity.WxApp;
import com.joolun.cloud.weixin.mp.mapper.WxAppMapper;
import com.joolun.cloud.weixin.mp.service.WxAppService;
import org.springframework.stereotype.Service;

/**
 * 微信应用
 *
 * @author JL
 * @date 2019-03-15 10:26:44
 */
@Service
public class WxAppServiceImpl extends ServiceImpl<WxAppMapper, WxApp> implements WxAppService {

	/**
	 * 微信原始标识查找
	 * @param weixinSign
	 * @return
	 */
	@Override
	public WxApp findByWeixinSign(String weixinSign){
		return baseMapper.selectOne(Wrappers.query(new WxApp()).eq("weixin_sign",weixinSign));
	}
}
