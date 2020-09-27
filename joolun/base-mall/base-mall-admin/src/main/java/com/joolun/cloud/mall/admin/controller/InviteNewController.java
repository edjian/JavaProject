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
import com.joolun.cloud.mall.common.entity.InviteNew;
import com.joolun.cloud.mall.admin.service.InviteNewService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 邀新表
 *
 * @author zq
 * @date 2020-07-09 15:06:47
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/invitenew")
@Api(value = "invitenew", tags = "邀新表管理")
public class InviteNewController {

    private final InviteNewService inviteNewService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param inviteNew 邀新表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:invitenew:index')")
    public R getPage(Page page, InviteNew inviteNew) {
        return R.ok(inviteNewService.page(page, Wrappers.query(inviteNew)));
    }

    /**
     * 邀新表查询
     * @param userIdFirst
     * @return R
     */
    @ApiOperation(value = "邀新表查询")
    @GetMapping("/{userIdFirst}")
    @PreAuthorize("@ato.hasAuthority('mall:invitenew:get')")
    public R getById(@PathVariable("userIdFirst") String userIdFirst) {
        return R.ok(inviteNewService.getById(userIdFirst));
    }

    /**
     * 邀新表新增
     * @param inviteNew 邀新表
     * @return R
     */
    @ApiOperation(value = "邀新表新增")
    @SysLog("新增邀新表")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:invitenew:add')")
    public R save(@RequestBody InviteNew inviteNew) {
        return R.ok(inviteNewService.save(inviteNew));
    }

    /**
     * 邀新表修改
     * @param inviteNew 邀新表
     * @return R
     */
    @ApiOperation(value = "邀新表修改")
    @SysLog("修改邀新表")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:invitenew:edit')")
    public R updateById(@RequestBody InviteNew inviteNew) {
        return R.ok(inviteNewService.updateById(inviteNew));
    }

//	/**
//	 * 邀新表邀新状态修改并通知
//	 * @param inviteNew 邀新表
//	 * @return R
//	 */
//	@ApiOperation(value = "邀新表邀新状态修改")
//	@SysLog("修改邀新表邀新状态")
//	@PutMapping("/updateInviteNewStatus")
//	@PreAuthorize("@ato.hasAuthority('mall:invitenew:edit')")
//	public R updateInviteNewStatus(@RequestBody InviteNew inviteNew) {
//		return R.ok(inviteNewService.updateInviteNewStatus(inviteNew));
//	}

    /**
     * 邀新表删除
     * @param userIdFirst
     * @return R
     */
    @ApiOperation(value = "邀新表删除")
    @SysLog("删除邀新表")
    @DeleteMapping("/{userIdFirst}")
    @PreAuthorize("@ato.hasAuthority('mall:invitenew:del')")
    public R removeById(@PathVariable String userIdFirst) {
        return R.ok(inviteNewService.removeById(userIdFirst));
    }

}
