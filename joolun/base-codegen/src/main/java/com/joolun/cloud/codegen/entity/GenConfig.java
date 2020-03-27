package com.joolun.cloud.codegen.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author
 * 生成配置
 */
@Data
@ApiModel(value="生成配置")
public class GenConfig {
	/**
	 * 数据源ID
	 */
	@ApiModelProperty(value = "pk")
	private String id;
	/**
	 * 包名
	 */
	@ApiModelProperty(value = "包名")
	private String packageName;
	/**
	 * 作者
	 */
	@ApiModelProperty(value = "作者")
	private String author;
	/**
	 * 模块名称
	 */
	@ApiModelProperty(value = "模块名称")
	private String moduleName;
	/**
	 * 表前缀
	 */
	@ApiModelProperty(value = "表前缀")
	private String tablePrefix;

	/**
	 * 表名称
	 */
	@ApiModelProperty(value = "表名称")
	private String tableName;

	/**
	 * 表备注
	 */
	@ApiModelProperty(value = "表备注")
	private String comments;
}
