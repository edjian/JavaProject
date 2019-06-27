package com.joolun.cloud.weixin.mp.handler;

import com.alibaba.fastjson.JSONObject;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.util.SpringContextHolder;
import com.joolun.cloud.weixin.common.constant.ConfigConstant;
import com.joolun.cloud.weixin.mp.entity.WxMenu;
import com.joolun.cloud.weixin.mp.entity.WxMsg;
import com.joolun.cloud.weixin.mp.constant.WebSocketConstant;
import com.joolun.cloud.weixin.common.entity.WxApp;
import com.joolun.cloud.weixin.common.entity.WxUser;
import com.joolun.cloud.weixin.mp.service.WxAppService;
import com.joolun.cloud.weixin.mp.service.WxMenuService;
import com.joolun.cloud.weixin.mp.service.WxMsgService;
import com.joolun.cloud.weixin.mp.service.WxUserService;
import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.common.session.WxSessionManager;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutNewsMessage;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import me.chanjar.weixin.mp.builder.outxml.*;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 自定义菜单处理
 * @author JL
 */
@Component
public class MenuHandler extends AbstractHandler {

    @Override
    public WxMpXmlOutMessage handle(WxMpXmlMessage wxMessage,
                                    Map<String, Object> context, WxMpService weixinService,
                                    WxSessionManager sessionManager) throws WxErrorException {
		WxMenuService wxMenuService = SpringContextHolder.getBean(WxMenuService.class);
		WxMenu wxMenu = null;
		if(WxConsts.EventType.CLICK.equals(wxMessage.getEvent())
				|| WxConsts.EventType.SCANCODE_WAITMSG.equals(wxMessage.getEvent())){
			wxMenu = wxMenuService.getById(wxMessage.getEventKey());
			if(wxMenu == null){//菜单过期
				return new TextBuilder().fromUser(wxMessage.getToUser()).toUser(wxMessage.getFromUser()).content("非常抱歉，该菜单已删除！").build();
			}
		}else{
			wxMenu = new WxMenu();
		}
		//消息记录
		WxUserService wxUserService = SpringContextHolder.getBean(WxUserService.class);
		WxAppService wxAppService = SpringContextHolder.getBean(WxAppService.class);
		WxApp wxApp = wxAppService.findByWeixinSign(wxMessage.getToUser());
		WxUser wxUser = wxUserService.getByOpenId(wxApp.getId(), wxMessage.getFromUser());
		if(wxUser==null){//库中无此用户
			WxMpUser userWxInfo = weixinService.getUserService()
					.userInfo(wxMessage.getFromUser(), null);
			wxUser = new WxUser();
			wxUser.setSubscribeNum(1);
			SubscribeHandler.setWxUserValue(wxApp,wxUser,userWxInfo);
//			wxUser.setTenantId(wxApp.getTenantId());
			wxUserService.save(wxUser);
		}
		//组装菜单回复消息
		return getWxMpXmlOutMessage(wxMessage, wxMenu, wxApp, wxUser);
    }

	/**
	 * 组装菜单回复消息
	 * @param wxMessage
	 * @param wxMenu
	 * @return
	 */
	public static WxMpXmlOutMessage getWxMpXmlOutMessage(WxMpXmlMessage wxMessage, WxMenu wxMenu, WxApp wxApp, WxUser wxUser){
		WxMpXmlOutMessage wxMpXmlOutMessage = null;
		WxMsgService wxMsgService = SpringContextHolder.getBean(WxMsgService.class);
		//记录接收消息
		WxMsg wxMsg = new WxMsg();
//		wxMsg.setTenantId(wxApp.getTenantId());
		wxMsg.setAppId(wxApp.getId());
		wxMsg.setWxUserId(wxUser.getId());
		wxMsg.setAppName(wxApp.getName());
		wxMsg.setAppLogo(wxApp.getLogo());
		wxMsg.setNickName(wxUser.getNickName());
		wxMsg.setHeadimgUrl(wxUser.getHeadimgUrl());
		wxMsg.setType(ConfigConstant.WX_MSG_TYPE_1);
		wxMsg.setRepEvent(wxMessage.getEvent());
		wxMsg.setRepType(wxMessage.getMsgType());
		wxMsg.setRepName(wxMenu.getName());
		if(WxConsts.EventType.VIEW.equals(wxMessage.getEvent())){
			wxMsg.setRepUrl(wxMessage.getEventKey());
		}
		if(WxConsts.EventType.SCANCODE_WAITMSG.equals(wxMessage.getEvent())){
			wxMsg.setRepContent(wxMessage.getScanCodeInfo().getScanResult());
		}
		wxMsg.setReadFlag(CommonConstants.NO);
		LocalDateTime now = LocalDateTime.now();
		wxMsg.setCreateDate(now);
		wxMsgService.save(wxMsg);
		//推送websocket
		SimpMessagingTemplate simpMessagingTemplate = SpringContextHolder.getBean(SimpMessagingTemplate.class);
		String destination = WebSocketConstant.USER_DESTINATION_PREFIX + WebSocketConstant.WX_MSG + wxMsg.getWxUserId();
		try {
			simpMessagingTemplate.convertAndSend(destination , JSONObject.toJSONString(wxMsg));
		}catch (Exception e){}
		if(WxConsts.MenuButtonType.CLICK.equals(wxMenu.getType())
				|| WxConsts.MenuButtonType.SCANCODE_WAITMSG.equals(wxMenu.getType())){
			//记录回复消息
			wxMsg = new WxMsg();
//			wxMsg.setTenantId(wxApp.getTenantId());
			wxMsg.setAppId(wxApp.getId());
			wxMsg.setWxUserId(wxUser.getId());
			wxMsg.setAppName(wxApp.getName());
			wxMsg.setAppLogo(wxApp.getLogo());
			wxMsg.setNickName(wxUser.getNickName());
			wxMsg.setHeadimgUrl(wxUser.getHeadimgUrl());
			wxMsg.setCreateDate(now.plusSeconds(1));
			wxMsg.setType(ConfigConstant.WX_MSG_TYPE_2);
			wxMsg.setRepType(wxMenu.getRepType());
			if(WxConsts.KefuMsgType.TEXT.equals(wxMenu.getRepType())){
				wxMsg.setRepContent(wxMenu.getRepContent());
				wxMpXmlOutMessage = new TextBuilder().fromUser(wxMessage.getToUser()).toUser(wxMessage.getFromUser()).content(wxMenu.getRepContent()).build();
			}
			if(WxConsts.KefuMsgType.IMAGE.equals(wxMenu.getRepType())){
				wxMsg.setRepName(wxMenu.getRepName());
				wxMsg.setRepUrl(wxMenu.getRepUrl());
				wxMsg.setRepMediaId(wxMenu.getRepMediaId());
				wxMpXmlOutMessage = new ImageBuilder().fromUser(wxMessage.getToUser()).toUser(wxMessage.getFromUser()).mediaId(wxMenu.getRepMediaId()).build();
			}
			if(WxConsts.KefuMsgType.VOICE.equals(wxMenu.getRepType())){
				wxMsg.setRepName(wxMenu.getRepName());
				wxMsg.setRepUrl(wxMenu.getRepUrl());
				wxMsg.setRepMediaId(wxMenu.getRepMediaId());
				wxMpXmlOutMessage = new VoiceBuilder().fromUser(wxMessage.getToUser()).toUser(wxMessage.getFromUser()).mediaId(wxMenu.getRepMediaId()).build();
			}
			if(WxConsts.KefuMsgType.VIDEO.equals(wxMenu.getRepType())){
				wxMsg.setRepName(wxMenu.getRepName());
				wxMsg.setRepDesc(wxMenu.getRepDesc());
				wxMsg.setRepUrl(wxMenu.getRepUrl());
				wxMsg.setRepMediaId(wxMenu.getRepMediaId());
				wxMpXmlOutMessage = new VideoBuilder().fromUser(wxMessage.getToUser()).toUser(wxMessage.getFromUser()).mediaId(wxMenu.getRepMediaId())
						.title(wxMenu.getRepName()).description(wxMenu.getRepDesc()).build();
			}
			if(WxConsts.KefuMsgType.MUSIC.equals(wxMenu.getRepType())){
				wxMsg.setRepName(wxMenu.getRepName());
				wxMsg.setRepDesc(wxMenu.getRepDesc());
				wxMsg.setRepUrl(wxMenu.getRepUrl());
				wxMsg.setRepHqUrl(wxMenu.getRepHqUrl());
				wxMsg.setRepThumbMediaId(wxMenu.getRepThumbMediaId());
				wxMsg.setRepThumbUrl(wxMenu.getRepThumbUrl());
				wxMpXmlOutMessage = new MusicBuilder().fromUser(wxMessage.getToUser()).toUser(wxMessage.getFromUser())
									.thumbMediaId(wxMenu.getRepThumbMediaId())
						.title(wxMenu.getRepName()).description(wxMenu.getRepDesc())
						.musicUrl(wxMenu.getRepUrl()).hqMusicUrl(wxMenu.getRepHqUrl()).build();
			}
			if(WxConsts.KefuMsgType.NEWS.equals(wxMenu.getRepType())){
				List<WxMpXmlOutNewsMessage.Item> list = new ArrayList<>();
				List<JSONObject> listJSONObject = wxMenu.getContent().getJSONArray("articles").toJavaList(JSONObject.class);
				WxMpXmlOutNewsMessage.Item t;
				for(JSONObject jSONObject : listJSONObject){
					t = new WxMpXmlOutNewsMessage.Item();
					t.setTitle(jSONObject.getString("title"));
					t.setDescription(jSONObject.getString("digest"));
					t.setPicUrl(jSONObject.getString("thumbUrl"));
					t.setUrl(jSONObject.getString("url"));
					list.add(t);
				}
				wxMsg.setRepName(wxMenu.getRepName());
				wxMsg.setRepDesc(wxMenu.getRepDesc());
				wxMsg.setRepUrl(wxMenu.getRepUrl());
				wxMsg.setRepMediaId(wxMenu.getRepMediaId());
				wxMsg.setContent(wxMenu.getContent());
				wxMpXmlOutMessage = new NewsBuilder().fromUser(wxMessage.getToUser()).toUser(wxMessage.getFromUser()).articles(list).build();
			}
			wxMsgService.save(wxMsg);
			try {
				simpMessagingTemplate.convertAndSend(destination , JSONObject.toJSONString(wxMsg));
			}catch (Exception e){}
		}
		return wxMpXmlOutMessage;
	}
}
