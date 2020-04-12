package com.joolun.cloud.common.datasource.constants;

/**
 * <p>
 * 数据源相关常量
 */
public interface DataSourceConstants {
	/**
	 * 数据源查询SQL
	 */
	String DS_QUERY_SQL = "select * from base_upms.sys_datasource where del_flag = 0";

	/**
	 * 数据源名称
	 */
	String DS_NAME = "name";

	/**
	 * jdbcurl
	 */
	String DS_JDBC_URL = "url";

	/**
	 * 用户名
	 */
	String DS_USER_NAME = "username";

	/**
	 * 密码
	 */
	String DS_USER_PWD = "password";

}
