/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import com.joolun.cloud.mall.common.entity.MerchantSettled;
import com.joolun.cloud.mall.admin.service.MerchantSettledService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 商城入驻信息表
 *
 * @author zq
 * @date 2020-07-16 13:10:38
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/merchantsettled")
@Api(value = "merchantsettled", tags = "商城入驻信息表管理")
public class MerchantSettledController {

    private final MerchantSettledService merchantSettledService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param merchantSettled 商城入驻信息表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:merchantsettled:index')")
    public R getPage(Page page, MerchantSettled merchantSettled) {
        return R.ok(merchantSettledService.page(page, Wrappers.query(merchantSettled)));
    }

    /**
     * 商城入驻信息表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "商城入驻信息表查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:merchantsettled:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(merchantSettledService.getById(id));
    }

    /**
     * 商城入驻信息表新增
     * @param merchantSettled 商城入驻信息表
     * @return R
     */
    @ApiOperation(value = "商城入驻信息表新增")
    @SysLog("新增商城入驻信息表")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:merchantsettled:add')")
    public R save(@RequestBody MerchantSettled merchantSettled) {
        return R.ok(merchantSettledService.save(merchantSettled));
    }

    /**
     * 商城入驻信息表修改
     * @param merchantSettled 商城入驻信息表
     * @return R
     */
    @ApiOperation(value = "商城入驻信息表修改")
    @SysLog("修改商城入驻信息表")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:merchantsettled:edit')")
    public R updateById(@RequestBody MerchantSettled merchantSettled) {
        return R.ok(merchantSettledService.updateById(merchantSettled));
    }
	/**
	 * 商城入驻审核
	 * @param  merchantSettled
	 * @return R
	 */
	@ApiOperation(value = "商城入驻审核")
	@SysLog("商城入驻审核")
	@PutMapping("/updateMerchantSettled")
	@PreAuthorize("@ato.hasAuthority('mall:merchantsettled:edit')")
    public R updateMerchantSettled(@RequestBody MerchantSettled merchantSettled){
		return R.ok(merchantSettledService.updateMerchantSettled(merchantSettled));
	}


    /**
     * 商城入驻信息表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "商城入驻信息表删除")
    @SysLog("删除商城入驻信息表")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:merchantsettled:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(merchantSettledService.removeById(id));
    }
	/*
	 * 商家基本信息查询(有分页）
	 * page 分页对象
	 * */
	@ApiOperation(value = "商家基本信息查询")
	@GetMapping(value = "/getmerchants")
	@PreAuthorize("@ato.hasAuthority('mall:merchantsettled:get')")
	public  R getMerchants(Page page,MerchantSettled merchantSettled){
		return R.ok(merchantSettledService.getMerchants(page,merchantSettled));
	}
}
