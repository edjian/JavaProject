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
import com.joolun.cloud.mall.common.entity.BusinessCollegeCategory;
import com.joolun.cloud.mall.admin.service.BusinessCollegeCategoryService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 商学院课程分类表
 *
 * @author zq
 * @date 2020-11-03 10:54:47
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/businesscollegecategory")
@Api(value = "businesscollegecategory", tags = "商学院课程分类表管理")
public class BusinessCollegeCategoryController {

    private final BusinessCollegeCategoryService businessCollegeCategoryService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param businessCollegeCategory 商学院课程分类表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegecategory:index')")
    public R getPage(Page page, BusinessCollegeCategory businessCollegeCategory) {
        return R.ok(businessCollegeCategoryService.page(page, Wrappers.query(businessCollegeCategory)));
    }

    /**
     * 商学院课程分类表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "商学院课程分类表查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegecategory:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(businessCollegeCategoryService.getById(id));
    }

    /**
     * 商学院课程分类表新增
     * @param businessCollegeCategory 商学院课程分类表
     * @return R
     */
    @ApiOperation(value = "商学院课程分类表新增")
    @SysLog("新增商学院课程分类表")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegecategory:add')")
    public R save(@RequestBody BusinessCollegeCategory businessCollegeCategory) {
        return R.ok(businessCollegeCategoryService.save(businessCollegeCategory));
    }

    /**
     * 商学院课程分类表修改
     * @param businessCollegeCategory 商学院课程分类表
     * @return R
     */
    @ApiOperation(value = "商学院课程分类表修改")
    @SysLog("修改商学院课程分类表")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegecategory:edit')")
    public R updateById(@RequestBody BusinessCollegeCategory businessCollegeCategory) {
        return R.ok(businessCollegeCategoryService.updateById(businessCollegeCategory));
    }

    /**
     * 商学院课程分类表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "商学院课程分类表删除")
    @SysLog("删除商学院课程分类表")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegecategory:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(businessCollegeCategoryService.removeById(id));
    }

}
