package com.joolun.cloud.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.joolun.cloud.admin.api.entity.SysDict;
import com.joolun.cloud.common.core.util.R;

/**
 * <p>
 * 字典表 服务类
 * </p>
 *
 * @author
 */
public interface SysDictService extends IService<SysDict> {
	/**
	 * 根据ID 删除字典
	 *
	 * @param id
	 * @return
	 */
	R removeDict(Integer id);

	/**
	 * 更新字典
	 *
	 * @param sysDict 字典
	 * @return
	 */
	R updateDict(SysDict sysDict);
}
