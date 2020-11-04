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
 * 商学院关联表
 *
 * @author zq
 * @date 2020-11-04 09:17:04
 */
@Data
@TableName("business_college_relation")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "商学院关联表")
public class BusinessCollegeRelation extends Model<BusinessCollegeRelation> {
    private static final long serialVersionUID=1L;

    /**
     * 
     */
    @TableId(type = IdType.ASSIGN_ID)
    @NotNull(message = "不能为空")
    @ApiModelProperty(value = "")
    private String id;
    /**
     * 
     */
    @ApiModelProperty(value = "")
    private LocalDateTime createTime;
    /**
     * 
     */
    @ApiModelProperty(value = "")
    private LocalDateTime updateTime;
    /**
     * 文本id
     */
    @ApiModelProperty(value = "文本id")
    private String textId;
    /**
     * 图片id
     */
    @ApiModelProperty(value = "图片id")
    private String picId;
    /**
     * 音频id
     */
    @ApiModelProperty(value = "音频id")
    private String videoId;
    /**
     * 逻辑删除标记（0：显示；1：隐藏）
     */
    @ApiModelProperty(value = "逻辑删除标记（0：显示；1：隐藏）")
    private String delFlag;

}
