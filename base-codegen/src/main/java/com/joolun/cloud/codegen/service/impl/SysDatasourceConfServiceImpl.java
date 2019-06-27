package com.joolun.cloud.codegen.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.common.datasource.config.DynamicDataSourceConfig;
import com.joolun.cloud.codegen.entity.SysDatasourceConf;
import com.joolun.cloud.codegen.mapper.SysDatasourceConfMapper;
import com.joolun.cloud.codegen.service.SysDatasourceConfService;
import lombok.AllArgsConstructor;
import org.jasypt.encryption.StringEncryptor;
import org.springframework.stereotype.Service;

/**
 * 数据源表
 */
@Service
@AllArgsConstructor
public class SysDatasourceConfServiceImpl extends ServiceImpl<SysDatasourceConfMapper, SysDatasourceConf> implements SysDatasourceConfService {
	private final DynamicDataSourceConfig dynamicDataSourceConfig;
	private final StringEncryptor stringEncryptor;

	/**
	 * 保存数据源并且加密
	 *
	 * @param sysDatasourceConf
	 * @return
	 */
	@Override
	public Boolean saveDsByEnc(SysDatasourceConf sysDatasourceConf) {
		sysDatasourceConf.setPassword(stringEncryptor.encrypt(sysDatasourceConf.getPassword()));
		this.baseMapper.insert(sysDatasourceConf);
		return dynamicDataSourceConfig.reload();
	}

	/**
	 * 更新数据源
	 *
	 * @param sysDatasourceConf
	 * @return
	 */
	@Override
	public Boolean updateDsByEnc(SysDatasourceConf sysDatasourceConf) {
		if (StrUtil.isNotBlank(sysDatasourceConf.getPassword())) {
			sysDatasourceConf.setPassword(stringEncryptor.encrypt(sysDatasourceConf.getPassword()));
		}
		this.baseMapper.updateById(sysDatasourceConf);
		return dynamicDataSourceConfig.reload();
	}
}
