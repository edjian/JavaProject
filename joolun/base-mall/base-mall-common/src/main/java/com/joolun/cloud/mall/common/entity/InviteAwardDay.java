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
 * 邀新奖励天数表
 *
 * @author zq
 * @date 2020-08-03 14:55:27
 */
@Data
@TableName("invite_award_day")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "邀新奖励天数表")
public class InviteAwardDay extends Model<InviteAwardDay> {
    private static final long serialVersionUID=1L;

    /**
     * PK
     */
    @TableId(type = IdType.ASSIGN_ID)
    @NotNull(message = "PK不能为空")
    @ApiModelProperty(value = "PK")
    private String id;
    /**
     * 邀请人当时的用户套餐id
     */
    @ApiModelProperty(value = "邀请人当时的用户套餐id")
    private String inviterUserMealId;
    /**
     * 被邀请者当时用户套餐id
     */
    @ApiModelProperty(value = "被邀请者当时用户套餐id")
    private String inviteeUserMealId;
    /**
     * 邀新到期时间
     */
    @ApiModelProperty(value = "邀新到期时间")
    private LocalDateTime endTime;
    /**
     * 邀请人用户id
     */
    @ApiModelProperty(value = "邀请人用户id")
    private String inviterUserId;

}
