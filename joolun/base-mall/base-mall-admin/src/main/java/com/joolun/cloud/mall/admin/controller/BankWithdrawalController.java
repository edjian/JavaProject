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
import com.joolun.cloud.mall.common.entity.BankWithdrawal;
import com.joolun.cloud.mall.admin.service.BankWithdrawalService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 银行提现表
 *
 * @author zq
 * @date 2020-08-21 10:41:42
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/bankwithdrawal")
@Api(value = "bankwithdrawal", tags = "银行提现表管理")
public class BankWithdrawalController {

    private final BankWithdrawalService bankWithdrawalService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param bankWithdrawal 银行提现表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    @PreAuthorize("@ato.hasAuthority('mall:bankwithdrawal:index')")
    public R getPage(Page page, BankWithdrawal bankWithdrawal) {
        return R.ok(bankWithdrawalService.page(page, Wrappers.query(bankWithdrawal)));
    }

    /**
     * 银行提现表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "银行提现表查询")
    @GetMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:bankwithdrawal:get')")
    public R getById(@PathVariable("id") String id) {
        return R.ok(bankWithdrawalService.getById(id));
    }
    /**
     * 银行提现表新增
     * @param bankWithdrawal 银行提现表
     * @return R
     */
    @ApiOperation(value = "银行提现表新增")
    @SysLog("新增银行提现表")
    @PostMapping
    @PreAuthorize("@ato.hasAuthority('mall:bankwithdrawal:add')")
    public R save(@RequestBody BankWithdrawal bankWithdrawal) {
        return R.ok(bankWithdrawalService.save(bankWithdrawal));
    }

    /**
     * 银行提现表修改
     * @param bankWithdrawal 银行提现表
     * @return R
     */
    @ApiOperation(value = "银行提现表修改")
    @SysLog("修改银行提现表")
    @PutMapping
    @PreAuthorize("@ato.hasAuthority('mall:bankwithdrawal:edit')")
    public R updateById(@RequestBody BankWithdrawal bankWithdrawal) {
        return R.ok(bankWithdrawalService.updateById(bankWithdrawal));
    }

	/**
	 * 银行提现表 提现审核结果修改
	 * @param  bankWithdrawal
	 * @return R
	 */
	@ApiOperation(value = "提现审核结果")
	@SysLog("提现审核结果")
	@PutMapping("/editauditresult")
	@PreAuthorize("@ato.hasAuthority('mall:bankwithdrawal:edit')")
	public R drawalAuditSuccessResult(@RequestBody BankWithdrawal bankWithdrawal){
		return R.ok(bankWithdrawalService.drawalAuditResult(bankWithdrawal));
	}

    /**
     * 银行提现表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "银行提现表删除")
    @SysLog("删除银行提现表")
    @DeleteMapping("/{id}")
    @PreAuthorize("@ato.hasAuthority('mall:bankwithdrawal:del')")
    public R removeById(@PathVariable String id) {
        return R.ok(bankWithdrawalService.removeById(id));
    }

}
