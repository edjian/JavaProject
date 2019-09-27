/**
 * Copyright (C) 2018-2019
 * All rights reserved, Designed By www.joolun.com
 * 注意：
 * 本软件为www.joolun.com开发研制，未经购买不得使用
 * 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
 * 一经发现盗用、分享等行为，将追究法律责任，后果自负
 */
package com.joolun.cloud.mall.common.vo;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * spu商品
 *
 * @author JL
 * @date 2019-08-12 16:25:10
 */
@Data
public class GoodsSpuVO implements Serializable {
	private static final long serialVersionUID = 1L;

    /**
   * PK
   */
    private String id;
    /**
   * 所属租户
   */
    private String tenantId;
    /**
   * spu编码
   */
    private String spuCode;
    /**
   * spu名字
   */
    private String name;
    /**
   * 卖点
   */
    private String sellPoint;
    /**
   * 描述
   */
    private String description;
	/**
	 * 一级分类ID
	 */
	private String categoryFirst;
	/**
	 * 二级分类ID
	 */
	private String categorySecond;
    /**
   * 商品主图
   */
	@TableField(el = "picUrls, typeHandler=com.joolun.cloud.common.data.mybatis.typehandler.ArrayStringTypeHandler, jdbcType=VARCHAR")
    private String[] picUrls;
    /**
   * 是否上架商品（0为已上架 1为已下架）
   */
    private String shelf;
    /**
   * 排序字段
   */
    private Integer sort;
	/**
	 * 最低价
	 */
	private BigDecimal priceDown;
	/**
	 * 最高价
	 */
	private BigDecimal priceUp;
	/**
	 * 销量
	 */
	private Integer saleNum;
    /**
   * 创建时间
   */
    private LocalDateTime createTime;
    /**
   * 最后更新时间
   */
    private LocalDateTime updateTime;
	/**
	 * 0统一规格；1多规格
	 */
	private String specType;
    /**
   * 逻辑删除标记（0：显示；1：隐藏）
   */
    private String delFlag;

    private List<GoodsSkuVO> skus;
	/**
	 * 收藏ID
	 */
	private String collectId;

}
