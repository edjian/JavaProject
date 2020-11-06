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
import com.joolun.cloud.mall.admin.service.BusinessCollegeCourseService;
import com.joolun.cloud.mall.common.dto.CourseDetailDTO;
import com.joolun.cloud.mall.common.entity.BusinessCollegeCourse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.repository.query.RedisOperationChain;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 商学院课程表
 *
 * @author zq
 * @date 2020-11-03 16:22:39
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/api/ma/businesscollegecourse")
@Api(value = "businesscollegecourse", tags = "商学院课程表管理")
public class BusinessCollegeCourseApi {

    private final BusinessCollegeCourseService businessCollegeCourseService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param businessCollegeCourse 商学院课程表
     * @return
     */
    @ApiOperation(value = "分页列表")
    @GetMapping("/page")
    public R getPage(Page page, BusinessCollegeCourse businessCollegeCourse) {
        return R.ok(businessCollegeCourseService.page(page, Wrappers.query(businessCollegeCourse)));
    }

    /**
     * 商学院课程表查询
     * @param id
     * @return R
     */
    @ApiOperation(value = "商学院课程表查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id) {
        return R.ok(businessCollegeCourseService.getById(id));
    }

    /**
     * 商学院课程表新增
     * @param businessCollegeCourse 商学院课程表
     * @return R
     */
    @ApiOperation(value = "商学院课程表新增")
    @SysLog("新增商学院课程表")
    @PostMapping
    public R save(@RequestBody BusinessCollegeCourse businessCollegeCourse) {
        return R.ok(businessCollegeCourseService.save(businessCollegeCourse));
    }

    /**
     * 商学院课程表修改
     * @param businessCollegeCourse 商学院课程表
     * @return R
     */
    @ApiOperation(value = "商学院课程表修改")
    @SysLog("修改商学院课程表")
    @PutMapping
    public R updateById(@RequestBody BusinessCollegeCourse businessCollegeCourse) {
        return R.ok(businessCollegeCourseService.updateById(businessCollegeCourse));
    }

    /**
     * 商学院课程表删除
     * @param id
     * @return R
     */
    @ApiOperation(value = "商学院课程表删除")
    @SysLog("删除商学院课程表")
    @DeleteMapping("/{id}")
    public R removeById(@PathVariable String id) {
        return R.ok(businessCollegeCourseService.removeById(id));
    }


	/**
	 * 商学院课程详情
	 * @param id
	 * @return R
	 */
	@ApiOperation(value = "商学院课程详情")
	//@SysLog("查询商学院课程详情")
	@GetMapping("/detail/{id}")
	public R courseDetail(@PathVariable("id") String id) {
		return R.ok(businessCollegeCourseService.courseDetail(id));
	}

	/**
	 * 相关推荐
	 * @param id
	 * @return R
	 */
	@ApiOperation(value = "随机五个相关推荐")
	//@SysLog("相关推荐")
	@GetMapping("/randomCourse/{id}")
	public R randomCourse(@PathVariable("id") String id) {
		return R.ok(businessCollegeCourseService.randomCourse(id));
	}
}
