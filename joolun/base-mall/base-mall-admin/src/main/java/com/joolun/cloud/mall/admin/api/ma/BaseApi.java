package com.joolun.cloud.mall.admin.api.ma;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.common.dto.PlaceOrderDTO;
import com.joolun.cloud.mall.common.entity.OrderInfo;
import com.joolun.cloud.mall.common.entity.ShoppingCart;
import com.joolun.cloud.mall.common.entity.UserAddress;
import com.joolun.cloud.mall.common.entity.UserCollect;
import com.joolun.cloud.weixin.common.constant.MyReturnCode;
import com.joolun.cloud.weixin.common.constant.WxMaConstants;
import com.joolun.cloud.weixin.common.entity.ThirdSession;
import com.joolun.cloud.weixin.common.entity.WxUser;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import javax.servlet.http.HttpServletRequest;

/**
 * 小程序Configuration
 * @author JL
 *
 */
@Configuration
public class BaseApi {

	private static RedisTemplate redisTemplate;

	public BaseApi(RedisTemplate redisTemplate){
		this.redisTemplate = redisTemplate;
	}

	/**
	 * 校验ThirdSession
	 * @param baseEntity
	 * @param request
	 * @return
	 */
	public static R checkThirdSession(Model<?> baseEntity, HttpServletRequest request) {
		String thirdSession = request.getHeader("thirdSession");
		//获取缓存中的ThirdSession
		String key = WxMaConstants.THIRD_SESSION_BEGIN  + ":" + thirdSession;
		Object thirdSessionObj = redisTemplate.opsForValue().get(key);
		if(thirdSessionObj == null) {//session过期
			//返回超时错误码，触发小程序重新登录
			return R.failed(MyReturnCode.ERR_60001.getCode(), MyReturnCode.ERR_60001.getMsg());
		}else {
			String thirdSessionStr = String.valueOf(thirdSessionObj);
			ThirdSession thirdSessionData = JSONUtil.toBean(thirdSessionStr, ThirdSession.class);
			String appId_session = thirdSessionData.getAppId();
			String userId_session = thirdSessionData.getWxUserId();
			String sessionKey_session = thirdSessionData.getSessionKey();
			String openId_session = thirdSessionData.getOpenId();
			if (baseEntity instanceof WxUser) {
				((WxUser) baseEntity).setAppId(appId_session);
				((WxUser) baseEntity).setId(userId_session);
				((WxUser) baseEntity).setSessionKey(sessionKey_session);
				((WxUser) baseEntity).setOpenId(openId_session);
			}else if (baseEntity instanceof ShoppingCart){
				((ShoppingCart) baseEntity).setUserId(userId_session);
			}else if (baseEntity instanceof PlaceOrderDTO){
				((PlaceOrderDTO) baseEntity).setUserId(userId_session);
				((PlaceOrderDTO) baseEntity).setAppId(appId_session);
			}else if (baseEntity instanceof UserAddress){
				((UserAddress) baseEntity).setUserId(userId_session);
			}else if (baseEntity instanceof OrderInfo){
				((OrderInfo) baseEntity).setUserId(userId_session);
			}else if (baseEntity instanceof UserCollect){
				((UserCollect) baseEntity).setUserId(userId_session);
			}
			return R.ok(baseEntity);
		}
	}

	/**
	 * 通过request获取appId
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static String getAppId(HttpServletRequest request) {
		//https://servicewechat.com/wxd7da5b5a941bcc1c/devtools/page-frame.html
		String referer = request.getHeader("Referer");
		String appId = referer.replace("https://servicewechat.com/", "");
		appId = appId.substring(0, appId.indexOf("/"));
		return appId;
	}
}
