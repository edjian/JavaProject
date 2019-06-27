package com.joolun.cloud.codegen.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.codegen.entity.SysDatasourceConf;
import com.joolun.cloud.codegen.service.SysDatasourceConfService;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;


/**
 * 数据源管理
 *
 * @author
 */
@RestController
@AllArgsConstructor
@RequestMapping("/dsconf")
public class SysDatasourceConfController {
	private final SysDatasourceConfService sysDatasourceConfService;

	/**
	 * 分页查询
	 *
	 * @param page              分页对象
	 * @param sysDatasourceConf 数据源表
	 * @return
	 */
	@GetMapping("/page")
	public R getSysDatasourceConfPage(Page page, SysDatasourceConf sysDatasourceConf) {
		return R.ok(sysDatasourceConfService.page(page, Wrappers.query(sysDatasourceConf)));
	}

	/**
	 * 查询全部数据源
	 *
	 * @return
	 */
	@GetMapping("/list")
	public R list() {
		return R.ok(sysDatasourceConfService.list());
	}


	/**
	 * 通过id查询数据源表
	 *
	 * @param id id
	 * @return R
	 */
	@GetMapping("/{id}")
	public R getById(@PathVariable("id") Integer id) {
		return R.ok(sysDatasourceConfService.getById(id));
	}

	/**
	 * 新增数据源表
	 *
	 * @param sysDatasourceConf 数据源表
	 * @return R
	 */
	@SysLog("新增数据源表")
	@PostMapping
	public R save(@RequestBody SysDatasourceConf sysDatasourceConf) {
		return R.ok(sysDatasourceConfService.saveDsByEnc(sysDatasourceConf));
	}

	/**
	 * 修改数据源表
	 *
	 * @param sysDatasourceConf 数据源表
	 * @return R
	 */
	@SysLog("修改数据源表")
	@PutMapping
	public R updateById(@RequestBody SysDatasourceConf sysDatasourceConf) {
		return R.ok(sysDatasourceConfService.updateDsByEnc(sysDatasourceConf));
	}

	/**
	 * 通过id删除数据源表
	 *
	 * @param id id
	 * @return R
	 */
	@SysLog("删除数据源表")
	@DeleteMapping("/{id}")
	public R removeById(@PathVariable Integer id) {
		return R.ok(sysDatasourceConfService.removeById(id));
	}

}
