package com.joolun.cloud.mall.common.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 课程详情
 *
 * @author lzc
 * @Date 2011/11/4
 */
@Data
@ApiModel(description = "课程详情")
public class CourseDetailDTO {
	@ApiModelProperty(value = "商品Id")
	private String id;

	@ApiModelProperty(value = "课程名称")
	private String name;

	@ApiModelProperty(value = "图片地址")
	private String picUrls;

	@ApiModelProperty(value = "文本内容")
	private String content;

	@ApiModelProperty(value = "音频地址")
	private String videoUrl;

	@ApiModelProperty(value = "收藏数量")
	private Integer collectedNum;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "浏览历史")
	private String history;
}
