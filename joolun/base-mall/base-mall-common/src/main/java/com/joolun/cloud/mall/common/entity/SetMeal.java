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
import java.math.BigDecimal;
import java.time.LocalDateTime;

import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiModel;

/**
 * 套餐
 *
 * @author zq
 * @date 2020-07-08 13:53:21
 */
@Data
@TableName("set_meal")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "套餐")
public class SetMeal extends Model<SetMeal> {
    private static final long serialVersionUID = 1L;

    /**
     * PK
     */
    @TableId(type = IdType.ASSIGN_ID)
    @NotNull(message = "PK不能为空")
    @ApiModelProperty(value = "PK")
    private String id;
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
     * 套餐名称
     */
    @NotNull(message = "套餐名称不能为空")
    @ApiModelProperty(value = "套餐名称")
    private String name;
    /**
     * 价格
     */
    @ApiModelProperty(value = "价格")
    private BigDecimal price;
    /**
     * 图片地址
     */
    @ApiModelProperty(value = "图片地址")
    private String picUrl;
    /**
     * 积分
     */
    @ApiModelProperty(value = "分享积分")
    private Integer sharePoint;
    /**
     * 套餐周期
     */
    @NotNull(message = "套餐周期不能为空")
    @ApiModelProperty(value = "套餐周期")
    private String period;
    /**
     * 邀请下单一级返利百分比
     */
    @ApiModelProperty(value = "邀请下单一级返利百分比")
    private Integer orderRebateFirst;
    /**
     * 邀请下单二级返利百分比
     */
    @ApiModelProperty(value = "邀请下单二级返利百分比")
    private Integer orderRebateSecond;
    /**
     * 邀新一级返利百分比
     */
    @ApiModelProperty(value = "邀新一级返利百分比")
    private Integer inviteRebateFirst;
    /**
     * 邀新二级返利百分比
     */
    @ApiModelProperty(value = "邀新二级返利百分比")
    private Integer inviteRebateSecond;
    /**
     * 跨界收益
     */
    @ApiModelProperty(value = "跨界收益")
    private Integer crossBorderBenefits;
    /**
     * 商家入驻资格
     */
    @NotNull(message = "商家入驻资格不能为空")
    @ApiModelProperty(value = "商家入驻资格")
    private Integer merchantStatus;

}
