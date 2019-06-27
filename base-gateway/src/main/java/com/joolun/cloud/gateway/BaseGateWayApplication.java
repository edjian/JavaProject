package com.joolun.cloud.gateway;

import com.joolun.cloud.common.gateway.annotation.EnableDynamicRoute;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * @author
 * 网关应用
 */
@EnableDynamicRoute
@SpringCloudApplication
public class BaseGateWayApplication {

	public static void main(String[] args) {
		SpringApplication.run(BaseGateWayApplication.class, args);
	}
}
