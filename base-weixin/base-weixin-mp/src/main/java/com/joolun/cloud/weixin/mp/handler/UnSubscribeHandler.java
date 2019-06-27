package com.joolun.cloud.weixin.mp.handler;

import com.joolun.cloud.common.core.util.SpringContextHolder;
import com.joolun.cloud.weixin.common.constant.ConfigConstant;
import com.joolun.cloud.weixin.common.entity.WxApp;
import com.joolun.cloud.weixin.common.entity.WxUser;
import com.joolun.cloud.weixin.mp.service.WxAppService;
import com.joolun.cloud.weixin.mp.service.WxUserService;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.session.WxSessionManager;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import org.springframework.stereotype.Component;
import java.time.LocalDateTime;
import java.util.Map;

/**
 * 用户取消关注
 * @author JL
 */
@Slf4j
@Component
public class UnSubscribeHandler extends AbstractHandler {

    @Override
    public WxMpXmlOutMessage handle(WxMpXmlMessage wxMessage,
                                    Map<String, Object> context, WxMpService wxMpService,
                                    WxSessionManager sessionManager) {
        String openId = wxMessage.getFromUser();
        log.info("取消关注用户 OPENID: " + openId);
        // TODO 更新本地数据库为取消关注状态
		WxUserService wxUserService = SpringContextHolder.getBean(WxUserService.class);
		WxAppService wxAppService = SpringContextHolder.getBean(WxAppService.class);
		WxApp wxApp = wxAppService.findByWeixinSign(wxMessage.getToUser());
		WxUser wxUser = wxUserService.getByOpenId(wxApp.getId(), openId);
		if(wxUser!=null){
			wxUser.setSubscribe(ConfigConstant.SUBSCRIBE_TYPE_NO);
			wxUser.setCancelSubscribeTime(LocalDateTime.now());
			wxUserService.updateById(wxUser);
			//消息记录
			MsgHandler.getWxMpXmlOutMessage(wxMessage,null,wxApp,wxUser);
		}
        return null;
    }

}
