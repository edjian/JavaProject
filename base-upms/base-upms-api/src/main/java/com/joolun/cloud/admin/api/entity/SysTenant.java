package com.joolun.cloud.admin.api.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 租户
 *
 */
@Data
@TableName("sys_tenant")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "租户")
public class SysTenant extends Model<SysTenant> {
	private static final long serialVersionUID = 1L;

	/**
	 * 租户id
	 */
	@TableId
	private Integer id;
	/**
	 * 租户名称
	 */
	private String name;
	/**
	 * 租户编号
	 */
	private String code;
	/**
	 * 开始时间
	 */
	private LocalDate startTime;
	/**
	 * 结束时间
	 */
	private LocalDate endTime;
	/**
	 * 0正常 9-冻结
	 */
	private String status;
	/**
	 * 删除标记
	 */
	@TableLogic
	private String delFlag;
	/**
	 * 创建
	 */
	private LocalDateTime createTime;
	/**
	 * 更新时间
	 */
	private LocalDateTime updateTime;

}
