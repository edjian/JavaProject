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
import com.joolun.cloud.mall.common.entity.ShareTask;
import com.joolun.cloud.mall.admin.service.ShareTaskService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 分享任务表
 *
 * @author zq
 * @date 2020-07-09 15:36:56
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/sharetask")
@Api(value = "sharetask", tags = "分享任务表管理")
public class ShareTaskController {

    private final ShareTaskService shareTaskService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param shareTask 分享任务表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:sharetask:index')")
    public R getPage(Page page, ShareTask shareTask) {
        return R.ok(shareTaskService.page(page, Wrappers.query(shareTask)));
    }

    /**
     * 分享任务表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "分享任务表查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:sharetask:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(shareTaskService.getById(id));
    }

    /**
     * 分享任务表新增
     * @param shareTask 分享任务表
     * @return R
     */
    @ApiOperation(value = "分享任务表新增")
    @SysLog("新增分享任务表")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:sharetask:add')")
    public R save(@RequestBody ShareTask shareTask) {
        return R.ok(shareTaskService.save(shareTask));
    }

    /**
     * 分享任务表修改
     * @param shareTask 分享任务表
     * @return R
     */
    @ApiOperation(value = "分享任务表修改")
    @SysLog("修改分享任务表")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:sharetask:edit')")
    public R updateById(@RequestBody ShareTask shareTask) {
        return R.ok(shareTaskService.updateById(shareTask));
    }

    /**
     * 分享任务表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "分享任务表删除")
    @SysLog("删除分享任务表")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:sharetask:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(shareTaskService.removeById(id));
    }

}
