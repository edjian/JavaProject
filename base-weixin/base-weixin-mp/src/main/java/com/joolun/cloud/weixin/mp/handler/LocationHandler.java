package com.joolun.cloud.weixin.mp.handler;

import com.joolun.cloud.common.core.util.SpringContextHolder;
import com.joolun.cloud.weixin.common.entity.WxApp;
import com.joolun.cloud.weixin.common.entity.WxUser;
import com.joolun.cloud.weixin.mp.service.WxAppService;
import com.joolun.cloud.weixin.mp.service.WxUserService;
import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.common.session.WxSessionManager;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import org.springframework.stereotype.Component;
import java.util.Map;


/**
 * @author JL
 */
@Component
public class LocationHandler extends AbstractHandler {

    @Override
    public WxMpXmlOutMessage handle(WxMpXmlMessage wxMessage,
                                    Map<String, Object> context, WxMpService wxMpService,
                                    WxSessionManager sessionManager) {
        if (wxMessage.getEvent().equals(WxConsts.EventType.LOCATION)) {
            try {
				WxUserService wxUserService = SpringContextHolder.getBean(WxUserService.class);
				WxAppService wxAppService = SpringContextHolder.getBean(WxAppService.class);
				WxApp wxApp = wxAppService.findByWeixinSign(wxMessage.getToUser());
				WxUser wxUser = wxUserService.getByOpenId(wxApp.getId(), wxMessage.getFromUser());
				wxUser.setLatitude(wxMessage.getLatitude());
				wxUser.setLongitude(wxMessage.getLongitude());
				wxUser.setPrecision(wxMessage.getPrecision());
				wxUserService.updateById(wxUser);
                return null;
            } catch (Exception e) {
            	e.printStackTrace();
                this.logger.error("位置消息接收处理失败", e);
                return null;
            }
        }
        return null;
    }

}
