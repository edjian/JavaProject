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
import com.joolun.cloud.mall.admin.service.UserMealService;
import com.joolun.cloud.mall.common.entity.UserMeal;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 用户套餐表
 *
 * @author zq
 * @date 2020-07-17 15:24:20
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/usermeal")
@Api(value = "usermeal", tags = "用户套餐表管理")
public class UserMealController {

    private final UserMealService userMealService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param userMeal 用户套餐表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:usermeal:index')")
    public R getPage(Page page, UserMeal userMeal) {
        return R.ok(userMealService.page(page, Wrappers.query(userMeal)));
    }

    /**
     * 用户套餐表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "用户套餐表查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:usermeal:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(userMealService.getById(id));
    }

    /**
     * 用户套餐表新增
     * @param userMeal 用户套餐表
     * @return R
     */
    @ApiOperation(value = "用户套餐表新增")
    @SysLog("新增用户套餐表")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:usermeal:add')")
    public R save(@RequestBody UserMeal userMeal) {
        return R.ok(userMealService.save(userMeal));
    }

    /**
     * 用户套餐表修改
     * @param userMeal 用户套餐表
     * @return R
     */
    @ApiOperation(value = "用户套餐表修改")
    @SysLog("修改用户套餐表")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:usermeal:edit')")
    public R updateById(@RequestBody UserMeal userMeal) {
        return R.ok(userMealService.updateById(userMeal));
    }

    /**
     * 用户套餐表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "用户套餐表删除")
    @SysLog("删除用户套餐表")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:usermeal:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(userMealService.removeById(id));
    }

//	/**
//	 * 会员等级通知
//	 * @param userMeal
//	 * @return R
//	 */
//	@ApiOperation(value = "会员等级通知")
//	@GetMapping("/membershipLevelChange")
//	@PreAuthorize("@ato.hasAuthority('mall:usermeal:get')")
//	public R membershipLevelChange(@RequestBody UserMeal userMeal) {
//		return R.ok(userMealService.membershipLevelChange(userMeal));
//	}
}
