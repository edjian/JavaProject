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
import com.baomidou.mybatisplus.annotation.TableField;
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
 * 分享任务表
 *
 * @author zq
 * @date 2020-07-09 15:36:56
 */
@Data
@TableName("share_task")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "分享任务表")
public class ShareTask extends Model<ShareTask> {
    private static final long serialVersionUID=1L;

    /**
     * PK
     */
    @TableId(type = IdType.ASSIGN_ID)
    @NotNull(message = "PK不能为空")
    @ApiModelProperty(value = "PK")
    private String id;
    /**
     * 任务名称
     */
    @ApiModelProperty(value = "任务名称")
    private String name;
    /**
     * 积分
     */
    @ApiModelProperty(value = "积分")
    private Integer point;
    /**
     * 分享地址
     */
    @ApiModelProperty(value = "分享地址")
    private String shareUrl;
    /**
     * 图片
     */
    @ApiModelProperty(value = "图片")
    private String picUrl;
    /**
     * （1：开启；0：关闭）
     */
    @ApiModelProperty(value = "（1：开启；0：关闭）")
    private String enable;
    /**
     * 任务标识：0、分享任务，1、视频任务
     */
    @ApiModelProperty(value = "任务标识：0、分享任务，1、视频任务")
    private String taskState;
    /**
     * 视频任务的说明
     */
    @ApiModelProperty(value = "视频任务的说明")
    private String tips;

    @TableField(exist = false)
    private String userId;

    @TableField(exist = false)
    private ShareRecord shareRecord;

    @TableField(exist = false)
    private boolean complete;
}
