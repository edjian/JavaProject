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
import com.joolun.cloud.mall.common.entity.InviteAwardDay;
import com.joolun.cloud.mall.admin.service.InviteAwardDayService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 邀新奖励天数表
 *
 * @author zq
 * @date 2020-08-03 14:55:27
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/inviteawardday")
@Api(value = "inviteawardday", tags = "邀新奖励天数表管理")
public class InviteAwardDayController {

    private final InviteAwardDayService inviteAwardDayService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param inviteAwardDay 邀新奖励天数表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:inviteawardday:index')")
    public R getPage(Page page, InviteAwardDay inviteAwardDay) {
        return R.ok(inviteAwardDayService.page(page, Wrappers.query(inviteAwardDay)));
    }

    /**
     * 邀新奖励天数表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "邀新奖励天数表查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:inviteawardday:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(inviteAwardDayService.getById(id));
    }

    /**
     * 邀新奖励天数表新增
     * @param inviteAwardDay 邀新奖励天数表
     * @return R
     */
    @ApiOperation(value = "邀新奖励天数表新增")
    @SysLog("新增邀新奖励天数表")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:inviteawardday:add')")
    public R save(@RequestBody InviteAwardDay inviteAwardDay) {
        return R.ok(inviteAwardDayService.save(inviteAwardDay));
    }

    /**
     * 邀新奖励天数表修改
     * @param inviteAwardDay 邀新奖励天数表
     * @return R
     */
    @ApiOperation(value = "邀新奖励天数表修改")
    @SysLog("修改邀新奖励天数表")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:inviteawardday:edit')")
    public R updateById(@RequestBody InviteAwardDay inviteAwardDay) {
        return R.ok(inviteAwardDayService.updateById(inviteAwardDay));
    }

    /**
     * 邀新奖励天数表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "邀新奖励天数表删除")
    @SysLog("删除邀新奖励天数表")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:inviteawardday:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(inviteAwardDayService.removeById(id));
    }

}
