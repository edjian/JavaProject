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
 * 银行卡号
 *
 * @author zq
 * @date 2020-08-06 17:37:35
 */
@Data
@TableName("bank_card")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "银行卡号")
public class BankCard extends Model<BankCard> {
    private static final long serialVersionUID=1L;

    /**
     * 
     */
    @TableId(type = IdType.ASSIGN_ID)
    @NotNull(message = "不能为空")
    @ApiModelProperty(value = "PK")
    private String id;
    /**
     * 用户id
     */
    @ApiModelProperty(value = "用户id")
    private String userId;
    /**
     * 卡类型
     */
    @ApiModelProperty(value = "卡类型")
    private String cardType;
    /**
     * 银行代码
     */
    @ApiModelProperty(value = "银行代码")
    private String bank;
    /**
     * 银行名称
     */
    @ApiModelProperty(value = "银行名称")
    private String bankName;
    /**
     * 卡号
     */
    @ApiModelProperty(value = "卡号")
    private String cardNumber;
    /**
     * 状态
     */
    @ApiModelProperty(value = "状态")
    private String stat;
    /**
     * 银行图标
     */
    @ApiModelProperty(value = "银行图标")
    private String iconUrl;
    /**
     * 姓名
     */
    @ApiModelProperty(value = "姓名")
    private String userName;
    /**
     * 开户行
     */
    @ApiModelProperty(value = "开户行")
    private String openingBank;
    /**
     * 手机号码
     */
    @ApiModelProperty(value = "手机号码")
    private String telephone;
}
