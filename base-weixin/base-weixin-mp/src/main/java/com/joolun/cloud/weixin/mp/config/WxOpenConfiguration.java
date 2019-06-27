package com.joolun.cloud.weixin.mp.config;

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
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.mp.constant.WxMpEventConstants;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.api.impl.WxOpenMessageRouter;
import me.chanjar.weixin.open.api.impl.WxOpenServiceImpl;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;

import javax.annotation.PostConstruct;

/**
 * 第三方平台Configuration
 * @author JL
 *
 */
@Slf4j
@Configuration
public class WxOpenConfiguration {
	private static WxOpenMessageRouter newRouter;
	private static WxOpenService wxOpenService;

	public static WxOpenService getOpenService(){
		return wxOpenService;
	}

	private static RedisTemplate redisTemplate;
	private static WxComponentConfigProperties wxComponentConfigProperties;
	public WxOpenConfiguration(RedisTemplate baseRedisTemplate,WxComponentConfigProperties wxComponentConfigProperties){
		this.redisTemplate = baseRedisTemplate;
		this.wxComponentConfigProperties = wxComponentConfigProperties;
	}
	@PostConstruct
	public void init() {
		wxOpenService = new WxOpenServiceImpl();
		WxOpenInRedisConfigStorage wxOpenInRedisConfigStorage = new WxOpenInRedisConfigStorage(redisTemplate);
		wxOpenInRedisConfigStorage.setComponentAppId(wxComponentConfigProperties.getAppId());
		wxOpenInRedisConfigStorage.setComponentAppSecret(wxComponentConfigProperties.getAppSecret());
		wxOpenInRedisConfigStorage.setComponentToken(wxComponentConfigProperties.getToken());
		wxOpenInRedisConfigStorage.setComponentAesKey(wxComponentConfigProperties.getAesKey());

		wxOpenService.setWxOpenConfigStorage(wxOpenInRedisConfigStorage);
		newRouter = new WxOpenMessageRouter(wxOpenService);
		newRouter.rule().handler(new LogHandler()).next();
		// 接收客服会话管理事件
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxMpEventConstants.CustomerService.KF_CREATE_SESSION)
				.handler(new KfSessionHandler()).end();
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxMpEventConstants.CustomerService.KF_CLOSE_SESSION)
				.handler(new KfSessionHandler())
				.end();
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxMpEventConstants.CustomerService.KF_SWITCH_SESSION)
				.handler(new KfSessionHandler()).end();

		// 门店审核事件
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxMpEventConstants.POI_CHECK_NOTIFY)
				.handler(new StoreCheckNotifyHandler()).end();

		// 自定义菜单事件
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxConsts.MenuButtonType.CLICK).handler(new MenuHandler()).end();

		// 点击菜单连接事件
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxConsts.MenuButtonType.VIEW).handler(new MenuHandler()).end();

		// 扫码事件
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxConsts.EventType.SCANCODE_WAITMSG).handler(new MenuHandler()).end();

		// 关注事件
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxConsts.EventType.SUBSCRIBE).handler(new SubscribeHandler())
				.end();

		// 取消关注事件
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxConsts.EventType.UNSUBSCRIBE)
				.handler(new UnSubscribeHandler()).end();

		// 上报地理位置事件
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxConsts.EventType.LOCATION).handler(new LocationHandler())
				.end();

		// 卡券领取事件
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxConsts.EventType.CARD_USER_GET_CARD).handler(new UserGetCardHandler()).end();

		// 卡券删除事件
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxConsts.EventType.CARD_USER_DEL_CARD).handler(new UserDelCardHandler()).end();

		// 卡券激活事件
		newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
				.event(WxConsts.EventType.CARD_SUBMIT_MEMBERCARD_USER_INFO).handler(new UserActivateCardHandler()).end();

		// 默认
		newRouter.rule().async(false).handler(new MsgHandler()).end();
	}
	public static WxOpenMessageRouter getWxOpenMessageRouter(){
		return newRouter;
	}
}
