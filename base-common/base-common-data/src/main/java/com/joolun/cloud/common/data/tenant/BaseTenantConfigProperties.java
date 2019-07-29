package com.joolun.cloud.common.data.tenant;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import java.util.ArrayList;
import java.util.List;

/**
 * 多租户配置
 *
 * @author
 */
@Data
@RefreshScope
@Configuration
@ConfigurationProperties(prefix = "base.tenant")
public class BaseTenantConfigProperties {

	/**
	 * 维护租户列名称
	 */
	private String column = "tenant_id";

	/**
	 * 多租户的数据表集合
	 */
	private List<String> tables = new ArrayList<>();

	/**
	 * 不需要租户信息约束的sql
	 */
	private List<String> ignoreMss = new ArrayList<>();
}
