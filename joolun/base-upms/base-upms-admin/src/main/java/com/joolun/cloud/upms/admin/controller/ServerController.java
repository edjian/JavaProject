package com.joolun.cloud.upms.admin.controller;

import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.upms.common.entity.SysServer;
import io.swagger.annotations.Api;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 服务器监控
 * 
 * @author JL
 */
@RestController
@AllArgsConstructor
@RequestMapping("/sysServer")
@Api(value = "sysServer", tags = "服务器监控")
public class ServerController{
	@GetMapping
	@PreAuthorize("@ato.hasAuthority('sys_server_index')")
    public R getInfo() throws Exception
    {
        SysServer server = new SysServer();
        server.copyTo();
        return R.ok(server);
    }
}
