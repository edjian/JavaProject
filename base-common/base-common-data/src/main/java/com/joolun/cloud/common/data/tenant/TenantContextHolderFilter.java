package com.joolun.cloud.common.data.tenant;

import cn.hutool.core.util.StrUtil;
import com.joolun.cloud.common.core.constant.CommonConstants;
import com.joolun.cloud.common.core.constant.SecurityConstants;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;
import javax.servlet.FilterChain;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author
 */
@Slf4j
@Component
@Order(Ordered.HIGHEST_PRECEDENCE)
@AllArgsConstructor
public class TenantContextHolderFilter extends GenericFilterBean {

	private final RedisTemplate redisTemplate;

	@Override
	@SneakyThrows
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		//需要token验权的请求，header中有token，通过token找租户ID
		String Authorization = request.getHeader(CommonConstants.AUTHORIZATION);
		if(StrUtil.isNotBlank(Authorization) && Authorization.contains(OAuth2AccessToken.BEARER_TYPE)){
			String tokenValue = Authorization.replace(OAuth2AccessToken.BEARER_TYPE, StrUtil.EMPTY).trim();
			String key = StrUtil.concat(false,SecurityConstants.BASE_PREFIX,SecurityConstants.OAUTH_PREFIX,"access:",tokenValue);
			OAuth2AccessToken oAuth2AccessToken = (OAuth2AccessToken) redisTemplate.opsForValue().get(key);
			if(oAuth2AccessToken != null){
				String tenantId = String.valueOf(oAuth2AccessToken.getAdditionalInformation().get(SecurityConstants.DETAILS_TENANT_ID));
				if (StrUtil.isNotBlank(tenantId)) {
					TenantContextHolder.setTenantId(tenantId);
				}
			}
		}else{
			//不需要token验权的请求，header中无token，用header中的租户ID
			String tenantId = request.getHeader(CommonConstants.TENANT_ID);
			if (StrUtil.isNotBlank(tenantId)) {
				TenantContextHolder.setTenantId(tenantId);
			}
		}

		filterChain.doFilter(request, response);
		TenantContextHolder.clear();
	}
}
