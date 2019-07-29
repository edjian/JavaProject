package com.joolun.cloud.common.core.constant;

/**
 * @author
 * <p>
 * 缓存的key 常量
 */
public interface CacheConstants {

	/**
	 * 用户信息缓存
	 */
	String USER_DETAILS = "user_details";

	/**
	 * oauth 客户端信息
	 */
	String CLIENT_DETAILS_KEY = "base_oauth:client:details";

	/**
	 * 菜单信息缓存
	 */
	String MENU_DETAILS = "menu_details";

	/**
	 * spring boot admin 事件key
	 */
	String EVENT_KEY = "event_key";

	/**
	 * 路由存放
	 */
	String ROUTE_KEY = "gateway_route_key";

	/**
	 * 字典缓存
	 */
	String DICT_DETAILS = "dict_details";

	/**
	 * 参数缓存
	 */
	String PARAMS_DETAILS = "params_details";

	/**
	 * 租户缓存
	 */
	String TENANT_DETAILS = "tenant_details";


	/**
	 * 默认验证码前缀
	 */
	String VER_CODE_DEFAULT = "ver_code_default:";

	/**
	 * 注册验证码前缀
	 */
	String VER_CODE_REGISTER = "ver_code_register:";
}
