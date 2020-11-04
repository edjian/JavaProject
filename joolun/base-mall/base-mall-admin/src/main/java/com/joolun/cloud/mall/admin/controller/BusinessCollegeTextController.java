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
import com.joolun.cloud.mall.common.entity.BusinessCollegeText;
import com.joolun.cloud.mall.admin.service.BusinessCollegeTextService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 商学院文本表
 *
 * @author zq
 * @date 2020-11-04 09:21:48
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/businesscollegetext")
@Api(value = "businesscollegetext", tags = "商学院文本表管理")
public class BusinessCollegeTextController {

    private final BusinessCollegeTextService businessCollegeTextService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param businessCollegeText 商学院文本表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegetext:index')")
    public R getPage(Page page, BusinessCollegeText businessCollegeText) {
        return R.ok(businessCollegeTextService.page(page, Wrappers.query(businessCollegeText)));
    }

    /**
     * 商学院文本表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "商学院文本表查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegetext:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(businessCollegeTextService.getById(id));
    }

    /**
     * 商学院文本表新增
     * @param businessCollegeText 商学院文本表
     * @return R
     */
    @ApiOperation(value = "商学院文本表新增")
    @SysLog("新增商学院文本表")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegetext:add')")
    public R save(@RequestBody BusinessCollegeText businessCollegeText) {
        return R.ok(businessCollegeTextService.save(businessCollegeText));
    }

    /**
     * 商学院文本表修改
     * @param businessCollegeText 商学院文本表
     * @return R
     */
    @ApiOperation(value = "商学院文本表修改")
    @SysLog("修改商学院文本表")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegetext:edit')")
    public R updateById(@RequestBody BusinessCollegeText businessCollegeText) {
        return R.ok(businessCollegeTextService.updateById(businessCollegeText));
    }

    /**
     * 商学院文本表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "商学院文本表删除")
    @SysLog("删除商学院文本表")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegetext:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(businessCollegeTextService.removeById(id));
    }

}
