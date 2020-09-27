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
 * 用户套餐表
 *
 * @author zq
 * @date 2020-07-17 15:24:20
 */
@Data
@TableName("user_meal")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "用户套餐表")
public class UserMeal extends Model<UserMeal> {
    private static final long serialVersionUID=1L;

    /**
     * PK
     */
    @TableId(type = IdType.ASSIGN_ID)
    @NotNull(message = "PK不能为空")
    @ApiModelProperty(value = "PK")
    private String id;
    /**
     * 用户id
     */
    @NotNull(message = "用户id不能为空")
    @ApiModelProperty(value = "用户id")
    private String userId;
    /**
     * 套餐id
     */
    @NotNull(message = "套餐id不能为空")
    @ApiModelProperty(value = "套餐id")
    private String setMealId;
    /**
     * 创建时间
     */
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime createTime;
    /**
     * 最后更新时间
     */
    @ApiModelProperty(value = "最后更新时间")
    private LocalDateTime updateTime;
    /**
     * 套餐开始时间
     */
    @ApiModelProperty(value = "套餐开始时间")
    private LocalDateTime startTime;
    /**
     * 套餐结束时间
     */
    @ApiModelProperty(value = "套餐结束时间")
    private LocalDateTime endTime;
    /**
     * 套餐状态：0、未开始 1、进行中 2、已结束
     */
    @NotNull(message = "套餐状态：0、未开始 1、进行中 2、已结束不能为空")
    @ApiModelProperty(value = "套餐状态：0、未开始 1、进行中 2、已结束")
    private String status;
    /**
     * 套餐支付状态：0、未支付 1、已支付 2、已退款
     */
    @NotNull(message = "套餐支付状态：0、未支付 1、已支付 2、已退款不能为空")
    @ApiModelProperty(value = "套餐支付状态：0、未支付 1、已支付 2、已退款")
    private String isPay;
    /**
     * 账号状态：0、激活 1、冻结
     */
    @NotNull(message = "账号状态：0、激活 1、冻结不能为空")
    @ApiModelProperty(value = "账号状态：0、激活 1、冻结")
    private String accountStatus;
    /**
     * 邀请周期时长
     */
    @NotNull(message = "邀请周期时长不能为空")
    @ApiModelProperty(value = "邀请周期时长")
    private Integer inviteDay;
    /**
     * 订单单号
     */
    @NotNull(message = "订单单号不能为空")
    @ApiModelProperty(value = "订单单号")
    private String orderNo;
    /**
     * 支付交易ID
     */
    @ApiModelProperty(value = "支付交易ID")
    private String transactionId;
    /**
     * 剩余可获取积分
     */
    @ApiModelProperty(value = "剩余可获取积分")
    private Integer surplusPoint;
    /**
     * 城市合伙人团队
     */
    @ApiModelProperty(value = "城市合伙人团队")
    private String cityPartner;
    /**
     * 套餐信息
     */
    @TableField(exist = false)
    private SetMeal setMeal;
    /**
     * 邀请人ID
     */
    @TableField(exist = false)
    private String inviteUserId;

}
