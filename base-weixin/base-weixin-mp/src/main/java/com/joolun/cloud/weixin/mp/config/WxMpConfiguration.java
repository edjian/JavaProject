package com.joolun.cloud.weixin.mp.config;

import java.util.Map;
import com.google.common.collect.Maps;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.weixin.common.entity.WxApp;
import com.joolun.cloud.weixin.mp.handler.KfSessionHandler;
import com.joolun.cloud.weixin.mp.handler.LocationHandler;
import com.joolun.cloud.weixin.mp.handler.LogHandler;
import com.joolun.cloud.weixin.mp.handler.MenuHandler;
import com.joolun.cloud.weixin.mp.handler.MsgHandler;
import com.joolun.cloud.weixin.mp.handler.StoreCheckNotifyHandler;
import com.joolun.cloud.weixin.mp.handler.SubscribeHandler;
import com.joolun.cloud.weixin.mp.handler.UnSubscribeHandler;
import com.joolun.cloud.weixin.mp.handler.UserActivateCardHandler;
import com.joolun.cloud.weixin.mp.handler.UserDelCardHandler;
import com.joolun.cloud.weixin.mp.handler.UserGetCardHandler;
import com.joolun.cloud.weixin.mp.service.WxAppService;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.api.WxConsts.EventType;
import me.chanjar.weixin.common.api.WxConsts.MenuButtonType;
import me.chanjar.weixin.common.api.WxConsts.XmlMsgType;
import me.chanjar.weixin.mp.api.WxMpMessageRouter;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.api.impl.WxMpServiceImpl;
import me.chanjar.weixin.mp.constant.WxMpEventConstants;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;

/**
 * 公众号Configuration
 * @author JL
 *
 */
@Slf4j
@Configuration
public class WxMpConfiguration {
	private static RedisTemplate redisTemplate;

	private static WxAppService wxAppService;
	/**
	 * 全局缓存WxMpService
	 */
	private static Map<String, WxMpService> mpServices = Maps.newHashMap();
	
	/**
	 * 全局缓存WxMpMessageRouter
	 */
	private static Map<String, WxMpMessageRouter> routers = Maps.newHashMap();
	public WxMpConfiguration(RedisTemplate baseRedisTemplate,
							 WxAppService wxAppService){
		this.redisTemplate = baseRedisTemplate;
		this.wxAppService = wxAppService;
	}
	/**
	 *  获取全局缓存WxMpService
	 * @param appId
	 * @return
	 */
	public static WxMpService getMpService(String appId) {
		WxMpService wxMpService = mpServices.get(appId);
        if(wxMpService == null) {
        	WxApp wxApp = wxAppService.getById(appId);
        	if(wxApp!=null) {
        		if(CommonConstants.YES.equals(wxApp.getIsComponent())){//第三方授权账号
					wxMpService = WxOpenConfiguration.getOpenService().getWxOpenComponentService().getWxMpServiceByAppid(appId);
					mpServices.put(appId, wxMpService);
					routers.put(appId, newRouter(wxMpService));
				}else{
					WxMpInRedisConfigStorage configStorage = new WxMpInRedisConfigStorage(redisTemplate);
					configStorage.setAppId(wxApp.getId());
					configStorage.setSecret(wxApp.getSecret());
					configStorage.setToken(wxApp.getToken());
					configStorage.setAesKey(wxApp.getAesKey());
					wxMpService = new WxMpServiceImpl();
					wxMpService.setWxMpConfigStorage(configStorage);
					mpServices.put(appId, wxMpService);
					routers.put(appId, newRouter(wxMpService));
				}
        	}
        }
		return wxMpService;
    }

	/**
	 * 获取WxMpService并缓存，会强制更新全局缓存
	 * @param wxApp
	 * @return
	 */
	public static WxMpService getMpService(WxApp wxApp) {
		WxMpInRedisConfigStorage configStorage = new WxMpInRedisConfigStorage(redisTemplate);
		configStorage.setAppId(wxApp.getId());
		configStorage.setSecret(wxApp.getSecret());
		configStorage.setToken(wxApp.getToken());
		configStorage.setAesKey(wxApp.getAesKey());
		WxMpService wxMpService = new WxMpServiceImpl();
		wxMpService.setWxMpConfigStorage(configStorage);
		mpServices.put(wxApp.getId(), wxMpService);
		routers.put(wxApp.getId(), newRouter(wxMpService));
		return wxMpService;
	}

	/**
	 *  获取全局缓存WxMpMessageRouter
	 * @param appId
	 * @return
	 */
	public static WxMpMessageRouter getWxMpMessageRouter(String appId) {
		WxMpMessageRouter wxMpMessageRouter = routers.get(appId);
		return wxMpMessageRouter;
    }
	
	private static WxMpMessageRouter newRouter(WxMpService wxMpService) {
        final WxMpMessageRouter newRouter = new WxMpMessageRouter(wxMpService);

        // 记录所有事件的日志 （异步执行）
        newRouter.rule().handler(new LogHandler()).next();

        // 接收客服会话管理事件
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(WxMpEventConstants.CustomerService.KF_CREATE_SESSION)
            .handler(new KfSessionHandler()).end();
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(WxMpEventConstants.CustomerService.KF_CLOSE_SESSION)
            .handler(new KfSessionHandler())
            .end();
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(WxMpEventConstants.CustomerService.KF_SWITCH_SESSION)
            .handler(new KfSessionHandler()).end();

        // 门店审核事件
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(WxMpEventConstants.POI_CHECK_NOTIFY)
            .handler(new StoreCheckNotifyHandler()).end();

        // 自定义菜单事件
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(MenuButtonType.CLICK).handler(new MenuHandler()).end();

        // 点击菜单连接事件
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(MenuButtonType.VIEW).handler(new MenuHandler()).end();

		// 扫码事件
		newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
				.event(EventType.SCANCODE_WAITMSG).handler(new MenuHandler()).end();

        // 关注事件
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(EventType.SUBSCRIBE).handler(new SubscribeHandler())
            .end();

        // 取消关注事件
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(EventType.UNSUBSCRIBE)
            .handler(new UnSubscribeHandler()).end();

        // 上报地理位置事件
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(EventType.LOCATION).handler(new LocationHandler())
            .end();
        
        // 卡券领取事件
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(EventType.CARD_USER_GET_CARD).handler(new UserGetCardHandler()).end();
        
        // 卡券删除事件
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(EventType.CARD_USER_DEL_CARD).handler(new UserDelCardHandler()).end();
        
        // 卡券激活事件
        newRouter.rule().async(false).msgType(XmlMsgType.EVENT)
            .event(EventType.CARD_SUBMIT_MEMBERCARD_USER_INFO).handler(new UserActivateCardHandler()).end();

        // 默认
        newRouter.rule().async(false).handler(new MsgHandler()).end();

        return newRouter;
    }
}
