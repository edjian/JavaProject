package com.joolun.cloud.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.joolun.cloud.admin.api.dto.UserInfo;
import com.joolun.cloud.admin.api.entity.SysSocialDetails;

/**
 * 系统社交登录账号表
 *
 * @author
 */
public interface SysSocialDetailsService extends IService<SysSocialDetails> {

	/**
	 * 绑定社交账号
	 *
	 * @param state 类型
	 * @param code  code
	 * @return
	 */
	Boolean bindSocial(String state, String code);

	/**
	 * 根据入参查询用户信息
	 *
	 * @param inStr
	 * @return
	 */
	UserInfo getUserInfo(String inStr);
}

