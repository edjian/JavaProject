/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.joolun.cloud.mall.admin.service.*;
import com.joolun.cloud.mall.common.dto.CourseDetailDTO;
import com.joolun.cloud.mall.common.entity.BusinessCollegeCourse;
import com.joolun.cloud.mall.admin.mapper.BusinessCollegeCourseMapper;
import com.joolun.cloud.mall.common.entity.BusinessCollegeHistory;
import com.joolun.cloud.mall.common.entity.BusinessCollegeRelation;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.sql.Wrapper;
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
	private final BusinessCollegeHistoryService businessCollegeHistoryService;

	/**
	 * 查询课程详情
	 * @param id
	 * @return
	 */
	@Override
	public CourseDetailDTO courseDetail(String id) {
		CourseDetailDTO courseDetailDTO = new CourseDetailDTO();
		BusinessCollegeCourse course = this.getById(id);
		courseDetailDTO.setId(id);
		courseDetailDTO.setName(course.getName());
		courseDetailDTO.setCollectedNum(course.getCollectedNum());
		courseDetailDTO.setCreateTime(course.getCreateTime());
		courseDetailDTO.setHistory(businessCollegeHistoryService.getOne(Wrappers.<BusinessCollegeHistory>lambdaQuery().eq(BusinessCollegeHistory::getCourseId,id),false).getHistory());
		BusinessCollegeRelation relation = businessCollegeRelationService.getById(this.getById(id).getRelationId());
		courseDetailDTO.setContent(businessCollegeTextService.getById(relation.getTextId()).getContent());
		courseDetailDTO.setPicUrls(businessCollegePictureService.getById(relation.getPicId()).getPicUrls());
		courseDetailDTO.setVideoUrl(businessCollegeVideoService.getById(relation.getVideoId()).getVideoUrl());
		return courseDetailDTO;
	}

	/**
	 * 查询五个随机课程
	 * @param id
	 * @return
	 */
	@Override
	public List<CourseDetailDTO> randomCourse(String id) {
		List<CourseDetailDTO> list = new ArrayList<>();
		QueryWrapper<BusinessCollegeCourse> wrapper = new QueryWrapper();
		wrapper.lambda().eq(BusinessCollegeCourse::getCategorySecond, this.getById(id).getCategorySecond());
		List<BusinessCollegeCourse> courseList = this.list(wrapper);
		Random random = new Random();
		Set<Integer> set = new HashSet<>();
		while (set.size() < 5) {
			set.add(random.nextInt(courseList.size()));
		}
		Iterator iterator = set.iterator();
		while (iterator.hasNext()) {
			int randomId = (int)iterator.next();
			CourseDetailDTO courseDetailDTO = new CourseDetailDTO();
			BusinessCollegeCourse course = courseList.get(randomId);
			courseDetailDTO.setId(course.getId());
			courseDetailDTO.setName(course.getName());
			courseDetailDTO.setCollectedNum(course.getCollectedNum());
			courseDetailDTO.setCreateTime(course.getCreateTime());
			courseDetailDTO.setHistory(businessCollegeHistoryService.getOne(Wrappers.<BusinessCollegeHistory>lambdaQuery().eq(BusinessCollegeHistory::getCourseId,course.getId()),false).getHistory());
			BusinessCollegeRelation relation = businessCollegeRelationService.getById(courseList.get(randomId).getRelationId());
			courseDetailDTO.setPicUrls(businessCollegePictureService.getById(relation.getPicId()).getPicUrls());
			courseDetailDTO.setVideoUrl(businessCollegeVideoService.getById(relation.getVideoId()).getVideoUrl());
			list.add(courseDetailDTO);
		}
		return list;
	}
}
