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
import com.joolun.cloud.mall.common.entity.ShareRecord;
import com.joolun.cloud.mall.admin.service.ShareRecordService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 用户分享任务记录表
 *
 * @author zq
 * @date 2020-07-16 13:17:33
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/sharerecord")
@Api(value = "sharerecord", tags = "用户分享任务记录表管理")
public class ShareRecordController {

    private final ShareRecordService shareRecordService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param shareRecord 用户分享任务记录表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:sharerecord:index')")
    public R getPage(Page page, ShareRecord shareRecord) {
        return R.ok(shareRecordService.page(page, Wrappers.query(shareRecord)));
    }

    /**
     * 用户分享任务记录表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "用户分享任务记录表查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:sharerecord:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(shareRecordService.getById(id));
    }

    /**
     * 用户分享任务记录表新增
     * @param shareRecord 用户分享任务记录表
     * @return R
     */
    @ApiOperation(value = "用户分享任务记录表新增")
    @SysLog("新增用户分享任务记录表")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:sharerecord:add')")
    public R save(@RequestBody ShareRecord shareRecord) {
        return R.ok(shareRecordService.save(shareRecord));
    }

    /**
     * 用户分享任务记录表修改
     * @param shareRecord 用户分享任务记录表
     * @return R
     */
    @ApiOperation(value = "用户分享任务记录表修改")
    @SysLog("修改用户分享任务记录表")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:sharerecord:edit')")
    public R updateById(@RequestBody ShareRecord shareRecord) {
        return R.ok(shareRecordService.updateById(shareRecord));
    }

    /**
     * 用户分享任务记录表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "用户分享任务记录表删除")
    @SysLog("删除用户分享任务记录表")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:sharerecord:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(shareRecordService.removeById(id));
    }

}
