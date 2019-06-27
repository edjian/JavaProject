package com.joolun.cloud.admin;

import com.joolun.cloud.common.security.annotation.EnableBaseFeignClients;
import com.joolun.cloud.common.security.annotation.EnableBaseResourceServer;
import com.joolun.cloud.common.swagger.annotation.EnableSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * @author
 * 用户统一管理系统
 */
@EnableSwagger2
@SpringCloudApplication
@EnableBaseFeignClients
@EnableBaseResourceServer
public class BaseUpmsApplication {
	public static void main(String[] args) {
		SpringApplication.run(BaseUpmsApplication.class, args);
	}

}
