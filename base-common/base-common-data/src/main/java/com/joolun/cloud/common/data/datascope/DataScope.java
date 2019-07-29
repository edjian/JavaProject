package com.joolun.cloud.common.data.datascope;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @author
 * 数据权限查询参数
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class DataScope extends HashMap {
	/**
	 * 限制范围的字段名称
	 */
	private String scopeName = "organ_id";

	/**
	 * 具体的数据范围
	 */
	private List<String> organIds = new ArrayList<>();

	/**
	 * 是否只查询本机构
	 */
	private Boolean isOnly = false;
}
