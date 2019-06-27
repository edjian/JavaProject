package com.joolun.cloud.common.log.event;

import com.joolun.cloud.admin.api.entity.SysLog;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author
 * 系统日志事件
 */
@Getter
@AllArgsConstructor
public class SysLogEvent {
	private final SysLog sysLog;
}
