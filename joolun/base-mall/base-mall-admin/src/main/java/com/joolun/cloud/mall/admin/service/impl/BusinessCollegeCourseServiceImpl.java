/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.BeanUtils;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.conditions.query.QueryChainWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.mall.admin.mapper.BusinessCollegeCollectMapper;
import com.joolun.cloud.mall.admin.service.*;
import com.joolun.cloud.mall.common.dto.CourseDetailDTO;
import com.joolun.cloud.mall.common.entity.BusinessCollegeCollect;
import com.joolun.cloud.mall.common.entity.BusinessCollegeCourse;
import com.joolun.cloud.mall.admin.mapper.BusinessCollegeCourseMapper;
import com.joolun.cloud.mall.common.entity.BusinessCollegeHistory;
import com.joolun.cloud.mall.common.entity.BusinessCollegeRelation;
import com.joolun.cloud.mall.common.util.StringUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.validation.constraints.NotNull;
import java.sql.Time;
import java.sql.Wrapper;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;

/**
 * 商学院课程表
 *
 * @author zq
 * @date 2020-11-03 16:22:39
 */
@Service
@AllArgsConstructor
public class BusinessCollegeCourseServiceImpl extends ServiceImpl<BusinessCollegeCourseMapper, BusinessCollegeCourse> implements BusinessCollegeCourseService {
	private final BusinessCollegeTextService businessCollegeTextService;
	private final BusinessCollegePictureService businessCollegePictureService;
	private final BusinessCollegeVideoService businessCollegeVideoService;
	private final BusinessCollegeRelationService businessCollegeRelationService;
	private final BusinessCollegeCollectService businessCollegeCollectService;

	/**
	 * 查询课程详情
	 * @param
	 * @return
	 */
	@Override
	public CourseDetailDTO courseDetail(String courseId,String userId) {
		CourseDetailDTO courseDetailDTO = new CourseDetailDTO();
		BusinessCollegeCourse course = this.getById(courseId);
		BeanUtil.copyProperties(course,courseDetailDTO);
		QueryWrapper<BusinessCollegeCollect> wrapper = new QueryWrapper();
		wrapper.lambda().eq(BusinessCollegeCollect::getCourseId, courseId).eq(BusinessCollegeCollect::getUserId, userId);
		BusinessCollegeCollect Collect = businessCollegeCollectService.getOne(wrapper);
		if (Objects.nonNull(Collect)) {
			courseDetailDTO.setCollected(Collect.getCollected());
		}
		BusinessCollegeRelation relation = businessCollegeRelationService.getById(this.getById(courseId).getRelationId());
		if (StringUtil.isNotBlank(relation.getTextId())) {
			courseDetailDTO.setContent(businessCollegeTextService.getById(relation.getTextId()).getContent());
		}
		if (StringUtil.isNotBlank(relation.getPicId())) {
			courseDetailDTO.setPicUrls(businessCollegePictureService.getById(relation.getPicId()).getPicUrls());
		}if (StringUtil.isNotBlank(relation.getVideoId())) {
			courseDetailDTO.setVideoUrl(businessCollegeVideoService.getById(relation.getVideoId()).getVideoUrl());
		}
		return courseDetailDTO;
	}

	/**
	 * 查询五个随机课程
	 * @param
	 * @return
	 */
	@Override
	public List<CourseDetailDTO> randomCourse(String courseId) {
		List<CourseDetailDTO> list = new ArrayList<>();
		QueryWrapper<BusinessCollegeCourse> wrapper = new QueryWrapper();
		wrapper.lambda().eq(BusinessCollegeCourse::getCategorySecond, this.getById(courseId).getCategorySecond());
		List<BusinessCollegeCourse> courseList = this.list(wrapper);
		Random r = new Random();
		Set<Integer> set = new HashSet<>();
		while (set.size() < 5) {
			set.add(r.nextInt(courseList.size()));
		}
		Iterator iterator = set.iterator();
		while (iterator.hasNext()) {
			int random = (int)iterator.next();
			BusinessCollegeCourse businessCollegeCourse = courseList.get(random);
			CourseDetailDTO courseDetailDTO = new CourseDetailDTO();
			BeanUtil.copyProperties(businessCollegeCourse, courseDetailDTO);
			LocalDateTime createTime = businessCollegeCourse.getCreateTime();
			Duration duration = Duration.between(createTime, LocalDateTime.now());
			long l = duration.toDays();
			if (duration.toDays() > 7) {
				courseDetailDTO.setIsNew(2);
			} else {
				courseDetailDTO.setIsNew(1);
			}
			BusinessCollegeRelation relation = businessCollegeRelationService.getById(businessCollegeCourse.getRelationId());
			courseDetailDTO.setPicUrls(businessCollegePictureService.getById(relation.getPicId()).getPicUrls());
			list.add(courseDetailDTO);
		}
		return list;
	}
}
