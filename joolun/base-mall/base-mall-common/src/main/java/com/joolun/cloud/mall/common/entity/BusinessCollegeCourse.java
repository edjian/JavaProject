/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;
import lombok.EqualsAndHashCode;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiModel;

/**
 * 商学院课程表
 *
 * @author zq
 * @date 2020-11-03 16:22:39
 */
@Data
@TableName("business_college_course")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "商学院课程表")
public class BusinessCollegeCourse extends Model<BusinessCollegeCourse> {
    private static final long serialVersionUID=1L;

    /**
     * 
     */
    @TableId(type = IdType.ASSIGN_ID)
    @NotNull(message = "不能为空")
    @ApiModelProperty(value = "")
    private String id;
    /**
     * 创建时间
     */
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime createTime;
    /**
     * 更新时间
     */
    @ApiModelProperty(value = "更新时间")
    private LocalDateTime updateTime;
    /**
     * 一级
     */
    @ApiModelProperty(value = "一级")
    private String categoryFirst;
    /**
     * 二级
     */
    @ApiModelProperty(value = "二级")
    private String categorySecond;
    /**
     * 专栏id
     */
    @ApiModelProperty(value = "专栏id")
    private String columnId;
    /**
     * 名称
     */
    @ApiModelProperty(value = "名称")
    private String name;
    /**
     * 关联id
     */
    @ApiModelProperty(value = "关联id")
    private String relationId;
    /**
     * 收藏数量
     */
    @ApiModelProperty(value = "收藏数量")
    private Integer collectedNum;
    /**
     * 逻辑删除标记（0：显示；1：隐藏）
     */
    @ApiModelProperty(value = "逻辑删除标记（0：显示；1：隐藏）")
    private String delFlag;

}
