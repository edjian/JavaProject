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
 * 商城入驻信息表
 *
 * @author zq
 * @date 2020-07-16 13:10:38
 */
@Data
@TableName("merchant_settled")
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "商城入驻信息表")
public class MerchantSettled extends Model<MerchantSettled> {
    private static final long serialVersionUID=1L;

    /**
     * PK
     */
    @TableId(type = IdType.ASSIGN_ID)
    @NotNull(message = "PK不能为空")
    @ApiModelProperty(value = "PK")
    private String id;
    /**
     * 商城用户id
     */
    @NotNull(message = "商城用户id不能为空")
    @ApiModelProperty(value = "商城用户id")
    private String userId;
    /**
     * 姓名
     */
    @NotNull(message = "姓名不能为空")
    @ApiModelProperty(value = "姓名")
    private String userName;
    /**
     * 电话号码
     */
    @ApiModelProperty(value = "电话号码")
    private String phone;
    /**
     * 身份证号码
     */
    @ApiModelProperty(value = "身份证号码")
    private String idNumber;
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
     * 商户名称
     */
    @ApiModelProperty(value = "商户名称")
    private String merchantsSettled;
    /**
     * 主要业务
     */
    @ApiModelProperty(value = "主要业务")
    private String mainBusiness;
    /**
     * 地区
     */
    @ApiModelProperty(value = "地区")
    private String area;
    /**
     * 详细地址
     */
    @ApiModelProperty(value = "详细地址")
    private String detailAddress;
    /**
     * 产品介绍
     */
    @ApiModelProperty(value = "产品介绍")
    private String productIntroduction;
    /**
     * 身份证正面
     */
    @ApiModelProperty(value = "身份证正面")
    private String idCardFrontUrl;
    /**
     * 身份证反面
     */
    @ApiModelProperty(value = "身份证反面")
    private String idCardReverseUrl;
    /**
     * 营业执照地址
     */
    @ApiModelProperty(value = "营业执照地址")
    private String businessLicenseUrl;
    /**
     * 商家入驻步骤
     */
    @NotNull(message = "商家入驻步骤")
    @ApiModelProperty(value = "商家入驻步骤")
    private Integer step;
    /**
     * 审核状态
     */
    @NotNull(message = "审核状态")
    @ApiModelProperty(value = "审核状态")
    private Integer status;
    /**
     * 审核失败原因
     */
    @ApiModelProperty(value = "审核失败原因")
    private String reason;
}
