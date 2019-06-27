package com.joolun.cloud.common.gateway.support;

import org.springframework.context.ApplicationEvent;

/**
 * @author
 * <p>
 * 路由初始化事件
 */
public class DynamicRouteInitEvent extends ApplicationEvent {
	public DynamicRouteInitEvent(Object source) {
		super(source);
	}
}
