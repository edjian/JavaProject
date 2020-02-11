package com.joolun.cloud.common.transaction.config;

import com.alibaba.druid.pool.DruidDataSource;
import io.seata.rm.datasource.DataSourceProxy;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

/**
 * @author JL
 */
@Configuration
public class DataSourceProxyConfig {

	@Bean
	@ConfigurationProperties(prefix = "spring.datasource.druid")
	public DruidDataSource druidDataSource() {
		return new DruidDataSource();
	}

	@Primary
	@Bean
	public DataSourceProxy dataSourceProxy(DruidDataSource druidDataSource) {
		return new DataSourceProxy(druidDataSource);
	}
}