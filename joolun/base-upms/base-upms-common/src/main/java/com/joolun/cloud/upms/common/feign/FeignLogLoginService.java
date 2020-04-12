package com.joolun.cloud.upms.common.feign;

import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.constant.ServiceNameConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.upms.common.entity.SysLogLogin;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * @author
 */
@FeignClient(contextId = "feignLogLoginService", value = ServiceNameConstants.UMPS_ADMIN_SERVICE)
public interface FeignLogLoginService {
	/**
	 * 保存登录日志
	 *
	 * @param sysLogLogin 日志实体
	 * @param from   是否内部调用
	 * @return succes、false
	 */
	@PostMapping("/loglogin/save")
	R<Boolean> saveLogLogin(@RequestBody SysLogLogin sysLogLogin, @RequestHeader(SecurityConstants.FROM) String from);
}
