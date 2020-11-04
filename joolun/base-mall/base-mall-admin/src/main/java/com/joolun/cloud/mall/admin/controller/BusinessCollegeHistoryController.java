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
import com.joolun.cloud.mall.common.entity.BusinessCollegeHistory;
import com.joolun.cloud.mall.admin.service.BusinessCollegeHistoryService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 商学院课程浏览记录
 *
 * @author zq
 * @date 2020-11-04 09:24:22
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/businesscollegehistory")
@Api(value = "businesscollegehistory", tags = "商学院课程浏览记录管理")
public class BusinessCollegeHistoryController {

    private final BusinessCollegeHistoryService businessCollegeHistoryService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param businessCollegeHistory 商学院课程浏览记录
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegehistory:index')")
    public R getPage(Page page, BusinessCollegeHistory businessCollegeHistory) {
        return R.ok(businessCollegeHistoryService.page(page, Wrappers.query(businessCollegeHistory)));
    }

    /**
     * 商学院课程浏览记录查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "商学院课程浏览记录查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegehistory:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(businessCollegeHistoryService.getById(id));
    }

    /**
     * 商学院课程浏览记录新增
     * @param businessCollegeHistory 商学院课程浏览记录
     * @return R
     */
    @ApiOperation(value = "商学院课程浏览记录新增")
    @SysLog("新增商学院课程浏览记录")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegehistory:add')")
    public R save(@RequestBody BusinessCollegeHistory businessCollegeHistory) {
        return R.ok(businessCollegeHistoryService.save(businessCollegeHistory));
    }

    /**
     * 商学院课程浏览记录修改
     * @param businessCollegeHistory 商学院课程浏览记录
     * @return R
     */
    @ApiOperation(value = "商学院课程浏览记录修改")
    @SysLog("修改商学院课程浏览记录")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegehistory:edit')")
    public R updateById(@RequestBody BusinessCollegeHistory businessCollegeHistory) {
        return R.ok(businessCollegeHistoryService.updateById(businessCollegeHistory));
    }

    /**
     * 商学院课程浏览记录删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "商学院课程浏览记录删除")
    @SysLog("删除商学院课程浏览记录")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:businesscollegehistory:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(businessCollegeHistoryService.removeById(id));
    }

}
