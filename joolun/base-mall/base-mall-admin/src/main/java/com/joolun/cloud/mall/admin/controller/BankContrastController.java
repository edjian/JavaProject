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
import com.joolun.cloud.mall.common.entity.BankContrast;
import com.joolun.cloud.mall.admin.service.BankContrastService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 银行关联表
 *
 * @author zq
 * @date 2020-08-07 10:34:56
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/bankcontrast")
@Api(value = "bankcontrast", tags = "银行关联表管理")
public class BankContrastController {

    private final BankContrastService bankContrastService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param bankContrast 银行关联表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:bankcontrast:index')")
    public R getPage(Page page, BankContrast bankContrast) {
        return R.ok(bankContrastService.page(page, Wrappers.query(bankContrast)));
    }

    /**
     * 银行关联表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "银行关联表查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:bankcontrast:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(bankContrastService.getById(id));
    }

    /**
     * 银行关联表新增
     * @param bankContrast 银行关联表
     * @return R
     */
    @ApiOperation(value = "银行关联表新增")
    @SysLog("新增银行关联表")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:bankcontrast:add')")
    public R save(@RequestBody BankContrast bankContrast) {
        return R.ok(bankContrastService.save(bankContrast));
    }

    /**
     * 银行关联表修改
     * @param bankContrast 银行关联表
     * @return R
     */
    @ApiOperation(value = "银行关联表修改")
    @SysLog("修改银行关联表")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:bankcontrast:edit')")
    public R updateById(@RequestBody BankContrast bankContrast) {
        return R.ok(bankContrastService.updateById(bankContrast));
    }

    /**
     * 银行关联表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "银行关联表删除")
    @SysLog("删除银行关联表")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:bankcontrast:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(bankContrastService.removeById(id));
    }

}
