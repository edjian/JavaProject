/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 8.0.15 : Database - base_mall
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`base_mall` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;

USE `base_mall`;

/*Table structure for table `bargain_cut` */

DROP TABLE IF EXISTS `bargain_cut`;

CREATE TABLE `bargain_cut` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `bargain_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '砍价ID',
  `bargain_user_id` varchar(32) DEFAULT NULL COMMENT '砍价用户ID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户ID',
  `cut_price` decimal(10,2) NOT NULL COMMENT '砍价金额',
  `nick_name` varchar(100) DEFAULT NULL COMMENT '昵称',
  `headimg_url` varchar(1000) DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='砍价帮砍记录';

/*Data for the table `bargain_cut` */

insert  into `bargain_cut`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`bargain_id`,`bargain_user_id`,`user_id`,`cut_price`,`nick_name`,`headimg_url`) values 
('1247864082032259074','1','0','2020-04-08 20:29:16','2020-04-08 20:29:16',NULL,'1245987408411914241','1247864081956761601','1234102578637127681',1301.60,'JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132'),
('1247864121878147073','1','0','2020-04-08 20:29:25','2020-04-08 20:29:25',NULL,'1235079512380551170','1247864121794260994','1234102578637127681',99.99,'JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132');

/*Table structure for table `bargain_info` */

DROP TABLE IF EXISTS `bargain_info`;

CREATE TABLE `bargain_info` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序字段',
  `enable` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '（1：开启；0：关闭）',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品Id',
  `sku_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'skuId',
  `name` varchar(100) DEFAULT NULL COMMENT '砍价名称',
  `valid_begin_time` datetime NOT NULL COMMENT '开始时间',
  `valid_end_time` datetime NOT NULL COMMENT '结束时间',
  `bargain_price` decimal(10,2) NOT NULL COMMENT '砍价底价',
  `self_cut` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '自砍一刀（1：开启；0：关闭）',
  `floor_buy` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '必须底价购买（1：是；0：否）',
  `launch_num` int(11) DEFAULT '0' COMMENT '发起人数',
  `cut_max` decimal(10,2) NOT NULL COMMENT '单次可砍最高金额',
  `cut_min` decimal(10,2) NOT NULL COMMENT '单次可砍最低金额',
  `pic_url` varchar(500) DEFAULT NULL COMMENT '图片',
  `cut_rule` text COMMENT '砍价规则',
  `share_title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分享标题 ',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='砍价';

/*Data for the table `bargain_info` */

insert  into `bargain_info`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`sort`,`enable`,`spu_id`,`sku_id`,`name`,`valid_begin_time`,`valid_end_time`,`bargain_price`,`self_cut`,`floor_buy`,`launch_num`,`cut_max`,`cut_min`,`pic_url`,`cut_rule`,`share_title`) values 
('1235079512380551170','1','0','2020-03-04 13:47:57','2020-03-04 13:47:57',NULL,7,'1','4d06c5157cce971b89166e509cdf63e8','7cee91d08568afe4f8c2a7651f52be8b','非顶不可有副作用','2020-03-03 00:00:00','2020-04-30 00:00:00',0.01,'1','1',7,200.00,100.00,'http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/14.jpg','她问他问题你爱我脸人','她问他问题你爱我脸人'),
('1245987408411914241','1','0','2020-04-03 16:12:02','2020-04-03 16:12:02',NULL,2,'1','2835671ff031c18cb181b1a199f86b01','8b3d9b08b33081b231e75ef5f0bf3705','vvj kk l l l','2020-03-02 00:00:00','2022-05-12 00:00:00',1.00,'1','0',37,2000.00,1000.00,'http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg','r rw r g ','vvj kk l l l');

/*Table structure for table `bargain_user` */

DROP TABLE IF EXISTS `bargain_user`;

CREATE TABLE `bargain_user` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `bargain_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '砍价ID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户ID',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品Id',
  `sku_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'skuId',
  `valid_begin_time` datetime NOT NULL COMMENT '开始时间',
  `valid_end_time` datetime NOT NULL COMMENT '结束时间',
  `bargain_price` decimal(10,2) NOT NULL COMMENT '砍价底价',
  `floor_buy` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '必须底价购买（1：是；0：否）',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '状态（0：砍价中；1：完成砍价）',
  `is_buy` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '是否购买（1：是；0：否）',
  `order_id` varchar(32) DEFAULT NULL COMMENT '订单Id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='砍价记录';

/*Data for the table `bargain_user` */

insert  into `bargain_user`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`bargain_id`,`user_id`,`spu_id`,`sku_id`,`valid_begin_time`,`valid_end_time`,`bargain_price`,`floor_buy`,`status`,`is_buy`,`order_id`) values 
('1247864081956761601','1','0','2020-04-08 20:29:15','2020-04-08 20:29:15',NULL,'1245987408411914241','1234102578637127681','2835671ff031c18cb181b1a199f86b01','8b3d9b08b33081b231e75ef5f0bf3705','2020-03-02 00:00:00','2022-05-12 00:00:00',1.00,'0','0','0',NULL),
('1247864121794260994','1','0','2020-04-08 20:29:25','2020-04-08 20:29:25',NULL,'1235079512380551170','1234102578637127681','4d06c5157cce971b89166e509cdf63e8','7cee91d08568afe4f8c2a7651f52be8b','2020-03-03 00:00:00','2020-04-30 00:00:00',0.01,'1','1','0',NULL);

/*Table structure for table `coupon_goods` */

DROP TABLE IF EXISTS `coupon_goods`;

CREATE TABLE `coupon_goods` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `coupon_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电子券ID',
  `spu_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品Id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='电子券商品关联';

/*Data for the table `coupon_goods` */

/*Table structure for table `coupon_info` */

DROP TABLE IF EXISTS `coupon_info`;

CREATE TABLE `coupon_info` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序字段',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型1、代金券；2：折扣券',
  `premise_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额满多少可使用',
  `expire_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '到期类型1、领券后生效；2：固定时间段',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `reduce_amount` decimal(10,2) DEFAULT NULL COMMENT '减免金额（代金券特有）',
  `discount` decimal(10,1) DEFAULT NULL COMMENT '折扣率（折扣券特有）',
  `valid_days` int(3) DEFAULT NULL COMMENT '有效天数（领券后生效特有）',
  `valid_begin_time` datetime DEFAULT NULL COMMENT '有效开始时间（固定时间段特有）',
  `valid_end_time` datetime DEFAULT NULL COMMENT '有效结束时间（固定时间段特有）',
  `suit_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '适用类型1、全部商品；2、指定商品可用',
  `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `enable` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '（1：开启；0：关闭）',
  `version` int(11) DEFAULT '0' COMMENT '版本号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='电子券';

/*Data for the table `coupon_info` */

insert  into `coupon_info`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`sort`,`name`,`type`,`premise_amount`,`expire_type`,`stock`,`reduce_amount`,`discount`,`valid_days`,`valid_begin_time`,`valid_end_time`,`suit_type`,`remarks`,`enable`,`version`) values 
('1242644273821609986','1','0','2020-03-25 10:47:36','2020-03-25 10:47:36',NULL,1,'8折券','2',10.00,'1',86,NULL,8.0,8,NULL,NULL,'1',NULL,'1',2),
('1242644400837718017','1','0','2020-03-25 10:48:07','2020-03-25 10:48:07',NULL,2,'5元券','1',99.00,'1',75,5.00,NULL,9,NULL,NULL,'1',NULL,'1',3),
('1245994369937338369','1','0','2020-04-03 16:39:41','2020-04-03 16:39:41',NULL,4,'5折券','2',100.00,'1',85,NULL,5.0,777,NULL,NULL,'1',NULL,'1',3);

/*Table structure for table `coupon_user` */

DROP TABLE IF EXISTS `coupon_user`;

CREATE TABLE `coupon_user` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `coupon_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电子券ID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
  `coupon_code` int(11) NOT NULL AUTO_INCREMENT COMMENT '电子券码',
  `valid_begin_time` datetime DEFAULT NULL COMMENT '有效开始时间',
  `valid_end_time` datetime DEFAULT NULL COMMENT '有效结束时间',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '状态0、未使用；1、已使用',
  `used_time` datetime DEFAULT NULL COMMENT '使用时间',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `type` char(2) DEFAULT NULL COMMENT '类型1、代金券；2：折扣券',
  `premise_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额满多少可使用',
  `reduce_amount` decimal(10,2) DEFAULT NULL COMMENT '减免金额（代金券特有）',
  `discount` decimal(10,1) DEFAULT NULL COMMENT '折扣率（折扣券特有）',
  `suit_type` char(2) DEFAULT NULL COMMENT '适用类型1、全部商品；2、指定商品可用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_coupon_code` (`coupon_code`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE,
  KEY `ids_user` (`user_id`),
  KEY `coupon_code` (`coupon_code`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='电子券用户记录';

/*Data for the table `coupon_user` */

insert  into `coupon_user`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`coupon_id`,`user_id`,`coupon_code`,`valid_begin_time`,`valid_end_time`,`status`,`used_time`,`name`,`type`,`premise_amount`,`reduce_amount`,`discount`,`suit_type`) values 
('1242644456152199170','1','0','2020-03-25 10:48:20','2020-03-25 10:48:20',NULL,'1242644400837718017','1234102578637127681',95,'2020-03-25 10:48:20','2020-04-03 10:48:20','0',NULL,'5元券','1',99.00,5.00,NULL,'1'),
('1245694341540827138','1','0','2020-04-02 20:47:29','2020-04-02 20:47:29',NULL,'1242644400837718017','1240923176084389889',96,'2020-04-02 20:47:30','2020-04-11 20:47:30','0',NULL,'5元券','1',99.00,5.00,NULL,'1'),
('1245694345680605185','1','0','2020-04-02 20:47:30','2020-04-02 20:47:30',NULL,'1242644273821609986','1240923176084389889',97,'2020-04-02 20:47:31','2020-04-10 20:47:31','0',NULL,'8折券','2',10.00,NULL,8.0,'1'),
('1245994454049910785','1','0','2020-04-03 16:40:01','2020-04-03 16:40:01',NULL,'1245994369937338369','1240923176084389889',98,'2020-04-03 16:40:02','2022-05-20 16:40:02','0',NULL,'5折券','2',100.00,NULL,5.0,'1'),
('1246261754518831105','1','0','2020-04-04 10:22:11','2020-04-04 10:22:11',NULL,'1245994369937338369','1234102578637127681',99,'2020-04-04 10:22:11','2022-05-21 10:22:11','1','2020-04-05 10:36:27','5折券','2',100.00,NULL,5.0,'1'),
('1246628672589279233','1','0','2020-04-05 10:40:11','2020-04-05 10:40:11',NULL,'1245994369937338369','1234102578637127681',100,'2020-04-05 10:40:11','2022-05-22 10:40:11','0',NULL,'5折券','2',100.00,NULL,5.0,'1'),
('1246628674560602113','1','0','2020-04-05 10:40:11','2020-04-05 10:40:11',NULL,'1242644400837718017','1234102578637127681',101,'2020-04-05 10:40:12','2020-04-14 10:40:12','0',NULL,'5元券','1',99.00,5.00,NULL,'1'),
('1246628678608105474','1','0','2020-04-05 10:40:12','2020-04-05 10:40:12',NULL,'1242644273821609986','1234102578637127681',102,'2020-04-05 10:40:13','2020-04-13 10:40:13','0',NULL,'8折券','2',10.00,NULL,8.0,'1');

/*Table structure for table `delivery_place` */

DROP TABLE IF EXISTS `delivery_place`;

CREATE TABLE `delivery_place` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `place` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '地方',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '详细地址',
  `tel_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '电话号码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='发货地';

/*Data for the table `delivery_place` */

insert  into `delivery_place`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`place`,`address`,`tel_num`) values 
('1226515772106289154','1','0','2020-02-09 22:38:42','2020-02-09 22:38:42',NULL,'广东深圳','杰奎琳啊各位作你你 仍','18653658264'),
('1226515817257971713','1','0','2020-02-09 22:38:53','2020-02-09 22:38:53',NULL,'湖南长沙','梦工厂仍和我自然人仍','18653625621'),
('1226515909281001473','1','0','2020-02-09 22:39:14','2020-02-09 22:39:14',NULL,'江苏南京','仍签名签名 你','18542561581');

/*Table structure for table `ensure` */

DROP TABLE IF EXISTS `ensure`;

CREATE TABLE `ensure` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '保障名',
  `detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '保障详情',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='保障服务';

/*Data for the table `ensure` */

insert  into `ensure`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`name`,`detail`) values 
('1226531618484621314','1','0','2020-02-09 23:41:40','2020-02-09 23:41:40',NULL,'假一赔十','正品保障，假一赔十'),
('1226531861997522946','1','0','2020-02-09 23:42:38','2020-02-09 23:42:38',NULL,'七天无理由退换','满足相应条件时，消费者可申请 “七天无理由退换”'),
('1226532182597537793','1','0','2020-02-09 23:43:54','2020-02-09 23:43:54',NULL,'24小时内发货',''),
('1226532495656194050','1','0','2020-02-09 23:45:09','2020-02-09 23:45:09',NULL,'5年质量保证','');

/*Table structure for table `ensure_goods` */

DROP TABLE IF EXISTS `ensure_goods`;

CREATE TABLE `ensure_goods` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `ensure_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '保障ID',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品spuID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商品保障';

/*Data for the table `ensure_goods` */

insert  into `ensure_goods`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`ensure_id`,`spu_id`) values 
('1246430673825181698','1','0','2020-04-04 21:33:24','2020-04-04 21:33:24',NULL,'1226531861997522946','2b48a2f35352a4d87d51d6dd03bb874e'),
('1246430906349006850','1','0','2020-04-04 21:34:20','2020-04-04 21:34:20',NULL,'1226531861997522946','4d06c5157cce971b89166e509cdf63e8'),
('1246430906353201154','1','0','2020-04-04 21:34:20','2020-04-04 21:34:20',NULL,'1226531618484621314','4d06c5157cce971b89166e509cdf63e8');

/*Table structure for table `freight_templat` */

DROP TABLE IF EXISTS `freight_templat`;

CREATE TABLE `freight_templat` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `sort` int(11) NOT NULL COMMENT '排序字段',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `type` char(2) NOT NULL COMMENT '模板类型1、买家承担运费；2、卖家包邮',
  `charge_type` char(2) NOT NULL COMMENT '计费方式1、按件数；2、按重量；3、按体积',
  `first_num` decimal(10,2) DEFAULT '0.00' COMMENT '首件、首体积、首重量',
  `first_freight` decimal(10,2) DEFAULT '0.00' COMMENT '首运费',
  `continue_num` decimal(10,2) DEFAULT '0.00' COMMENT '续件、续体积、续重量',
  `continue_freight` decimal(10,2) DEFAULT '0.00' COMMENT '续运费',
  PRIMARY KEY (`id`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='运费模板';

/*Data for the table `freight_templat` */

insert  into `freight_templat`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`sort`,`name`,`type`,`charge_type`,`first_num`,`first_freight`,`continue_num`,`continue_freight`) values 
('556760ba464981b71de368b7d5627746','1','0','2019-12-24 18:30:36','2019-12-24 18:30:36',3,'全国统一按重量收费','1','2',6.00,5.00,5.00,5.00),
('a73cf89f7a5a0dcd8c45b9cf2b7be681','1','0','2019-12-24 18:23:59','2019-12-24 18:23:59',2,'全国统一按件收费','1','1',2.00,5.00,2.00,3.00),
('b850d39b204f3be8654d8358b91aff3f','1','0','2019-12-24 18:31:08','2019-12-24 18:31:08',5,'全国统一按体积收费','1','3',6.00,5.00,5.00,5.00),
('e2daad9554fc3206bab0ab4788840b42','1','0','2019-12-24 18:07:17','2019-12-24 18:07:17',1,'全国包邮','2','1',0.00,0.00,0.00,0.00);

/*Table structure for table `goods_appraises` */

DROP TABLE IF EXISTS `goods_appraises`;

CREATE TABLE `goods_appraises` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `order_id` varchar(32) DEFAULT NULL COMMENT '订单ID',
  `order_item_id` varchar(32) DEFAULT NULL COMMENT '订单详情ID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户编号',
  `nick_name` varchar(200) DEFAULT NULL COMMENT '用户昵称',
  `headimg_url` varchar(1000) DEFAULT NULL COMMENT '用户头像',
  `spu_id` varchar(32) DEFAULT NULL COMMENT '商品Id',
  `sku_id` varchar(32) DEFAULT NULL COMMENT 'sku_id',
  `pic_urls` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片',
  `spec_info` varchar(500) DEFAULT NULL COMMENT '规格信息',
  `goods_score` smallint(6) DEFAULT NULL COMMENT '商品评分',
  `service_score` smallint(6) DEFAULT NULL COMMENT '服务评分',
  `logistics_score` smallint(6) DEFAULT NULL COMMENT '物流评分',
  `content` varchar(500) DEFAULT NULL COMMENT '评论内容',
  `seller_reply` varchar(500) DEFAULT NULL COMMENT '卖家回复',
  `reply_time` datetime DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商品评价表';

/*Data for the table `goods_appraises` */

insert  into `goods_appraises`(`id`,`tenant_id`,`create_time`,`update_time`,`del_flag`,`order_id`,`order_item_id`,`user_id`,`nick_name`,`headimg_url`,`spu_id`,`sku_id`,`pic_urls`,`spec_info`,`goods_score`,`service_score`,`logistics_score`,`content`,`seller_reply`,`reply_time`) values 
('1235083976705564673','1','2020-03-04 14:05:41','2020-03-04 14:05:41','0','1235082093857222658','1235082093932720129','1234102578905571330','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','10f415b0cd746ebf764acc3a6a4d13a2',NULL,'电信，白色，64G',5,5,5,NULL,'wgsgweyewy','2020-03-24 10:21:13'),
('1235083976718147585','1','2020-03-04 14:05:41','2020-03-04 14:05:41','0','1235082093857222658','1235082093932720130','1234102578905571330','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','106c4dc9184da01ce15e26f4256560d4',NULL,'移动，白色，32G',4,3,5,NULL,NULL,NULL),
('1235083976722341890','1','2020-03-04 14:05:41','2020-03-04 14:05:41','0','1235082093857222658','1235082093941108738','1234102578905571330','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','954060498a28ba885c504d9e9234a009',NULL,'移动，红色，64G',2,3,4,NULL,NULL,NULL),
('1235083976722341891','1','2020-03-04 14:05:41','2020-03-04 14:05:41','0','1235082093857222658','1235082093941108739','1234102578905571330','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','4d06c5157cce971b89166e509cdf63e8','894b591741d425ca9c1b1579ce299a5b',NULL,'裸机',5,5,5,NULL,NULL,NULL),
('1245706897160433665','1','2020-04-02 21:37:23','2020-04-02 21:37:23','0','1245705213176737793','1245705213201903617','1240923176159866882','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00',NULL,'电信，红色，64G',5,5,5,'哈站好的',NULL,NULL),
('1245707972265406465','1','2020-04-02 21:41:39','2020-04-02 21:41:39','0','1245693883183091714','1245693883241811969','1240923176159866882','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','4d06c5157cce971b89166e509cdf63e8','7cee91d08568afe4f8c2a7651f52be8b',NULL,'超值大礼包',5,5,5,'JOJO',NULL,NULL),
('1245985763091312642','1','2020-04-03 16:05:29','2020-04-03 16:05:29','0','1245702994784186370','1245702994842906625','1240923176159866882','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93',NULL,'移动，红色，32G',5,5,5,'好? ','xiexie ','2020-04-03 04:07:59');

/*Table structure for table `goods_category` */

DROP TABLE IF EXISTS `goods_category`;

CREATE TABLE `goods_category` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `parent_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '父分类编号',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '描述',
  `pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片',
  `sort` smallint(4) DEFAULT NULL COMMENT '排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='分类表';

/*Data for the table `goods_category` */

insert  into `goods_category`(`id`,`tenant_id`,`parent_id`,`name`,`description`,`pic_url`,`sort`,`create_time`,`update_time`,`del_flag`) values 
('07c4d5a53332888c5a59e81ebcff1933','1','0','生活电器','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%AE%B6%E7%94%A8%E7%94%B5%E5%99%A8.png',6,'2019-09-27 14:24:40','2019-09-27 14:24:40','0'),
('0e2d6c17203e3d46ee5a1d0ca1eec715','1','31e2b38f810a89159411e43160afd0f9','数码相机','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%95%B0%E7%A0%81%E7%9B%B8%E6%9C%BA.jpg',0,'2019-09-27 14:47:34','2019-09-27 14:47:34','0'),
('0f2aa8354eedb3b652b45e90efb54e27','1','9bb404548cc6513c1c148b532b6db720','苹果','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E8%8B%B9%E6%9E%9C.jpg',4,'2019-08-24 22:19:16','2019-08-24 22:19:16','0'),
('1e26b32eda4e4d73d5b8ce21926f4a48','1','9bb404548cc6513c1c148b532b6db720','三星','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E4%B8%89%E6%98%9F.png',6,'2019-08-24 22:19:43','2019-08-24 22:19:43','0'),
('1f09f987669ae343342f1ef9a3fe6cd0','1','f19e67b9a7863b37485f7f3cbec53fcf','耳麦','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E8%80%B3%E6%9C%BA%E8%80%B3%E9%BA%A6.jpg',0,'2019-09-27 14:48:40','2019-09-27 14:48:40','0'),
('2239dfa1128dd7c88066040dc7dfa44a','1','d5a7b863c2759241ac571f5bc1b6239d','生活电池','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E7%94%B5%E6%B1%A0.jpg',0,'2019-09-27 14:47:56','2019-09-27 14:47:56','0'),
('235a1554567c92073b0ee1bc8c6772ca','872f46d167f7428c8e9e252c17997fb5','0','的的','的的啊','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/872f46d167f7428c8e9e252c17997fb5/material/1f5377c7-3a83-4470-a629-52cc3203857c.jpg',1,'2019-12-16 20:55:07','2019-12-16 20:55:07','0'),
('2a5e644f2722dac1e677a61394eae980','1','07c4d5a53332888c5a59e81ebcff1933','吹风机','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%90%B9%E9%A3%8E%E6%9C%BA.jpg',0,'2019-09-27 14:45:27','2019-09-27 14:45:27','0'),
('2e950da001186a809674e3d4a935b5c5','1','9bb404548cc6513c1c148b532b6db720','OPPO','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/oppo.png',5,'2019-08-24 22:19:28','2019-08-24 22:19:28','0'),
('2f3ea9d7a46a40325fa6f713ac0a1d17','1','cfda0b45b229fa9f77c02464c9c694f0','机械键盘','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/TB2VsugXGZPyuJjSspmXXX2IXXa_!!2510050218_gaitubao_.jpg',0,'2019-09-27 15:10:41','2019-09-27 15:10:41','0'),
('31e2b38f810a89159411e43160afd0f9','1','0','单反相机','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%8D%95%E5%8F%8D%E7%9B%B8%E6%9C%BA.png',8,'2019-09-27 14:21:32','2019-09-27 14:21:32','0'),
('356ea44470f5ffff46f395256438c275','1','a31ddf2eb997d61bdb70375ffd364153','平板贴膜','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%B9%B3%E6%9D%BF%E8%B4%B4%E8%86%9C.jpg',11,'2019-08-23 23:13:20','2019-08-23 23:13:20','0'),
('37cb876ae742945fea974ab0e281ae7f','1','cff988e342a4ed77ae64f0c9032159f5','扫地机器人','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%89%AB%E5%9C%B0%E6%9C%BA%E5%99%A8%E4%BA%BA.jpg',0,'2019-09-27 14:46:44','2019-09-27 14:46:44','0'),
('3c8d3fd9400792e716814e7952f60e72','1','c60c5526496d5dd9e1f507c836473699','笔记本电脑','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E7%AC%94%E8%AE%B0%E6%9C%AC%E7%94%B5%E8%84%91.jpg',0,'2019-09-27 14:14:24','2019-09-27 14:14:24','0'),
('4c0830479e930777902c8b3aa49ea53b','1','ccaafb0ae7ec4ade755b3f8cfa73b2db','保护壳/套','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%89%8B%E6%9C%BA%E5%A3%B3.jpg',2,'2019-09-27 14:17:10','2019-09-27 14:17:10','0'),
('4d44df171be6d7d6ccb923270c6f0f25','1','e14a5fd83638e8b720cff2b62ec143cc','烤箱','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E7%83%A4%E7%AE%B1_gaitubao_.jpg',0,'2019-09-27 14:45:59','2019-09-27 14:45:59','0'),
('4e4892411532de5d37054304ec08934e','1','ccaafb0ae7ec4ade755b3f8cfa73b2db','手机支架','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%94%AF%E6%9E%B6.jpg',3,'2019-09-27 14:17:26','2019-09-27 14:17:26','0'),
('4ed2743ae2198f247b204cb08efcca44','1','0','智能手环','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%99%BA%E8%83%BD%E6%89%8B%E7%8E%AF.png',13,'2019-09-27 14:22:14','2019-09-27 14:22:14','0'),
('522dbac5f593593a7c3722fc64b07359','1','a31ddf2eb997d61bdb70375ffd364153','支架','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%94%AF%E6%9E%B6.jpg',10,'2019-08-23 23:13:05','2019-08-23 23:13:05','0'),
('75221e3d0f3cc0fbf9160536b38d326e','1','a31ddf2eb997d61bdb70375ffd364153','U盘','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/u%E7%9B%981.png',5,'2019-08-23 23:05:42','2019-08-23 23:05:42','0'),
('7b936b3fe43c3c60df4618c86f542f1a','1','9bb404548cc6513c1c148b532b6db720','vivo','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/vivo.jpg',8,'2019-08-24 22:20:35','2019-08-24 22:20:35','0'),
('81eafcfd718dc8ba8662aa94c249f6df','1','a31ddf2eb997d61bdb70375ffd364153','数码收纳','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%95%B0%E7%A0%81%E6%94%B6%E7%BA%B3.jpg',7,'2019-08-23 23:06:24','2019-08-23 23:06:24','0'),
('8328db9dd6e9a4d6ef0956a649053cbf','1','0','摄影配件','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%91%84%E5%BD%B1%E9%85%8D%E4%BB%B6%E9%95%BF%E5%9B%BE_gaitubao_.jpg',9,'2019-09-27 14:28:39','2019-09-27 14:28:39','0'),
('862a74f109f7f14bcbfff1d5adf73cdc','1','9bb404548cc6513c1c148b532b6db720','华为','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%8D%8E%E4%B8%BA.jpg',1,'2019-08-24 22:18:43','2019-08-24 22:18:43','0'),
('8722b34fd15ba8e6cb9f1754d09ec59c','1','a31ddf2eb997d61bdb70375ffd364153','数码保护套','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%95%B0%E7%A0%81%E4%BF%9D%E6%8A%A4%E5%A5%97.jpg',3,'2019-08-23 23:05:14','2019-08-23 23:05:14','0'),
('8945e91422a84476cdd0a8361092ca44','1','ccaafb0ae7ec4ade755b3f8cfa73b2db','移动电源','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E7%A7%BB%E5%8A%A8%E7%94%B5%E6%BA%901.jpg',0,'2019-09-27 14:16:35','2019-09-27 14:16:35','0'),
('8a3e5b7dd20542ce298758cc02bee1fd','1','f39dbb616d9ede9e353041bc1f35f459','手机内存卡','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/595e02ccNf23b2553.jpg',0,'2019-09-27 14:49:12','2019-09-27 14:49:12','0'),
('8f47e312f90ff89e61b5a2c9e4a78459','1','9bb404548cc6513c1c148b532b6db720','honor','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E8%8D%A3%E8%80%80.jpg',2,'2019-08-24 22:18:54','2019-08-24 22:18:54','0'),
('988f1af72652178159de1ec009ab8fb0','1','9bb404548cc6513c1c148b532b6db720','小米','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%B0%8F%E7%B1%B3.jpg',3,'2019-08-24 22:19:03','2019-08-24 22:19:03','0'),
('9bb404548cc6513c1c148b532b6db720','1','0','手机','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%89%8B%E6%9C%BA_gaitubao_467x243.jpg',0,'2019-08-23 23:23:05','2019-08-23 23:23:05','0'),
('a31ddf2eb997d61bdb70375ffd364153','1','0','数码配件','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%95%B0%E7%A0%81_gaitubao_521x275.jpg',1,'2019-08-12 15:36:37','2019-08-12 18:32:21','0'),
('a629d3418f406d27dfdcde71670ffa0a','1','0','大家电','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190824233956_gaitubao_567x275.jpg',5,'2019-08-12 15:23:08','2019-08-14 09:59:49','0'),
('a9acd965e1bf8c062edfa46b7f99203f','1','0','电脑周边','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E7%94%B5%E8%84%91%E5%91%A8%E8%BE%B9.png',4,'2019-09-27 14:27:08','2019-09-27 14:27:08','0'),
('ade737abcb77d0cd880e0208a34027eb','1','a9acd965e1bf8c062edfa46b7f99203f','鼠标','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E9%BC%A0%E6%A0%87.jpg',1,'2019-09-27 14:45:00','2019-09-27 14:45:00','0'),
('aee643fbb77dfeac433a275ff8d900d7','1','a31ddf2eb997d61bdb70375ffd364153','硬盘','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E7%A1%AC%E7%9B%98.jpg',1,'2019-08-12 15:39:54','2019-08-12 15:39:54','0'),
('b077e1d31deace3aa871da9fedae35ad','1','ccaafb0ae7ec4ade755b3f8cfa73b2db','手机耳机','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E8%80%B3%E6%9C%BA.jpg',1,'2019-09-27 14:16:52','2019-09-27 14:16:52','0'),
('b117a0d046a79337ec53bbf9e62b47f7','1','9bb404548cc6513c1c148b532b6db720','诺基亚','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E8%AF%BA%E5%9F%BA%E4%BA%9A.jpg',7,'2019-08-24 22:19:59','2019-08-24 22:19:59','0'),
('c2731c7e8c6867d8a1168298e9e28c5b','1','a629d3418f406d27dfdcde71670ffa0a','洗衣机','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%B4%97%E8%A1%A3%E6%9C%BA.jpg',2,'2019-08-24 22:04:29','2019-08-24 22:04:29','0'),
('c60c5526496d5dd9e1f507c836473699','1','0','电脑','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190927151104.png',3,'2019-08-23 23:24:46','2019-08-23 23:24:46','0'),
('cab5358226cfb8b04199c0a63209e49e','1','8328db9dd6e9a4d6ef0956a649053cbf','脚架','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%91%84%E5%BD%B1%E8%84%9A%E6%9E%B6.jpg',0,'2019-09-27 14:48:21','2019-09-27 14:48:21','0'),
('ccaafb0ae7ec4ade755b3f8cfa73b2db','1','0','手机配件','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%89%8B%E6%9C%BA%E9%85%8D%E4%BB%B6.png',2,'2019-09-27 14:16:14','2019-09-27 14:16:14','0'),
('ce0192da5725a512b702ab2b3f7e5a1f','1','c60c5526496d5dd9e1f507c836473699','显示器','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%98%BE%E7%A4%BA%E5%99%A8.jpg',1,'2019-09-27 14:14:38','2019-09-27 14:14:38','0'),
('cfda0b45b229fa9f77c02464c9c694f0','1','0','游戏设备','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%B8%B8%E6%88%8F%E8%AE%BE%E5%A4%87.png',16,'2019-09-27 15:10:27','2019-09-27 15:10:27','0'),
('cff988e342a4ed77ae64f0c9032159f5','1','0','智能家居','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%AE%B6%E7%94%A8%E6%99%BA%E8%83%BD.png',12,'2019-09-27 14:31:24','2019-09-27 14:31:24','0'),
('d4ecd80e6f3526dec6949027de971908','1','4ed2743ae2198f247b204cb08efcca44','智能手表','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E6%99%BA%E8%83%BD%E6%89%8B%E8%A1%A8.jpg',0,'2019-09-27 14:48:55','2019-09-27 14:48:55','0'),
('d5a7b863c2759241ac571f5bc1b6239d','1','0','电池类','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E7%94%B5%E6%B1%A0.png',14,'2019-09-27 14:40:55','2019-09-27 14:40:55','0'),
('d9b1af75073a44c78e3cd8a0c8525f44','1','c60c5526496d5dd9e1f507c836473699','平板电脑','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%B9%B3%E6%9D%BF%E7%94%B5%E8%84%91.jpg',2,'2019-09-27 14:14:57','2019-09-27 14:14:57','0'),
('ddbe36b3a276020b92020f398e420895','1','a629d3418f406d27dfdcde71670ffa0a','冰箱','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%86%B0%E7%AE%B1_gaitubao_383x383.jpg',0,'2019-08-12 15:40:33','2019-08-12 15:40:33','0'),
('e14a5fd83638e8b720cff2b62ec143cc','1','0','厨卫电器','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%8E%A8%E5%8D%AB%E7%94%B5%E5%99%A8.png',7,'2019-09-27 14:24:31','2019-09-27 14:24:31','0'),
('ef0e1b94f209171cc9efbd04f8232a7b','1','a31ddf2eb997d61bdb70375ffd364153','USB周边','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/usb%E5%91%A8%E8%BE%B9.jpg',4,'2019-08-23 23:05:29','2019-08-23 23:05:29','0'),
('f19e67b9a7863b37485f7f3cbec53fcf','1','0','影音电子','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E9%9F%B3%E5%93%8D.png',9,'2019-09-27 14:26:37','2019-09-27 14:26:37','0'),
('f39dbb616d9ede9e353041bc1f35f459','1','0','储存卡','','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%82%A8%E5%AD%98%E5%8D%A1.png',15,'2019-09-27 14:42:10','2019-09-27 14:42:10','0');

/*Table structure for table `goods_sku` */

DROP TABLE IF EXISTS `goods_sku`;

CREATE TABLE `goods_sku` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `sku_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'sku编码',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品Id',
  `pic_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '图片',
  `sales_price` decimal(10,2) DEFAULT NULL COMMENT '销售价格',
  `market_price` decimal(10,2) DEFAULT NULL COMMENT '市场价',
  `cost_price` decimal(10,2) DEFAULT NULL COMMENT '成本价',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `weight` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '重量（kg）',
  `volume` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '体积（m³）',
  `enable` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '是否启用1、是；0否',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='sku表';

/*Data for the table `goods_sku` */

insert  into `goods_sku`(`id`,`create_time`,`update_time`,`tenant_id`,`sku_code`,`spu_id`,`pic_url`,`sales_price`,`market_price`,`cost_price`,`stock`,`weight`,`volume`,`enable`,`del_flag`) values 
('106c4dc9184da01ce15e26f4256560d4','2020-04-03 16:19:05','2020-04-03 16:19:05','1',NULL,'2835671ff031c18cb181b1a199f86b01','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',0.01,NULL,NULL,4,0.00,0.00,'1','0'),
('10f415b0cd746ebf764acc3a6a4d13a2','2020-04-03 16:19:05','2020-04-03 16:19:05','1',NULL,'2835671ff031c18cb181b1a199f86b01','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',0.01,NULL,NULL,97,0.00,0.00,'1','0'),
('25382fd4bb10ff4ca5b9000262e7b0e4','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('278357f4667ba6677c9936e33b94bfdd','2020-04-04 21:36:43','2020-04-04 21:36:43','1',NULL,'6545a6fc2927edc195b93982f446917c','',5488.00,NULL,NULL,54,0.00,0.00,'1','0'),
('2ab787084884a7169d5dd2b7a259c9cc','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('2db22126dc5c251de13064fe12ebfb62','2020-04-04 21:36:20','2020-04-04 21:36:20','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',3599.00,NULL,NULL,7,0.00,0.00,'1','0'),
('3c56e0951df15b44cfc121cf61c33829','2020-04-04 21:36:43','2020-04-04 21:36:43','1',NULL,'6545a6fc2927edc195b93982f446917c','',4988.00,NULL,NULL,54,0.00,0.00,'1','0'),
('401c62d0a62226e6209728629645677d','2020-04-04 21:36:20','2020-04-04 21:36:20','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',3599.00,NULL,NULL,8,0.00,0.00,'1','0'),
('416ab6fc443778d2a9fc5e7f4a9b0e00','2020-04-03 16:19:05','2020-04-03 16:19:05','1',NULL,'2835671ff031c18cb181b1a199f86b01','',2599.00,NULL,NULL,42,0.00,0.00,'1','0'),
('445e36a6969f8ad3d50189ae93ffb648','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1560.00,NULL,NULL,5,0.00,0.00,'1','0'),
('4bdae99ee87f891eba5ed92fefd6398e','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('5002eafdeca30f4c590b3288de5fa217','2020-04-04 21:36:43','2020-04-04 21:36:43','1',NULL,'6545a6fc2927edc195b93982f446917c','',4988.00,NULL,NULL,92,0.00,0.00,'1','0'),
('5033e1f2bfa07231d1c2045392fa2f93','2020-04-03 16:19:05','2020-04-03 16:19:05','1',NULL,'2835671ff031c18cb181b1a199f86b01','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',2000.00,NULL,NULL,88,0.00,0.00,'1','0'),
('51ff5da47a14e61e32f01f06261fbb8a','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1508.00,NULL,NULL,5,0.00,0.00,'1','0'),
('5a61a7876305b760efa8abe04b912a8b','2020-04-03 16:19:05','2020-04-03 16:19:05','1',NULL,'2835671ff031c18cb181b1a199f86b01','',0.01,NULL,NULL,4,0.00,0.00,'1','0'),
('7cee91d08568afe4f8c2a7651f52be8b','2020-04-04 21:34:20','2020-04-04 21:34:20','1',NULL,'4d06c5157cce971b89166e509cdf63e8','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',100.00,888.00,NULL,101,4.00,3.00,'1','0'),
('7d194deff8da58f84a6fea43c0aaba6d','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('7feea846da4bfd3e2dc1c5c41184cd40','2020-04-04 21:36:43','2020-04-04 21:36:43','1',NULL,'6545a6fc2927edc195b93982f446917c','',5488.00,NULL,NULL,66,0.00,0.00,'1','0'),
('81f6520c7fd6a07c2085ed477401adc6','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('8558b4f72eb78580e251f7b50351ba2f','2020-04-04 21:36:20','2020-04-04 21:36:20','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',2799.00,NULL,NULL,8,0.00,0.00,'1','0'),
('894b591741d425ca9c1b1579ce299a5b','2020-04-04 21:34:20','2020-04-04 21:34:20','1',NULL,'4d06c5157cce971b89166e509cdf63e8','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',0.01,666.00,NULL,53,2.00,5.00,'1','0'),
('8b3d9b08b33081b231e75ef5f0bf3705','2020-04-03 16:19:05','2020-04-03 16:19:05','1',NULL,'2835671ff031c18cb181b1a199f86b01','',1999.00,NULL,NULL,8,0.00,0.00,'1','0'),
('9211ed74de18ec2d044377163ba6ad90','2020-04-04 21:36:20','2020-04-04 21:36:20','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',3599.00,NULL,NULL,8,0.00,0.00,'1','0'),
('954060498a28ba885c504d9e9234a009','2020-04-03 16:19:05','2020-04-03 16:19:05','1',NULL,'2835671ff031c18cb181b1a199f86b01','',0.01,NULL,NULL,99,0.00,0.00,'1','0'),
('965bac3dbc101b6abe68b72469118f03','2019-12-28 21:38:26','2019-12-28 21:38:26','1',NULL,'2b48a2f35352a4d87d51d6dd03bb874e','',0.01,0.00,0.00,75,3.00,0.00,'1','0'),
('a1c72bd9cd274406fbd8ee212f7fb583','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1500.00,NULL,NULL,5,0.00,0.00,'1','0'),
('a93e101a5923bf5924a24353f9a93f62','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('b139d9185833c938e4340e3a181b245a','2020-04-03 16:19:05','2020-04-03 16:19:05','1',NULL,'2835671ff031c18cb181b1a199f86b01','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',2000.00,NULL,NULL,7,0.00,0.00,'1','0'),
('c43134d412ab15a0075a31d2b35f0838','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1200.00,NULL,NULL,5,0.00,0.00,'1','0'),
('df566ba8600b4305606b87fe523a87f4','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1100.00,NULL,NULL,5,0.00,0.00,'1','0'),
('e632fe2bf818837ec0f05903568a1c59','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1200.00,NULL,NULL,5,0.00,0.00,'1','0'),
('eca0bf5189ba8192ccf5fc615970ea9d','2020-04-04 21:36:43','2020-04-04 21:36:43','1',NULL,'6545a6fc2927edc195b93982f446917c','',4988.00,NULL,NULL,87,0.00,0.00,'1','0'),
('eea55f1c4ad3b9eb305c8b357c8fb46a','2020-04-04 21:36:20','2020-04-04 21:36:20','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',2799.00,NULL,NULL,5,0.00,0.00,'1','0'),
('f1e8f2b7de163c57cfd8920bd200a110','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1500.00,NULL,NULL,5,0.00,0.00,'1','0'),
('f3b7f08030e448c0aaca6895e65aa5e9','2020-04-04 21:36:43','2020-04-04 21:36:43','1',NULL,'6545a6fc2927edc195b93982f446917c','',5488.00,NULL,NULL,5,0.00,0.00,'1','0'),
('f42bda1c9215a878fd49360a7576c913','2020-04-04 21:36:20','2020-04-04 21:36:20','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',2799.00,NULL,NULL,7,0.00,0.00,'1','0'),
('f987f6a1f92babfeb6ecff2df7f6b899','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1201.00,NULL,NULL,5,0.00,0.00,'1','0');

/*Table structure for table `goods_sku_spec_value` */

DROP TABLE IF EXISTS `goods_sku_spec_value`;

CREATE TABLE `goods_sku_spec_value` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属租户',
  `spu_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'spu_id',
  `sku_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'sku_id',
  `spec_value_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规格值id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='sku规格值';

/*Data for the table `goods_sku_spec_value` */

insert  into `goods_sku_spec_value`(`id`,`tenant_id`,`spu_id`,`sku_id`,`spec_value_id`,`create_time`,`update_time`) values 
('1245989184036958209','1','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','5','2020-04-03 16:19:05',NULL),
('1245989184045346817','1','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','958aad754214368594a38428bc09defd','2020-04-03 16:19:05',NULL),
('1245989184045346818','1','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','1','2020-04-03 16:19:05',NULL),
('1245989184045346819','1','2835671ff031c18cb181b1a199f86b01','8b3d9b08b33081b231e75ef5f0bf3705','5','2020-04-03 16:19:05',NULL),
('1245989184045346820','1','2835671ff031c18cb181b1a199f86b01','8b3d9b08b33081b231e75ef5f0bf3705','958aad754214368594a38428bc09defd','2020-04-03 16:19:05',NULL),
('1245989184045346821','1','2835671ff031c18cb181b1a199f86b01','8b3d9b08b33081b231e75ef5f0bf3705','2','2020-04-03 16:19:05',NULL),
('1245989184045346822','1','2835671ff031c18cb181b1a199f86b01','10f415b0cd746ebf764acc3a6a4d13a2','5','2020-04-03 16:19:05',NULL),
('1245989184045346823','1','2835671ff031c18cb181b1a199f86b01','10f415b0cd746ebf764acc3a6a4d13a2','e14c2a907231c2bd0d484a9cdc1fb557','2020-04-03 16:19:05',NULL),
('1245989184045346824','1','2835671ff031c18cb181b1a199f86b01','10f415b0cd746ebf764acc3a6a4d13a2','1','2020-04-03 16:19:05',NULL),
('1245989184045346825','1','2835671ff031c18cb181b1a199f86b01','b139d9185833c938e4340e3a181b245a','5','2020-04-03 16:19:05',NULL),
('1245989184045346826','1','2835671ff031c18cb181b1a199f86b01','b139d9185833c938e4340e3a181b245a','e14c2a907231c2bd0d484a9cdc1fb557','2020-04-03 16:19:05',NULL),
('1245989184045346827','1','2835671ff031c18cb181b1a199f86b01','b139d9185833c938e4340e3a181b245a','2','2020-04-03 16:19:05',NULL),
('1245989184045346828','1','2835671ff031c18cb181b1a199f86b01','954060498a28ba885c504d9e9234a009','4','2020-04-03 16:19:05',NULL),
('1245989184045346829','1','2835671ff031c18cb181b1a199f86b01','954060498a28ba885c504d9e9234a009','958aad754214368594a38428bc09defd','2020-04-03 16:19:05',NULL),
('1245989184045346830','1','2835671ff031c18cb181b1a199f86b01','954060498a28ba885c504d9e9234a009','1','2020-04-03 16:19:05',NULL),
('1245989184045346831','1','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','4','2020-04-03 16:19:05',NULL),
('1245989184045346832','1','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','958aad754214368594a38428bc09defd','2020-04-03 16:19:05',NULL),
('1245989184045346833','1','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','2','2020-04-03 16:19:05',NULL),
('1245989184045346834','1','2835671ff031c18cb181b1a199f86b01','5a61a7876305b760efa8abe04b912a8b','4','2020-04-03 16:19:05',NULL),
('1245989184045346835','1','2835671ff031c18cb181b1a199f86b01','5a61a7876305b760efa8abe04b912a8b','e14c2a907231c2bd0d484a9cdc1fb557','2020-04-03 16:19:05',NULL),
('1245989184045346836','1','2835671ff031c18cb181b1a199f86b01','5a61a7876305b760efa8abe04b912a8b','1','2020-04-03 16:19:05',NULL),
('1245989184053735426','1','2835671ff031c18cb181b1a199f86b01','106c4dc9184da01ce15e26f4256560d4','4','2020-04-03 16:19:05',NULL),
('1245989184053735427','1','2835671ff031c18cb181b1a199f86b01','106c4dc9184da01ce15e26f4256560d4','e14c2a907231c2bd0d484a9cdc1fb557','2020-04-03 16:19:05',NULL),
('1245989184053735428','1','2835671ff031c18cb181b1a199f86b01','106c4dc9184da01ce15e26f4256560d4','2','2020-04-03 16:19:05',NULL),
('1246430906315452417','1','4d06c5157cce971b89166e509cdf63e8','7cee91d08568afe4f8c2a7651f52be8b','69ca24903aa6261ea946ef37d88db23f','2020-04-04 21:34:20',NULL),
('1246430906323841026','1','4d06c5157cce971b89166e509cdf63e8','894b591741d425ca9c1b1579ce299a5b','414571f4d40c91b2be1d5039341fb080','2020-04-04 21:34:20',NULL),
('1246431412676997121','1','87ec583e2883cbd2fd259f47ece0fe15','8558b4f72eb78580e251f7b50351ba2f','e0b840a51e251badb5606d5ce1faa695','2020-04-04 21:36:21',NULL),
('1246431412676997122','1','87ec583e2883cbd2fd259f47ece0fe15','8558b4f72eb78580e251f7b50351ba2f','ed144c2c87660ead15b4784ed8df5d63','2020-04-04 21:36:21',NULL),
('1246431412676997123','1','87ec583e2883cbd2fd259f47ece0fe15','8558b4f72eb78580e251f7b50351ba2f','694d1ae3ffb4d03111a5b901cf1e1a8a','2020-04-04 21:36:21',NULL),
('1246431412676997124','1','87ec583e2883cbd2fd259f47ece0fe15','9211ed74de18ec2d044377163ba6ad90','e0b840a51e251badb5606d5ce1faa695','2020-04-04 21:36:21',NULL),
('1246431412685385730','1','87ec583e2883cbd2fd259f47ece0fe15','9211ed74de18ec2d044377163ba6ad90','ed144c2c87660ead15b4784ed8df5d63','2020-04-04 21:36:21',NULL),
('1246431412685385731','1','87ec583e2883cbd2fd259f47ece0fe15','9211ed74de18ec2d044377163ba6ad90','da0b3c06d18c677984f1b37655aa4505','2020-04-04 21:36:21',NULL),
('1246431412685385732','1','87ec583e2883cbd2fd259f47ece0fe15','f42bda1c9215a878fd49360a7576c913','e0b840a51e251badb5606d5ce1faa695','2020-04-04 21:36:21',NULL),
('1246431412685385733','1','87ec583e2883cbd2fd259f47ece0fe15','f42bda1c9215a878fd49360a7576c913','62de70420a9be05b6fbcf3e1c818e0de','2020-04-04 21:36:21',NULL),
('1246431412685385734','1','87ec583e2883cbd2fd259f47ece0fe15','f42bda1c9215a878fd49360a7576c913','694d1ae3ffb4d03111a5b901cf1e1a8a','2020-04-04 21:36:21',NULL),
('1246431412685385735','1','87ec583e2883cbd2fd259f47ece0fe15','2db22126dc5c251de13064fe12ebfb62','e0b840a51e251badb5606d5ce1faa695','2020-04-04 21:36:21',NULL),
('1246431412685385736','1','87ec583e2883cbd2fd259f47ece0fe15','2db22126dc5c251de13064fe12ebfb62','62de70420a9be05b6fbcf3e1c818e0de','2020-04-04 21:36:21',NULL),
('1246431412685385737','1','87ec583e2883cbd2fd259f47ece0fe15','2db22126dc5c251de13064fe12ebfb62','da0b3c06d18c677984f1b37655aa4505','2020-04-04 21:36:21',NULL),
('1246431412685385738','1','87ec583e2883cbd2fd259f47ece0fe15','eea55f1c4ad3b9eb305c8b357c8fb46a','e0b840a51e251badb5606d5ce1faa695','2020-04-04 21:36:21',NULL),
('1246431412685385739','1','87ec583e2883cbd2fd259f47ece0fe15','eea55f1c4ad3b9eb305c8b357c8fb46a','63fc0234dc4ebcc9553ab576b36167d2','2020-04-04 21:36:21',NULL),
('1246431412693774337','1','87ec583e2883cbd2fd259f47ece0fe15','eea55f1c4ad3b9eb305c8b357c8fb46a','694d1ae3ffb4d03111a5b901cf1e1a8a','2020-04-04 21:36:21',NULL),
('1246431412693774338','1','87ec583e2883cbd2fd259f47ece0fe15','401c62d0a62226e6209728629645677d','e0b840a51e251badb5606d5ce1faa695','2020-04-04 21:36:21',NULL),
('1246431412693774339','1','87ec583e2883cbd2fd259f47ece0fe15','401c62d0a62226e6209728629645677d','63fc0234dc4ebcc9553ab576b36167d2','2020-04-04 21:36:21',NULL),
('1246431412693774340','1','87ec583e2883cbd2fd259f47ece0fe15','401c62d0a62226e6209728629645677d','da0b3c06d18c677984f1b37655aa4505','2020-04-04 21:36:21',NULL),
('1246431505404669954','1','6545a6fc2927edc195b93982f446917c','f3b7f08030e448c0aaca6895e65aa5e9','f53488c6a79e795ba288d1279a5f98e7','2020-04-04 21:36:43',NULL),
('1246431505413058562','1','6545a6fc2927edc195b93982f446917c','f3b7f08030e448c0aaca6895e65aa5e9','da0b3c06d18c677984f1b37655aa4505','2020-04-04 21:36:43',NULL),
('1246431505413058563','1','6545a6fc2927edc195b93982f446917c','f3b7f08030e448c0aaca6895e65aa5e9','cba677f619061b9c326c15d8eceeb31e','2020-04-04 21:36:43',NULL),
('1246431505413058564','1','6545a6fc2927edc195b93982f446917c','5002eafdeca30f4c590b3288de5fa217','f53488c6a79e795ba288d1279a5f98e7','2020-04-04 21:36:43',NULL),
('1246431505413058565','1','6545a6fc2927edc195b93982f446917c','5002eafdeca30f4c590b3288de5fa217','694d1ae3ffb4d03111a5b901cf1e1a8a','2020-04-04 21:36:43',NULL),
('1246431505421447170','1','6545a6fc2927edc195b93982f446917c','5002eafdeca30f4c590b3288de5fa217','cba677f619061b9c326c15d8eceeb31e','2020-04-04 21:36:43',NULL),
('1246431505421447171','1','6545a6fc2927edc195b93982f446917c','278357f4667ba6677c9936e33b94bfdd','63fc0234dc4ebcc9553ab576b36167d2','2020-04-04 21:36:43',NULL),
('1246431505421447172','1','6545a6fc2927edc195b93982f446917c','278357f4667ba6677c9936e33b94bfdd','da0b3c06d18c677984f1b37655aa4505','2020-04-04 21:36:43',NULL),
('1246431505421447173','1','6545a6fc2927edc195b93982f446917c','278357f4667ba6677c9936e33b94bfdd','cba677f619061b9c326c15d8eceeb31e','2020-04-04 21:36:43',NULL),
('1246431505421447174','1','6545a6fc2927edc195b93982f446917c','3c56e0951df15b44cfc121cf61c33829','63fc0234dc4ebcc9553ab576b36167d2','2020-04-04 21:36:43',NULL),
('1246431505421447175','1','6545a6fc2927edc195b93982f446917c','3c56e0951df15b44cfc121cf61c33829','694d1ae3ffb4d03111a5b901cf1e1a8a','2020-04-04 21:36:43',NULL),
('1246431505421447176','1','6545a6fc2927edc195b93982f446917c','3c56e0951df15b44cfc121cf61c33829','cba677f619061b9c326c15d8eceeb31e','2020-04-04 21:36:43',NULL),
('1246431505421447177','1','6545a6fc2927edc195b93982f446917c','7feea846da4bfd3e2dc1c5c41184cd40','b8b3ece7283992f1c42826542eb98a43','2020-04-04 21:36:43',NULL),
('1246431505421447178','1','6545a6fc2927edc195b93982f446917c','7feea846da4bfd3e2dc1c5c41184cd40','da0b3c06d18c677984f1b37655aa4505','2020-04-04 21:36:43',NULL),
('1246431505421447179','1','6545a6fc2927edc195b93982f446917c','7feea846da4bfd3e2dc1c5c41184cd40','cba677f619061b9c326c15d8eceeb31e','2020-04-04 21:36:43',NULL),
('1246431505421447180','1','6545a6fc2927edc195b93982f446917c','eca0bf5189ba8192ccf5fc615970ea9d','b8b3ece7283992f1c42826542eb98a43','2020-04-04 21:36:43',NULL),
('1246431505421447181','1','6545a6fc2927edc195b93982f446917c','eca0bf5189ba8192ccf5fc615970ea9d','694d1ae3ffb4d03111a5b901cf1e1a8a','2020-04-04 21:36:43',NULL),
('1246431505421447182','1','6545a6fc2927edc195b93982f446917c','eca0bf5189ba8192ccf5fc615970ea9d','cba677f619061b9c326c15d8eceeb31e','2020-04-04 21:36:43',NULL),
('257c9920abdf14b7bafe2d1f8d1ee41f','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','25382fd4bb10ff4ca5b9000262e7b0e4','25a8724edc2ecf4fc295bf72f2faf923','2019-12-16 20:59:16',NULL),
('35a565f4adb80e8e96f3ba91421fbd9d','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','4bdae99ee87f891eba5ed92fefd6398e','fd82720178bbf4e198bf689f28b6d072','2019-12-16 20:59:16',NULL),
('48c63476857168f0cd17949deec14364','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','7d194deff8da58f84a6fea43c0aaba6d','fd82720178bbf4e198bf689f28b6d072','2019-12-16 20:59:16',NULL),
('4c778b28778a7c0a7ca4fcd1c8d155a0','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','a93e101a5923bf5924a24353f9a93f62','25a8724edc2ecf4fc295bf72f2faf923','2019-12-16 20:59:16',NULL),
('65dbc3a197236b4fa1bcefad192282aa','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','4bdae99ee87f891eba5ed92fefd6398e','1d7f73d660f51ed9737614eb7b0041c6','2019-12-16 20:59:16',NULL),
('910993ee19b4c953797922564510fc13','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','81f6520c7fd6a07c2085ed477401adc6','25a8724edc2ecf4fc295bf72f2faf923','2019-12-16 20:59:16',NULL),
('ae43f1b1f0002090b9c928a8f82bb794','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','2ab787084884a7169d5dd2b7a259c9cc','204fa96e649cc9333aa903d4b53d0f36','2019-12-16 20:59:16',NULL),
('b34543c50b3f1121bc461d63a67be069','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','81f6520c7fd6a07c2085ed477401adc6','204fa96e649cc9333aa903d4b53d0f36','2019-12-16 20:59:16',NULL),
('cd7514dd95c8a7ba5c5e15b379bbcdbf','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','2ab787084884a7169d5dd2b7a259c9cc','fd82720178bbf4e198bf689f28b6d072','2019-12-16 20:59:16',NULL),
('d856a208e914b72b632a4be00f960ee4','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','25382fd4bb10ff4ca5b9000262e7b0e4','1d7f73d660f51ed9737614eb7b0041c6','2019-12-16 20:59:16',NULL),
('db7c58cd5320fab23965f7c186c5c48a','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','a93e101a5923bf5924a24353f9a93f62','690315b4e8a0642a465167ed93063f9c','2019-12-16 20:59:16',NULL),
('f8c86f44a2589aaa41feb6115a0bb5e5','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','7d194deff8da58f84a6fea43c0aaba6d','690315b4e8a0642a465167ed93063f9c','2019-12-16 20:59:16',NULL);

/*Table structure for table `goods_spec` */

DROP TABLE IF EXISTS `goods_spec`;

CREATE TABLE `goods_spec` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '名称',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_name` (`tenant_id`,`name`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='规格表';

/*Data for the table `goods_spec` */

insert  into `goods_spec`(`id`,`tenant_id`,`name`,`del_flag`,`create_time`,`update_time`) values 
('02c21865a7681cc77f9b7f60d48cf2a1','1','购买方式','0','2019-08-26 14:53:18','2019-08-26 14:53:18'),
('030c4a9407b189383113fb3e7988cf38','1','版本','0','2019-08-14 21:26:21','2019-08-14 21:26:21'),
('1','1','内存','0','2019-08-13 11:20:15','2019-08-13 11:20:15'),
('2','1','网络制式','0','2019-08-13 14:14:31','2019-08-13 14:14:31'),
('22d6082e0c1cc2b5a570195f8d91ddad','1','容量','0','2019-08-26 11:53:04','2019-08-26 11:53:04'),
('2b2d479c89dfef05ea1e35386a3c4795','872f46d167f7428c8e9e252c17997fb5','款式','0','2019-12-16 20:58:01','2019-12-16 20:58:01'),
('3','1','颜色','0','2019-08-13 21:53:00','2019-08-13 21:53:00'),
('7e7f8fed52c4627fbf62b5a5dd58151f','1','尺码','0','2019-08-28 21:40:40','2019-08-28 21:40:40'),
('7f3333f95900cf5fce3dc41ef93e46bc','1','网络规格','0','2019-08-26 14:07:45','2019-08-26 14:07:45'),
('8b0e496328b99e49fb521fa6f880fedf','1','用途','0','2019-08-16 16:33:57','2019-08-16 16:33:57'),
('a51fda1bb9fbfb0c3fdc16f988319185','872f46d167f7428c8e9e252c17997fb5','颜色','0','2019-12-16 20:57:38','2019-12-16 20:57:38'),
('b38b0d33b310ff6e6c9f6762092e238d','1','套餐类型','0','2019-08-26 14:55:58','2019-08-26 14:55:58'),
('dae1169b7a82a1d6accff95ff8406aee','1','地区','0','2019-08-14 21:28:03','2019-08-14 21:28:03');

/*Table structure for table `goods_spec_value` */

DROP TABLE IF EXISTS `goods_spec_value`;

CREATE TABLE `goods_spec_value` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `spec_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规格Id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '名称',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_name` (`spec_id`,`name`,`tenant_id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='规格值表';

/*Data for the table `goods_spec_value` */

insert  into `goods_spec_value`(`id`,`tenant_id`,`spec_id`,`name`,`del_flag`,`create_time`,`update_time`) values 
('0027fd6892a74bc38431ccc77dd4bb3a','1','3','黑色','0','2019-08-28 21:42:51','2019-08-28 21:42:51'),
('048d8cfbd70c3b01ff2ff5976a64842f','1','7e7f8fed52c4627fbf62b5a5dd58151f','S','0','2019-08-28 21:40:45','2019-08-28 21:40:45'),
('1','1','1','64G','0','2019-08-13 11:20:33','2019-08-13 11:20:33'),
('1d7f73d660f51ed9737614eb7b0041c6','872f46d167f7428c8e9e252c17997fb5','a51fda1bb9fbfb0c3fdc16f988319185','白色','0','2019-12-16 20:57:44','2019-12-16 20:57:44'),
('2','1','1','32G','0','2019-08-13 11:20:48','2019-08-13 11:20:48'),
('204fa96e649cc9333aa903d4b53d0f36','872f46d167f7428c8e9e252c17997fb5','a51fda1bb9fbfb0c3fdc16f988319185','黑色','0','2019-12-16 20:57:48','2019-12-16 20:57:48'),
('219547f11911619c247414314762b5eb','1','3','蓝色','0','2019-08-24 17:39:42','2019-08-24 17:39:42'),
('25a8724edc2ecf4fc295bf72f2faf923','872f46d167f7428c8e9e252c17997fb5','2b2d479c89dfef05ea1e35386a3c4795','款式2','0','2019-12-16 20:58:14','2019-12-16 20:58:14'),
('3','1','2','联通','0','2019-08-13 14:14:50','2019-08-13 14:14:50'),
('314393294141bb35417b164ee2bc9a0b','1','7e7f8fed52c4627fbf62b5a5dd58151f','165','0','2019-08-28 21:47:39','2019-08-28 21:47:39'),
('316bf47699774271e344253021b48b47','1','3','珠光贝母','0','2019-08-26 11:52:21','2019-08-26 11:52:21'),
('37251998ff4119058821e0f5ec0d282a','1','22d6082e0c1cc2b5a570195f8d91ddad','8+128GB','0','2019-08-26 11:53:48','2019-08-26 11:53:48'),
('3a6dec5833f02abad0fe5bc287951f53','1','7e7f8fed52c4627fbf62b5a5dd58151f','L','0','2019-08-28 21:43:13','2019-08-28 21:43:13'),
('4','1','2','移动','0','2019-08-13 14:15:03','2019-08-13 14:15:03'),
('414571f4d40c91b2be1d5039341fb080','1','02c21865a7681cc77f9b7f60d48cf2a1','裸机','0','2019-08-26 14:53:26','2019-08-26 14:53:26'),
('45ca242a5356bc352325a2e7c89e5b40','1','7e7f8fed52c4627fbf62b5a5dd58151f','M','0','2019-08-28 21:43:08','2019-08-28 21:43:08'),
('4f49ae1a8442793b5d5564f65c910d94','1','3',' 幻夜黑','0','2019-08-26 14:52:18','2019-08-26 14:52:18'),
('5','1','2','电信','0','2019-08-14 22:10:52','2019-08-14 22:10:52'),
('54b91be8f9d4a73e54b9a2488ae6cda5','1','3','欧若拉银','0','2019-08-28 22:05:24','2019-08-28 22:05:24'),
('568e18093656647e8a6ce349d1a81181','1','b38b0d33b310ff6e6c9f6762092e238d','套餐一','0','2019-08-27 21:58:30','2019-08-27 21:58:30'),
('58b15ffc7fb68aa1057a4a70450af6fb','1','2','全网通','0','2019-08-16 10:48:20','2019-08-16 10:48:20'),
('59df0a8135ab62ba610a84b97fb71fb5','1','b38b0d33b310ff6e6c9f6762092e238d','官方标配','0','2019-08-26 14:56:08','2019-08-26 14:56:08'),
('5a1eb958744e4b59f0e2f4da15958c57','1','3','琥珀棕','0','2019-08-26 14:52:28','2019-08-26 14:52:28'),
('5de5789a394b2ff6fae227547e59d871','1','3','星光金','0','2019-08-28 22:07:10','2019-08-28 22:07:10'),
('62de70420a9be05b6fbcf3e1c818e0de','1','3','仲夏紫','0','2019-08-26 14:39:28','2019-08-26 14:39:28'),
('63fc0234dc4ebcc9553ab576b36167d2','1','3','极光色','0','2019-08-26 11:52:14','2019-08-26 11:52:14'),
('690315b4e8a0642a465167ed93063f9c','872f46d167f7428c8e9e252c17997fb5','a51fda1bb9fbfb0c3fdc16f988319185','蓝色','0','2019-12-16 20:57:52','2019-12-16 20:57:52'),
('694d1ae3ffb4d03111a5b901cf1e1a8a','1','1','128G','0','2019-08-14 22:31:59','2019-08-14 22:31:59'),
('69ca24903aa6261ea946ef37d88db23f','1','02c21865a7681cc77f9b7f60d48cf2a1','超值大礼包','0','2019-08-26 14:53:34','2019-08-26 14:53:34'),
('6c69234b70c97c9656b0658b89ff0d1c','1','8b0e496328b99e49fb521fa6f880fedf','家用','0','2019-08-16 16:34:16','2019-08-16 16:34:16'),
('70429b93875a445d88ea90a56f2d4f7f','1','1','86G','0','2019-08-14 23:11:34','2019-08-14 23:11:34'),
('73afb3dac3e734a716381f7d0d53d2ee','1','dae1169b7a82a1d6accff95ff8406aee','深圳','0','2019-09-26 14:10:42','2019-09-26 14:10:42'),
('829507194471d6aa6425fce05dd578b8','1','030c4a9407b189383113fb3e7988cf38','WD20EZAZ 2TB 5400转 SATA','0','2019-08-24 17:40:27','2019-08-24 17:40:27'),
('86786c195fbf7f2256bffe67bdf8c943','1','7e7f8fed52c4627fbf62b5a5dd58151f','XL','0','2019-08-28 21:43:17','2019-08-28 21:43:17'),
('8b4e151487d785f83c4785e8ca197f4a','1','7e7f8fed52c4627fbf62b5a5dd58151f','170','0','2019-08-28 21:47:42','2019-08-28 21:47:42'),
('8c5f2941e6789e692f94bd2b2ae7adc8','1','3','绿色','0','2019-08-15 09:28:50','2019-08-15 09:28:50'),
('8cc278b2924be8aac519b1caf9ea03fb','1','dae1169b7a82a1d6accff95ff8406aee','湖南','0','2019-09-26 14:10:25','2019-09-26 14:10:25'),
('8f8349aa1dc205cb644c8eccbe9a13c9','1','3','4TB蓝','0','2019-08-24 17:41:52','2019-08-24 17:41:52'),
('958aad754214368594a38428bc09defd','1','3','红色','0','2019-08-15 09:28:10','2019-08-15 09:28:10'),
('9fe64e448e64401d325f2731c0366d62','1','22d6082e0c1cc2b5a570195f8d91ddad','8+64GB','0','2019-08-26 11:53:29','2019-08-26 11:53:29'),
('a9a2957787cff867418635f0587d3046','1','030c4a9407b189383113fb3e7988cf38','sdg','0','2019-08-14 22:35:32','2019-08-14 22:35:32'),
('ac83f6289072e704fc983f22823b9832','1','030c4a9407b189383113fb3e7988cf38','WD40EZRZ 4TB 5400转 SATA','0','2019-08-24 17:40:56','2019-08-24 17:40:56'),
('afdff2b138fe9ad54afabcce42ba17ce','1','030c4a9407b189383113fb3e7988cf38','WD30EZRZ 3TB 5400转 SATA','0','2019-08-24 17:40:38','2019-08-24 17:40:38'),
('b0879152ec0a13dd747e1876fd321f00','1','030c4a9407b189383113fb3e7988cf38','WD10EZEX 1TB 7200转 SATA','0','2019-08-24 17:47:10','2019-08-24 17:47:10'),
('b50258dcbe378145b0159b4cdf89202e','1','3','天际白','0','2019-08-26 15:06:02','2019-08-26 15:06:02'),
('b8b3ece7283992f1c42826542eb98a43','1','3','天空之境','0','2019-08-26 11:52:01','2019-08-26 11:52:01'),
('bbe044bc2ba48270e27901732624d710','1','22d6082e0c1cc2b5a570195f8d91ddad','8+256GB','0','2019-08-26 11:54:07','2019-08-26 11:54:07'),
('c08a41bfa243e6ea121a0f0c3050517e','1','22d6082e0c1cc2b5a570195f8d91ddad','6+128GB','0','2019-08-26 11:54:20','2019-08-26 11:54:20'),
('c1acf203b7facc656925866200856697','1','8b0e496328b99e49fb521fa6f880fedf','服务器','0','2019-08-16 16:34:04','2019-08-16 16:34:04'),
('c9c9eabb61b4524b7e9415d1cace93df','1','3','粉色','0','2019-08-28 21:54:22','2019-08-28 21:54:22'),
('caf2f679a29e6ea2d34239a513add028','1','1','75G','0','2019-08-14 22:43:17','2019-08-14 22:43:17'),
('cba677f619061b9c326c15d8eceeb31e','1','7f3333f95900cf5fce3dc41ef93e46bc','4G全网通','0','2019-08-26 14:34:55','2019-08-26 14:34:55'),
('cc5eb984477015cfff0b99ba711753d6','1','7e7f8fed52c4627fbf62b5a5dd58151f','160','0','2019-08-28 21:47:34','2019-08-28 21:47:34'),
('d96a8197252a4d260c7868ddbea5e0ea','1','3','赤茶橘','0','2019-08-26 11:52:46','2019-08-26 11:52:46'),
('da0b3c06d18c677984f1b37655aa4505','1','1','256G','0','2019-08-26 14:05:44','2019-08-26 14:05:44'),
('dba851cb5f505e287a65f799121a928f','1','7e7f8fed52c4627fbf62b5a5dd58151f','XS','0','2019-08-28 21:40:48','2019-08-28 21:40:48'),
('e0b840a51e251badb5606d5ce1faa695','1','2','4g全网通','0','2019-08-26 11:51:27','2019-08-26 11:51:27'),
('e14c2a907231c2bd0d484a9cdc1fb557','1','3','白色','0','2019-08-15 09:50:04','2019-08-15 09:50:04'),
('e9b07c814d143d750ce38293b8497ff1','1','030c4a9407b189383113fb3e7988cf38','D10EZEX 1TB 7200转 SATA','0','2019-08-24 17:40:12','2019-08-24 17:40:12'),
('ed144c2c87660ead15b4784ed8df5d63','1','3','珊瑚橙','0','2019-08-26 14:39:20','2019-08-26 14:39:20'),
('f06e7ed568c220d2624771b8f5de5b66','1','7e7f8fed52c4627fbf62b5a5dd58151f','175','0','2019-08-28 21:47:45','2019-08-28 21:47:45'),
('f53488c6a79e795ba288d1279a5f98e7','1','3','亮黑色','0','2019-08-26 11:51:55','2019-08-26 11:51:55'),
('f5cae0dec1002ac65be1852e07a94fd2','1','7e7f8fed52c4627fbf62b5a5dd58151f','2XL','0','2019-08-28 21:43:29','2019-08-28 21:43:29'),
('f6459927049f7e3aff811cf106aa04e4','1','dae1169b7a82a1d6accff95ff8406aee','长沙','0','2019-09-26 14:10:36','2019-09-26 14:10:36'),
('fd82720178bbf4e198bf689f28b6d072','872f46d167f7428c8e9e252c17997fb5','2b2d479c89dfef05ea1e35386a3c4795','款式1','0','2019-12-16 20:58:09','2019-12-16 20:58:09');

/*Table structure for table `goods_spu` */

DROP TABLE IF EXISTS `goods_spu`;

CREATE TABLE `goods_spu` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `spu_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'spu编码',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'spu名字',
  `sell_point` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '卖点',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '描述',
  `category_first` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '一级分类ID',
  `category_second` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '二级分类ID',
  `pic_urls` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '商品图片',
  `shelf` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '是否上架（1是 0否）',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序字段',
  `price_down` decimal(10,2) DEFAULT NULL COMMENT '最低价',
  `price_up` decimal(10,2) DEFAULT NULL COMMENT '最高价',
  `sale_num` int(11) DEFAULT '0' COMMENT '销量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `spec_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '0统一规格；1多规格',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `points_give_switch` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '积分赠送开关（1开 0关）',
  `points_give_num` int(11) DEFAULT NULL COMMENT '积分赠送数量',
  `points_deduct_switch` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '积分抵扣开关（1开 0关）',
  `points_deduct_scale` int(11) DEFAULT NULL COMMENT '积分抵扣商品金额比例（0~100）',
  `points_deduct_amount` decimal(10,2) DEFAULT NULL COMMENT '1积分数可抵多少元',
  `freight_templat_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '运费模板ID',
  `delivery_place_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发货地ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='spu表';

/*Data for the table `goods_spu` */

insert  into `goods_spu`(`id`,`tenant_id`,`spu_code`,`name`,`sell_point`,`description`,`category_first`,`category_second`,`pic_urls`,`shelf`,`sort`,`price_down`,`price_up`,`sale_num`,`create_time`,`update_time`,`spec_type`,`del_flag`,`points_give_switch`,`points_give_num`,`points_deduct_switch`,`points_deduct_scale`,`points_deduct_amount`,`freight_templat_id`,`delivery_place_id`) values 
('2835671ff031c18cb181b1a199f86b01','1','57458568','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','限时优惠200，成交价2599！索尼4800万广角微距三摄，屏下指纹解锁！','<p><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01Ac8ERJ29zFjq0IN2y_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01VMOTzx29zFgQnngH0_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN018vpvKv29zFh3wew1f_!!1714128138.jpg\" class=\"fr-fic fr-dii\"></p><p><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01zj5VGR29zFgLLD7wC_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01KKow1v29zFgPlRcz1_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01YHoVHN29zFgJyP0jm_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01aYZWKp29zFgKlVh75_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01IbunXO29zFgLLDWuD_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01o5fy2K29zFgLpRWa2_!!1714128138.jpg\" class=\"fr-fic fr-dii\"></p>','9bb404548cc6513c1c148b532b6db720','988f1af72652178159de1ec009ab8fb0','[\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg\"]','1',0,0.01,2599.00,64,'2019-08-24 00:45:48','2019-12-25 14:31:59','1','0','1',1000,'1',50,0.10,'556760ba464981b71de368b7d5627746','1226515817257971713'),
('2b48a2f35352a4d87d51d6dd03bb874e','1','956522','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro','','<p><a href=\"https://pages.tmall.com/wow/a/act/ju/dailygroup/165/wupr?wh_pid=daily-162671\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(51, 85, 170);\"><img src=\"https://img.alicdn.com/imgextra/i3/1776456424/O1CN01BuwjUK1xKEsjohG37_!!1776456424.jpg\"></a><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN01hjor4b1xKEslWIxDv_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN018hPVGP1xKEorbraLs_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01b5wdQ61xKEroGytUe_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN019q71Lm1xKEsZnF5ie_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01cu6iVy1xKEsSnTh4j_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN01Ao9iBe1xKEro8t36J_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i3/1776456424/O1CN01qprNEv1xKEsZyRPvC_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01WePTyw1xKErq70lQj_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01yjG99b1xKEsWCXsiq_!!1776456424.jpg\"></span></p><p class=\"ql-align-center\"><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN015HBfs11xKEoR25qqV_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/1776456424/O1CN01MO9oMd1xKEpK79BbJ_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/1776456424/O1CN01KSsv3u1xKEpNIadlG_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i3/1776456424/O1CN01zeuTlh1xKEpMc21z8_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN01Ru3j8T1xKEpMc3N8R_!!1776456424.jpg\"></span></p>','9bb404548cc6513c1c148b532b6db720','862a74f109f7f14bcbfff1d5adf73cdc','[\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/58.jpg\"]','1',0,0.01,0.01,7,'2019-12-28 21:38:26','2019-12-28 21:38:26','0','0','1',10,'1',20,0.10,'556760ba464981b71de368b7d5627746','1226515817257971713'),
('4d06c5157cce971b89166e509cdf63e8','1','','小程序付款演示，不发货，不退款','付款流畅，方便快捷','<p><strong>产品参数：</strong></p><ul><li>证书编号：2019011606195595</li><li>证书状态：有效</li><li>申请人名称：华为技术有限公司</li><li>制造商名称：西可通信技术设备（河源）有限公司</li><li>产品名称：TD-LTE 无线数据终端</li><li>3C产品型号：SCM-AL09</li><li>产品名称：Huawei/华为 华为平板 M6...</li><li>品牌:&nbsp;Huawei/华为</li><li>型号:&nbsp;华为平板 M6 10.8英寸</li><li>内存容量:&nbsp;128GB&nbsp;64GB</li><li>存储容量:&nbsp;6+256GB&nbsp;64GB&nbsp;128GB</li><li>核心数:&nbsp;八核</li><li>触摸屏类型:&nbsp;电容十点触控</li><li>厂商</li><li><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i2/2711014365/O1CN01qrYdwN1i7DOBVwCBo_!!2711014365.jpg\"></span></li></ul>','d5a7b863c2759241ac571f5bc1b6239d','2239dfa1128dd7c88066040dc7dfa44a','[\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20190619223905.png\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/5.jpg\"]','1',0,0.01,100.00,78,'2019-09-27 16:58:56','2019-12-26 21:05:10','1','0','1',100,'1',50,0.10,'e2daad9554fc3206bab0ab4788840b42','1226515772106289154'),
('6545a6fc2927edc195b93982f446917c','1','','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','10倍光学变焦 官方正品','<p><a href=\"https://detail.tmall.com/item.htm?spm=a21ag.7623864.0.0.1b3d3ba5emmXaw&amp;id=598332699918&amp;sku_properties=10004:36095;5919063:6536025;12304035:677288068&amp;scene=taobao_shop\" target=\"_blank\" style=\"color: rgb(41, 83, 166);\"><img src=\"https://gdp.alicdn.com/imgextra/i1/686947088/O1CN01TI1uVG22ELrXhTvSM_!!686947088.jpg\"></a><a href=\"https://detail.tmall.com/item.htm?spm=a21ag.7623864.0.0.14953ba5vM5tUC&amp;id=594719496850&amp;sku_properties=10004:385316259;5919063:6536025&amp;scene=taobao_shop\" target=\"_blank\" style=\"color: rgb(41, 83, 166);\"><img src=\"https://gdp.alicdn.com/imgextra/i1/686947088/O1CN01ZpgKun22ELrCoGxjb_!!686947088.jpg\"></a></p><p><img src=\"https://img.alicdn.com/imgextra/i2/686947088/O1CN01DLaQEi22ELrweWGjM_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN01iyjovP22ELqELmRn4_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01LcL89h22ELqCkrMzC_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01EGKfOh22ELqHdZNNA_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01tQaVEe22ELqDzORWv_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01pPpZO122ELqFikhfq_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN015rUfW422ELqELmmbb_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN012o5kwi22ELqCkqlbF_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN01EcuhWk22ELqELmNgr_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN01Am5ynR22ELq7MXDsS_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01vDIfhL22ELq7MWcRx_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i3/686947088/O1CN01A87agX22ELqGKyU5q_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i3/686947088/O1CN016sgogg22ELqEeejw8_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/686947088/O1CN01dTZ7qp22ELqCkr2Hx_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01G71mhe22ELqDzPNk4_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN0141QGol22ELqBt5bkT_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01555TaH22ELq7MW14H_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN01nh176Z22ELqFU3HYX_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/686947088/O1CN01otPMGD22ELqCkryUl_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/686947088/O1CN01FCMAtw22ELqFU4YYm_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/686947088/O1CN01uMuTeD22ELqEc1n7t_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01fjPP8Y22ELqBt3jPF_!!686947088.jpg\"></p>','9bb404548cc6513c1c148b532b6db720','862a74f109f7f14bcbfff1d5adf73cdc','[\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/16.jpg\"]','1',0,4988.00,5488.00,465,'2019-08-26 14:37:45','2020-04-01 22:04:23','1','0','1',80,'1',5,1.00,'e2daad9554fc3206bab0ab4788840b42','1226515772106289154'),
('87ec583e2883cbd2fd259f47ece0fe15','1','','可优惠900/送壕礼/Huawei/华为 Nova 4中移动手机正品官方旗舰店新款青春版3i2s 3e 32plus 4e 5高配版Pro','最高优惠900/全国联保/再送壕礼！','<p><a href=\"https://pages.tmall.com/wow/a/act/ju/dailygroup/165/wupr?wh_pid=daily-162671\" target=\"_blank\" style=\"color: rgb(51, 85, 170);\"><img src=\"https://img.alicdn.com/imgextra/i3/1776456424/O1CN01BuwjUK1xKEsjohG37_!!1776456424.jpg\"></a><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN01hjor4b1xKEslWIxDv_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN018hPVGP1xKEorbraLs_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01b5wdQ61xKEroGytUe_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN019q71Lm1xKEsZnF5ie_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01cu6iVy1xKEsSnTh4j_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN01Ao9iBe1xKEro8t36J_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i3/1776456424/O1CN01qprNEv1xKEsZyRPvC_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01WePTyw1xKErq70lQj_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01yjG99b1xKEsWCXsiq_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN015HBfs11xKEoR25qqV_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/1776456424/O1CN01MO9oMd1xKEpK79BbJ_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/1776456424/O1CN01KSsv3u1xKEpNIadlG_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i3/1776456424/O1CN01zeuTlh1xKEpMc21z8_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN01Ru3j8T1xKEpMc3N8R_!!1776456424.jpg\"></span></p>','9bb404548cc6513c1c148b532b6db720','862a74f109f7f14bcbfff1d5adf73cdc','[\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/50.jpg\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/51.jpg\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/52.jpg\"]','1',0,2799.00,3599.00,68,'2019-08-26 14:48:33','2019-12-25 14:32:06','1','0','1',20,'1',5,1.00,'a73cf89f7a5a0dcd8c45b9cf2b7be681','1226515817257971713'),
('b13822de6c8ecddc06c167de4c054aeb','872f46d167f7428c8e9e252c17997fb5','','阿道夫','烦得很收到货房贷是','<p><img src=\"https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/872f46d167f7428c8e9e252c17997fb5/editor/2361ca4e-9e56-40b1-97ac-e5d6742f2b62.jpg\" style=\"width: 300px;\" class=\"fr-fic fr-dib\"></p><p data-f-id=\"pbf\" style=\"text-align: center; font-size: 14px; margin-top: 30px; opacity: 0.65; font-family: sans-serif;\">Powered by <a href=\"https://www.froala.com/wysiwyg-editor?pb=1\" title=\"Froala Editor\">Froala Editor</a></p>','235a1554567c92073b0ee1bc8c6772ca',NULL,'[\"https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/872f46d167f7428c8e9e252c17997fb5/material/b6ee51d3-60e3-4ea2-861f-e1a799f8746b.png\"]','1',0,8888.00,8888.00,999,'2019-12-16 20:59:16','2020-04-01 22:20:37','1','0','1',10,'1',30,0.10,'e2daad9554fc3206bab0ab4788840b42','');

/*Table structure for table `goods_spu_spec` */

DROP TABLE IF EXISTS `goods_spu_spec`;

CREATE TABLE `goods_spu_spec` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'spu_id',
  `spec_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'spec_id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='spu规格表';

/*Data for the table `goods_spu_spec` */

insert  into `goods_spu_spec`(`id`,`tenant_id`,`spu_id`,`spec_id`,`create_time`,`update_time`) values 
('1245989184011792386','1','2835671ff031c18cb181b1a199f86b01','2','2020-04-03 16:19:05',NULL),
('1245989184020180993','1','2835671ff031c18cb181b1a199f86b01','3','2020-04-03 16:19:05',NULL),
('1245989184020180994','1','2835671ff031c18cb181b1a199f86b01','1','2020-04-03 16:19:05',NULL),
('1246430906294480897','1','4d06c5157cce971b89166e509cdf63e8','02c21865a7681cc77f9b7f60d48cf2a1','2020-04-04 21:34:20',NULL),
('1246431412647636993','1','87ec583e2883cbd2fd259f47ece0fe15','2','2020-04-04 21:36:21',NULL),
('1246431412651831297','1','87ec583e2883cbd2fd259f47ece0fe15','3','2020-04-04 21:36:21',NULL),
('1246431412660219906','1','87ec583e2883cbd2fd259f47ece0fe15','1','2020-04-04 21:36:21',NULL),
('1246431505387892738','1','6545a6fc2927edc195b93982f446917c','3','2020-04-04 21:36:43',NULL),
('1246431505396281345','1','6545a6fc2927edc195b93982f446917c','1','2020-04-04 21:36:43',NULL),
('1246431505396281346','1','6545a6fc2927edc195b93982f446917c','7f3333f95900cf5fce3dc41ef93e46bc','2020-04-04 21:36:43',NULL),
('afac75bf80d2d578e8e5175ed2a44852','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','2b2d479c89dfef05ea1e35386a3c4795','2019-12-16 20:59:16',NULL),
('e0d34a63c1e4e9e3bd2a6cc18d45dcb1','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','a51fda1bb9fbfb0c3fdc16f988319185','2019-12-16 20:59:16',NULL);

/*Table structure for table `groupon_info` */

DROP TABLE IF EXISTS `groupon_info`;

CREATE TABLE `groupon_info` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序字段',
  `enable` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '（1：开启；0：关闭）',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品Id',
  `sku_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'skuId',
  `name` varchar(100) DEFAULT NULL COMMENT '拼团名称',
  `groupon_num` int(11) DEFAULT '0' COMMENT '拼团人数（几人团）',
  `groupon_price` decimal(10,2) NOT NULL COMMENT '拼团价',
  `duration` int(11) NOT NULL COMMENT '拼团时长（小时）',
  `valid_begin_time` datetime NOT NULL COMMENT '开始时间',
  `valid_end_time` datetime NOT NULL COMMENT '结束时间',
  `launch_num` int(11) DEFAULT '0' COMMENT '发起人数',
  `pic_url` varchar(500) DEFAULT NULL COMMENT '图片',
  `groupon_rule` text COMMENT '拼团规则',
  `share_title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分享标题 ',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='拼团';

/*Data for the table `groupon_info` */

insert  into `groupon_info`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`sort`,`enable`,`spu_id`,`sku_id`,`name`,`groupon_num`,`groupon_price`,`duration`,`valid_begin_time`,`valid_end_time`,`launch_num`,`pic_url`,`groupon_rule`,`share_title`) values 
('1239773817540141057','1','0','2020-03-17 12:41:26','2020-03-20 16:57:37',NULL,1,'1','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855',3,0.01,24,'2020-03-18 00:00:00','2020-07-31 00:00:00',3,'http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg','5325235\n','eyreyey'),
('1240199061186789378','1','0','2020-03-18 16:51:12','2020-03-19 19:35:27',NULL,2,'1','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','二亿人人秀主微软业务有 有',5,0.01,24,'2020-03-19 00:00:00','2020-07-24 00:00:00',0,'http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/22.png','扒哀怨角角胸有脸 ','问题为43 43 6遥徐鹏的'),
('1241935330631618561','1','0','2020-03-23 11:50:31','2020-03-23 11:50:31',NULL,8,'1','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','RURTURTURUEtruria的有',2,0.01,46,'2020-03-22 00:00:00','2020-04-30 00:00:00',666,'http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/22.png','爱的就是你有认脸  人','肮脏有人 仍认有2');

/*Table structure for table `groupon_user` */

DROP TABLE IF EXISTS `groupon_user`;

CREATE TABLE `groupon_user` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `groupon_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '拼团ID',
  `groupon_num` int(11) DEFAULT NULL COMMENT '拼团人数（几人团）',
  `groupon_price` decimal(10,2) DEFAULT NULL COMMENT '拼团价',
  `group_id` varchar(32) NOT NULL COMMENT '组ID（团长的拼团记录ID）',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户ID',
  `nick_name` varchar(100) DEFAULT NULL COMMENT '昵称',
  `headimg_url` varchar(1000) DEFAULT NULL COMMENT '头像',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品Id',
  `sku_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'skuId',
  `is_leader` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '是否团长（0：否；1：是）',
  `valid_begin_time` datetime DEFAULT NULL COMMENT '开始时间',
  `valid_end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `order_id` varchar(32) DEFAULT NULL COMMENT '订单Id',
  `status` char(2) DEFAULT NULL COMMENT '状态（0：拼团中；1：完成拼团）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_group_user` (`group_id`,`user_id`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='拼团记录';

/*Data for the table `groupon_user` */

insert  into `groupon_user`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`groupon_id`,`groupon_num`,`groupon_price`,`group_id`,`user_id`,`nick_name`,`headimg_url`,`spu_id`,`sku_id`,`is_leader`,`valid_begin_time`,`valid_end_time`,`order_id`,`status`) values 
('1240939770630078466','1','0','2020-03-20 17:54:31','2020-03-20 17:56:42',NULL,'1239773817540141057',3,0.01,'1240939770630078466','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','1','2020-03-20 17:54:30','2020-03-21 17:54:30','1240939735053991937','1'),
('1240939883507187714','1','0','2020-03-20 17:54:58','2020-03-20 17:56:42',NULL,'1239773817540141057',3,0.01,'1240939770630078466','1240826736922284033','JooLun','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLWNvwtdDIKNiahOicVFYJzQCY3ppdfvCDL6d9C0dRMYybEJDDJQuj1ibqLNp1ic5XVaPwW9IeZq1L44A/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','0','2020-03-20 17:54:57','2020-03-21 17:54:57','1240939845611651073','1'),
('1240940320859848706','1','0','2020-03-20 17:56:42','2020-03-20 17:56:42',NULL,'1239773817540141057',3,0.01,'1240939770630078466','1240923176084389889','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','0','2020-03-20 17:56:41','2020-03-21 17:56:41','1240940141935034370','1'),
('1240978678453600258','1','0','2020-03-20 20:29:07','2020-03-20 20:29:07',NULL,'1239773817540141057',3,0.01,'1240978678453600258','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','1','2020-03-20 20:29:06','2020-03-21 20:29:06','1240978608668770306','0'),
('1241577637148491777','1','0','2020-03-22 12:09:10','2020-03-22 12:09:10',NULL,'1240199061186789378',5,0.01,'1241577637148491777','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','1','2020-03-22 12:09:09','2020-03-23 12:09:09','1241577588691697666','0'),
('1241926263163027457','1','0','2020-03-23 11:14:29','2020-03-23 11:49:02',NULL,'1239773817540141057',3,0.01,'1241926263163027457','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','1','2020-03-23 11:14:28','2020-03-24 11:14:28','1241926229340160001','1'),
('1241929185653297153','1','0','2020-03-23 11:26:06','2020-03-23 11:49:02',NULL,'1239773817540141057',3,0.01,'1241926263163027457','1240826736922284033','JooLun','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLWNvwtdDIKNiahOicVFYJzQCY3ppdfvCDL6d9C0dRMYybEJDDJQuj1ibqLNp1ic5XVaPwW9IeZq1L44A/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','0','2020-03-23 11:26:04','2020-03-24 11:26:04','1241929155013906434','1'),
('1241934957137235969','1','0','2020-03-23 11:49:02','2020-03-23 11:49:02',NULL,'1239773817540141057',3,0.01,'1241926263163027457','1240923176084389889','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','0','2020-03-23 11:49:01','2020-03-24 11:49:01','1241934924958535681','1'),
('1241935531459088386','1','0','2020-03-23 11:51:19','2020-03-23 11:52:11',NULL,'1241935330631618561',2,0.01,'1241935531459088386','1240826736922284033','JooLun','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLWNvwtdDIKNiahOicVFYJzQCY3ppdfvCDL6d9C0dRMYybEJDDJQuj1ibqLNp1ic5XVaPwW9IeZq1L44A/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','1','2020-03-23 11:51:17','2020-03-25 09:51:17','1241935501188796418','1'),
('1241935750519197697','1','0','2020-03-23 11:52:11','2020-03-23 11:52:11',NULL,'1241935330631618561',2,0.01,'1241935531459088386','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','0','2020-03-23 11:52:10','2020-03-25 09:52:10','1241935719250661377','1'),
('1242093976934150145','1','0','2020-03-23 22:20:55','2020-03-24 11:25:49',NULL,'1241935330631618561',2,0.01,'1242093976934150145','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','1','2020-03-23 22:20:54','2020-03-25 20:20:54','1242093910047584257','1'),
('1242291280999841793','1','0','2020-03-24 11:24:56','2020-03-24 11:28:22',NULL,'1241935330631618561',2,0.01,'1242291280999841793','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','1','2020-03-24 11:24:53','2020-03-26 09:24:53','1242291248150052865','1'),
('1242291504040345601','1','0','2020-03-24 11:25:49','2020-03-24 11:25:49',NULL,'1241935330631618561',2,0.01,'1242093976934150145','1240826736922284033','JooLun','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLWNvwtdDIKNiahOicVFYJzQCY3ppdfvCDL6d9C0dRMYybEJDDJQuj1ibqLNp1ic5XVaPwW9IeZq1L44A/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','0','2020-03-23 22:20:54','2020-03-25 20:20:54','1242291473988157442','1'),
('1242292145433313282','1','0','2020-03-24 11:28:22','2020-03-24 11:28:22',NULL,'1241935330631618561',2,0.01,'1242291280999841793','1240923176084389889','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','0','2020-03-24 11:24:53','2020-03-26 09:24:53','1242292062759387137','1'),
('1242292210918981633','1','0','2020-03-24 11:28:38','2020-03-24 11:28:38',NULL,'1241935330631618561',2,0.01,'1242292210918981633','1240826736922284033','JooLun','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLWNvwtdDIKNiahOicVFYJzQCY3ppdfvCDL6d9C0dRMYybEJDDJQuj1ibqLNp1ic5XVaPwW9IeZq1L44A/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','1','2020-03-24 11:28:20','2020-03-26 09:28:20','1242291883201232898','0'),
('1242658418377846785','1','0','2020-03-25 11:43:49','2020-03-25 11:43:49',NULL,'1241935330631618561',2,0.01,'1242658418377846785','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','1','2020-03-25 11:43:47','2020-03-27 09:43:47','1242658346600722433','0'),
('1245564114906923010','1','0','2020-04-02 12:10:01','2020-04-02 22:05:24',NULL,'1239773817540141057',3,0.01,'1245564114906923010','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','1','2020-04-02 12:09:59','2020-04-03 12:09:59','1245564051266748418','1'),
('1245564503219781634','1','0','2020-04-02 12:11:33','2020-04-02 22:05:24',NULL,'1239773817540141057',3,0.01,'1245564114906923010','1240826736922284033','JooLun','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLWNvwtdDIKNiahOicVFYJzQCY3ppdfvCDL6d9C0dRMYybEJDDJQuj1ibqLNp1ic5XVaPwW9IeZq1L44A/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','0','2020-04-02 12:09:59','2020-04-03 12:09:59','1245564443941683201','1'),
('1245568602539569154','1','0','2020-04-02 12:27:51','2020-04-02 12:27:51',NULL,'1239773817540141057',3,0.01,'1245568602539569154','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','1','2020-04-02 12:27:49','2020-04-03 12:27:49','1245562819827482626','0'),
('1245693180087717890','1','0','2020-04-02 20:42:52','2020-04-02 20:42:52',NULL,'1239773817540141057',3,0.01,'1245693180087717890','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','1','2020-04-02 20:42:49','2020-04-03 20:42:49','1245692052197429250','0'),
('1245703032692305921','1','0','2020-04-02 21:22:01','2020-04-03 15:54:33',NULL,'1241935330631618561',2,0.01,'1245703032692305921','1240923176084389889','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','1','2020-04-02 21:22:00','2020-04-04 19:22:00','1245702994784186370','1'),
('1245705249751068673','1','0','2020-04-02 21:30:50','2020-04-02 21:33:40',NULL,'1239773817540141057',3,0.01,'1245705249751068673','1240923176084389889','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','1','2020-04-02 21:30:48','2020-04-03 21:30:48','1245705213176737793','1'),
('1245705438368919553','1','0','2020-04-02 21:31:35','2020-04-02 21:33:40',NULL,'1239773817540141057',3,0.01,'1245705249751068673','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','0','2020-04-02 21:30:48','2020-04-03 21:30:48','1245705402465677313','1'),
('1245705965643264002','1','0','2020-04-02 21:33:40','2020-04-02 21:33:40',NULL,'1239773817540141057',3,0.01,'1245705249751068673','1240826736922284033','JooLun','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLWNvwtdDIKNiahOicVFYJzQCY3ppdfvCDL6d9C0dRMYybEJDDJQuj1ibqLNp1ic5XVaPwW9IeZq1L44A/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','0','2020-04-02 21:30:48','2020-04-03 21:30:48','1245705919900184577','1'),
('1245713950188793858','1','0','2020-04-02 22:05:24','2020-04-02 22:05:24',NULL,'1239773817540141057',3,0.01,'1245564114906923010','1240923176084389889','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','0','2020-04-02 12:09:59','2020-04-03 12:09:59','1245713914168111105','1'),
('1245983008171782145','1','0','2020-04-03 15:54:33','2020-04-03 15:54:33',NULL,'1241935330631618561',2,0.01,'1245703032692305921','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','0','2020-04-02 21:22:00','2020-04-04 19:22:00','1245982972616667137','1'),
('1247857999100276738','1','0','2020-04-08 20:05:05','2020-04-08 20:05:05',NULL,'1239773817540141057',3,0.01,'1247857999100276738','1234102578637127681','JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','1','2020-04-08 20:05:04','2020-04-09 20:05:04','1247857870528081922','0');

/*Table structure for table `material` */

DROP TABLE IF EXISTS `material`;

CREATE TABLE `material` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `type` char(2) NOT NULL COMMENT '类型1、图片；2、视频',
  `group_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '分组ID',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '素材名',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '素材链接',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='素材库';

/*Data for the table `material` */

insert  into `material`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`type`,`group_id`,`name`,`url`) values 
('05e598abb11205b206d826e5b928c57d','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:50:29','2019-11-11 22:50:29','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225845.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/d9d407a1-e044-4954-b1f1-707ad3f4e35c.png'),
('086dfabb2ea4593809432d273d0b0ea0','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:53:39','2019-11-11 22:53:39','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111230147.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/989d29a2-9b15-4b6b-962f-2adc9a4d7483.png'),
('0ed5e7cc4378c4d951a385da51dccfa5','f5c359e514a34617b27cef72dea646d5','0','2019-11-10 14:28:10','2019-11-10 14:28:10','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'11.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/68ae0f9b-4d1c-424d-8c2e-fdd807b6a27f.png'),
('0ee4a56d79e8cc0659156ccff02b1d33','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:28:19','2019-11-11 22:28:19','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111223612.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/22f4ca4f-9725-400b-ace4-5194d56268cb.png'),
('11','1','0','2019-10-30 16:43:00','2019-11-05 21:14:44',NULL,'1','def6e4c80222c71bbc0993ac85bcb8ce','45646498498','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg'),
('12','1','0','2019-10-30 16:43:38','2019-11-05 21:10:14',NULL,'1','def6e4c80222c71bbc0993ac85bcb8ce','165165','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg'),
('1237256990159265794','1','0','2020-03-10 14:00:28','2020-03-10 14:00:28','1','1',NULL,'gh_d01b456ef38a_258.jpg','http://frp.sdhtwlkjyxgs.com:3310/shopmp/1/material/fa221716-23f6-4a5c-940d-ca5a82c34ac4.jpg'),
('1a0e8681df6990eb631bab85476f6196','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:17:38','2019-11-11 22:17:38','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111222527.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/8b25ea11-be72-48dc-8d1c-57a5d99e4a1f.png'),
('1c797dfb247be68174760c3f4288dc36','f5c359e514a34617b27cef72dea646d5','0','2019-11-10 14:51:24','2019-11-10 14:51:24','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191110145935.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/3c85454c-534b-446d-bc63-65d415e8199f.png'),
('1ea037ed16239afd0f83bb9dbf7d3fb2','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:22:08','2019-11-11 22:22:08','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111223019.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/c733b3eb-0837-46c2-8ea1-e4a9fe9fa698.png'),
('2','1','0','2019-10-30 16:09:09','2019-11-05 21:10:28','1','1','1','asgwet','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190826115920.png'),
('29f61b7b4beda4f8c8785bf2a996b6c6','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:38:03','2019-11-11 22:38:03','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224618.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/712e3664-f933-446e-b963-29179beec2ec.png'),
('3','1','0','2019-10-30 16:09:22','2019-11-05 21:10:35','1','1','1','sgset作伤脑筋脸','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01PGTRF41mbDmTT1XHk_!!2201435294972.png'),
('310e7cddad265d81242d6284b16d450d','f5c359e514a34617b27cef72dea646d5','0','2019-11-10 14:22:39','2019-11-10 14:22:39','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'微信截图_20191110143006.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/0991951a-abf3-462d-ac29-b71b43879bc8.png'),
('31a70ce6812b6d067a0d89ddce7c2e4c','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:45:21','2019-11-11 22:45:21','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225336.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/083a86b2-6c33-4e10-8dda-cb5346bcdbe7.png'),
('33a1baebf5c5635eca16ec76a8ff3bf2','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:19:54','2019-11-11 22:19:54','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111222758.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/dcd48570-a81b-4420-8a86-fb6f044e6af6.png'),
('3f203d9c83556450b3943cf9504aaffa','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:51:15','2019-11-11 22:51:15','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225923.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/6881df67-508b-4c6f-9b46-fee6dc408400.png'),
('3fe0018f52c9ab8001f2b0bcd0863e0f','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:22:57','2019-11-11 22:22:57','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111223105.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/0c31a49f-45db-4872-bbbb-f1704acfda17.png'),
('4','1','0','2019-10-30 16:09:29','2019-11-05 21:10:40',NULL,'1','1','1555','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190827154452.png'),
('44ae191dded25ad0ce690f17e4e4ceef','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:33:15','2019-11-11 22:33:15','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224117.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/454ab366-8e82-42b5-914b-60919e1f0d1d.png'),
('49e3b0da647c6e199fd857cd9da716d6','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:37:05','2019-11-11 22:37:05','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224519.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/e8a75609-700e-417e-a22b-48b130ce26b9.png'),
('5bd03a078030fe87872be47acb6a3d50','1','0','2019-11-01 17:26:10','2019-11-05 21:10:48','1','1',NULL,'QQ截图20190715120631.png','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01TnmV7g1mbDmdi5SFG_!!2-item_pic.png'),
('5d7d9481aa5ea0a548a44cd417705f25','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:44:33','2019-11-11 22:44:33','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225248.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/1e1cbaa7-1e1f-42a3-bde1-a75b158dd4cc.png'),
('600f0de9ff961aa0949d5ec09ae54673','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:24:12','2019-11-11 22:24:12','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111223159.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/18e20579-3a6e-4b58-879c-3c4ca7c17df0.png'),
('60f0bdb0e780bdbe1ca067f39e48bef6','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:25:21','2019-11-11 22:25:21','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111223306.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/44195111-3636-4577-a6dc-c618f52d64ff.png'),
('63458d22bc5ee0cd891fbceb37e88222','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:16:14','2019-11-11 22:16:14','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111222403.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/ef050eb7-d264-49e3-923a-b68715cf8eb2.png'),
('6841fe88f5a825d4976bfe0d0aeb5f3a','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:43:43','2019-11-11 22:43:43','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225155.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/93abc908-2f11-4d80-9c6a-c07516f1dac0.png'),
('6f3c93797b1db3c52bd956a86f36f2b1','f5c359e514a34617b27cef72dea646d5','0','2019-11-10 14:22:17','2019-11-10 14:22:17','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'微信截图_20191110142938.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/598b6705-4412-4415-8f4f-ceed055f5931.png'),
('7','1','0','2019-10-30 16:09:59','2019-11-05 21:15:03',NULL,'1','1','sgdwet235','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/59.jpg'),
('71500b41298a3b8e9bf96f8387282bce','f5c359e514a34617b27cef72dea646d5','0','2019-11-10 15:06:09','2019-11-10 15:06:09','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'1号.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/845c1927-8093-4eaa-b66b-246dbfcfb3fe.png'),
('7a93cb67626055fbf58207047eb28b16','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:35:23','2019-11-11 22:35:23','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224338.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/0e653f27-0272-4442-b9bc-1e8dc6af2819.png'),
('7c42ff6c6cb90c521f9b398ce562b683','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:34:00','2019-11-11 22:34:00','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224214.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/a2eecedd-2951-4454-90f4-f4e06af63810.png'),
('7c56054005d5d64e968a4b66dc68c1c7','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:39:26','2019-11-11 22:39:26','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224738.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/55337aba-27aa-4894-bdb3-2188469e31d7.png'),
('8','1','0','2019-10-30 16:42:34','2019-11-05 21:14:58',NULL,'1','1','mijwet','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/58.jpg'),
('84c709cdc69284f40d7f0ca65e545c8c','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:36:13','2019-11-11 22:36:13','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224424.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/e8b64e03-a6c8-48ac-8a74-ff01475eb3c0.png'),
('8bbe088782073c2b19075450e1c8e91a','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:32:07','2019-11-11 22:32:07','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224015.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/e05d4840-0f19-497e-a719-25370a7a404d.png'),
('9','1','0','2019-10-30 16:42:48','2019-11-05 21:14:52',NULL,'1','19a4433a1b8c5e48e58bdb4db98abf3b','novas','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/14.jpg'),
('91eaf6fd5175391b6c59f1f05c3f3b1e','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:49:47','2019-11-11 22:49:47','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225756.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/f18f843b-0a41-4c31-af46-acc0a19a1393.png'),
('92976c48bacc52e52796ce469716df24','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:47:57','2019-11-11 22:47:57','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225606.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/b4a6c58f-31f9-4ee1-81e0-b6ec325ae221.png'),
('93b647266a6ab3b72871d3a5324ddffa','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:18:55','2019-11-11 22:18:55','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111222710.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/5bc59c17-244f-466c-90f2-bfe3ddab2957.png'),
('956896caccc6ab2ae0f79bfc98c877aa','f5c359e514a34617b27cef72dea646d5','0','2019-11-10 14:23:13','2019-11-10 14:23:13','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'微信截图_20191110143026.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/99ad9b24-8c61-44ae-bdf5-6d16d0e1f57a.png'),
('9e786f1d056578dca02b245a5c1dfc83','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:43:07','2019-11-11 22:43:07','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225122.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/0cd7bc42-dff3-43b2-a55a-7b4259225dcd.png'),
('a52b64fe9342765a567e553a7720fa3d','f5c359e514a34617b27cef72dea646d5','0','2019-11-10 14:25:07','2019-11-10 14:25:07','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'20190403152637496.jpg','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/1715a61f-ef75-474d-836f-6c5885b977dc.jpg'),
('a8b2d938eb02aefc711a9d2bc0859e99','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:40:24','2019-11-11 22:40:24','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224839.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/94e1e5b9-e05c-4c1e-8242-1404d18de7d0.png'),
('b66ee61e3e066c5f65fa9e9c41a8de7f','41c120b6bb3c426fa4ec513fa3ff792a','0','2020-01-05 12:47:23','2020-01-05 12:47:23','60d4576d9e1d732b14118a695895fa31','1','ca4c67a5e286310cb0d62a7efeabf1b4','timg.jpeg','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/41c120b6bb3c426fa4ec513fa3ff792a/material/46242f76-458b-4f76-b489-8da694918350.jpeg'),
('b749e4f5f34a1740f590645f6c25a5e7','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:26:26','2019-11-11 22:26:26','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111223417.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/8755feae-97f2-4404-8e9a-7a7db41af762.png'),
('b7d3f64f84f06a7cc14c0dabafd14cef','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:47:00','2019-11-11 22:47:00','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225517.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/df2c0ab9-bc4b-4b12-a8c1-a2f5288472d3.png'),
('bd20a0dd649b41a5d02648b2a20352b7','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:30:02','2019-11-11 22:30:02','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111223813.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/ff5c5310-32c5-475a-9122-a28550c079e4.png'),
('c8bdcc026deb1cbded3edeaae715cbf2','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:21:18','2019-11-11 22:21:18','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111222931.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/19fca07c-3c3f-41ae-9a38-96aca3f08c37.png'),
('c94b12eac6307c09e5a98718a811a1b1','f5c359e514a34617b27cef72dea646d5','0','2019-11-10 21:15:10','2019-11-10 21:15:10','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'2号.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/645b29ac-a783-439f-8ee5-084a143c479a.png'),
('d3a06b260217d9527d331448b30682fb','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:29:20','2019-11-11 22:29:20','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111223717.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/87890530-a921-4171-a9af-45d76a2aade2.png'),
('d633825709fbf63b0fc145f1e3a475c1','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:31:06','2019-11-11 22:31:06','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111223901.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/a2362ef0-a76c-41d9-b013-a360031ed434.png'),
('d86355afed7c7e92b4d7270e057befc1','1','0','2019-11-01 17:30:10','2020-02-10 12:10:26','1','1','19a4433a1b8c5e48e58bdb4db98abf3b','c119f0d1694aeabca.jpg','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/22.png'),
('dc90d9554bdb5fb1809d740fc3efb8eb','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:27:12','2019-11-11 22:27:12','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111223514.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/8f703a73-f50d-4d9a-bc28-687e1552b34c.png'),
('e63113b5998a30e18ca87a10ffb8ce89','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:48:40','2019-11-11 22:48:40','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225656.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/079cde1e-2851-4425-beea-7d7698c61471.png'),
('efa3f224c92a0036014822b366e78522','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:52:00','2019-11-11 22:52:00','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111230013.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/ed25ae23-7390-4fd5-896d-d7f05052a5de.png'),
('f7709113226e18a01df0465fea2a57b9','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:41:27','2019-11-11 22:41:27','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224942.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/1b4d0e1b-57bb-4aac-b794-4c7aa606b4e9.png'),
('f83dc89cb938ad3a37e55a8e1a273c3a','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:52:57','2019-11-11 22:52:57','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111230102.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/c05132e3-cef1-4fe8-808c-0b0eb7ce831a.png'),
('faad3cfb9c79e863f3c7f486476328a5','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:46:14','2019-11-11 22:46:14','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225428.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/85fd8e12-c2ec-42c2-9a54-06427081a78e.png');

/*Table structure for table `material_group` */

DROP TABLE IF EXISTS `material_group`;

CREATE TABLE `material_group` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分组名',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='素材分组';

/*Data for the table `material_group` */

insert  into `material_group`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`name`) values 
('19a4433a1b8c5e48e58bdb4db98abf3b','1','0','2019-10-30 11:19:17','2019-11-01 17:38:19','1','商品图'),
('ca4c67a5e286310cb0d62a7efeabf1b4','41c120b6bb3c426fa4ec513fa3ff792a','0','2020-01-05 12:46:25','2020-01-05 12:46:25','60d4576d9e1d732b14118a695895fa31','水果'),
('def6e4c80222c71bbc0993ac85bcb8ce','1','0','2019-10-30 11:18:50','2020-02-10 11:56:27','1','分类图');

/*Table structure for table `notice` */

DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `app_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '应用ID',
  `type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型1、小程序首页轮播图；2、小程序首页公告',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '通知名',
  `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `enable` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '（1：开启；0：关闭）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商城通知';

/*Data for the table `notice` */

insert  into `notice`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`app_id`,`type`,`name`,`remarks`,`enable`) values 
('6a2720cacf551f859bf3be5d3930a287','1','0','2019-11-10 20:50:00','2019-11-10 20:50:00',NULL,'wxd5b98bbec200013b','1',NULL,NULL,'1'),
('c4ea63ba2e009a428ec25e1b145c3da4','1','0','2019-11-10 21:01:53','2019-11-10 21:01:53',NULL,'wxd5b98bbec200013b','2',NULL,NULL,'1');

/*Table structure for table `notice_item` */

DROP TABLE IF EXISTS `notice_item`;

CREATE TABLE `notice_item` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `notice_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通知ID',
  `type` char(2) NOT NULL COMMENT '类型1、图片；2、视频；3、文字',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '名称',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '通知链接',
  `page` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '跳转页面',
  `content` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '内容',
  `tag` varchar(10) DEFAULT NULL COMMENT '标签',
  `enable` char(2) DEFAULT NULL COMMENT '（1：开启；0：关闭）',
  `sort` int(11) DEFAULT NULL COMMENT '排序字段',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商城通知详情';

/*Data for the table `notice_item` */

insert  into `notice_item`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`notice_id`,`type`,`name`,`url`,`page`,`content`,`tag`,`enable`,`sort`) values 
('039428b5e16a870fbbb948f67faf8953','1','0','2019-11-10 20:52:13','2020-01-03 17:28:22',NULL,'6a2720cacf551f859bf3be5d3930a287','1',NULL,'http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/6.jpg','/pages/goods/goods-detail/index?id=2835671ff031c18cb181b1a199f86b01',NULL,NULL,'1',6),
('21ea872de3a8f788115ada60a10d2e29','1','0','2019-11-10 21:07:51','2019-11-10 21:07:51',NULL,'c4ea63ba2e009a428ec25e1b145c3da4','2',NULL,'','','7564745765476sdg你爱我仍自然人锻造欠自然人称作欠脸色','科','1',3),
('78b58bde3529ca583af819122680379c','1','0','2019-11-10 21:01:53','2019-12-05 10:38:19',NULL,'c4ea63ba2e009a428ec25e1b145c3da4','2',NULL,'','/pages/goods/goods-detail/index?id=2835671ff031c18cb181b1a199f86b01','遥谁持彩练当空舞 脸腑而又热又遥望43 43 334 你爱我仍人','厅事','1',1),
('7e60a12a378b533fdce77c5b9b8de8d3','1','0','2019-11-10 21:50:20','2020-01-03 17:28:26',NULL,'6a2720cacf551f859bf3be5d3930a287','1',NULL,'http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/22.png','',NULL,NULL,'1',2);

/*Table structure for table `order_info` */

DROP TABLE IF EXISTS `order_info`;

CREATE TABLE `order_info` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `app_type` char(2) NOT NULL COMMENT '应用类型1、小程序',
  `app_id` varchar(32) NOT NULL COMMENT '应用ID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单单号',
  `payment_way` char(2) NOT NULL COMMENT '支付方式1、货到付款；2、在线支付',
  `delivery_way` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配送方式1、普通快递；2、上门自提',
  `payment_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付类型1、微信支付；2、支付宝支付',
  `is_pay` char(2) NOT NULL COMMENT '是否支付0、未支付 1、已支付',
  `name` varchar(255) DEFAULT NULL COMMENT '订单名',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '订单状态1、待发货 2、待收货 3、确认收货/已完成 5、已关闭 10、拼团中',
  `appraises_status` char(2) DEFAULT NULL COMMENT '评价状态0、未评；1、已评；2、已追评',
  `freight_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '运费金额',
  `sales_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '销售金额',
  `payment_points_price` decimal(10,2) DEFAULT '0.00' COMMENT '积分抵扣金额',
  `payment_coupon_price` decimal(10,2) DEFAULT '0.00' COMMENT '电子券抵扣金额',
  `payment_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '支付金额（销售金额+运费金额-积分抵扣金额-电子券抵扣金额）',
  `payment_points` int(11) DEFAULT '0' COMMENT '支付积分',
  `payment_time` datetime DEFAULT NULL COMMENT '付款时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '发货时间',
  `receiver_time` datetime DEFAULT NULL COMMENT '收货时间',
  `closing_time` datetime DEFAULT NULL COMMENT '成交时间',
  `user_message` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '买家留言',
  `logistics_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '物流id',
  `transaction_id` varchar(32) DEFAULT NULL COMMENT '支付交易ID',
  `order_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '订单类型（0、普通订单；1、砍价订单；2、拼团订单）',
  `market_id` varchar(32) DEFAULT NULL COMMENT '营销ID（砍价ID、拼团ID）',
  `relation_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '营销记录ID（砍价记录ID、拼团记录组ID（团长的拼团记录ID））',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `ids_tenant_id` (`tenant_id`,`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单';

/*Data for the table `order_info` */

insert  into `order_info`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`app_type`,`app_id`,`user_id`,`order_no`,`payment_way`,`delivery_way`,`payment_type`,`is_pay`,`name`,`status`,`appraises_status`,`freight_price`,`sales_price`,`payment_points_price`,`payment_coupon_price`,`payment_price`,`payment_points`,`payment_time`,`delivery_time`,`receiver_time`,`closing_time`,`user_message`,`logistics_id`,`transaction_id`,`order_type`,`market_id`,`relation_id`,`remark`) values 
('1245684247830810625','1','0','2020-04-02 20:07:23','2020-04-02 20:07:23','1','wxd5b98bbec200013b','1234102578637127681','1245684247579066368','2','1','1','0',NULL,'5',NULL,5.00,0.02,0.00,0.00,5.02,0,NULL,NULL,NULL,NULL,NULL,'1245684247788867586',NULL,'0',NULL,NULL,NULL),
('1245684299693379586','1','0','2020-04-02 20:07:35','2020-04-02 20:07:35','1','wxd5b98bbec200013b','1234102578637127681','1245684299626184704','2','2','1','0',NULL,'5',NULL,0.00,0.02,0.00,0.00,0.02,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL),
('1245687903087054850','1','0','2020-04-02 20:21:54','2020-04-02 20:21:54','1','wxd5b98bbec200013b','1234102578637127681','1245687902994694144','2','2','1','0',NULL,'5',NULL,0.00,0.01,0.00,0.00,0.01,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL),
('1245687954911875073','1','0','2020-04-02 20:22:06','2020-04-02 20:22:06','1','wxd5b98bbec200013b','1234102578637127681','1245687954794348544','2','1','1','0',NULL,'5',NULL,5.00,0.01,0.00,0.00,5.01,0,NULL,NULL,NULL,NULL,NULL,'1245687954853154818',NULL,'0',NULL,NULL,NULL),
('1245688045882134530','1','0','2020-04-02 20:22:28','2020-04-02 20:22:28','1','wxd5b98bbec200013b','1234102578637127681','1245688045777190912','2','1','1','0',NULL,'5',NULL,5.00,0.01,0.00,0.00,5.01,0,NULL,NULL,NULL,NULL,NULL,'1245688045827608578',NULL,'0',NULL,NULL,NULL),
('1245691924053053442','1','0','2020-04-02 20:37:53','2020-04-02 20:37:53','1','wxd5b98bbec200013b','1234102578637127681','1245691923973275648','2','2','1','1',NULL,'3','0',0.00,100.00,0.00,0.00,0.01,0,'2020-04-02 20:43:13',NULL,'2020-04-02 21:11:21',NULL,NULL,'1226515772106289154','4200000560202004022826888405','1','1235079512380551170','1245691484544520193',NULL),
('1245692052197429250','1','0','2020-04-02 20:38:23','2020-04-02 20:38:23','1','wxd5b98bbec200013b','1234102578637127681','1245692052163788800','2','2','1','1',NULL,'10',NULL,0.00,2599.00,0.00,0.00,0.01,0,'2020-04-02 20:42:49',NULL,NULL,NULL,NULL,'1226515817257971713','4200000570202004022129902127','2','1239773817540141057','1245693180087717890',NULL),
('1245693765134405633','1','0','2020-04-02 20:45:12','2020-04-02 20:45:12','1','wxd5b98bbec200013b','1240923176084389889','1245693765016879104','2','2','1','0',NULL,'5',NULL,0.00,100.00,0.00,0.00,0.01,0,NULL,NULL,NULL,NULL,'xx',NULL,NULL,'1','1235079512380551170','1245693424808579073',NULL),
('1245693827054915585','1','0','2020-04-02 20:45:26','2020-04-02 20:45:26','1','wxd5b98bbec200013b','1240923176084389889','1245693826970943488','2','1','1','0',NULL,'5',NULL,5.00,100.00,0.00,0.00,5.01,0,NULL,NULL,NULL,NULL,NULL,'1245693827008778242',NULL,'1','1235079512380551170','1245693424808579073',NULL),
('1245693883183091714','1','0','2020-04-02 20:45:40','2020-04-02 21:41:39','1','wxd5b98bbec200013b','1240923176084389889','1245693883094925312','2','2','1','1',NULL,'3','1',0.00,100.00,0.00,0.00,0.01,0,'2020-04-02 20:46:13',NULL,'2020-04-02 21:20:35','2020-04-02 21:41:39',NULL,'1226515772106289154','4200000554202004021437645976','1','1235079512380551170','1245693424808579073',NULL),
('1245693922462748673','1','0','2020-04-02 20:45:49','2020-04-02 20:45:49','1','wxd5b98bbec200013b','1240923176084389889','1245693922202615808','2','1','1','0',NULL,'5',NULL,5.00,100.00,0.00,0.00,5.01,0,NULL,NULL,NULL,NULL,NULL,'1245693922412417026',NULL,'1','1235079512380551170','1245693424808579073',NULL),
('1245702994784186370','1','0','2020-04-02 21:21:52','2020-04-03 16:05:29','1','wxd5b98bbec200013b','1240923176084389889','1245702994318589952','2','2','1','1',NULL,'3','1',0.00,2000.00,0.00,0.00,0.01,0,'2020-04-02 21:22:00',NULL,'2020-04-03 16:05:02','2020-04-03 16:05:30',NULL,'1226515817257971713','4200000564202004024246554034','2','1241935330631618561','1245703032692305921',NULL),
('1245705168322850818','1','0','2020-04-02 21:30:30','2020-04-02 21:30:30','1','wxd5b98bbec200013b','1240923176084389889','1245705168138272768','2','1','1','0',NULL,'5',NULL,5.00,2599.00,0.00,0.00,5.01,0,NULL,NULL,NULL,NULL,NULL,'1245705168306073602',NULL,'2','1239773817540141057',NULL,NULL),
('1245705213176737793','1','0','2020-04-02 21:30:41','2020-04-02 22:01:50','1','wxd5b98bbec200013b','1240923176084389889','1245705213017325568','2','2','1','1',NULL,'5','1',0.00,2599.00,0.00,0.00,0.01,0,'2020-04-02 21:30:48',NULL,'2020-04-02 21:36:53','2020-04-02 21:37:23',NULL,'1226515817257971713','4200000563202004025853715892','2','1239773817540141057','1245705249751068673',NULL),
('1245705402465677313','1','0','2020-04-02 21:31:26','2020-04-02 21:33:40','1','wxd5b98bbec200013b','1234102578637127681','1245705402314653696','2','2','1','1',NULL,'1',NULL,0.00,2599.00,0.00,0.00,0.01,0,'2020-04-02 21:31:33',NULL,NULL,NULL,NULL,'1226515817257971713','4200000555202004026698176739','2','1239773817540141057','1245705249751068673',NULL),
('1245705671014379522','1','0','2020-04-02 21:32:30','2020-04-02 21:32:30','1','wxd5b98bbec200013b','1240826736922284033','1245705670863355904','2','1','1','0',NULL,'5',NULL,5.00,2599.00,0.00,0.00,5.01,0,NULL,NULL,NULL,NULL,NULL,'1245705670997602306',NULL,'2','1239773817540141057','1245705249751068673',NULL),
('1245705710721855489','1','0','2020-04-02 21:32:40','2020-04-02 21:32:40','1','wxd5b98bbec200013b','1240826736922284033','1245705710600192000','2','2','1','0',NULL,'5',NULL,0.00,2599.00,0.00,0.00,0.01,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2','1239773817540141057','1245705249751068673',NULL),
('1245705919900184577','1','0','2020-04-02 21:33:30','2020-04-02 21:33:30','1','wxd5b98bbec200013b','1240826736922284033','1245705919753355264','2','2','1','1',NULL,'3','0',0.00,2599.00,0.00,0.00,0.01,0,'2020-04-02 21:33:38',NULL,'2020-04-02 21:35:56',NULL,NULL,'1226515817257971713','4200000563202004024065696199','2','1239773817540141057','1245705249751068673',NULL),
('1245713914168111105','1','0','2020-04-02 22:05:16','2020-04-02 22:05:16','1','wxd5b98bbec200013b','1240923176084389889','1245713913924812800','2','1','1','1',NULL,'1',NULL,5.00,2599.00,0.00,0.00,5.01,0,'2020-04-02 22:05:21',NULL,NULL,NULL,NULL,'1245713914151333889','4200000563202004022160656827','2','1239773817540141057','1245564114906923010',NULL),
('1245982972616667137','1','0','2020-04-03 15:54:24','2020-04-08 21:10:01','1','wxd5b98bbec200013b','1234102578637127681','1245982972553723904','2','2','1','1',NULL,'5',NULL,0.00,2000.00,0.00,0.00,0.01,0,'2020-04-03 15:54:30',NULL,NULL,NULL,NULL,'1226515817257971713','4200000564202004035326608360','2','1241935330631618561','1245703032692305921',NULL),
('1245988441410269186','1','0','2020-04-03 16:16:08','2020-04-03 16:55:32','1','wxd5b98bbec200013b','1240923176084389889','1245988441066307584','2','1','1','1',NULL,'5',NULL,10.00,0.03,0.00,0.00,10.03,0,'2020-04-03 16:16:17',NULL,NULL,NULL,NULL,'1245988441359937538','4200000570202004038694711355','0',NULL,NULL,NULL),
('1245995127483166722','1','0','2020-04-03 16:42:42','2020-04-03 16:42:42','1','wxd5b98bbec200013b','1240923176084389889','1245995296891076608','2','2','1','1',NULL,'3','0',0.00,2599.00,0.00,0.00,0.10,0,'2020-04-03 16:52:31',NULL,'2020-04-03 16:52:53',NULL,NULL,'1226515817257971713','4200000560202004035182025704','0',NULL,NULL,NULL),
('1246433027769249794','1','0','2020-04-04 21:42:46','2020-04-04 21:42:46','1','wxd5b98bbec200013b','1234102578637127681','1246433027626631168','2','2','1','0',NULL,'5',NULL,0.00,2799.00,0.00,0.00,2799.00,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL),
('1246625090242621441','1','0','2020-04-05 10:25:57','2020-04-05 10:25:57','1','wxd5b98bbec200013b','1234102578637127681','1246625090167111680','2','2','1','0',NULL,'5',NULL,0.00,2799.00,139.00,0.00,2660.00,139,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL),
('1246627732163407873','1','0','2020-04-05 10:36:27','2020-04-05 10:36:27','1','wxd5b98bbec200013b','1234102578637127681','1246627732104675328','2','2','1','0',NULL,'5',NULL,0.00,2799.00,139.00,1399.50,1260.50,139,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL),
('1246792972419215361','1','0','2020-04-05 21:33:03','2020-04-05 21:33:03','1','wxd5b98bbec200013b','1234102578637127681','1246792972268208128','2','1','1','0',NULL,'5',NULL,5.00,2599.00,0.00,0.00,5.01,0,NULL,NULL,NULL,NULL,NULL,'1246792972394049537',NULL,'2','1239773817540141057',NULL,NULL),
('1247857870528081922','1','0','2020-04-08 20:04:35','2020-04-08 20:04:35','1','wxd5b98bbec200013b','1234102578637127681','1247857870368669696','2','2','1','1',NULL,'10',NULL,0.00,2599.00,0.00,0.00,0.01,0,'2020-04-08 20:05:04',NULL,NULL,NULL,NULL,'1226515817257971713','4200000569202004084466756382','2','1239773817540141057','1247857999100276738',NULL),
('1247861781926277122','1','0','2020-04-08 20:20:07','2020-04-08 20:20:07','1','wxd5b98bbec200013b','1234102578637127681','1247861781787836416','2','1','1','0',NULL,'5',NULL,0.00,5488.00,0.00,0.00,5488.00,0,NULL,NULL,NULL,NULL,NULL,'1247861781880139778',NULL,'0',NULL,NULL,NULL),
('1247862450645135362','1','0','2020-04-08 20:22:47','2020-04-08 20:22:47','1','wxd5b98bbec200013b','1234102578637127681','1247862450552832000','2','1','1','0',NULL,'5',NULL,0.00,5488.00,0.00,0.00,5488.00,0,NULL,NULL,NULL,NULL,NULL,'1247862450598998018',NULL,'0',NULL,NULL,NULL),
('1248969345179095042','1','0','2020-04-11 21:41:11','2020-04-11 21:41:11','1','wxd5b98bbec200013b','1234102578637127681','1248969344981925888','2','1','1','0',NULL,NULL,NULL,0.00,5488.00,0.00,0.00,5488.00,0,NULL,NULL,NULL,NULL,NULL,'1248969345145540610',NULL,'0',NULL,NULL,NULL),
('1248972296836632578','1','0','2020-04-11 21:52:55','2020-04-11 21:52:55','1','wxd5b98bbec200013b','1234102578637127681','1248972296631091200','2','1','1','0','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro',NULL,NULL,0.00,5488.00,0.00,0.00,5488.00,0,NULL,NULL,NULL,NULL,NULL,'1248972296807272449',NULL,'0',NULL,NULL,NULL),
('1248972519331876866','1','0','2020-04-11 21:53:32','2020-04-11 21:53:32','1','wxd5b98bbec200013b','1234102578637127681','1248972519319273472','2','2','1','1','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro','1',NULL,0.00,0.01,0.00,0.00,0.01,0,'2020-04-11 21:53:47',NULL,NULL,NULL,NULL,'1226515772106289154','4200000558202004110642396009','0',NULL,NULL,NULL),
('1248972519382208514','1','0','2020-04-11 21:53:32','2020-04-11 21:53:32','1','wxd5b98bbec200013b','1234102578637127681','1248972519365410816','2','2','1','1','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro','1',NULL,0.00,0.02,0.00,0.00,0.02,0,'2020-04-11 21:53:47',NULL,NULL,NULL,NULL,'1226515817257971713','4200000558202004110642396009','0',NULL,NULL,NULL),
('1248972854981054465','1','0','2020-04-11 21:55:08','2020-04-11 21:55:08','1','wxd5b98bbec200013b','1234102578637127681','1248972854809067520','2','1','1','1','小程序付款演示，不发货，不退款','1',NULL,0.00,0.01,0.00,0.00,0.01,0,'2020-04-11 21:55:20',NULL,NULL,NULL,NULL,'1248972854930722817','4200000556202004118802337385','0',NULL,NULL,NULL);

/*Table structure for table `order_item` */

DROP TABLE IF EXISTS `order_item`;

CREATE TABLE `order_item` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品Id',
  `spu_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品名',
  `spec_info` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '规格信息',
  `sku_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'skuId',
  `pic_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片',
  `quantity` int(3) NOT NULL COMMENT '商品数量',
  `sales_price` decimal(10,2) NOT NULL COMMENT '购买单价',
  `freight_price` decimal(10,2) DEFAULT '0.00' COMMENT '运费金额',
  `payment_price` decimal(10,2) DEFAULT '0.00' COMMENT '支付金额（购买单价*商品数量+运费金额-积分抵扣金额-电子券抵扣金额）',
  `payment_points_price` decimal(10,2) DEFAULT '0.00' COMMENT '积分抵扣金额',
  `payment_coupon_price` decimal(10,2) DEFAULT '0.00' COMMENT '电子券抵扣金额',
  `payment_points` int(11) DEFAULT '0' COMMENT '支付积分',
  `coupon_user_id` varchar(32) DEFAULT NULL COMMENT '用户电子券ID',
  `remark` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '状态0：正常；1：退款中；2：退货退款中；3：完成退款；4：完成退货退款',
  `is_refund` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '是否退款0:否 1：是',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单详情';

/*Data for the table `order_item` */

insert  into `order_item`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`order_id`,`spu_id`,`spu_name`,`spec_info`,`sku_id`,`pic_url`,`quantity`,`sales_price`,`freight_price`,`payment_price`,`payment_points_price`,`payment_coupon_price`,`payment_points`,`coupon_user_id`,`remark`,`status`,`is_refund`) values 
('1245684247864365057','1','0','2020-04-02 20:07:23','2020-04-02 20:07:23','1245684247830810625','2b48a2f35352a4d87d51d6dd03bb874e','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro',NULL,'965bac3dbc101b6abe68b72469118f03','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',2,0.01,5.00,5.02,0.00,0.00,0,NULL,NULL,'0','0'),
('1245684299756294146','1','0','2020-04-02 20:07:35','2020-04-02 20:07:35','1245684299693379586','2b48a2f35352a4d87d51d6dd03bb874e','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro',NULL,'965bac3dbc101b6abe68b72469118f03','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',2,0.01,0.00,0.02,0.00,0.00,0,NULL,NULL,'0','0'),
('1245687903103832066','1','0','2020-04-02 20:21:54','2020-04-02 20:21:54','1245687903087054850','2b48a2f35352a4d87d51d6dd03bb874e','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro',NULL,'965bac3dbc101b6abe68b72469118f03','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,0.01,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245687954920263682','1','0','2020-04-02 20:22:06','2020-04-02 20:22:06','1245687954911875073','2b48a2f35352a4d87d51d6dd03bb874e','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro',NULL,'965bac3dbc101b6abe68b72469118f03','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,0.01,5.00,5.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245688045894717442','1','0','2020-04-02 20:22:28','2020-04-02 20:22:28','1245688045882134530','2b48a2f35352a4d87d51d6dd03bb874e','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro',NULL,'965bac3dbc101b6abe68b72469118f03','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,0.01,5.00,5.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245691924061442049','1','0','2020-04-02 20:37:53','2020-04-02 20:37:53','1245691924053053442','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245692052205817858','1','0','2020-04-02 20:38:23','2020-04-02 20:38:23','1245692052197429250','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，红色，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245693765193125889','1','0','2020-04-02 20:45:12','2020-04-02 20:45:12','1245693765134405633','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245693827067498497','1','0','2020-04-02 20:45:26','2020-04-02 20:45:26','1245693827054915585','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,5.00,5.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245693883241811969','1','0','2020-04-02 20:45:40','2020-04-02 20:45:40','1245693883183091714','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'2','0'),
('1245693922471137282','1','0','2020-04-02 20:45:49','2020-04-02 20:45:49','1245693922462748673','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,5.00,5.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245702994842906625','1','0','2020-04-02 21:21:52','2020-04-02 21:21:52','1245702994784186370','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','移动，红色，32G','5033e1f2bfa07231d1c2045392fa2f93','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',1,2000.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245705168339628033','1','0','2020-04-02 21:30:30','2020-04-02 21:30:30','1245705168322850818','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，红色，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,5.00,5.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245705213201903617','1','0','2020-04-02 21:30:41','2020-04-02 21:30:41','1245705213176737793','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，红色，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'4','1'),
('1245705402524397570','1','0','2020-04-02 21:31:26','2020-04-02 21:31:26','1245705402465677313','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，红色，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245705671031156737','1','0','2020-04-02 21:32:30','2020-04-02 21:32:30','1245705671014379522','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，红色，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,5.00,5.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245705710776381441','1','0','2020-04-02 21:32:40','2020-04-02 21:32:40','1245705710721855489','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，红色，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245705919963099138','1','0','2020-04-02 21:33:30','2020-04-02 21:33:30','1245705919900184577','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，红色，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1245713914180694017','1','0','2020-04-02 22:05:16','2020-04-02 22:05:16','1245713914168111105','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，红色，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,5.00,5.01,0.00,0.00,0,NULL,NULL,'2','0'),
('1245982972671193090','1','0','2020-04-03 15:54:24','2020-04-03 15:54:24','1245982972616667137','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','移动，红色，32G','5033e1f2bfa07231d1c2045392fa2f93','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',1,2000.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'3','1'),
('1245988441452212226','1','0','2020-04-03 16:16:08','2020-04-03 16:16:08','1245988441410269186','2b48a2f35352a4d87d51d6dd03bb874e','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro',NULL,'965bac3dbc101b6abe68b72469118f03','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',2,0.01,5.00,5.02,0.00,0.00,0,NULL,NULL,'3','1'),
('1245988441477378049','1','0','2020-04-03 16:16:08','2020-04-03 16:16:08','1245988441410269186','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','移动，红色，64G','954060498a28ba885c504d9e9234a009','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,0.01,5.00,5.01,0.00,0.00,0,NULL,NULL,'3','1'),
('1245995127499943938','1','0','2020-04-03 16:42:42','2020-04-03 16:42:42','1245995127483166722','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，红色，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,0.00,0.10,0.00,0.00,0,NULL,NULL,'0','0'),
('1246433027815387137','1','0','2020-04-04 21:42:46','2020-04-04 21:42:46','1246433027769249794','87ec583e2883cbd2fd259f47ece0fe15','可优惠900/送壕礼/Huawei/华为 Nova 4中移动手机正品官方旗舰店新款青春版3i2s 3e 32plus 4e 5高配版Pro','4g全网通，仲夏紫，128G','f42bda1c9215a878fd49360a7576c913','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/50.jpg',1,2799.00,0.00,2799.00,0.00,0.00,0,NULL,NULL,'0','0'),
('1246625090255204353','1','0','2020-04-05 10:25:57','2020-04-05 10:25:57','1246625090242621441','87ec583e2883cbd2fd259f47ece0fe15','可优惠900/送壕礼/Huawei/华为 Nova 4中移动手机正品官方旗舰店新款青春版3i2s 3e 32plus 4e 5高配版Pro','4g全网通，仲夏紫，128G','f42bda1c9215a878fd49360a7576c913','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/50.jpg',1,2799.00,0.00,2660.00,139.00,0.00,139,NULL,NULL,'0','0'),
('1246627732175990785','1','0','2020-04-05 10:36:27','2020-04-05 10:36:27','1246627732163407873','87ec583e2883cbd2fd259f47ece0fe15','可优惠900/送壕礼/Huawei/华为 Nova 4中移动手机正品官方旗舰店新款青春版3i2s 3e 32plus 4e 5高配版Pro','4g全网通，仲夏紫，128G','f42bda1c9215a878fd49360a7576c913','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/50.jpg',1,2799.00,0.00,1260.50,139.00,1399.50,139,'1246261754518831105',NULL,'0','0'),
('1246792972444381185','1','0','2020-04-05 21:33:03','2020-04-05 21:33:03','1246792972419215361','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，红色，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,5.00,5.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1247857870611968001','1','0','2020-04-08 20:04:35','2020-04-08 20:04:35','1247857870528081922','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，红色，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1247861781938860033','1','0','2020-04-08 20:20:07','2020-04-08 20:20:07','1247861781926277122','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','极光色，256G，4G全网通','278357f4667ba6677c9936e33b94bfdd','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,5488.00,0.00,5488.00,0.00,0.00,0,NULL,NULL,'0','0'),
('1247862450653523969','1','0','2020-04-08 20:22:47','2020-04-08 20:22:47','1247862450645135362','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','极光色，256G，4G全网通','278357f4667ba6677c9936e33b94bfdd','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,5488.00,0.00,5488.00,0.00,0.00,0,NULL,NULL,'0','0'),
('1248969345221038081','1','0','2020-04-11 21:41:11','2020-04-11 21:41:11','1248969345179095042','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','极光色，256G，4G全网通','278357f4667ba6677c9936e33b94bfdd','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,5488.00,0.00,5488.00,0.00,0.00,0,NULL,NULL,'0','0'),
('1248972296878575617','1','0','2020-04-11 21:52:55','2020-04-11 21:52:55','1248972296836632578','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','亮黑色，256G，4G全网通','f3b7f08030e448c0aaca6895e65aa5e9','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,5488.00,0.00,5488.00,0.00,0.00,0,NULL,NULL,'0','0'),
('1248972455481987074','1','0','2020-04-11 21:53:32','2020-04-11 21:53:32','1248972519382208514','2b48a2f35352a4d87d51d6dd03bb874e','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro',NULL,'965bac3dbc101b6abe68b72469118f03','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',2,0.01,0.00,0.02,0.00,0.00,0,NULL,NULL,'0','0'),
('1248972455490375682','1','0','2020-04-11 21:53:32','2020-04-11 21:53:32','1248972519331876866','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1248972854993637378','1','0','2020-04-11 21:55:08','2020-04-11 21:55:08','1248972854981054465','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0');

/*Table structure for table `order_logistics` */

DROP TABLE IF EXISTS `order_logistics`;

CREATE TABLE `order_logistics` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `postal_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮编',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人名字',
  `tel_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '电话号码',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '详细地址',
  `logistics` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '物流商家',
  `logistics_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '物流单号',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '快递单当前状态，包括-1错误，0在途，1揽收，2疑难，3签收，4退签，5派件，6退回，7转投 等7个状态',
  `is_check` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '签收标记（0：未签收；1：已签收）',
  `message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '相关信息',
  PRIMARY KEY (`id`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单物流表';

/*Data for the table `order_logistics` */

insert  into `order_logistics`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`postal_code`,`user_name`,`tel_num`,`address`,`logistics`,`logistics_no`,`status`,`is_check`,`message`) values 
('1235079694442704898','1','0','2020-03-04 13:48:40','2020-03-04 13:48:40',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1235082092322107393','1','0','2020-03-04 13:58:12','2020-03-04 13:58:12',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号','shunfeng','SF1017566909728','3','1','[乐安镇合作点]您的快件已签收，如有疑问请电联小哥【龚稳，电话：13141545139】。疫情期间顺丰每日对网点消毒、小哥每日测温、配戴口罩，感谢您使用顺丰，期待再次为您服务。（主单总件数：1件）'),
('1236876828032864257','1','0','2020-03-09 12:49:50','2020-03-09 12:49:50',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237246808368844801','1','0','2020-03-10 13:20:00','2020-03-10 13:20:00',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237259374423957506','1','0','2020-03-10 14:09:56','2020-03-10 14:09:56',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237277273821798402','1','0','2020-03-10 15:21:04','2020-03-10 15:21:04',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237285183167651842','1','0','2020-03-10 15:52:29','2020-03-10 15:52:29',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237290301376159745','1','0','2020-03-10 16:12:50','2020-03-10 16:12:50',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237291138114617346','1','0','2020-03-10 16:16:09','2020-03-10 16:16:09',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237292766565715969','1','0','2020-03-10 16:22:37','2020-03-10 16:22:37',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237292896031297538','1','0','2020-03-10 16:23:08','2020-03-10 16:23:08',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237617358312239105','1','0','2020-03-11 13:52:26','2020-03-11 13:52:26',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237970361489801217','1','0','2020-03-12 13:15:09','2020-03-12 13:15:09',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237972113584799746','1','0','2020-03-12 13:22:06','2020-03-12 13:22:06',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237972951518613506','1','0','2020-03-12 13:25:26','2020-03-12 13:25:26',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237976212191522818','1','0','2020-03-12 13:38:24','2020-03-12 13:38:24',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237979810690375682','1','0','2020-03-12 13:52:42','2020-03-12 13:52:42',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1237979929376595969','1','0','2020-03-12 13:53:10','2020-03-12 13:53:10',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1238281291570290690','1','0','2020-03-13 09:50:40','2020-03-13 09:50:40',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240150615490760705','1','0','2020-03-18 13:38:42','2020-03-18 13:38:42',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240154384475557890','1','0','2020-03-18 13:53:40','2020-03-18 13:53:40',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240160530368237569','1','0','2020-03-18 14:18:06','2020-03-18 14:18:06',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240167907272359937','1','0','2020-03-18 14:47:24','2020-03-18 14:47:24',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240168516344020994','1','0','2020-03-18 14:49:50','2020-03-18 14:49:50',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240169162698887169','1','0','2020-03-18 14:52:24','2020-03-18 14:52:24',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240199169039122434','1','0','2020-03-18 16:51:38','2020-03-18 16:51:38',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240200818444980225','1','0','2020-03-18 16:58:11','2020-03-18 16:58:11',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240201797554917378','1','0','2020-03-18 17:02:05','2020-03-18 17:02:05',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240203041979748354','1','0','2020-03-18 17:07:01','2020-03-18 17:07:01',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240215693657362434','1','0','2020-03-18 17:57:18','2020-03-18 17:57:18',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240215895957032962','1','0','2020-03-18 17:58:06','2020-03-18 17:58:06',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240217185550323713','1','0','2020-03-18 18:03:13','2020-03-18 18:03:13',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240839566283198466','1','0','2020-03-20 11:16:20','2020-03-20 11:16:20',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240855176979361793','1','0','2020-03-20 12:18:22','2020-03-20 12:18:22',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240893105579720706','1','0','2020-03-20 14:49:05','2020-03-20 14:49:05',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1240916378090721281','1','0','2020-03-20 16:21:34','2020-03-20 16:21:34',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1240917599836913666','1','0','2020-03-20 16:26:25','2020-03-20 16:26:25',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1240923439151136770','1','0','2020-03-20 16:49:37','2020-03-20 16:49:37',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1240925619316801538','1','0','2020-03-20 16:58:17','2020-03-20 16:58:17',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240927966872944641','1','0','2020-03-20 17:07:37','2020-03-20 17:07:37',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1240928923375583233','1','0','2020-03-20 17:11:25','2020-03-20 17:11:25',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1240933776298532865','1','0','2020-03-20 17:30:42','2020-03-20 17:30:42',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240934189068378113','1','0','2020-03-20 17:32:20','2020-03-20 17:32:20',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1240934474801143809','1','0','2020-03-20 17:33:28','2020-03-20 17:33:28',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1240935517677121538','1','0','2020-03-20 17:37:37','2020-03-20 17:37:37',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240935626678693889','1','0','2020-03-20 17:38:03','2020-03-20 17:38:03',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1240935721893588993','1','0','2020-03-20 17:38:26','2020-03-20 17:38:26',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1240938197132648450','1','0','2020-03-20 17:48:16','2020-03-20 17:48:16',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1240938309321891841','1','0','2020-03-20 17:48:43','2020-03-20 17:48:43',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240938500926087169','1','0','2020-03-20 17:49:28','2020-03-20 17:49:28',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1240939734982688769','1','0','2020-03-20 17:54:23','2020-03-20 17:54:23',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1240939845561319425','1','0','2020-03-20 17:54:49','2020-03-20 17:54:49',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1240940045793198082','1','0','2020-03-20 17:55:37','2020-03-20 17:55:37',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1240940141888897025','1','0','2020-03-20 17:56:00','2020-03-20 17:56:00',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1240978608651993089','1','0','2020-03-20 20:28:51','2020-03-20 20:28:51',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1241577588624588801','1','0','2020-03-22 12:08:59','2020-03-22 12:08:59',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1241578701897728002','1','0','2020-03-22 12:13:24','2020-03-22 12:13:24',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1241909336612929538','1','0','2020-03-23 10:07:14','2020-03-23 10:07:14',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1241923100506820610','1','0','2020-03-23 11:01:55','2020-03-23 11:01:55',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1241923349547814913','1','0','2020-03-23 11:02:55','2020-03-23 11:02:55',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1241924424485011458','1','0','2020-03-23 11:07:11','2020-03-23 11:07:11',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1241926229285634050','1','0','2020-03-23 11:14:21','2020-03-23 11:14:21',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1241926740831338498','1','0','2020-03-23 11:16:23','2020-03-23 11:16:23',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1241928520457654274','1','0','2020-03-23 11:23:27','2020-03-23 11:23:27',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1241928869889314818','1','0','2020-03-23 11:24:51','2020-03-23 11:24:51',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1241929154963574786','1','0','2020-03-23 11:25:59','2020-03-23 11:25:59',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1241929224412860417','1','0','2020-03-23 11:26:15','2020-03-23 11:26:15',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1241934924945952770','1','0','2020-03-23 11:48:54','2020-03-23 11:48:54',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1241935501172019201','1','0','2020-03-23 11:51:12','2020-03-23 11:51:12',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1241935589118185474','1','0','2020-03-23 11:51:33','2020-03-23 11:51:33',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1241935719238078465','1','0','2020-03-23 11:52:04','2020-03-23 11:52:04',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1241935787886252033','1','0','2020-03-23 11:52:20','2020-03-23 11:52:20',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1242008398284591105','1','0','2020-03-23 16:40:52','2020-03-23 16:40:52',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242010289596928002','1','0','2020-03-23 16:48:23','2020-03-23 16:48:23',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242010616928800770','1','0','2020-03-23 16:49:41','2020-03-23 16:49:41',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242012262916366337','1','0','2020-03-23 16:56:13','2020-03-23 16:56:13',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242012353064542210','1','0','2020-03-23 16:56:35','2020-03-23 16:56:35',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242013506502377473','1','0','2020-03-23 17:01:10','2020-03-23 17:01:10',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242016542666735618','1','0','2020-03-23 17:13:13','2020-03-23 17:13:13',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242019775883739138','1','0','2020-03-23 17:26:04','2020-03-23 17:26:04',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242020485459341314','1','0','2020-03-23 17:28:54','2020-03-23 17:28:54',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242069580039319554','1','0','2020-03-23 20:43:59','2020-03-23 20:43:59',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242078678868815874','1','0','2020-03-23 21:20:08','2020-03-23 21:20:08',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242086473747918849','1','0','2020-03-23 21:51:06','2020-03-23 21:51:06',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242090142170083329','1','0','2020-03-23 22:05:41','2020-03-23 22:05:41',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242093910039195649','1','0','2020-03-23 22:20:39','2020-03-23 22:20:39',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242291248074555394','1','0','2020-03-24 11:24:48','2020-03-24 11:24:48',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242291473962991618','1','0','2020-03-24 11:25:42','2020-03-24 11:25:42',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1242291838422843393','1','0','2020-03-24 11:27:09','2020-03-24 11:27:09',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1242291883184455681','1','0','2020-03-24 11:27:20','2020-03-24 11:27:20',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1242292000641744898','1','0','2020-03-24 11:27:48','2020-03-24 11:27:48',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1242292062746804226','1','0','2020-03-24 11:28:03','2020-03-24 11:28:03',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1242457142134296578','1','0','2020-03-24 22:24:01','2020-03-24 22:24:01',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1242658346575556609','1','0','2020-03-25 11:43:31','2020-03-25 11:43:31',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245290517676179457','1','0','2020-04-01 18:02:50','2020-04-01 18:02:50',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245315729088114690','1','0','2020-04-01 19:43:01','2020-04-01 19:43:01',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245316531081039874','1','0','2020-04-01 19:46:12','2020-04-01 19:46:12',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245317164890591233','1','0','2020-04-01 19:48:43','2020-04-01 19:48:43',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245317804463226882','1','0','2020-04-01 19:51:16','2020-04-01 19:51:16',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245322403370778626','1','0','2020-04-01 20:09:32','2020-04-01 20:09:32',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245323779446509570','1','0','2020-04-01 20:15:00','2020-04-01 20:15:00',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245324589395894274','1','0','2020-04-01 20:18:13','2020-04-01 20:18:13',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245327250484649985','1','0','2020-04-01 20:28:48','2020-04-01 20:28:48',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245328183054573570','1','0','2020-04-01 20:32:30','2020-04-01 20:32:30',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245328534210093057','1','0','2020-04-01 20:33:54','2020-04-01 20:33:54',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245343949325869057','1','0','2020-04-01 21:35:09','2020-04-01 21:35:09',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245344090518724610','1','0','2020-04-01 21:35:43','2020-04-01 21:35:43',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245354335190171649','1','0','2020-04-01 22:16:25','2020-04-01 22:16:25',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245553695555338241','1','0','2020-04-02 11:28:36','2020-04-02 11:28:36',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245562754576695298','1','0','2020-04-02 12:04:36','2020-04-02 12:04:36',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245563054725283842','1','0','2020-04-02 12:05:48','2020-04-02 12:05:48',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1245564443891351553','1','0','2020-04-02 12:11:19','2020-04-02 12:11:19',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1245568204453982209','1','0','2020-04-02 12:26:16','2020-04-02 12:26:16',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245568244731883521','1','0','2020-04-02 12:26:25','2020-04-02 12:26:25',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245619022666412033','1','0','2020-04-02 15:48:12','2020-04-02 15:48:12',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1245619315294613506','1','0','2020-04-02 15:49:21','2020-04-02 15:49:21',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1245673219541716994','1','0','2020-04-02 19:23:33','2020-04-02 19:23:33',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245676658283892737','1','0','2020-04-02 19:37:13','2020-04-02 19:37:13',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245681805181390849','1','0','2020-04-02 19:57:40','2020-04-02 19:57:40',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245682040402153473','1','0','2020-04-02 19:58:36','2020-04-02 19:58:36',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245683158771400706','1','0','2020-04-02 20:03:03','2020-04-02 20:03:03',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245684247788867586','1','0','2020-04-02 20:07:23','2020-04-02 20:07:23',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245687954853154818','1','0','2020-04-02 20:22:06','2020-04-02 20:22:06',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245688045827608578','1','0','2020-04-02 20:22:28','2020-04-02 20:22:28',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1245693827008778242','1','0','2020-04-02 20:45:26','2020-04-02 20:45:26',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1245693922412417026','1','0','2020-04-02 20:45:49','2020-04-02 20:45:49',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1245705168306073602','1','0','2020-04-02 21:30:30','2020-04-02 21:30:30',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1245705670997602306','1','0','2020-04-02 21:32:30','2020-04-02 21:32:30',NULL,'空的时候','18569685123','江苏省南京市六合区摸着自己的身体不舒服',NULL,NULL,NULL,NULL,NULL),
('1245713914151333889','1','0','2020-04-02 22:05:16','2020-04-02 22:05:16',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1245988441359937538','1','0','2020-04-03 16:16:08','2020-04-03 16:16:08',NULL,'磁力链接','18569856855','北京市北京市东城区旅游鞋',NULL,NULL,NULL,NULL,NULL),
('1246792972394049537','1','0','2020-04-05 21:33:03','2020-04-05 21:33:03',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1247861781880139778','1','0','2020-04-08 20:20:07','2020-04-08 20:20:07',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1247862450598998018','1','0','2020-04-08 20:22:47','2020-04-08 20:22:47',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1248969345145540610','1','0','2020-04-11 21:41:11','2020-04-11 21:41:11',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1248972296807272449','1','0','2020-04-11 21:52:55','2020-04-11 21:52:55',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('1248972854930722817','1','0','2020-04-11 21:55:08','2020-04-11 21:55:08',NULL,'张三','18603652310','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `order_logistics_detail` */

DROP TABLE IF EXISTS `order_logistics_detail`;

CREATE TABLE `order_logistics_detail` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `logistics_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '物流id',
  `logistics_time` datetime NOT NULL COMMENT '物流时间',
  `logistics_information` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '物流信息',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单物流详情表';

/*Data for the table `order_logistics_detail` */

insert  into `order_logistics_detail`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`logistics_id`,`logistics_time`,`logistics_information`) values 
('1235110509159636993','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-18 20:42:30','[乐安镇合作点]您的快件已签收，如有疑问请电联小哥【龚稳，电话：13141545139】。疫情期间顺丰每日对网点消毒、小哥每日测温、配戴口罩，感谢您使用顺丰，期待再次为您服务。（主单总件数：1件）'),
('1235110509163831297','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-18 13:50:56','[乐安镇合作点]快件交给龚稳,正在派送途中（联系电话：13141545139,顺丰已开启“安全呼叫”保护您的电话隐私,请放心接听！）'),
('1235110509163831298','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-18 12:55:11','[乐安镇合作点]快件交给曹双春,正在派送途中（联系电话：13327276669,顺丰已开启“安全呼叫”保护您的电话隐私,请放心接听！）'),
('1235110509163831299','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-18 12:41:40','快件到达 【乐安镇合作点】'),
('1235110509163831300','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-17 15:21:52','[益阳朝阳集散点]快件已发车'),
('1235110509172219905','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-17 15:21:20','快件在【益阳朝阳集散点】已装车,准备发往 【益阳安化县梅城镇营业点】'),
('1235110509172219906','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-17 14:02:38','快件到达 【益阳朝阳集散点】'),
('1235110509180608513','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-17 10:40:17','[长沙星沙中转场]快件已发车'),
('1235110509180608514','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-17 10:15:12','[长沙星沙中转场]快件在【长沙星沙集散中心】已装车,准备发往 【益阳朝阳集散点】'),
('1235110509180608515','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-17 07:26:02','[长沙星沙中转场]快件到达 【长沙星沙集散中心】'),
('1235110509180608516','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-17 01:51:50','[武汉吴家山中转场]快件已发车'),
('1235110509180608517','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-16 23:37:08','[武汉吴家山中转场]快件在【武汉吴家山集散中心】已装车,准备发往 【长沙星沙集散中心】'),
('1235110509188997121','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-16 20:32:52','[武汉吴家山中转场]快件到达 【武汉吴家山集散中心】'),
('1235110509188997122','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-16 18:36:17','[武汉市江岸区集收客户营业部]快件已发车'),
('1235110509188997123','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-16 17:51:02','快件在【武汉市江岸区集收客户营业部】已装车,准备发往 【武汉吴家山集散中心】'),
('1235110509188997124','1','0','2020-03-04 15:51:07','2020-03-04 15:51:07','1235082092322107393','2020-02-16 17:50:52','[武汉市江岸区集收客户营业部]顺丰速运 已收取快件');

/*Table structure for table `order_refunds` */

DROP TABLE IF EXISTS `order_refunds`;

CREATE TABLE `order_refunds` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者ID',
  `order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单ID',
  `order_item_id` varchar(32) DEFAULT NULL COMMENT '订单详情ID',
  `status` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '退款状态0：撤销退换申请；1：退款申请中；11、同意退款；12、拒绝退款；2：退货退款申请中；21：同意退货退款/退货中；22：拒绝退货退款；211：收到退货同意退款；212：收到退货拒绝退款',
  `refund_amount` decimal(10,2) NOT NULL COMMENT '退款金额',
  `refund_trade_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '退款流水号',
  `refund_reson` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '退款原因',
  `refuse_refund_reson` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '拒绝退款原因',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE,
  KEY `ids_order_id` (`tenant_id`,`order_id`,`order_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单退款记录表';

/*Data for the table `order_refunds` */

insert  into `order_refunds`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`order_id`,`order_item_id`,`status`,`refund_amount`,`refund_trade_no`,`refund_reson`,`refuse_refund_reson`) values 
('1237980646799712257','1','0','2020-03-12 13:56:01','2020-03-12 14:00:38',NULL,'1237979929393373185','1237979929410150402','11',0.01,'50300303772020031215105497640','sdgshhh',NULL),
('1240830790763237377','1','0','2020-03-20 10:41:28','2020-03-20 10:41:49',NULL,'1240200818512089089','1240200818545643521','11',0.01,'50300303632020032015218295777','大地震h占地面积',NULL),
('1242058222572924930','1','0','2020-03-23 19:58:51','2020-03-23 20:00:38',NULL,'1241577588691697666','1241577588792360962','11',0.01,'50300703662020032315260387796','ghjjjjjkkk',NULL),
('1245698071543762946','1','0','2020-04-02 21:02:18','2020-04-02 21:02:18',NULL,'1245693883183091714','1245693883241811969','2',0.01,NULL,'了',NULL),
('1245708401992822786','1','0','2020-04-02 21:43:21','2020-04-02 22:01:45',NULL,'1245705213176737793','1245705213201903617','211',0.01,'50300403892020040215443291095','她',NULL),
('1245715468606533633','1','0','2020-04-02 22:11:26','2020-04-02 22:11:46',NULL,'1245713914168111105','1245713914180694017','211',5.01,'50300304022020040215411799012','咯',NULL),
('1245997841915080706','1','0','2020-04-03 16:53:29','2020-04-03 16:54:19',NULL,'1245988441410269186','1245988441452212226','11',5.02,'50300304152020040300010428316','咯',NULL),
('1245998160698961922','1','0','2020-04-03 16:54:45','2020-04-03 16:55:18',NULL,'1245988441410269186','1245988441477378049','11',5.01,'50300304152020040300009903179','啦',NULL),
('1247874186110595073','1','0','2020-04-08 21:09:25','2020-04-08 21:09:56',NULL,'1245982972616667137','1245982972671193090','11',0.01,'50300003882020040800052459568','egsagwet',NULL);

/*Table structure for table `points_config` */

DROP TABLE IF EXISTS `points_config`;

CREATE TABLE `points_config` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `init_posts` int(11) DEFAULT '0' COMMENT '用户初始积分数',
  `init_vip_posts` int(11) DEFAULT '0' COMMENT '会员初始积分数',
  `premise_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额满多少可使用抵扣',
  `default_deduct_scale` int(11) DEFAULT NULL COMMENT '默认抵扣比例',
  `default_deduct_amount` decimal(10,2) DEFAULT NULL COMMENT '默认1积分数可抵多少元',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_id` (`tenant_id`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='积分设置';

/*Data for the table `points_config` */

insert  into `points_config`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`init_posts`,`init_vip_posts`,`premise_amount`,`default_deduct_scale`,`default_deduct_amount`) values 
('1215980007031005185','1','0','2020-01-11 20:53:20','2020-01-11 20:53:20',100,3000,100.00,5,1.00);

/*Table structure for table `points_record` */

DROP TABLE IF EXISTS `points_record`;

CREATE TABLE `points_record` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户ID',
  `amount` int(11) DEFAULT NULL COMMENT '数量',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '描述',
  `spu_id` varchar(32) DEFAULT NULL COMMENT '商品ID',
  `order_item_id` varchar(32) DEFAULT NULL COMMENT '订单详情ID',
  `record_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '记录类型0、用户初始化；1、会员初始化；2、商品赠送；3、退款赠送减回；4、商品抵扣；5、订单取消抵扣加回；6、退款抵扣加回',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='积分变动记录';

/*Data for the table `points_record` */

insert  into `points_record`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`user_id`,`amount`,`description`,`spu_id`,`order_item_id`,`record_type`) values 
('1234102578695847938','1','0','2020-03-01 21:05:57','2020-03-01 21:05:57','1234102578637127681',100,'用户初始积分',NULL,NULL,'0'),
('1234403517298368514','1','0','2020-03-02 17:01:47','2020-03-02 17:01:47','1234102578637127681',3000,'会员初始积分',NULL,NULL,'1'),
('1235079782476951554','1','0','2020-03-04 13:49:01','2020-03-04 13:49:01','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1235079694530785282','2'),
('1235082168826212353','1','0','2020-03-04 13:58:30','2020-03-04 13:58:30','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1235082093941108739','2'),
('1235082168826212354','1','0','2020-03-04 13:58:30','2020-03-04 13:58:30','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1235082093932720129','2'),
('1235082168847183873','1','0','2020-03-04 13:58:30','2020-03-04 13:58:30','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1235082093932720130','2'),
('1235082168847183874','1','0','2020-03-04 13:58:30','2020-03-04 13:58:30','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1235082093941108738','2'),
('1237292843610886146','1','0','2020-03-10 16:22:56','2020-03-10 16:22:56','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1237292766620241922','2'),
('1237294737188147201','1','0','2020-03-10 16:30:27','2020-03-10 16:30:27','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1237291138181726209','2'),
('1237617453426470914','1','0','2020-03-11 13:52:49','2020-03-11 13:52:49','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1237617358383542273','2'),
('1238281358440079361','1','0','2020-03-13 09:50:56','2020-03-13 09:50:56','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1238281291696119809','2'),
('1240201958746214401','1','0','2020-03-18 17:02:43','2020-03-18 17:02:43','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240201797638803457','2'),
('1240202179920252930','1','0','2020-03-18 17:03:36','2020-03-18 17:03:36','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240200818545643521','2'),
('1240202740392513538','1','0','2020-03-18 17:05:49','2020-03-18 17:05:49','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240199169097842689','2'),
('1240826736985198593','1','0','2020-03-20 10:25:22','2020-03-20 10:25:22','1240826736922284033',100,'用户初始积分',NULL,NULL,'0'),
('1240826773588889602','1','0','2020-03-20 10:25:30','2020-03-20 10:25:30','1240826736922284033',3000,'会员初始积分',NULL,NULL,'1'),
('1240830902977646593','1','0','2020-03-20 10:41:55','2020-03-20 10:41:55','1234102578637127681',-1000,'【退款】 【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240200818545643521','3'),
('1240839598218629121','1','0','2020-03-20 11:16:28','2020-03-20 11:16:28','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240839566396444673','2'),
('1240855213759213570','1','0','2020-03-20 12:18:31','2020-03-20 12:18:31','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240855177067442177','2'),
('1240916417047416833','1','0','2020-03-20 16:21:43','2020-03-20 16:21:43','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240916378208161793','2'),
('1240917633366179841','1','0','2020-03-20 16:26:33','2020-03-20 16:26:33','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240917599924994049','2'),
('1240923176109555713','1','0','2020-03-20 16:48:35','2020-03-20 16:48:35','1240923176084389889',100,'用户初始积分',NULL,NULL,'0'),
('1240923310868348929','1','0','2020-03-20 16:49:07','2020-03-20 16:49:07','1240923176084389889',3000,'会员初始积分',NULL,NULL,'1'),
('1240923491949035522','1','0','2020-03-20 16:49:50','2020-03-20 16:49:50','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240923439218245633','2'),
('1240925647011790849','1','0','2020-03-20 16:58:24','2020-03-20 16:58:24','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240925619383910402','2'),
('1240927995620704257','1','0','2020-03-20 17:07:44','2020-03-20 17:07:44','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240927966969413634','2'),
('1240928970603446273','1','0','2020-03-20 17:11:36','2020-03-20 17:11:36','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240928923400749058','2'),
('1240933809785856001','1','0','2020-03-20 17:30:50','2020-03-20 17:30:50','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240933776390807554','2'),
('1240934221561651202','1','0','2020-03-20 17:32:28','2020-03-20 17:32:28','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240934189152264193','2'),
('1240934518791004162','1','0','2020-03-20 17:33:39','2020-03-20 17:33:39','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240934474864058370','2'),
('1240935551097335810','1','0','2020-03-20 17:37:45','2020-03-20 17:37:45','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240935517777784834','2'),
('1240935653597736961','1','0','2020-03-20 17:38:09','2020-03-20 17:38:09','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240935626720636929','2'),
('1240935756400128002','1','0','2020-03-20 17:38:34','2020-03-20 17:38:34','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240935721927143426','2'),
('1240938228057251841','1','0','2020-03-20 17:48:23','2020-03-20 17:48:23','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240938197195563009','2'),
('1240938340611399682','1','0','2020-03-20 17:48:50','2020-03-20 17:48:50','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240938309397389313','2'),
('1240938536669945858','1','0','2020-03-20 17:49:37','2020-03-20 17:49:37','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240938501043527682','2'),
('1240939770558775298','1','0','2020-03-20 17:54:31','2020-03-20 17:54:31','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240939735087546369','2'),
('1240939883398135810','1','0','2020-03-20 17:54:58','2020-03-20 17:54:58','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240939845624233986','2'),
('1240940320817905666','1','0','2020-03-20 17:56:42','2020-03-20 17:56:42','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240940141943422977','2'),
('1240978678361325570','1','0','2020-03-20 20:29:07','2020-03-20 20:29:07','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1240978608748462082','2'),
('1241577637098160130','1','0','2020-03-22 12:09:10','2020-03-22 12:09:10','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1241577588792360962','2'),
('1241926263087529986','1','0','2020-03-23 11:14:29','2020-03-23 11:14:29','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1241926229365325826','2'),
('1241929185586188290','1','0','2020-03-23 11:26:06','2020-03-23 11:26:06','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1241929155030683649','2'),
('1241934957086904322','1','0','2020-03-23 11:49:02','2020-03-23 11:49:02','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1241934924971118593','2'),
('1241935531396173825','1','0','2020-03-23 11:51:19','2020-03-23 11:51:19','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1241935501201379330','2'),
('1241935750477254658','1','0','2020-03-23 11:52:11','2020-03-23 11:52:11','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1241935719263244290','2'),
('1242058698307661825','1','0','2020-03-23 20:00:44','2020-03-23 20:00:44','1234102578637127681',-1000,'【退款】 【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1241577588792360962','3'),
('1242093976862846977','1','0','2020-03-23 22:20:55','2020-03-23 22:20:55','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1242093910055972866','2'),
('1242291280907567105','1','0','2020-03-24 11:24:56','2020-03-24 11:24:56','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1242291248200384513','2'),
('1242291503977431041','1','0','2020-03-24 11:25:49','2020-03-24 11:25:49','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1242291474009128961','2'),
('1242292145382981634','1','0','2020-03-24 11:28:22','2020-03-24 11:28:22','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1242292062767775745','2'),
('1242292210860261378','1','0','2020-03-24 11:28:38','2020-03-24 11:28:38','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1242291883218010113','2'),
('1242658418310737921','1','0','2020-03-25 11:43:49','2020-03-25 11:43:49','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1242658346655248385','2'),
('1245290602011049985','1','0','2020-04-01 18:03:10','2020-04-01 18:03:10','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245290517722316802','2'),
('1245290602011049986','1','0','2020-04-01 18:03:10','2020-04-01 18:03:10','1234102578637127681',200,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 2','4d06c5157cce971b89166e509cdf63e8','1245290517730705409','2'),
('1245317867117740033','1','0','2020-04-01 19:51:31','2020-04-01 19:51:31','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245317804551307265','2'),
('1245317867126128642','1','0','2020-04-01 19:51:31','2020-04-01 19:51:31','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245317804534530049','2'),
('1245318245494292482','1','0','2020-04-01 19:53:01','2020-04-01 19:53:01','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245317165012226050','2'),
('1245318245502681090','1','0','2020-04-01 19:53:01','2020-04-01 19:53:01','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245317165003837442','2'),
('1245319354090782722','1','0','2020-04-01 19:57:25','2020-04-01 19:57:25','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245315729151029249','2'),
('1245319354103365634','1','0','2020-04-01 19:57:25','2020-04-01 19:57:25','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245315729134252033','2'),
('1245320147523076098','1','0','2020-04-01 20:00:34','2020-04-01 20:00:34','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245316531160731649','2'),
('1245320147535659009','1','0','2020-04-01 20:00:34','2020-04-01 20:00:34','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245316531152343041','2'),
('1245322496152977410','1','0','2020-04-01 20:09:54','2020-04-01 20:09:54','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245322403450470402','2'),
('1245322496161366017','1','0','2020-04-01 20:09:54','2020-04-01 20:09:54','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245322403463053313','2'),
('1245323845934616577','1','0','2020-04-01 20:15:16','2020-04-01 20:15:16','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245323779538784258','2'),
('1245323845943005186','1','0','2020-04-01 20:15:16','2020-04-01 20:15:16','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245323779522007042','2'),
('1245324654994808833','1','0','2020-04-01 20:18:29','2020-04-01 20:18:29','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245324589471391745','2'),
('1245324655003197441','1','0','2020-04-01 20:18:29','2020-04-01 20:18:29','1234102578637127681',200,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 2','4d06c5157cce971b89166e509cdf63e8','1245324589488168961','2'),
('1245327313801863170','1','0','2020-04-01 20:29:03','2020-04-01 20:29:03','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245327250539175938','2'),
('1245327313810251777','1','0','2020-04-01 20:29:03','2020-04-01 20:29:03','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245327250522398722','2'),
('1245328247500054529','1','0','2020-04-01 20:32:45','2020-04-01 20:32:45','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245328183113293825','2'),
('1245328247508443137','1','0','2020-04-01 20:32:45','2020-04-01 20:32:45','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245328183104905218','2'),
('1245328590250188802','1','0','2020-04-01 20:34:07','2020-04-01 20:34:07','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245328534252036098','2'),
('1245563154713296897','1','0','2020-04-02 12:06:12','2020-04-02 12:06:12','1240826736922284033',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245563098488651778','2'),
('1245563504178511873','1','0','2020-04-02 12:07:35','2020-04-02 12:07:35','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245563425958936577','2'),
('1245563836828762114','1','0','2020-04-02 12:08:54','2020-04-02 12:08:54','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245563779631038465','2'),
('1245564114776899586','1','0','2020-04-02 12:10:01','2020-04-02 12:10:01','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245564051308691458','2'),
('1245564503182032897','1','0','2020-04-02 12:11:33','2020-04-02 12:11:33','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245564443950071810','2'),
('1245568311555534850','1','0','2020-04-02 12:26:41','2020-04-02 12:26:41','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245568281394294785','2'),
('1245568602455683073','1','0','2020-04-02 12:27:51','2020-04-02 12:27:51','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245562819877814274','2'),
('1245693180037386241','1','0','2020-04-02 20:42:52','2020-04-02 20:42:52','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245692052205817858','2'),
('1245693272685367298','1','0','2020-04-02 20:43:14','2020-04-02 20:43:14','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245691924061442049','2'),
('1245694029849513985','1','0','2020-04-02 20:46:15','2020-04-02 20:46:15','1240923176084389889',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1245693883241811969','2'),
('1245703032600031234','1','0','2020-04-02 21:22:01','2020-04-02 21:22:01','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245702994842906625','2'),
('1245705249675571201','1','0','2020-04-02 21:30:50','2020-04-02 21:30:50','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245705213201903617','2'),
('1245705438318587906','1','0','2020-04-02 21:31:35','2020-04-02 21:31:35','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245705402524397570','2'),
('1245705965597126657','1','0','2020-04-02 21:33:40','2020-04-02 21:33:40','1240826736922284033',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245705919963099138','2'),
('1245713053618565121','1','0','2020-04-02 22:01:50','2020-04-02 22:01:50','1240923176084389889',-1000,'【退款】 【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245705213201903617','3'),
('1245713950079741954','1','0','2020-04-02 22:05:24','2020-04-02 22:05:24','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245713914180694017','2'),
('1245983008121450498','1','0','2020-04-03 15:54:33','2020-04-03 15:54:33','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245982972671193090','2'),
('1245988490601066498','1','0','2020-04-03 16:16:20','2020-04-03 16:16:20','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245988441477378049','2'),
('1245997605402472450','1','0','2020-04-03 16:52:33','2020-04-03 16:52:33','1240923176084389889',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245995127499943938','2'),
('1245998356837199873','1','0','2020-04-03 16:55:32','2020-04-03 16:55:32','1240923176084389889',-1000,'【退款】 【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245988441477378049','3'),
('1246625090360061954','1','0','2020-04-05 10:25:57','2020-04-05 10:25:57','1234102578637127681',-139,'【抵扣】购买商品【可优惠900/送壕礼/Huawei/华为 Nova 4中移动手机正品官方旗舰店新款青春版3i2s 3e 32plus 4e 5高配版Pro】 * 1','87ec583e2883cbd2fd259f47ece0fe15','1246625090255204353','4'),
('1246627732217933825','1','0','2020-04-05 10:36:27','2020-04-05 10:36:27','1234102578637127681',-139,'【抵扣】购买商品【可优惠900/送壕礼/Huawei/华为 Nova 4中移动手机正品官方旗舰店新款青春版3i2s 3e 32plus 4e 5高配版Pro】 * 1','87ec583e2883cbd2fd259f47ece0fe15','1246627732175990785','4'),
('1246630237341495297','1','0','2020-04-05 10:46:24','2020-04-05 10:46:24','1234102578637127681',139,'【订单取消】 【抵扣】购买商品【可优惠900/送壕礼/Huawei/华为 Nova 4中移动手机正品官方旗舰店新款青春版3i2s 3e 32plus 4e 5高配版Pro】 * 1','87ec583e2883cbd2fd259f47ece0fe15','1246627732175990785','5'),
('1246632642384769026','1','0','2020-04-05 10:55:57','2020-04-05 10:55:57','1234102578637127681',139,'【订单取消】 【抵扣】购买商品【可优惠900/送壕礼/Huawei/华为 Nova 4中移动手机正品官方旗舰店新款青春版3i2s 3e 32plus 4e 5高配版Pro】 * 1','87ec583e2883cbd2fd259f47ece0fe15','1246625090255204353','5'),
('1247857998999613442','1','0','2020-04-08 20:05:05','2020-04-08 20:05:05','1234102578637127681',1000,'【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1247857870611968001','2'),
('1247865792205189121','1','0','2020-04-08 20:36:03','2020-04-08 20:36:03','1247865792188411905',100,'用户初始积分',NULL,NULL,'0'),
('1247865949596446722','1','0','2020-04-08 20:36:41','2020-04-08 20:36:41','1247865792188411905',3000,'会员初始积分',NULL,NULL,'1'),
('1247874339831836674','1','0','2020-04-08 21:10:01','2020-04-08 21:10:01','1234102578637127681',-1000,'【退款】 【赠送】购买商品【小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机】 * 1','2835671ff031c18cb181b1a199f86b01','1245982972671193090','3'),
('1248972519273156609','1','0','2020-04-11 21:53:48','2020-04-11 21:53:48','1234102578637127681',20,'【赠送】购买商品【华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro】 * 2','2b48a2f35352a4d87d51d6dd03bb874e','1248972455481987074','2'),
('1248972519273156610','1','0','2020-04-11 21:53:48','2020-04-11 21:53:48','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1248972455490375682','2'),
('1248972911650295809','1','0','2020-04-11 21:55:21','2020-04-11 21:55:21','1234102578637127681',100,'【赠送】购买商品【小程序付款演示，不发货，不退款】 * 1','4d06c5157cce971b89166e509cdf63e8','1248972854993637378','2');

/*Table structure for table `shopping_cart` */

DROP TABLE IF EXISTS `shopping_cart`;

CREATE TABLE `shopping_cart` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户编号',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品SPU',
  `sku_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品SKU',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `spu_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '加入时的spu名字',
  `add_price` decimal(10,2) DEFAULT NULL COMMENT '加入时价格',
  `spec_info` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '加入时的规格信息',
  `pic_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='购物车';

/*Data for the table `shopping_cart` */

insert  into `shopping_cart`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`user_id`,`spu_id`,`sku_id`,`quantity`,`spu_name`,`add_price`,`spec_info`,`pic_url`) values 
('1245693222458576897','1','0','2020-04-02 20:43:02','2020-04-02 21:59:31','1240923176084389889','6545a6fc2927edc195b93982f446917c','eca0bf5189ba8192ccf5fc615970ea9d',6,'Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro',4988.00,'天空之境;128G;4G全网通','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg'),
('1245694416455290882','1','0','2020-04-02 20:47:47','2020-04-03 16:14:44','1240923176084389889','87ec583e2883cbd2fd259f47ece0fe15','2db22126dc5c251de13064fe12ebfb62',1,'可优惠900/送壕礼/Huawei/华为 Nova 4中移动手机正品官方旗舰店新款青春版3i2s 3e 32plus 4e 5高配版Pro',3599.00,'4g全网通;仲夏紫;256G','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/50.jpg'),
('1245715065689108481','1','0','2020-04-02 22:09:50','2020-04-02 22:09:50','1240923176084389889','4d06c5157cce971b89166e509cdf63e8','7cee91d08568afe4f8c2a7651f52be8b',1,'小程序付款演示，不发货，不退款',100.00,'超值大礼包','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif'),
('1245989389562048514','1','0','2020-04-03 16:19:54','2020-04-03 16:19:54','1240923176084389889','2835671ff031c18cb181b1a199f86b01','5a61a7876305b760efa8abe04b912a8b',1,'小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机',0.01,'移动;白色;64G','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg'),
('1245991006332022785','1','0','2020-04-03 16:26:19','2020-04-03 16:26:19','1240923176084389889','2835671ff031c18cb181b1a199f86b01','954060498a28ba885c504d9e9234a009',1,'小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机',0.01,'移动;红色;64G','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg'),
('1245992749891612673','1','0','2020-04-03 16:33:15','2020-04-03 16:35:11','1240923176084389889','2b48a2f35352a4d87d51d6dd03bb874e','965bac3dbc101b6abe68b72469118f03',3,'华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro',0.01,'','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg');

/*Table structure for table `undo_log` */

DROP TABLE IF EXISTS `undo_log`;

CREATE TABLE `undo_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `xid` varchar(100) NOT NULL,
  `context` varchar(128) NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int(11) NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  `ext` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `undo_log` */

/*Table structure for table `user_address` */

DROP TABLE IF EXISTS `user_address`;

CREATE TABLE `user_address` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户编号',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '收货人名字',
  `postal_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮编',
  `province_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '省名',
  `city_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '市名',
  `county_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '区名',
  `detail_info` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '详情地址',
  `tel_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '电话号码',
  `is_default` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '是否默认 1是0否',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户地址';

/*Data for the table `user_address` */

insert  into `user_address`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`user_id`,`user_name`,`postal_code`,`province_name`,`city_name`,`county_name`,`detail_info`,`tel_num`,`is_default`) values 
('1235079681763323906','1','0','2020-03-04 13:48:37','2020-03-04 13:48:37','1234102578637127681','张三',NULL,'广东省','广州市','海珠区','新港中路397号','18603652310','1'),
('1240893087862980610','1','0','2020-03-20 14:49:01','2020-03-20 14:49:01','1240826736922284033','空的时候',NULL,'江苏省','南京市','六合区','摸着自己的身体不舒服','18569685123','1'),
('1240923427939762177','1','0','2020-03-20 16:49:35','2020-03-20 16:49:35','1240923176084389889','磁力链接',NULL,'北京市','北京市','东城区','旅游鞋','18569856855','1');

/*Table structure for table `user_collect` */

DROP TABLE IF EXISTS `user_collect`;

CREATE TABLE `user_collect` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `type` char(2) NOT NULL COMMENT '类型1、商品',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户编号',
  `relation_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关联ID：商品类型为商品ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_type_user_relation` (`type`,`user_id`,`relation_id`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户收藏';

/*Data for the table `user_collect` */

insert  into `user_collect`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`type`,`user_id`,`relation_id`) values 
('1245704546265624578','1','0','2020-04-02 21:28:02','2020-04-02 21:28:02','1','1240923176084389889','6545a6fc2927edc195b93982f446917c'),
('1245704581845905409','1','0','2020-04-02 21:28:11','2020-04-02 21:28:11','1','1240923176084389889','2835671ff031c18cb181b1a199f86b01'),
('1245988045329559554','1','0','2020-04-03 16:14:34','2020-04-03 16:14:34','1','1240923176084389889','4d06c5157cce971b89166e509cdf63e8'),
('1247146453567025153','1','0','2020-04-06 20:57:40','2020-04-06 20:57:40','1','1234102578637127681','6545a6fc2927edc195b93982f446917c');

/*Table structure for table `user_info` */

DROP TABLE IF EXISTS `user_info`;

CREATE TABLE `user_info` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属租户',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `user_code` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户编码',
  `app_type` char(2) NOT NULL COMMENT '来源应用类型1、小程序；2、公众号',
  `app_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '来源应用id',
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机号码',
  `user_grade` smallint(6) DEFAULT '0' COMMENT '用户等级（0：普通用户，1：普通会员）',
  `points_current` int(11) DEFAULT '0' COMMENT '当前积分',
  `nick_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '昵称',
  `sex` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '性别（1：男，2：女，0：未知）',
  `headimg_url` varchar(1000) DEFAULT NULL COMMENT '头像',
  `city` varchar(64) DEFAULT NULL COMMENT '所在城市',
  `country` varchar(64) DEFAULT NULL COMMENT '所在国家',
  `province` varchar(64) DEFAULT NULL COMMENT '所在省份',
  PRIMARY KEY (`id`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE,
  KEY `vip_code` (`user_code`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商城用户';

/*Data for the table `user_info` */

insert  into `user_info`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`user_code`,`app_type`,`app_id`,`phone`,`user_grade`,`points_current`,`nick_name`,`sex`,`headimg_url`,`city`,`country`,`province`) values 
('1234102578637127681','1','0','2020-03-01 21:05:57','2020-03-01 21:05:57',110,'1','wxd5b98bbec200013b',NULL,1,38620,'JL','1','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','深圳','中国','广东'),
('1240826736922284033','1','0','2020-03-20 10:25:22','2020-03-20 10:25:22',111,'1','wxd5b98bbec200013b',NULL,1,16200,'JooLun','1','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLWNvwtdDIKNiahOicVFYJzQCY3ppdfvCDL6d9C0dRMYybEJDDJQuj1ibqLNp1ic5XVaPwW9IeZq1L44A/132','长沙','中国','湖南'),
('1240923176084389889','1','0','2020-03-20 16:48:35','2020-03-20 16:48:35',112,'1','wxd5b98bbec200013b',NULL,1,14200,'安安晨晨','2','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','益阳','中国','湖南'),
('1247865792188411905','1','0','2020-04-08 20:36:03','2020-04-08 20:36:03',113,'1','wxd5b98bbec200013b',NULL,1,3100,'liufeng','2','https://wx.qlogo.cn/mmopen/vi_32/icbS7icm2jxy0PDYMjOUfKiaMn5UVxYrNcTcv3ey0vxRTia24BTFQxfZbM4Kia0TwJbVyWBd9tvic8HmXXCickux7L6ibg/132','益阳','中国','湖南');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
