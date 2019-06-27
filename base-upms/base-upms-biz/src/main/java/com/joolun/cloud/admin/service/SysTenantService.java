package com.joolun.cloud.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.joolun.cloud.admin.api.entity.SysTenant;

import java.util.List;

/**
 * 租户管理
 *
 */
public interface SysTenantService extends IService<SysTenant> {

	/**
	 * 获取正常的租户
	 *
	 * @return
	 */
	List<SysTenant> getNormal();

	/**
	 * 保存租户
	 *
	 * @param sysTenant
	 * @return
	 */
	Boolean saveTenant(SysTenant sysTenant);
}
