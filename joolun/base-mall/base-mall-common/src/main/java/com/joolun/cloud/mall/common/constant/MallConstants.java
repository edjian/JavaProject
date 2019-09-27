package com.joolun.cloud.mall.common.constant;

/**
 * @author
 */
public interface MallConstants {
	/**
	 * 商品规格类型：0统一规格；1多规格
	 */
	String SPU_SPEC_TYPE_0 = "0";
	/**
	 * 商品规格类型：0统一规格；1多规格
	 */
	String SPU_SPEC_TYPE_1 = "1";
	/**
	 * 商品上架状态（0为已上架 1为已下架）
	 */
	String SPU_SHELF_0 = "0";
	/**
	 * 商品上架状态（0为已上架 1为已下架）
	 */
	String SPU_SHELF_1 = "1";
	/**
	 * 收藏类型1、商品
	 */
	String COLLECT_TYPE_1 = "1";
	/**
	 * 订单自动取消时间（分钟）
	 */
	long ORDER_TIME_OUT_0 = 30;
	/**
	 * 订单自动收货时间（天）
	 */
	long ORDER_TIME_OUT_2 = 7;
	/**
	 * redis订单key
	 */
	String REDIS_ORDER_KEY_STATUS_0 = "mall:order:status_0:";
	/**
	 * redis订单key
	 */
	String REDIS_ORDER_KEY_STATUS_2 = "mall:order:status_2:";
}
