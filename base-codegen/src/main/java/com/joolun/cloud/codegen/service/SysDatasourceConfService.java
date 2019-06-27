package com.joolun.cloud.codegen.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.joolun.cloud.codegen.entity.SysDatasourceConf;

/**
 * 数据源表
 *
 * @author
 */
public interface SysDatasourceConfService extends IService<SysDatasourceConf> {
	/**
	 * 保存数据源并且加密
	 *
	 * @param sysDatasourceConf
	 * @return
	 */
	Boolean saveDsByEnc(SysDatasourceConf sysDatasourceConf);

	/**
	 * 更新数据源
	 *
	 * @param sysDatasourceConf
	 * @return
	 */
	Boolean updateDsByEnc(SysDatasourceConf sysDatasourceConf);
}
