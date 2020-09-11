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
import com.joolun.cloud.mall.common.entity.SetMeal;
import com.joolun.cloud.mall.admin.service.SetMealService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 套餐
 *
 * @author zq
 * @date 2020-07-08 13:53:21
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/setMeal")
@Api(value = "setMeal", tags = "套餐管理")
public class SetMealController {

    private final SetMealService setMealService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param setMeal 套餐
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:setmeal:index')")
    public R getPage(Page page, SetMeal setMeal) {
        return R.ok(setMealService.page(page, Wrappers.query(setMeal)));
    }

    /**
     * 套餐查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "套餐查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:setmeal:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(setMealService.getById(id));
    }

    /**
     * 套餐新增
     * @param setMeal 套餐
     * @return R
     */
    @ApiOperation(value = "套餐新增")
    @SysLog("新增套餐")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:setmeal:add')")
    public R save(@RequestBody SetMeal setMeal) {
        return R.ok(setMealService.save(setMeal));
    }

    /**
     * 套餐修改
     * @param setMeal 套餐
     * @return R
     */
    @ApiOperation(value = "套餐修改")
    @SysLog("修改套餐")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:setmeal:edit')")
    public R updateById(@RequestBody SetMeal setMeal) {
        return R.ok(setMealService.updateById(setMeal));
    }

    /**
     * 套餐删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "套餐删除")
    @SysLog("删除套餐")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:setmeal:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(setMealService.removeById(id));
    }

}
