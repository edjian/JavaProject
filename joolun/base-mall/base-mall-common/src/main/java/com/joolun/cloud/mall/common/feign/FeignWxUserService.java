package com.joolun.cloud.mall.common.feign;

import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.constant.ServiceNameConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.mall.common.dto.WxOpenDataDTO;
import com.joolun.cloud.weixin.common.entity.WxUser;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

/**
 * @author
 */
@FeignClient(contextId = "feignWxUserService", value = ServiceNameConstants.WX_ADMIN_SERVICE)
public interface FeignWxUserService {

	/**
	 * 获取微信用户信息
	 * @param id
	 * @return
	 */
	@GetMapping("/wxuser/inside/{id}")
	R<WxUser> getById(@PathVariable("id") String id, @RequestHeader(SecurityConstants.FROM) String from);

	@PostMapping("/wxuser/inside")
	R<WxUser> save(@RequestBody WxOpenDataDTO wxOpenDataDTO, @RequestHeader(SecurityConstants.FROM) String from);

	@GetMapping("/wxuser/insideByMallUserId/{mallUserId}")
	R<WxUser> getByMallUserIdInside(@PathVariable("mallUserId") String mallUserId, @RequestHeader(SecurityConstants.FROM) String from);
}
