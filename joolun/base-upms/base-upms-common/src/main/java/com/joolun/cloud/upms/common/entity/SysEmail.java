package com.joolun.cloud.upms.common.entity;

import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 邮件
 * </p>
 *
 * @author
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysEmail extends Model<SysEmail> {

	private static final long serialVersionUID = 1L;

	private String id;
	private String to;
	private String title;
	private String content;

}
