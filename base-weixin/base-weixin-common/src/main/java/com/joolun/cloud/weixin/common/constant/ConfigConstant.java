package com.joolun.cloud.weixin.common.constant;

/**
 * 全局常量
 * @author JL
 * 2019年1月21日
 */
public interface ConfigConstant {
	
	//是否订阅（0：已订阅；1：未订阅；2：网页授权用户）
	/**
	 * 1：已订阅
	 */
	String SUBSCRIBE_TYPE_YES = "0";
  	/**
  	 * 0：未订阅
  	 */
  	String SUBSCRIBE_TYPE_NO = "1";
  	/**
  	 * 2：网页授权用户
  	 */
  	String SUBSCRIBE_TYPE_WEBLICENS = "2";

	/**
	 * 应用类型 1:小程序
	 */
	String WX_APP_TYPE_1 = "1";
	/**
	 * 应用类型 2:公众号
	 */
	String WX_APP_TYPE_2 = "2";

	/**
	 * 消息自动回复类型（1、关注时回复；2、消息回复；3、关键词回复）
	 */
	String WX_AUTO_REPLY_TYPE_1 = "1";
	String WX_AUTO_REPLY_TYPE_2 = "2";
	String WX_AUTO_REPLY_TYPE_3 = "3";

	/**
	 * 回复类型文本匹配类型（1、全匹配，2、半匹配）
	 */
	String WX_REP_MATE_1 = "1";
	String WX_REP_MATE_2 = "2";

	/**
	 * 消息分类（1、用户发给公众号；2、公众号发给用户；）
	 */
	String WX_MSG_TYPE_1 = "1";
	String WX_MSG_TYPE_2 = "2";

}
