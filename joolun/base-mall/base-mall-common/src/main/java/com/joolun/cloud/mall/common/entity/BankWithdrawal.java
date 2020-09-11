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
 * 银行提现表
 *
 * @author zq
 * @date 2020-08-21 10:41:42
 */
@Data
@TableName("bank_withdrawal")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "银行提现表")
public class BankWithdrawal extends Model<BankWithdrawal> {
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
    @ApiModelProperty(value = "用户id")
    private String userId;
    /**
     * 银行卡id
     */
    @ApiModelProperty(value = "银行卡id")
    private String bankCardId;
    /**
     * 提现状态：0、审核中，1、放款中，2、驳回重新申请，3、驳回已重新申请，4、已提现
     */
    @ApiModelProperty(value = "提现状态：0、审核中，1、放款中，2、驳回重新申请，3、驳回已重新申请，4、已提现")
    private String status;
    /**
     * 申请时间
     */
    @ApiModelProperty(value = "申请时间")
    private LocalDateTime createTime;
    /**
     * 提现积分
     */
    @ApiModelProperty(value = "提现积分")
    private BigDecimal sum;

    /**
     * 原因
     */
    @ApiModelProperty(value = "原因")
    private String reason;
}
