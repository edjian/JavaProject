package com.joolun.cloud.common.security.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

/**
 * @author
 */
public interface BaseUserDetailsService extends UserDetailsService {

	/**
	 * 手机验证码登录
	 *
	 * @param code TYPE:CODE
	 * @return UserDetails
	 * @throws UsernameNotFoundException
	 */
	UserDetails loadUserByPhone(String code) throws UsernameNotFoundException;

	/**
	 * 根据社交登录code 登录
	 *
	 * @param code TYPE@CODE
	 * @return UserDetails
	 * @throws UsernameNotFoundException
	 */
	UserDetails loadUserBySysThirdParty(String code) throws UsernameNotFoundException;
}
