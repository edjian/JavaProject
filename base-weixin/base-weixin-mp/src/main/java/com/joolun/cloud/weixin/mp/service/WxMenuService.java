package com.joolun.cloud.weixin.mp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.joolun.cloud.weixin.mp.entity.WxMenu;
import me.chanjar.weixin.common.error.WxErrorException;

/**
 * 自定义菜单
 *
 * @author JL
 * @date 2019-03-27 16:52:10
 */
public interface WxMenuService extends IService<WxMenu> {

	/***
	 * 获取WxApp下的菜单
	 * @param appId
	 * @return
	 */
	String getWxMenuButton(String appId);

	/**
	 * 保存并发布菜单
	 * @param
	 */
	void saveAndRelease(String appId , String strWxMenu) throws WxErrorException;
}
