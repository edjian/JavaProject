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
import com.joolun.cloud.mall.admin.service.ForbiddenWordsService;
import com.joolun.cloud.mall.common.entity.ForbiddenWords;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 违禁词表
 *
 * @author zq
 * @date 2020-10-08 14:12:20
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/forbiddenwords")
@Api(value = "forbiddenwords", tags = "违禁词表管理")
public class ForbiddenWordsController {

    private final ForbiddenWordsService forbiddenWordsService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param forbiddenWords 违禁词表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:forbiddenwords:index')")
    public R getPage(Page page, ForbiddenWords forbiddenWords) {
        return R.ok(forbiddenWordsService.page(page, Wrappers.query(forbiddenWords)));
    }

    /**
     * 违禁词表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "违禁词表查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:forbiddenwords:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(forbiddenWordsService.getById(id));
    }

    /**
     * 违禁词表新增
     * @param forbiddenWords 违禁词表
     * @return R
     */
    @ApiOperation(value = "违禁词表新增")
    @SysLog("新增违禁词表")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:forbiddenwords:add')")
    public R save(@RequestBody ForbiddenWords forbiddenWords) {
        return R.ok(forbiddenWordsService.save(forbiddenWords));
    }

    /**
     * 违禁词表修改
     * @param forbiddenWords 违禁词表
     * @return R
     */
    @ApiOperation(value = "违禁词表修改")
    @SysLog("修改违禁词表")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:forbiddenwords:edit')")
    public R updateById(@RequestBody ForbiddenWords forbiddenWords) {
        return R.ok(forbiddenWordsService.updateById(forbiddenWords));
    }

    /**
     * 违禁词表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "违禁词表删除")
    @SysLog("删除违禁词表")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:forbiddenwords:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(forbiddenWordsService.removeById(id));
    }

}
