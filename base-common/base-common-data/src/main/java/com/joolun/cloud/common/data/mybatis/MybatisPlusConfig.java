package com.joolun.cloud.common.data.mybatis;

import com.baomidou.mybatisplus.core.injector.ISqlInjector;
import com.baomidou.mybatisplus.core.parser.ISqlParser;
import com.baomidou.mybatisplus.core.parser.ISqlParserFilter;
import com.baomidou.mybatisplus.extension.injector.LogicSqlInjector;
import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import com.baomidou.mybatisplus.extension.plugins.tenant.TenantSqlParser;
import com.joolun.cloud.common.data.datascope.DataScopeInterceptor;
import com.joolun.cloud.common.data.datascope.DataScopeProperties;
import com.joolun.cloud.common.data.tenant.TenantConfigProperties;
import com.joolun.cloud.common.data.tenant.BaseTenantHandler;
import lombok.AllArgsConstructor;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.reflection.MetaObject;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;

/**
 * MybatisPlus配置
 * @author
 */
@Configuration
@ConditionalOnBean(DataSource.class)
@AllArgsConstructor
@AutoConfigureAfter(DataSourceAutoConfiguration.class)
@MapperScan("com.joolun.cloud.**.mapper")
public class MybatisPlusConfig {

	private TenantConfigProperties tenantConfigProperties;
	private DataScopeProperties dataScopeProperties;

	/**
	 * 创建租户维护处理器对象
	 *
	 * @return 处理后的租户维护处理器
	 */
	@Bean
	@ConditionalOnMissingBean
	public BaseTenantHandler baseTenantHandler() {
		return new BaseTenantHandler();
	}

	/**
	 * 租户处理器
	 *
	 * @param tenantHandler
	 * @return PaginationInterceptor
	 */
	@Bean
	@ConditionalOnMissingBean
	@ConditionalOnProperty(name = "mybatisPlus.tenantEnable", havingValue = "true", matchIfMissing = true)
	public PaginationInterceptor paginationInterceptor(BaseTenantHandler tenantHandler) {
		PaginationInterceptor paginationInterceptor = new PaginationInterceptor();
		List<ISqlParser> sqlParserList = new ArrayList<>();
		TenantSqlParser tenantSqlParser = new TenantSqlParser();
		tenantSqlParser.setTenantHandler(tenantHandler);
		sqlParserList.add(tenantSqlParser);
		paginationInterceptor.setSqlParserList(sqlParserList);
		paginationInterceptor.setSqlParserFilter(new ISqlParserFilter() {
			@Override
			public boolean doFilter(MetaObject metaObject) {
				MappedStatement ms = (MappedStatement) metaObject.getValue("delegate.mappedStatement");
				// 过滤自定义查询此时无租户信息约束
				if (tenantConfigProperties.getIgnoreMss().contains(ms.getId())) {
					return true;
				}
				return false;
			}
		});
		return paginationInterceptor;
	}

	/**
	 * 数据权限插件
	 *
	 * @param dataSource 数据源
	 * @return DataScopeInterceptor
	 */
	@Bean
	@ConditionalOnMissingBean
	public DataScopeInterceptor dataScopeInterceptor(DataSource dataSource) {
		return new DataScopeInterceptor(dataSource,dataScopeProperties);
	}

	/**
	 * 逻辑删除插件
	 *
	 * @return LogicSqlInjector
	 */
	@Bean
	@ConditionalOnMissingBean
	public ISqlInjector sqlInjector() {
		return new LogicSqlInjector();
	}
}
