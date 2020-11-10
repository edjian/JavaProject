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

	@ApiModelProperty(value = "是否收藏：0、收藏；1、取消收藏")
	private String collected;

	@ApiModelProperty(value = "观看数量")
	private Integer watchName;

	@ApiModelProperty(value = "标识：1、图文；2、视频；3、音频；4、专栏；5、直播")
	private String tag;

	@ApiModelProperty(value = "是否为新课程：1、是  2、不是")
	private Integer isNew;

	@ApiModelProperty(value = "分类一级：1、商城运营；2、金融服务；3、精选课程")
	private String categoryFirst;

	@ApiModelProperty(value = "分类二级：1、初级；2、中级；3、高级")
	private String categorySecond;
}
