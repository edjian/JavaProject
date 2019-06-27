package com.joolun.cloud.common.core.constant;

/**
 * @author
 */
public interface CommonConstants {
	/**
	 * 是
	 */
	String YES = "0";
	/**
	 * 否
	 */
	String NO = "1";
	/**
	 * header 中租户ID
	 */
	String TENANT_ID = "TENANT_ID";
	/**
	 * 删除
	 */
	String STATUS_DEL = "1";
	/**
	 * 正常
	 */
	String STATUS_NORMAL = "0";

	/**
	 * 锁定
	 */
	String STATUS_LOCK = "9";

	/**
	 * 菜单
	 */
	String MENU = "0";

	/**
	 * 菜单根节点
	 */
	Integer MENU_TREE_ROOT_ID = -1;

	/**
	 * 编码
	 */
	String UTF8 = "UTF-8";

	/**
	 * 前端工程名
	 */
	String FRONT_END_PROJECT = "joolun-ui";

	/**
	 * 后端工程名
	 */
	String BACK_END_PROJECT = "joolun";

	/**
	 * 公共参数
	 */
	String BASE_PUBLIC_PARAM_KEY = "BASE_PUBLIC_PARAM_KEY";

	/**
	 * 验证码前缀
	 */
	String DEFAULT_CODE_KEY = "DEFAULT_CODE_KEY_";

	/**
	 * 成功标记
	 */
	Integer SUCCESS = 0;
	/**
	 * 失败标记
	 */
	Integer FAIL = 1;

	/**
	 * 默认存储bucket
	 */
	String BUCKET_NAME = "joolun";

	/**
	 * 微信存储bucket
	 */
	String BUCKET_NAME_WX = "joolun-wx";
}
