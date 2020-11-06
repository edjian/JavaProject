/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.api.ma;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.joolun.cloud.common.core.util.R;
import com.joolun.cloud.common.log.annotation.SysLog;
import com.joolun.cloud.mall.admin.service.BusinessCollegeAppraisesService;
import com.joolun.cloud.mall.common.entity.BusinessCollegeAppraises;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 商学院评价表
 *
 * @author zq
 * @date 2020-11-04 09:24:53
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/api/ma/businesscollegeappraises")
@Api(value = "businesscollegeappraises", tags = "商学院评价表管理")
public class BusinessCollegeAppraisesApi {

    private final BusinessCollegeAppraisesService businessCollegeAppraisesService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param businessCollegeAppraises 商学院评价表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    public R getPage(Page page, BusinessCollegeAppraises businessCollegeAppraises) {
        return R.ok(businessCollegeAppraisesService.page(page, Wrappers.query(businessCollegeAppraises)));
    }

    /**
     * 商学院评价表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "商学院评价表查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id) {
        return R.ok(businessCollegeAppraisesService.getById(id));
    }

    /**
     * 商学院评价表新增
     * @param businessCollegeAppraises 商学院评价表
     * @return R
     */
    @ApiOperation(value = "商学院评价表新增")
    @SysLog("新增商学院评价表")
    @PostMapping
    public R save(@RequestBody BusinessCollegeAppraises businessCollegeAppraises) {
        return R.ok(businessCollegeAppraisesService.save(businessCollegeAppraises));
    }

    /**
     * 商学院评价表修改
     * @param businessCollegeAppraises 商学院评价表
     * @return R
     */
    @ApiOperation(value = "商学院评价表修改")
    @SysLog("修改商学院评价表")
    @PutMapping
    public R updateById(@RequestBody BusinessCollegeAppraises businessCollegeAppraises) {
        return R.ok(businessCollegeAppraisesService.updateById(businessCollegeAppraises));
    }

    /**
     * 商学院评价表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "商学院评价表删除")
    @SysLog("删除商学院评价表")
    @DeleteMapping("/{id}")
    public R removeById(@PathVariable String id) {
        return R.ok(businessCollegeAppraisesService.removeById(id));
    }

}
