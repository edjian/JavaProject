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
 * 商学院评价表
 *
 * @author zq
 * @date 2020-11-04 09:24:53
 */
@Data
@TableName("business_college_appraises")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "商学院评价表")
public class BusinessCollegeAppraises extends Model<BusinessCollegeAppraises> {
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
     * 逻辑删除标记（0：显示；1：隐藏）
     */
    @ApiModelProperty(value = "逻辑删除标记（0：显示；1：隐藏）")
    private String delFlag;
    /**
     * 用户ID
     */
    @ApiModelProperty(value = "用户ID")
    private String userId;
    /**
     * 昵称
     */
    @ApiModelProperty(value = "昵称")
    private String nickName;
    /**
     * 头像
     */
    @ApiModelProperty(value = "头像")
    private String headimgUrl;
    /**
     * 课程ID
     */
    @ApiModelProperty(value = "课程ID")
    private String courseId;
    /**
     * 回复ID
     */
    @ApiModelProperty(value = "回复ID")
    private String replyId;
    /**
     * 评价内容
     */
    @ApiModelProperty(value = "评价内容")
    private String content;
    /**
     * 点赞数
     */
    @ApiModelProperty(value = "点赞数")
    private Integer likeNum;

}
