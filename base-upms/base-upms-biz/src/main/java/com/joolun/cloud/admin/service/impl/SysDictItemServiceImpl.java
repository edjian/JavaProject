package com.joolun.cloud.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.admin.api.entity.SysDictItem;
import com.joolun.cloud.admin.mapper.SysDictItemMapper;
import com.joolun.cloud.admin.service.SysDictItemService;
import org.springframework.stereotype.Service;
import com.joolun.cloud.admin.api.entity.SysDict;
import com.joolun.cloud.admin.service.SysDictService;
import com.joolun.cloud.common.core.constant.CacheConstants;
import com.joolun.cloud.common.core.constant.enums.DictTypeEnum;
import com.joolun.cloud.common.core.util.R;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
/**
 * 字典项
 *
 * @author
 */
@Service
@AllArgsConstructor
public class SysDictItemServiceImpl extends ServiceImpl<SysDictItemMapper, SysDictItem> implements SysDictItemService {
	private final SysDictService dictService;

	/**
	 * 删除字典项
	 *
	 * @param id 字典项ID
	 * @return
	 */
	@Override
	@CacheEvict(value = CacheConstants.DICT_DETAILS, allEntries = true)
	public R removeDictItem(Integer id) {
		//根据ID查询字典ID
		SysDictItem dictItem = this.getById(id);
		SysDict dict = dictService.getById(dictItem.getDictId());
		// 系统内置
		if (DictTypeEnum.SYSTEM.getType().equals(dict.getIsSystem())) {
			return R.failed("系统内置字典项目不能删除");
		}
		return R.ok(this.removeById(id));
	}

	/**
	 * 更新字典项
	 *
	 * @param item 字典项
	 * @return
	 */
	@Override
	@CacheEvict(value = CacheConstants.DICT_DETAILS, allEntries = true)
	public R updateDictItem(SysDictItem item) {
		//查询字典
		SysDict dict = dictService.getById(item.getDictId());
		// 系统内置
		if (DictTypeEnum.SYSTEM.getType().equals(dict.getIsSystem())) {
			return R.failed("系统内置字典项目不能修改");
		}
		return R.ok(this.updateById(item));
	}
}
