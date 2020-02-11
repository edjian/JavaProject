/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.upms.admin.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import com.joolun.cloud.upms.common.entity.SysConfigStorage;
import com.joolun.cloud.upms.admin.service.SysConfigStorageService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;

/**
 * 存储配置
 *
 * @author JL
 * @date 2020-02-03 20:07:38
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/configstorage")
@Api(value = "configstorage", tags = "存储配置管理")
public class SysConfigStorageController {

    private final SysConfigStorageService sysConfigStorageService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param sysConfigStorage 存储配置
     * @return
     */
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('sys_configstorage_index')")
    public R getPage(Page page, SysConfigStorage sysConfigStorage) {
        return R.ok(sysConfigStorageService.page(page, Wrappers.query(sysConfigStorage)));
    }

    /**
     * 存储配置查询
     * @param id
     * @return R
     */
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('sys_configstorage_get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(sysConfigStorageService.getById(id));
    }

    /**
     * 存储配置新增
     * @param sysConfigStorage 存储配置
     * @return R
     */
    @SysLog("新增存储配置")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('sys_configstorage_add')")
    public R save(@RequestBody SysConfigStorage sysConfigStorage) {
        return R.ok(sysConfigStorageService.save(sysConfigStorage));
    }

    /**
     * 存储配置修改
     * @param sysConfigStorage 存储配置
     * @return R
     */
    @SysLog("修改存储配置")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('sys_configstorage_edit')")
    public R updateById(@RequestBody SysConfigStorage sysConfigStorage) {
		if(StrUtil.isNotBlank(sysConfigStorage.getId())){
			sysConfigStorageService.updateById(sysConfigStorage);
			return R.ok(sysConfigStorage);
		}else{
			sysConfigStorageService.save(sysConfigStorage);
			return R.ok(sysConfigStorage);
		}
    }

    /**
     * 存储配置删除
     * @param id
     * @return R
     */
    @SysLog("删除存储配置")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('sys_configstorage_del')")
    public R removeById(@PathVariable String id) {
        return R.ok(sysConfigStorageService.removeById(id));
    }

	/**
	 * 查询存储配置
	 * @return R
	 */
	@GetMapping()
	@PreAuthorize("@ato.hasAuthority('sys_configstorage_get')")
	public R get() {
		return R.ok(sysConfigStorageService.getOne(Wrappers.emptyWrapper()));
	}
}
