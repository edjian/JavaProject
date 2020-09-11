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
import com.joolun.cloud.mall.common.entity.BankCard;
import com.joolun.cloud.mall.admin.service.BankCardService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 银行卡号
 *
 * @author zq
 * @date 2020-08-06 17:37:35
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/bankcard")
@Api(value = "bankcard", tags = "银行卡号管理")
public class BankCardController {

    private final BankCardService bankCardService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param bankCard 银行卡号
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:bankcard:index')")
    public R getPage(Page page, BankCard bankCard) {
        return R.ok(bankCardService.page(page, Wrappers.query(bankCard)));
    }

    /**
     * 银行卡号查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "银行卡号查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:bankcard:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(bankCardService.getById(id));
    }

    /**
     * 银行卡号新增
     * @param bankCard 银行卡号
     * @return R
     */
    @ApiOperation(value = "银行卡号新增")
    @SysLog("新增银行卡号")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:bankcard:add')")
    public R save(@RequestBody BankCard bankCard) {
        return R.ok(bankCardService.save(bankCard));
    }

    /**
     * 银行卡号修改
     * @param bankCard 银行卡号
     * @return R
     */
    @ApiOperation(value = "银行卡号修改")
    @SysLog("修改银行卡号")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:bankcard:edit')")
    public R updateById(@RequestBody BankCard bankCard) {
        return R.ok(bankCardService.updateById(bankCard));
    }

    /**
     * 银行卡号删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "银行卡号删除")
    @SysLog("删除银行卡号")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:bankcard:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(bankCardService.removeById(id));
    }

}
