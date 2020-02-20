package com.joolun.cloud.upms.common.entity;

import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 短信
 * </p>
 *
 * @author
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysSms extends Model<SysSms> {

	private static final long serialVersionUID = 1L;

	private String signName;
	private String phoneNumbers;
	private String templateCode;
	private String templateParam;
}
