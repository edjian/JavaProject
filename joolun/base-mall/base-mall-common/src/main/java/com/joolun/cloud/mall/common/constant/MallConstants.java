package com.joolun.cloud.mall.common.constant;

import java.math.BigDecimal;

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
    String REDIS_ORDER_KEY_IS_PAY_0 = "mall:order:is_pay_0:";
    /**
     * redis订单key
     */
    String REDIS_ORDER_KEY_STATUS_2 = "mall:order:status_2:";
    /**
     * 应用类型1小程序
     */
    String APP_TYPE_1 = "1";
    /**
     * 支付方式1、货到付款；2、在线支付
     */
    String PAYMENT_WAY_1 = "1";
    /**
     * 支付方式1、货到付款；2、在线支付
     */
    String PAYMENT_WAY_2 = "2";
    /**
     * 评价状态0、未评；1、已评；2、已追评
     */
    String APPRAISES_STATUS_0 = "0";
    /**
     * 评价状态0、未评；1、已评；2、已追评
     */
    String APPRAISES_STATUS_1 = "1";
    /**
     * 评价状态0、未评；1、已评；2、已追评
     */
    String APPRAISES_STATUS_2 = "2";
    /**
     * 用户等级（0：普通用户，1：普通会员）
     */
    Integer USER_GRADE_0 = 0;
    /**
     * 用户等级（0：普通用户，1：普通会员）
     */
    Integer USER_GRADE_1 = 1;
    /**
     * 记录类型0、用户初始化；1、会员初始化；2、商品赠送；3、退款赠送减回；4、商品抵扣；5、订单取消抵扣加回；6、退款抵扣加回；7、邀新一级积分；8、邀新二级积分；9、分享积分；10、积分提现
     */
    String POINTS_RECORD_TYPE_0 = "0";
    String POINTS_RECORD_TYPE_1 = "1";
    String POINTS_RECORD_TYPE_2 = "2";
    String POINTS_RECORD_TYPE_3 = "3";
    String POINTS_RECORD_TYPE_4 = "4";
    String POINTS_RECORD_TYPE_5 = "5";
    String POINTS_RECORD_TYPE_6 = "6";
    String POINTS_RECORD_TYPE_7 = "7";
    String POINTS_RECORD_TYPE_8 = "8";
    String POINTS_RECORD_TYPE_9 = "9";
    String POINTS_RECORD_TYPE_10 = "10";

    /**
     * 电子券适用类型1、全部商品；2、指定商品可用；
     */
    String COUPON_SUIT_TYPE_1 = "1";
    String COUPON_SUIT_TYPE_2 = "2";

    /**
     * 到期类型1、领券后生效；2：固定时间段
     */
    String COUPON_EXPIRE_TYPE_1 = "1";
    String COUPON_EXPIRE_TYPE_2 = "2";

    /**
     * 用户电子券状态0、未使用；1、已使用；2、已过期
     */
    String COUPON_USER_STATUS_0 = "0";
    String COUPON_USER_STATUS_1 = "1";
    String COUPON_USER_STATUS_2 = "2";

    /**
     * 砍价状态（0：未开始；1：活动中；2：已过期）
     */
    String BARGAIN_INFO_STATUS_0 = "0";
    String BARGAIN_INFO_STATUS_1 = "1";
    String BARGAIN_INFO_STATUS_2 = "2";

    /**
     * 砍价记录状态（0：砍价中；1：完成砍价；2：已过期）
     */
    String BARGAIN_USER_STATUS_0 = "0";
    String BARGAIN_USER_STATUS_1 = "1";
    String BARGAIN_USER_STATUS_2 = "2";

    /**
     * 拼团状态（0：未开始；1：活动中；2：已过期）
     */
    String GROUPON_INFO_STATUS_0 = "0";
    String GROUPON_INFO_STATUS_1 = "1";
    String GROUPON_INFO_STATUS_2 = "2";

    /**
     * 拼团记录状态（0：拼团中；1：完成拼团；2：已过期）
     */
    String GROUPON_USER_STATUS_0 = "0";
    String GROUPON_USER_STATUS_1 = "1";
    String GROUPON_USER_STATUS_2 = "2";

    /**
     * 订单类型（0、普通订单；1、砍价订单；2、拼团订单）
     */
    String ORDER_TYPE_0 = "0";
    String ORDER_TYPE_1 = "1";
    String ORDER_TYPE_2 = "2";

    /**
     * 配送方式1、普通快递；2、上门自提
     */
    String DELIVERY_WAY_1 = "1";
    String DELIVERY_WAY_2 = "2";

    /**
     * 套餐价格（980、伙计；3980、掌柜；59800、城市合伙人）
     */
    Integer BASICS_MEAL = 980;
    Integer FLAGSHIP_MEAL = 3980;
    Integer CITY_PARTNER = 59800;

    /**
     * 套餐状态（0、未开始；1、进行中；2、已结束）
     */
    String NOT_START = "0";
    String UNDER_WAY = "1";
    String FINISHED = "2";

    /**
     * 套餐支付状态（0、未支付；1、已支付）
     */
    String UNPAID = "0";
    String PAID = "1";

    /**
     * 套餐周期
     */
    Integer DEFAULT_TIME = 30;
    Integer DEFAULT_INVITE_TIME = 15;
    Integer MINE_UPGRADE_TIME = 22;
    Integer FLAGSHIP_INVITE_BASIC_TIME = 3;
    Integer FLAGSHIP_INVITE_BASIC_UPGRADE_TIME = 12;
    Integer BASIC_INVITE_FLAGSHIP_UPGRADE_TIME = 11;

    /**
     * 分享记录状态（0、未分享；1、已分享）
     */
    String SHARE_RECORD_NO = "0";
    String SHARE_RECORD_YES = "1";

    /**
     * 我的邀请等级分别（first、一级；second、二级；all、所有）
     */
    String MY_INVITE_STAT_FIRST = "first";
    String MY_INVITE_STAT_SECOND = "second";
    String MY_INVITE_STAT_ALL = "all";

    /**
     * 消费收益
     */
    Integer CONSUME_PROFIT = 10;//自然人比例

//    /**
//     * 跨界收益
//     */
//    Integer TRANSBOUNDARY_PROFIT_10 = 10;//掌柜比例
//    Integer TRANSBOUNDARY_PROFIT_30 = 30;//城市合伙人比例

    /**
     * 商城入驻资料填报状态
     */
    Integer MERCHANT_STATUS_0 = 0;
    Integer MERCHANT_STATUS_1 = 1;
    Integer MERCHANT_STATUS_2 = 2;
    Integer MERCHANT_STATUS_3 = 3;

    /**
     * 提现积分状态
     */
    Integer BANK_WITHDRAWAL_STATUS_0 = 0;
    Integer BANK_WITHDRAWAL_STATUS_1 = 1;
    Integer BANK_WITHDRAWAL_STATUS_2 = 2;
    Integer BANK_WITHDRAWAL_STATUS_3 = 3;
    Integer BANK_WITHDRAWAL_STATUS_4 = 4;

    /**
     * 套餐邀请城市合伙人比例
     */
    BigDecimal SET_MEAL_980 = new BigDecimal("0.03");
    BigDecimal SET_MEAL_3980 = new BigDecimal("0.12");
    BigDecimal SET_MEAL_59800 = new BigDecimal("0.20");

    /**
     * 城市合伙人分享比例
     */
    BigDecimal CITY_PARTNER_SHARE = new BigDecimal("0.05");

    /**
     * 积分明细描述
     */
    String DAILY_TASKS = "每日任务";

    /**
     * 分享任务条数
     */
    Integer SHARE_COUNT = 4;

    /**
     * 每日点击商品虚拟数量
     */
    Integer VOID_NUM = 100;
}
