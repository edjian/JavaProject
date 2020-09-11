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
import io.swagger.annotations.Api;
import lombok.Data;
import lombok.EqualsAndHashCode;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiModel;
import org.springframework.data.annotation.Id;

/**
 * 邀新表
 *
 * @author zq
 * @date 2020-07-09 15:06:47
 */
@Data
@TableName("invite_new")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "邀新表")
public class InviteNew extends Model<InviteNew> {
    private static final long serialVersionUID=1L;

    /**
     * PK
     */
    @TableId(type = IdType.ASSIGN_ID)
    @NotNull(message = "PK不能为空")
    @ApiModelProperty(value = "PK")
    private String id;
    /**
     * 被邀请人id
     */
    @NotNull(message = "被邀请人id不能为空")
    @ApiModelProperty(value = "被邀请人id")
    private String userId;
    /**
     * 一级用户id
     */
    @ApiModelProperty(value = "一级用户id")
    private String userIdFirst;
    /**
     * 二级用户id
     */
    @ApiModelProperty(value = "二级用户id")
    private String userIdSecond;
    /**
     * 创建时间
     */
    @NotNull(message = "创建时间不能为空")
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime createTime;
    /**
     * 最后更新时间
     */
    @NotNull(message = "最后更新时间不能为空")
    @ApiModelProperty(value = "最后更新时间")
    private LocalDateTime updateTime;
    /**
     * 0：已注册 1：已完成 2：已完成且积分已分发
     */
    @NotNull(message = "0：已注册 1：已完成 2：已完成且积分已分发不能为空")
    @ApiModelProperty(value = "0：已注册 1：已完成 2：已完成且积分已分发")
    private String status;
    /**
     * 一级套餐id
     */
    @ApiModelProperty(value = "一级套餐id")
    private String setMealIdFirst;
    /**
     * 二级套餐id
     */
    @ApiModelProperty(value = "二级套餐id")
    private String setMealIdSecond;
    /**
     * 用户信息表
     */
    @TableField(exist = false)
    private UserInfo userInfo;
}
