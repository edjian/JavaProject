package com.joolun.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.Version;
import com.joolun.cloud.upms.common.dto.TreeNode;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@EqualsAndHashCode(callSuper = true)
public class GoodsSpuTree extends TreeNode {

    /**
     * PK
     */
    @ApiModelProperty(value = "PK")
    private String id;
    /**
     * 所属租户
     */
    @ApiModelProperty(value = "所属租户")
    private String tenantId;
    /**
     * spu编码
     */
    @ApiModelProperty(value = "spu编码")
    private String spuCode;
    /**
     * spu名字
     */
    @ApiModelProperty(value = "spu名字")
    private String name;
    /**
     * 卖点
     */
    @ApiModelProperty(value = "卖点")
    private String sellPoint;
    /**
     * 描述
     */
    @ApiModelProperty(value = "描述")
    private String description;
    /**
     * 一级分类ID
     */
    @ApiModelProperty(value = "一级分类ID")
    private String categoryFirst;
    /**
     * 二级分类ID
     */
    @ApiModelProperty(value = "二级分类ID")
    private String categorySecond;
    /**
     * 商品主图
     */
    @ApiModelProperty(value = "商品主图")
    private String[] picUrls;
    /**
     * 是否上架（0否 1是）
     */
    @ApiModelProperty(value = "是否上架（0否 1是）")
    private String shelf;
    /**
     * 排序字段
     */
    @ApiModelProperty(value = "排序字段")
    private Integer sort;
    /**
     * 最低价
     */
    @ApiModelProperty(value = "最低价")
    private BigDecimal priceDown;
    /**
     * 最高价
     */
    @ApiModelProperty(value = "最高价")
    private BigDecimal priceUp;
    /**
     * 销量
     */
    @ApiModelProperty(value = "销量")
    private Integer saleNum;
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
     * 0统一规格；1多规格
     */
    @ApiModelProperty(value = "0统一规格；1多规格")
    private String specType;
    /**
     * 逻辑删除标记（0：显示；1：隐藏）
     */
    @ApiModelProperty(value = "逻辑删除标记（0：显示；1：隐藏）")
    private String delFlag;
    /**
     *积分赠送开关（1开 0关）
     */
    @ApiModelProperty(value = "积分赠送开关（1开 0关）")
    private String pointsGiveSwitch;
    /**
     * 积分赠送数量
     */
    @ApiModelProperty(value = "积分赠送数量")
    private Integer pointsGiveNum;
    /**
     * 积分抵扣开关（1开 0关）
     */
    @ApiModelProperty(value = "积分抵扣开关（1开 0关）")
    private String pointsDeductSwitch;
    /**
     * 积分抵扣商品金额比例（0~100）
     */
    @ApiModelProperty(value = "积分抵扣商品金额比例（0~100）")
    private Integer pointsDeductScale;
    /**
     * 1积分数可抵多少元
     */
    @ApiModelProperty(value = "1积分数可抵多少元")
    private BigDecimal pointsDeductAmount;
    /**
     * 运费模板ID
     */
    @ApiModelProperty(value = "运费模板ID")
    private String freightTemplatId;
    /**
     * 发货地ID
     */
    @ApiModelProperty(value = "发货地ID")
    private String deliveryPlaceId;
    /**
     * 机构ID
     */
    @ApiModelProperty(value = "机构ID")
    private String organId;
    /**
     * 版本号
     */
    @Version
    private Integer version;
    /**
     * 每日点击商品虚拟数量
     */
    @ApiModelProperty(value = "每日点击商品虚拟数量")
    private Integer voidNum;
}
