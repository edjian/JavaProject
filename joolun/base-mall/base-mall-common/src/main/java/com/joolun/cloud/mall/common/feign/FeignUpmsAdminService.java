package com.joolun.cloud.mall.common.feign;

import com.joolun.cloud.common.core.constant.SecurityConstants;
import com.joolun.cloud.common.core.constant.ServiceNameConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.upms.common.entity.SysConfigStorage;
import com.joolun.cloud.upms.common.entity.SysUser;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@FeignClient(contextId = "feignUpmsAdminService",value = ServiceNameConstants.UMPS_ADMIN_SERVICE)
public interface FeignUpmsAdminService {

    @GetMapping("/configstorage/getOne")
    SysConfigStorage getOne(@RequestHeader(SecurityConstants.FROM)String from);

//    @GetMapping("")
//    SysUser getSysUser(@RequestHeader(SecurityConstants.FROM)String from);

	@GetMapping("/organ/getPhoneById/{organId}")
	String getPhoneById(@PathVariable("organId") String organId, @RequestHeader(SecurityConstants.FROM) String from);
}
