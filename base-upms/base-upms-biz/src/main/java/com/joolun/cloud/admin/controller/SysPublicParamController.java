package com.joolun.cloud.admin.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.admin.api.entity.SysPublicParam;
import com.joolun.cloud.admin.service.SysPublicParamService;
import com.joolun.cloud.common.core.constant.CacheConstants;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import com.joolun.cloud.common.security.annotation.Inner;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;


/**
 * 公共参数
 *
 * @author
 */
@RestController
@AllArgsConstructor
@RequestMapping("/param")
@Api(value = "param", tags = "公共参数配置")
public class SysPublicParamController {

	private final SysPublicParamService sysPublicParamService;

	/**
	 * 通过key查询公共参数值
	 *
	 * @param publicKey
	 * @return
	 */
	@Inner(value = false)
	@ApiOperation(value = "查询公共参数值", notes = "根据key查询公共参数值")
	@ApiImplicitParams({@ApiImplicitParam(name = "publicKey", value = "键值，譬如：VERSION_INSTRUCTIONS", required = true)})
	@GetMapping("/publicValue/{publicKey}")
	public R publicKey(@PathVariable("publicKey") String publicKey) {
		return R.ok(sysPublicParamService.getSysPublicParamKeyToValue(publicKey));
	}

	/**
	 * 分页查询
	 *
	 * @param page           分页对象
	 * @param sysPublicParam 公共参数
	 * @return
	 */
	@GetMapping("/page")
	@ApiOperation(value = "分页查询", notes = "分页查询")
	public R getSysPublicParamPage(Page page, SysPublicParam sysPublicParam) {
		return R.ok(sysPublicParamService.page(page, Wrappers.query(sysPublicParam)));
	}


	/**
	 * 通过id查询公共参数
	 *
	 * @param publicId id
	 * @return R
	 */
	@GetMapping("/{publicId}")
	@ApiOperation(value = "通过id查询公共参数", notes = "通过id查询公共参数")
	public R getById(@PathVariable("publicId") Long publicId) {
		return R.ok(sysPublicParamService.getById(publicId));
	}

	/**
	 * 新增公共参数
	 *
	 * @param sysPublicParam 公共参数
	 * @return R
	 */
	@SysLog("新增公共参数")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('admin_syspublicparam_add')")
	@ApiOperation(value = "新增公共参数", notes = "新增公共参数")
	public R save(@RequestBody SysPublicParam sysPublicParam) {
		return R.ok(sysPublicParamService.save(sysPublicParam));
	}

	/**
	 * 修改公共参数
	 *
	 * @param sysPublicParam 公共参数
	 * @return R
	 */
	@SysLog("修改公共参数")
	@PutMapping
	@CacheEvict(value = CacheConstants.PARAMS_DETAILS, key = "#sysPublicParam.publicKey")
	@PreAuthorize("@pms.hasPermission('admin_syspublicparam_edit')")
	@ApiOperation(value = "修改公共参数", notes = "修改公共参数")
	public R updateById(@RequestBody SysPublicParam sysPublicParam) {
		return sysPublicParamService.updateParam(sysPublicParam);
	}

	/**
	 * 通过id删除公共参数
	 *
	 * @param publicId id
	 * @return R
	 */
	@SysLog("删除公共参数")
	@DeleteMapping("/{publicId}")
	@ApiOperation(value = "删除公共参数", notes = "删除公共参数")
	@PreAuthorize("@pms.hasPermission('admin_syspublicparam_del')")
	public R removeById(@PathVariable Long publicId) {
		return sysPublicParamService.removeParam(publicId);
	}

}
