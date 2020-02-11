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
('1216178093615439873','1','0','2020-01-12 10:00:27','2020-01-12 10:00:27',NULL,'1216178045288669185','1216178093489610754','c9dd5a13672d3c7606d141c0efe29571',234.56,'JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132'),
('1216340497494138882','1','0','2020-01-12 20:45:47','2020-01-12 20:45:47',NULL,'1216178045288669185','1216178093489610754','1216178230869843969',221.40,'JooLun','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLWNvwtdDIKNiahOicVFYJzQCY3ppdfvCDL6d9C0dRMYybEJDDJQuj1ibqLNp1ic5XVaPwW9IeZq1L44A/132'),
('1b39b6e4bffa477b44165c842d045ae7','1','0','2020-01-09 16:40:12','2020-01-09 16:40:12',NULL,'a434f008fceca0b3f72e6da138606af8','16ba2bb8ae11284a9526f23e3163e2c0','8d7dd5bf2b35090a9f3d8646ffb520c5',126.36,'JooLun','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLWNvwtdDIKNiahOicVFYJzQCY3ppdfvCDL6d9C0dRMYybEJDDJQuj1ibqLNp1ic5XVaPwW9IeZq1L44A/132'),
('27581a8a671739abaf212669f894521a','1','0','2020-01-09 16:39:40','2020-01-09 16:39:40',NULL,'a434f008fceca0b3f72e6da138606af8','16ba2bb8ae11284a9526f23e3163e2c0','c9dd5a13672d3c7606d141c0efe29571',1778.63,'JL','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132');

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
('1216178045288669185','1','0','2020-01-12 10:00:16','2020-01-12 10:00:16',NULL,3,'1','2835671ff031c18cb181b1a199f86b01','10f415b0cd746ebf764acc3a6a4d13a2','6666','2020-01-11 00:00:00','2020-02-29 00:00:00',200.00,'1','1',1,250.00,200.00,'https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/291e0557-16d2-458a-92e2-a34d82919ffc.jpg','995555','666'),
('a434f008fceca0b3f72e6da138606af8','1','0','2020-01-09 16:39:10','2020-01-09 16:39:10',NULL,6,'1','2835671ff031c18cb181b1a199f86b01','106c4dc9184da01ce15e26f4256560d4','777656555566','2020-01-08 00:00:00','2020-02-29 00:00:00',0.01,'1','1',7,2000.00,1000.00,'https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/8cdb474d-ac76-49e9-b80c-9663ef9dc95a.png','eryeryreyreyrey','666666666666666'),
('ac030ad766034854678e08355aa467a5','1','0','2020-01-05 11:50:39','2020-01-05 12:27:03',NULL,2,'1','2835671ff031c18cb181b1a199f86b01','954060498a28ba885c504d9e9234a009','哭啦啦啦啦','2020-01-05 00:00:00','2020-01-07 00:00:00',5.00,'1','0',36,1500.00,1000.00,'http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190826115920.png','阴阳怪气的小臭气的啊大纲','哭啦啦啦啦'),
('bb5fa7ae1638087614eab99600faf51f','1','0','2020-01-05 11:42:05','2020-01-05 12:27:04',NULL,1,'1','2835671ff031c18cb181b1a199f86b01','106c4dc9184da01ce15e26f4256560d4','快来帮我砍价吧','2020-01-05 00:00:00','2020-01-06 00:00:00',0.00,'1','0',7,1500.00,1000.00,'http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190826115920.png','砍价需要先授权关注公众号，祝你砍价成功，抱得最佳礼品','呵呵'),
('f7570137ba536cbb6e46aabbd8282e50','1','0','2020-01-05 12:31:37','2020-01-05 12:31:37',NULL,3,'1','2b48a2f35352a4d87d51d6dd03bb874e','965bac3dbc101b6abe68b72469118f03','好几款了','2020-01-01 00:00:00','2020-01-03 00:00:00',0.00,'1','1',67,400.00,300.00,'http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg','分段函数环境让他加让他加','好几款了');

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

insert  into `coupon_goods`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`coupon_id`,`spu_id`) values 
('2477a1b83cabcd5de1e8cd38c0898b63','1','0','2020-01-05 19:37:41','2020-01-05 19:37:41',NULL,'8ac22b99e8737f0c8e4dd74ea5fcebd6','87ec583e2883cbd2fd259f47ece0fe15'),
('3660f4781b8fe4fbeb46941a2c920bbe','1','0','2020-01-05 19:37:41','2020-01-05 19:37:41',NULL,'8ac22b99e8737f0c8e4dd74ea5fcebd6','2b48a2f35352a4d87d51d6dd03bb874e'),
('5ef06507754d97f9ade41c21c6e474a6','1','0','2020-01-05 19:37:41','2020-01-05 19:37:41',NULL,'8ac22b99e8737f0c8e4dd74ea5fcebd6','2835671ff031c18cb181b1a199f86b01'),
('6912740764bba0a6352ad74aa10db40e','1','0','2020-01-08 22:01:30','2020-01-08 22:01:30',NULL,'9e93315d90f6323f6811740832779516','2835671ff031c18cb181b1a199f86b01'),
('ca72f7533cc6116c3af60a98ae529a39','1','0','2020-01-05 19:37:41','2020-01-05 19:37:41',NULL,'8ac22b99e8737f0c8e4dd74ea5fcebd6','6545a6fc2927edc195b93982f446917c');

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
('16636f2b80ecfe67e75bff510bfbf2da','1','0','2019-12-14 16:45:59','2019-12-28 20:13:09',NULL,1,'订单满100减5元','1',100.00,'2',30,5.00,NULL,1,'2019-12-11 00:00:00','2020-01-31 00:00:00','1','','1',41),
('8ac22b99e8737f0c8e4dd74ea5fcebd6','1','0','2019-12-14 16:46:53','2019-12-26 21:12:10',NULL,2,'8折券','2',100.00,'1',53,NULL,8.9,7,'2019-12-02 00:00:00','2020-01-23 00:00:00','2','','1',44),
('ba6182e7e7f4f54628f574fd90a3c470','1','0','2019-12-28 20:48:17','2019-12-28 20:48:17',NULL,5,'订单满200减15元','1',200.00,'2',19,15.00,NULL,NULL,'2019-12-24 00:00:00','2020-01-31 00:00:00','1',NULL,'1',5);

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
  PRIMARY KEY (`id`,`coupon_code`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE,
  KEY `ids_user` (`user_id`),
  KEY `coupon_code` (`coupon_code`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='电子券用户记录';

/*Data for the table `coupon_user` */

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='发货地';

/*Data for the table `delivery_place` */

insert  into `delivery_place`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`place`) values 
('1226515772106289154','1','0','2020-02-09 22:38:42','2020-02-09 22:38:42',NULL,'广东深圳'),
('1226515817257971713','1','0','2020-02-09 22:38:53','2020-02-09 22:38:53',NULL,'湖南长沙'),
('1226515909281001473','1','0','2020-02-09 22:39:14','2020-02-09 22:39:14',NULL,'江苏南京');

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
('1226548871431151617','1','0','2020-02-10 00:50:13','2020-02-10 00:50:13',NULL,'1226531861997522946','4d06c5157cce971b89166e509cdf63e8'),
('1226548871435345921','1','0','2020-02-10 00:50:13','2020-02-10 00:50:13',NULL,'1226531618484621314','4d06c5157cce971b89166e509cdf63e8'),
('1226797167420624898','1','0','2020-02-10 17:16:52','2020-02-10 17:16:52',NULL,'1226531861997522946','2b48a2f35352a4d87d51d6dd03bb874e');

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
('013090a5c1c42f11e8b427474019b9a0','1','2019-09-24 14:30:58','2019-09-24 15:35:30','0','876b7d66fef43fafb91df56570ac5191','788513a689a88ebd78c297574d4a2c26','db2355c836d46016e7b2eb41146291ee','undefined?','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','6545a6fc2927edc195b93982f446917c','5002eafdeca30f4c590b3288de5fa217',NULL,'128G，4G全网通，亮黑色',4,4,5,'顶下促膝长谈和手遥的顶下促膝长谈和手遥的顶下促膝长谈和手遥的顶下促膝长谈和手遥的顶下促膝长谈和手遥的顶下促膝长谈和手遥的顶下促膝长谈和手遥的顶下促膝长谈和手遥的顶下促膝长谈和手遥的顶下促膝长谈和手遥的顶下促膝长谈和手遥的顶下促膝长谈和手遥的','sdgasdgas夺 有扔有仍脸授信佣兵谣?额我热有','2019-09-25 11:50:50'),
('0ccd8cdfae9d554c895cb2c8b90c4606','1','2019-09-26 22:54:21','2019-09-26 22:54:21','0','6abfaf58a35a58807d1acaf96e321c18','b350cb7a1b81567401d91b46d7f5e46d','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','1b46c10d275262533b352329cc6d3af0','5a0a1c24928af80a732cd179faac2d58',NULL,'官方标配，欧若拉银',5,5,5,'这冰箱好冰呀，箱子也蛮大。不错不错，看着就能发财','感谢您的支持，您的支持是我们卖产品的动力，有你在的每一天我都觉得自己如花季少女般的闪亮耀眼，如果有一天我发现我老了，产品卖不动了，那肯定你已经离我而去，爱你如初恋，我的客户，祝您发大财，发了财再来买冰箱','2019-09-26 11:08:55'),
('2aec076e1df5dc445aa99113212df5da','1','2019-09-26 23:25:30','2019-09-26 23:25:30','0','e9497016faa3b937590e814ad0f9cf34','ebe33583232de06302c252cd5852d34d','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','ff39bc8f64b1d9b524b28c6000af8191','55a7d46eb9893cab480c70378d4dcefa',NULL,NULL,4,4,4,'为了追你，姑娘我一天一台冰箱，只为了每天见到你，你愿意和我一起卖冰箱吗，以后冷藏是你，冰冻也是你','只要负了钱，我都是你的','2019-09-26 11:36:39'),
('2ff679c066a9c51cdcf324a4d1dd00a3','1','2019-09-26 14:53:53','2019-09-26 14:53:53','0','2db258cd6704269cda038772b525e2df','d4bf104d03dbc1b6e51e137dbcd8add0','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','ff39bc8f64b1d9b524b28c6000af8191','55a7d46eb9893cab480c70378d4dcefa',NULL,NULL,5,5,5,'送货上门的，物流很快，搬起来很小心，没有损坏，冰箱挺好看的，尺寸跟我们家刚刚好，高大上，喜欢','为您服务是小的荣幸，这个尺寸就是为您量身打造的，感谢您的肯定，爱你么么哒','2019-09-26 11:27:03'),
('3b6288c6b9497c1569c1f722927cb773','1','2019-09-24 12:19:25','2019-09-25 22:50:22','0','ec8f3afc835ce71d213e77b28eda389f','8ff7d1557ca8bdfbd1fe73374be563e3','db2355c836d46016e7b2eb41146291ee',NULL,NULL,'43768c89b11316e1edf56c2fd56f7751','f3273ea5922fcdbf67c03eac71f28900',NULL,'官方标配',3,4,5,'sg本人人复合肥特容易爱你的有脸','sdgds酥松有签名用我答 ag???????','2019-09-25 22:50:19'),
('62b375cf6c9106a22a177b06bd7a8182','1','2019-09-26 23:23:01','2019-09-26 23:23:01','0','5d8ae3ab3f93cbf2d58af7afa32a8833','04b396c51aadbe88823ccf50870f2176','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','ff39bc8f64b1d9b524b28c6000af8191','55a7d46eb9893cab480c70378d4dcefa',NULL,NULL,5,5,5,'那个姑娘很喜欢你，买了冰箱麻烦帅哥送货上门',NULL,NULL),
('696bcd4b729bc1f2e9235b71e603e7b8','1','2019-09-26 15:02:08','2019-09-26 15:02:08','0','4a56db8916471bc20cab4aad67049134','ef8a7e4633d821e0086e38b8d562c559','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','ff39bc8f64b1d9b524b28c6000af8191','55a7d46eb9893cab480c70378d4dcefa',NULL,NULL,4,5,4,'收到很惊喜哦，颜色很漂亮，里面空间大','您的评价也同样让我惊喜哦','2019-09-26 11:25:52'),
('6cc3b667b6aba83079e666a4c7e00df9','1','2019-09-27 16:24:49','2019-09-27 16:24:49','0','c46b00a554a130e32181703d96fe3bac','22c6604298a9c165a82360753fd52a05','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','ff3d6dd5a37ff42e2b67b87bd12d1d01','2467663a7b6432b726d5205088445559',NULL,'星光金',5,5,5,'一看就知道高端大气有逼格，与众不同的你配与众不同的我，我的冰箱我做主，爱你么么哒? ',NULL,NULL),
('6fa6acda4fcbb6d4b3a77921713863d0','1','2019-11-11 23:38:32','2019-11-11 23:38:32','0','9da85ae06bd72bc02d7287b08ae15f14','1ee6b0e818223ba91bd5c09184ac6777','db2355c836d46016e7b2eb41146291ee','undefined?','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','4d06c5157cce971b89166e509cdf63e8','894b591741d425ca9c1b1579ce299a5b',NULL,'裸机',5,4,5,NULL,NULL,NULL),
('94ea7c75f3dc48549fca02ef4dc18576','1','2019-09-26 22:29:19','2019-09-26 22:29:19','0','53ccf04b952e1980342bf1778e5b998a','b19dcde4a09eefaf5dfe3a4609d5e284','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','ff39bc8f64b1d9b524b28c6000af8191','55a7d46eb9893cab480c70378d4dcefa',NULL,NULL,5,5,5,'空间大，声音小，还不','还不咋地啦，冰箱不冰了？空气不新鲜了？保鲜不持久了？','2019-09-26 11:12:53'),
('b3f5346cdbec183fa66d7c1a17822193','1','2019-09-24 12:14:14','2019-09-24 12:15:03','0','237342b610874be926fe1820e8b392dd','66e3ffe108bb3496188a79b1cf0ed552','db2355c836d46016e7b2eb41146291ee',NULL,NULL,'6545a6fc2927edc195b93982f446917c','5002eafdeca30f4c590b3288de5fa217',NULL,'128G，4G全网通，亮黑色',2,3,5,NULL,'d d d d ','2019-09-25 11:58:23'),
('c454a8cd496dbc9f267c9862665954c1','1','2019-09-26 23:27:35','2019-09-26 23:27:35','0','66c5b8ee5fc03ded38110f49c9c064fd','20e75d5d7e3f511120147bd36eaa4edb','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','ff39bc8f64b1d9b524b28c6000af8191','55a7d46eb9893cab480c70378d4dcefa',NULL,NULL,5,5,5,'有一台冰箱让我一见钟情说的就是你，你愿意跟我回家吗','我愿意我愿意我愿意','2019-09-26 11:36:14'),
('c4a6513b3bc6b107ce9440549e7a7460','1','2019-09-26 22:36:49','2019-09-26 22:36:49','0','5f1e9a65663da6450e73d623152ac806','49543b3455c55e69f7a51a9259e97f31','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','ff39bc8f64b1d9b524b28c6000af8191','55a7d46eb9893cab480c70378d4dcefa',NULL,NULL,4,4,5,'曾经有一份真挚的爱情摆在我面前。我没有珍惜，如果重来一次。我会对她说一句，爱你一万年。','曾经的你是真正善良美丽的你，那时候你只在我家买冰箱，后来你遇见了这样那样更低的价格，被他们吸引住了，但是我依然是我，是那个爱你如初的我，我相信你会发现我的好，我们家的冰箱肯定是最适合你的，我也爱你一万年','2019-09-26 11:11:26'),
('c762e1b03c759397cc17916da8f70620','1','2019-09-24 12:19:25','2019-09-24 12:19:25','0','ec8f3afc835ce71d213e77b28eda389f','e867a279af2cfe8c3e8169dd8daf4eaf','db2355c836d46016e7b2eb41146291ee',NULL,NULL,'6545a6fc2927edc195b93982f446917c','5002eafdeca30f4c590b3288de5fa217',NULL,'128G，4G全网通，亮黑色',5,4,5,NULL,'楕仍成都理工噶山豆根苛副作用丁苯三茶杯犬维特企业夏雨来','2019-09-25 10:54:05'),
('e7be4c2e818e00f23b6f9b1d996cd27c','1','2019-09-27 16:17:38','2019-09-27 16:17:38','0','6899afc86eac357fd8671f6ce5175c25','2483285ff19803729d49eee7e056a511','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','1b46c10d275262533b352329cc6d3af0','5a0a1c24928af80a732cd179faac2d58',NULL,'官方标配，欧若拉银',4,4,5,'你呀你。改怎么说你好呢，太早来到我身边，以至于我把你遗忘了几天，只怪物流太给力，只怪你太想来我家，以后我给你供电，你帮我冷藏',NULL,NULL),
('e918db3418a9302e4e3ce6e761eb9a29','1','2019-09-27 16:20:50','2019-09-27 16:20:50','0','bea0b0bacc1905c24b16550d809e7ddb','cf8e6ba07e940d7deced1ec27c1d3c35','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','43768c89b11316e1edf56c2fd56f7751','f3273ea5922fcdbf67c03eac71f28900',NULL,'官方标配',5,5,5,'真喜欢你呀，以后我负责美，你负责拍，不着急，我们慢慢来，现在你镜头里只有我一个人，以后将会会两个人，三个人，一家人，我的幸福生活在你眼里也在你心里，合作愉快小可爱',NULL,NULL),
('ec5666ee6d1ece031d88303891e2fe5e','1','2019-11-11 23:38:32','2019-11-11 23:38:32','0','9da85ae06bd72bc02d7287b08ae15f14','f6f291e26d443d611994d8f58ee3e659','db2355c836d46016e7b2eb41146291ee','undefined?','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','ff39bc8f64b1d9b524b28c6000af8191','55a7d46eb9893cab480c70378d4dcefa',NULL,NULL,4,4,4,NULL,NULL,NULL),
('eedab35b451f4ce70c83994b662e35de','1','2019-09-27 17:04:18','2019-09-27 17:04:18','0','347167130f8d0c96bec85e385beaccfc','6e513ee250f71892f58a0ad1e5ffc465','478d05c0ceb1bb61dcb4f658d7700511','安安晨晨','https://wx.qlogo.cn/mmopen/vi_32/AwUmcUqcSemYAA1x0yAmvjtBIEh4GgxcrgwTGAQDAqRS7nmcia9OtOK8Q4onSubDYkqiazz8aUVuXcB16DTna7oQ/132','4d06c5157cce971b89166e509cdf63e8','84d7a885ce5ef3d692d92c6a81dd9f45',NULL,NULL,5,5,5,'Joolun微信快速开发框架， 拥有单独的商城模块，方便拆分拓展。专业商品规格sku算法，前后端直观展示。订单、物流实时跟踪、商品各类管理、用户订单评价、购物车、收货地址、用户收藏等等基本商城功能全包含。后期会不断新增功能和模块',NULL,NULL),
('fdd70b4a7910e996102830d7ae88a91a','1','2019-11-11 23:20:17','2019-11-11 23:20:17','0','14144c785656ca143fb21c413570cf44','6666f2868b8c922a6aa8ac408646fc24','db2355c836d46016e7b2eb41146291ee','undefined?','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','4d06c5157cce971b89166e509cdf63e8','894b591741d425ca9c1b1579ce299a5b',NULL,'裸机',5,4,5,NULL,'weg酉人自然人签名欠','2019-11-11 11:21:31');

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
('106c4dc9184da01ce15e26f4256560d4','2020-01-04 22:23:58','2020-01-04 22:23:58','1',NULL,'2835671ff031c18cb181b1a199f86b01','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',1905.00,NULL,NULL,5,0.00,0.00,'1','0'),
('10f415b0cd746ebf764acc3a6a4d13a2','2020-01-04 22:23:58','2020-01-04 22:23:58','1',NULL,'2835671ff031c18cb181b1a199f86b01','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',2400.00,NULL,NULL,8,0.00,0.00,'1','0'),
('25382fd4bb10ff4ca5b9000262e7b0e4','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('278357f4667ba6677c9936e33b94bfdd','2019-09-27 16:55:23','2019-11-12 11:27:40','1',NULL,'6545a6fc2927edc195b93982f446917c','',5488.00,0.00,0.00,55,0.00,0.00,'1','0'),
('2ab787084884a7169d5dd2b7a259c9cc','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('2db22126dc5c251de13064fe12ebfb62','2020-02-09 22:48:57','2020-02-09 22:48:57','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',3599.00,NULL,NULL,7,0.00,0.00,'1','0'),
('3c56e0951df15b44cfc121cf61c33829','2019-09-27 16:55:23','2019-11-12 11:27:40','1',NULL,'6545a6fc2927edc195b93982f446917c','',4988.00,0.00,0.00,55,0.00,0.00,'1','0'),
('401c62d0a62226e6209728629645677d','2020-02-09 22:48:57','2020-02-09 22:48:57','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',3599.00,NULL,NULL,8,0.00,0.00,'1','0'),
('416ab6fc443778d2a9fc5e7f4a9b0e00','2020-01-04 22:23:58','2020-01-04 22:23:58','1',NULL,'2835671ff031c18cb181b1a199f86b01','',2599.00,NULL,NULL,71,0.00,0.00,'1','0'),
('445e36a6969f8ad3d50189ae93ffb648','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1560.00,NULL,NULL,5,0.00,0.00,'1','0'),
('4bdae99ee87f891eba5ed92fefd6398e','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('5002eafdeca30f4c590b3288de5fa217','2019-09-27 16:55:23','2019-11-12 11:27:40','1',NULL,'6545a6fc2927edc195b93982f446917c','',4988.00,0.00,0.00,92,0.00,0.00,'1','0'),
('5033e1f2bfa07231d1c2045392fa2f93','2020-01-04 22:23:58','2020-01-04 22:23:58','1',NULL,'2835671ff031c18cb181b1a199f86b01','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',2000.00,NULL,NULL,5,0.00,0.00,'1','0'),
('51ff5da47a14e61e32f01f06261fbb8a','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1508.00,NULL,NULL,5,0.00,0.00,'1','0'),
('5a61a7876305b760efa8abe04b912a8b','2020-01-04 22:23:58','2020-01-04 22:23:58','1',NULL,'2835671ff031c18cb181b1a199f86b01','',2700.00,NULL,NULL,4,0.00,0.00,'1','0'),
('7cee91d08568afe4f8c2a7651f52be8b','2020-02-10 00:50:13','2020-02-10 00:50:13','1',NULL,'4d06c5157cce971b89166e509cdf63e8','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',100.00,888.00,NULL,107,4.00,3.00,'1','0'),
('7d194deff8da58f84a6fea43c0aaba6d','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('7feea846da4bfd3e2dc1c5c41184cd40','2019-09-27 16:55:23','2019-11-12 11:27:40','1',NULL,'6545a6fc2927edc195b93982f446917c','',5488.00,0.00,0.00,66,0.00,0.00,'1','0'),
('81f6520c7fd6a07c2085ed477401adc6','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('8558b4f72eb78580e251f7b50351ba2f','2020-02-09 22:48:57','2020-02-09 22:48:57','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',2799.00,NULL,NULL,8,0.00,0.00,'1','0'),
('894b591741d425ca9c1b1579ce299a5b','2020-02-10 00:50:13','2020-02-10 00:50:13','1',NULL,'4d06c5157cce971b89166e509cdf63e8','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',0.01,666.00,NULL,75,2.00,5.00,'1','0'),
('8b3d9b08b33081b231e75ef5f0bf3705','2020-01-04 22:23:58','2020-01-04 22:23:58','1',NULL,'2835671ff031c18cb181b1a199f86b01','',1999.00,NULL,NULL,8,0.00,0.00,'1','0'),
('9211ed74de18ec2d044377163ba6ad90','2020-02-09 22:48:57','2020-02-09 22:48:57','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',3599.00,NULL,NULL,8,0.00,0.00,'1','0'),
('954060498a28ba885c504d9e9234a009','2020-01-04 22:23:58','2020-01-04 22:23:58','1',NULL,'2835671ff031c18cb181b1a199f86b01','',2600.00,NULL,NULL,6,0.00,0.00,'1','0'),
('965bac3dbc101b6abe68b72469118f03','2019-12-28 21:38:26','2019-12-28 21:38:26','1',NULL,'2b48a2f35352a4d87d51d6dd03bb874e','',600.00,0.00,0.00,90,0.00,0.00,'1','0'),
('a1c72bd9cd274406fbd8ee212f7fb583','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1500.00,NULL,NULL,5,0.00,0.00,'1','0'),
('a93e101a5923bf5924a24353f9a93f62','2019-12-16 20:59:16','2019-12-25 12:45:31','872f46d167f7428c8e9e252c17997fb5',NULL,'b13822de6c8ecddc06c167de4c054aeb','',8888.00,66666.00,555.00,5555,0.00,0.00,'1','0'),
('b139d9185833c938e4340e3a181b245a','2020-01-04 22:23:58','2020-01-04 22:23:58','1',NULL,'2835671ff031c18cb181b1a199f86b01','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',2000.00,NULL,NULL,7,0.00,0.00,'1','0'),
('c43134d412ab15a0075a31d2b35f0838','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1200.00,NULL,NULL,5,0.00,0.00,'1','0'),
('df566ba8600b4305606b87fe523a87f4','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1100.00,NULL,NULL,5,0.00,0.00,'1','0'),
('e632fe2bf818837ec0f05903568a1c59','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1200.00,NULL,NULL,5,0.00,0.00,'1','0'),
('eca0bf5189ba8192ccf5fc615970ea9d','2019-09-27 16:55:23','2019-11-12 11:27:40','1',NULL,'6545a6fc2927edc195b93982f446917c','',4988.00,0.00,0.00,87,0.00,0.00,'1','0'),
('eea55f1c4ad3b9eb305c8b357c8fb46a','2020-02-09 22:48:57','2020-02-09 22:48:57','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',2799.00,NULL,NULL,5,0.00,0.00,'1','0'),
('f1e8f2b7de163c57cfd8920bd200a110','2019-08-24 00:45:48','2019-12-25 12:45:31','1',NULL,'','',1500.00,NULL,NULL,5,0.00,0.00,'1','0'),
('f3b7f08030e448c0aaca6895e65aa5e9','2019-09-27 16:55:23','2019-11-12 11:27:40','1',NULL,'6545a6fc2927edc195b93982f446917c','',5488.00,0.00,0.00,7,0.00,0.00,'1','0'),
('f42bda1c9215a878fd49360a7576c913','2020-02-09 22:48:57','2020-02-09 22:48:57','1',NULL,'87ec583e2883cbd2fd259f47ece0fe15','',2799.00,NULL,NULL,7,0.00,0.00,'1','0'),
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
('050484658d1caf3c21e2ec5dd3c5ca04','1','6545a6fc2927edc195b93982f446917c','5002eafdeca30f4c590b3288de5fa217','cba677f619061b9c326c15d8eceeb31e','2019-09-27 16:55:23',NULL),
('05557e5066b72908658c80fc5863e492','1','2835671ff031c18cb181b1a199f86b01','10f415b0cd746ebf764acc3a6a4d13a2','5','2020-01-04 22:23:58',NULL),
('1226518352727351298','1','87ec583e2883cbd2fd259f47ece0fe15','8558b4f72eb78580e251f7b50351ba2f','e0b840a51e251badb5606d5ce1faa695','2020-02-09 22:48:57',NULL),
('1226518352735739906','1','87ec583e2883cbd2fd259f47ece0fe15','8558b4f72eb78580e251f7b50351ba2f','ed144c2c87660ead15b4784ed8df5d63','2020-02-09 22:48:57',NULL),
('1226518352735739907','1','87ec583e2883cbd2fd259f47ece0fe15','8558b4f72eb78580e251f7b50351ba2f','694d1ae3ffb4d03111a5b901cf1e1a8a','2020-02-09 22:48:57',NULL),
('1226518352735739908','1','87ec583e2883cbd2fd259f47ece0fe15','9211ed74de18ec2d044377163ba6ad90','e0b840a51e251badb5606d5ce1faa695','2020-02-09 22:48:57',NULL),
('1226518352735739909','1','87ec583e2883cbd2fd259f47ece0fe15','9211ed74de18ec2d044377163ba6ad90','ed144c2c87660ead15b4784ed8df5d63','2020-02-09 22:48:57',NULL),
('1226518352744128514','1','87ec583e2883cbd2fd259f47ece0fe15','9211ed74de18ec2d044377163ba6ad90','da0b3c06d18c677984f1b37655aa4505','2020-02-09 22:48:57',NULL),
('1226518352744128515','1','87ec583e2883cbd2fd259f47ece0fe15','f42bda1c9215a878fd49360a7576c913','e0b840a51e251badb5606d5ce1faa695','2020-02-09 22:48:57',NULL),
('1226518352744128516','1','87ec583e2883cbd2fd259f47ece0fe15','f42bda1c9215a878fd49360a7576c913','62de70420a9be05b6fbcf3e1c818e0de','2020-02-09 22:48:57',NULL),
('1226518352744128517','1','87ec583e2883cbd2fd259f47ece0fe15','f42bda1c9215a878fd49360a7576c913','694d1ae3ffb4d03111a5b901cf1e1a8a','2020-02-09 22:48:57',NULL),
('1226518352744128518','1','87ec583e2883cbd2fd259f47ece0fe15','2db22126dc5c251de13064fe12ebfb62','e0b840a51e251badb5606d5ce1faa695','2020-02-09 22:48:57',NULL),
('1226518352744128519','1','87ec583e2883cbd2fd259f47ece0fe15','2db22126dc5c251de13064fe12ebfb62','62de70420a9be05b6fbcf3e1c818e0de','2020-02-09 22:48:57',NULL),
('1226518352744128520','1','87ec583e2883cbd2fd259f47ece0fe15','2db22126dc5c251de13064fe12ebfb62','da0b3c06d18c677984f1b37655aa4505','2020-02-09 22:48:57',NULL),
('1226518352752517122','1','87ec583e2883cbd2fd259f47ece0fe15','eea55f1c4ad3b9eb305c8b357c8fb46a','e0b840a51e251badb5606d5ce1faa695','2020-02-09 22:48:57',NULL),
('1226518352752517123','1','87ec583e2883cbd2fd259f47ece0fe15','eea55f1c4ad3b9eb305c8b357c8fb46a','63fc0234dc4ebcc9553ab576b36167d2','2020-02-09 22:48:57',NULL),
('1226518352752517124','1','87ec583e2883cbd2fd259f47ece0fe15','eea55f1c4ad3b9eb305c8b357c8fb46a','694d1ae3ffb4d03111a5b901cf1e1a8a','2020-02-09 22:48:57',NULL),
('1226518352752517125','1','87ec583e2883cbd2fd259f47ece0fe15','401c62d0a62226e6209728629645677d','e0b840a51e251badb5606d5ce1faa695','2020-02-09 22:48:57',NULL),
('1226518352752517126','1','87ec583e2883cbd2fd259f47ece0fe15','401c62d0a62226e6209728629645677d','63fc0234dc4ebcc9553ab576b36167d2','2020-02-09 22:48:57',NULL),
('1226518352752517127','1','87ec583e2883cbd2fd259f47ece0fe15','401c62d0a62226e6209728629645677d','da0b3c06d18c677984f1b37655aa4505','2020-02-09 22:48:57',NULL),
('1226548871405985793','1','4d06c5157cce971b89166e509cdf63e8','7cee91d08568afe4f8c2a7651f52be8b','69ca24903aa6261ea946ef37d88db23f','2020-02-10 00:50:13',NULL),
('1226548871405985794','1','4d06c5157cce971b89166e509cdf63e8','894b591741d425ca9c1b1579ce299a5b','414571f4d40c91b2be1d5039341fb080','2020-02-10 00:50:13',NULL),
('16de946e90dbb3d9ffbf26fa31d72c45','1','2835671ff031c18cb181b1a199f86b01','8b3d9b08b33081b231e75ef5f0bf3705','5','2020-01-04 22:23:58',NULL),
('1eb7260d55a9269c06bd3fafc5ee9616','1','6545a6fc2927edc195b93982f446917c','7feea846da4bfd3e2dc1c5c41184cd40','da0b3c06d18c677984f1b37655aa4505','2019-09-27 16:55:23',NULL),
('22e62c6248d2ba577b15220dd23e22a3','1','6545a6fc2927edc195b93982f446917c','3c56e0951df15b44cfc121cf61c33829','cba677f619061b9c326c15d8eceeb31e','2019-09-27 16:55:23',NULL),
('23d70c62868c6007f52e244728c13903','1','2835671ff031c18cb181b1a199f86b01','8b3d9b08b33081b231e75ef5f0bf3705','958aad754214368594a38428bc09defd','2020-01-04 22:23:58',NULL),
('257c9920abdf14b7bafe2d1f8d1ee41f','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','25382fd4bb10ff4ca5b9000262e7b0e4','25a8724edc2ecf4fc295bf72f2faf923','2019-12-16 20:59:16',NULL),
('26c0c164e420ed7bdd15a38471f16aa7','1','6545a6fc2927edc195b93982f446917c','278357f4667ba6677c9936e33b94bfdd','da0b3c06d18c677984f1b37655aa4505','2019-09-27 16:55:23',NULL),
('2ebd98621da4744bd6b200976b242d8c','1','6545a6fc2927edc195b93982f446917c','5002eafdeca30f4c590b3288de5fa217','f53488c6a79e795ba288d1279a5f98e7','2019-09-27 16:55:23',NULL),
('343e142fd6f4e02cca0b5dfee1982099','1','2835671ff031c18cb181b1a199f86b01','b139d9185833c938e4340e3a181b245a','5','2020-01-04 22:23:58',NULL),
('35a565f4adb80e8e96f3ba91421fbd9d','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','4bdae99ee87f891eba5ed92fefd6398e','fd82720178bbf4e198bf689f28b6d072','2019-12-16 20:59:16',NULL),
('3eb4e81f760d07bf67ab85a8a6de4129','1','6545a6fc2927edc195b93982f446917c','f3b7f08030e448c0aaca6895e65aa5e9','cba677f619061b9c326c15d8eceeb31e','2019-09-27 16:55:23',NULL),
('3fa04cc5eee99a5a67361139a6bc710a','1','6545a6fc2927edc195b93982f446917c','f3b7f08030e448c0aaca6895e65aa5e9','da0b3c06d18c677984f1b37655aa4505','2019-09-27 16:55:23',NULL),
('48c63476857168f0cd17949deec14364','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','7d194deff8da58f84a6fea43c0aaba6d','fd82720178bbf4e198bf689f28b6d072','2019-12-16 20:59:16',NULL),
('4c778b28778a7c0a7ca4fcd1c8d155a0','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','a93e101a5923bf5924a24353f9a93f62','25a8724edc2ecf4fc295bf72f2faf923','2019-12-16 20:59:16',NULL),
('4f49467f16d8e8aa755fab182f7bf4e4','1','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','5','2020-01-04 22:23:58',NULL),
('59dd867c851cb59360b47e2d259acadb','1','2835671ff031c18cb181b1a199f86b01','106c4dc9184da01ce15e26f4256560d4','e14c2a907231c2bd0d484a9cdc1fb557','2020-01-04 22:23:58',NULL),
('5aea40edb83937a460b9ac4cdbd8a9da','1','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','958aad754214368594a38428bc09defd','2020-01-04 22:23:58',NULL),
('65dbc3a197236b4fa1bcefad192282aa','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','4bdae99ee87f891eba5ed92fefd6398e','1d7f73d660f51ed9737614eb7b0041c6','2019-12-16 20:59:16',NULL),
('6d3fac1e1c5072be66282469174d2237','1','2835671ff031c18cb181b1a199f86b01','416ab6fc443778d2a9fc5e7f4a9b0e00','1','2020-01-04 22:23:58',NULL),
('76948b2e46f81442719b4d10f700481f','1','2835671ff031c18cb181b1a199f86b01','954060498a28ba885c504d9e9234a009','1','2020-01-04 22:23:58',NULL),
('77fc777c77553dba9cdd026666b1c3ff','1','2835671ff031c18cb181b1a199f86b01','106c4dc9184da01ce15e26f4256560d4','4','2020-01-04 22:23:58',NULL),
('7b5911b2d0f6eead097166cbefc0ee26','1','6545a6fc2927edc195b93982f446917c','f3b7f08030e448c0aaca6895e65aa5e9','f53488c6a79e795ba288d1279a5f98e7','2019-09-27 16:55:23',NULL),
('7baf7b19ac8fc36a901fd308576ef656','1','2835671ff031c18cb181b1a199f86b01','10f415b0cd746ebf764acc3a6a4d13a2','1','2020-01-04 22:23:58',NULL),
('8972e1eaa462add5231fcf7fc53808cc','1','6545a6fc2927edc195b93982f446917c','278357f4667ba6677c9936e33b94bfdd','cba677f619061b9c326c15d8eceeb31e','2019-09-27 16:55:23',NULL),
('90491af766a6bf510a80feda7d38730b','1','2835671ff031c18cb181b1a199f86b01','b139d9185833c938e4340e3a181b245a','2','2020-01-04 22:23:58',NULL),
('910993ee19b4c953797922564510fc13','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','81f6520c7fd6a07c2085ed477401adc6','25a8724edc2ecf4fc295bf72f2faf923','2019-12-16 20:59:16',NULL),
('9855a91f7c26c22b9b7862ba15908bb4','1','6545a6fc2927edc195b93982f446917c','eca0bf5189ba8192ccf5fc615970ea9d','694d1ae3ffb4d03111a5b901cf1e1a8a','2019-09-27 16:55:23',NULL),
('a556f98fa8fb71eb0b143b5d2fff0f1b','1','6545a6fc2927edc195b93982f446917c','7feea846da4bfd3e2dc1c5c41184cd40','cba677f619061b9c326c15d8eceeb31e','2019-09-27 16:55:23',NULL),
('ae43f1b1f0002090b9c928a8f82bb794','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','2ab787084884a7169d5dd2b7a259c9cc','204fa96e649cc9333aa903d4b53d0f36','2019-12-16 20:59:16',NULL),
('b19c7d1a84c3763ab9517eeae5ff91c2','1','2835671ff031c18cb181b1a199f86b01','8b3d9b08b33081b231e75ef5f0bf3705','2','2020-01-04 22:23:58',NULL),
('b257ea41c20750443ec0956541eb87ce','1','6545a6fc2927edc195b93982f446917c','278357f4667ba6677c9936e33b94bfdd','63fc0234dc4ebcc9553ab576b36167d2','2019-09-27 16:55:23',NULL),
('b34543c50b3f1121bc461d63a67be069','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','81f6520c7fd6a07c2085ed477401adc6','204fa96e649cc9333aa903d4b53d0f36','2019-12-16 20:59:16',NULL),
('b78a786e06645332b2aa6876215cba22','1','2835671ff031c18cb181b1a199f86b01','5a61a7876305b760efa8abe04b912a8b','e14c2a907231c2bd0d484a9cdc1fb557','2020-01-04 22:23:58',NULL),
('bc3772c38c4c672586889e380723576c','1','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','4','2020-01-04 22:23:58',NULL),
('bedb1b587a6cabe4b8069f1559e1a412','1','2835671ff031c18cb181b1a199f86b01','954060498a28ba885c504d9e9234a009','4','2020-01-04 22:23:58',NULL),
('c723d6dc83faeed195153e4bf7ba13dc','1','6545a6fc2927edc195b93982f446917c','3c56e0951df15b44cfc121cf61c33829','63fc0234dc4ebcc9553ab576b36167d2','2019-09-27 16:55:23',NULL),
('cb2210b229ea4ec14f351f5b8b4b6c51','1','2835671ff031c18cb181b1a199f86b01','5a61a7876305b760efa8abe04b912a8b','1','2020-01-04 22:23:58',NULL),
('cbc64d0b89c11f68e618ee62bc67a8aa','1','2835671ff031c18cb181b1a199f86b01','b139d9185833c938e4340e3a181b245a','e14c2a907231c2bd0d484a9cdc1fb557','2020-01-04 22:23:58',NULL),
('cbdec7418fce48acc5483f7dc2bafb86','1','6545a6fc2927edc195b93982f446917c','eca0bf5189ba8192ccf5fc615970ea9d','b8b3ece7283992f1c42826542eb98a43','2019-09-27 16:55:23',NULL),
('ccc2cd0a3edcf4d9fa3147b3b7fc4ea7','1','2835671ff031c18cb181b1a199f86b01','5a61a7876305b760efa8abe04b912a8b','4','2020-01-04 22:23:58',NULL),
('cd7514dd95c8a7ba5c5e15b379bbcdbf','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','2ab787084884a7169d5dd2b7a259c9cc','fd82720178bbf4e198bf689f28b6d072','2019-12-16 20:59:16',NULL),
('d3c9dbfaf4fbd1174167be539e91a454','1','6545a6fc2927edc195b93982f446917c','3c56e0951df15b44cfc121cf61c33829','694d1ae3ffb4d03111a5b901cf1e1a8a','2019-09-27 16:55:23',NULL),
('d67bf84deaac9c85cd8d6b53a0daacb2','1','6545a6fc2927edc195b93982f446917c','7feea846da4bfd3e2dc1c5c41184cd40','b8b3ece7283992f1c42826542eb98a43','2019-09-27 16:55:23',NULL),
('d856a208e914b72b632a4be00f960ee4','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','25382fd4bb10ff4ca5b9000262e7b0e4','1d7f73d660f51ed9737614eb7b0041c6','2019-12-16 20:59:16',NULL),
('db7c58cd5320fab23965f7c186c5c48a','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','a93e101a5923bf5924a24353f9a93f62','690315b4e8a0642a465167ed93063f9c','2019-12-16 20:59:16',NULL),
('e655c2bd0c5ed1196df46b92cbcb5e53','1','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','2','2020-01-04 22:23:58',NULL),
('ed382b1dbfbba7c52b0191a3d63085dc','1','6545a6fc2927edc195b93982f446917c','5002eafdeca30f4c590b3288de5fa217','694d1ae3ffb4d03111a5b901cf1e1a8a','2019-09-27 16:55:23',NULL),
('ee5ed7c95ed26378b5d374cec82b3d51','1','6545a6fc2927edc195b93982f446917c','eca0bf5189ba8192ccf5fc615970ea9d','cba677f619061b9c326c15d8eceeb31e','2019-09-27 16:55:23',NULL),
('f007dc6252e1bf6c9b732376fe454405','1','2835671ff031c18cb181b1a199f86b01','10f415b0cd746ebf764acc3a6a4d13a2','e14c2a907231c2bd0d484a9cdc1fb557','2020-01-04 22:23:58',NULL),
('f47d2173f7069cefbb4e49d54a9be9b1','1','2835671ff031c18cb181b1a199f86b01','5033e1f2bfa07231d1c2045392fa2f93','958aad754214368594a38428bc09defd','2020-01-04 22:23:58',NULL),
('f8c86f44a2589aaa41feb6115a0bb5e5','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','7d194deff8da58f84a6fea43c0aaba6d','690315b4e8a0642a465167ed93063f9c','2019-12-16 20:59:16',NULL),
('fb08fa1678eac76dab51ee5a34fb674d','1','2835671ff031c18cb181b1a199f86b01','106c4dc9184da01ce15e26f4256560d4','2','2020-01-04 22:23:58',NULL),
('fee1d5bfd579118e25b3f1dd8ba9631c','1','2835671ff031c18cb181b1a199f86b01','954060498a28ba885c504d9e9234a009','958aad754214368594a38428bc09defd','2020-01-04 22:23:58',NULL);

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
  `freight_templat_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '运费模板ID',
  `delivery_place_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '发货地ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='spu表';

/*Data for the table `goods_spu` */

insert  into `goods_spu`(`id`,`tenant_id`,`spu_code`,`name`,`sell_point`,`description`,`category_first`,`category_second`,`pic_urls`,`shelf`,`sort`,`price_down`,`price_up`,`sale_num`,`create_time`,`update_time`,`spec_type`,`del_flag`,`points_give_switch`,`points_give_num`,`points_deduct_switch`,`points_deduct_scale`,`points_deduct_amount`,`freight_templat_id`,`delivery_place_id`) values 
('2835671ff031c18cb181b1a199f86b01','1','57458568','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','限时优惠200，成交价2599！索尼4800万广角微距三摄，屏下指纹解锁！','<p><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01Ac8ERJ29zFjq0IN2y_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01VMOTzx29zFgQnngH0_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN018vpvKv29zFh3wew1f_!!1714128138.jpg\" class=\"fr-fic fr-dii\"></p><p><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01zj5VGR29zFgLLD7wC_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01KKow1v29zFgPlRcz1_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01YHoVHN29zFgJyP0jm_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01aYZWKp29zFgKlVh75_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01IbunXO29zFgLLDWuD_!!1714128138.jpg\" class=\"fr-fic fr-dii\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01o5fy2K29zFgLpRWa2_!!1714128138.jpg\" class=\"fr-fic fr-dii\"></p>','9bb404548cc6513c1c148b532b6db720','988f1af72652178159de1ec009ab8fb0','[\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg\"]','1',0,1905.00,2700.00,9,'2019-08-24 00:45:48','2019-12-25 14:31:59','1','0','1',1000,'1',50,0.10,'e2daad9554fc3206bab0ab4788840b42',NULL),
('2b48a2f35352a4d87d51d6dd03bb874e','1','956522','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro','','<p>658685<span style=\"color: rgb(230, 0, 0);\">88yyuoyo</span><img src=\"http://q54s9uxiz.bkt.clouddn.com/1/editor/d95547f8-0f57-46a6-a21b-47c54ab04843.jfif\"></p><p><br></p><p class=\"ql-align-center\">Powered by <a href=\"https://www.froala.com/wysiwyg-editor?pb=1\" rel=\"noopener noreferrer\" target=\"_blank\">Froala Editor</a></p>','9bb404548cc6513c1c148b532b6db720','862a74f109f7f14bcbfff1d5adf73cdc','[\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/58.jpg\"]','1',0,600.00,600.00,0,'2019-12-28 21:38:26','2019-12-28 21:38:26','0','0','0',NULL,'0',20,0.10,'e2daad9554fc3206bab0ab4788840b42','1226515772106289154'),
('4d06c5157cce971b89166e509cdf63e8','1','','小程序付款演示，不发货，不退款','付款流畅，方便快捷','<p><strong>产品参数：</strong></p><ul><li>证书编号：2019011606195595</li><li>证书状态：有效</li><li>申请人名称：华为技术有限公司</li><li>制造商名称：西可通信技术设备（河源）有限公司</li><li>产品名称：TD-LTE 无线数据终端</li><li>3C产品型号：SCM-AL09</li><li>产品名称：Huawei/华为 华为平板 M6...</li><li>品牌:&nbsp;Huawei/华为</li><li>型号:&nbsp;华为平板 M6 10.8英寸</li><li>内存容量:&nbsp;128GB&nbsp;64GB</li><li>存储容量:&nbsp;6+256GB&nbsp;64GB&nbsp;128GB</li><li>核心数:&nbsp;八核</li><li>触摸屏类型:&nbsp;电容十点触控</li><li>厂商</li><li><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i2/2711014365/O1CN01qrYdwN1i7DOBVwCBo_!!2711014365.jpg\"></span></li></ul>','d5a7b863c2759241ac571f5bc1b6239d','2239dfa1128dd7c88066040dc7dfa44a','[\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20190619223905.png\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/5.jpg\"]','1',0,0.01,100.00,50,'2019-09-27 16:58:56','2019-12-26 21:05:10','1','0','1',100,'1',50,0.10,'e2daad9554fc3206bab0ab4788840b42','1226515772106289154'),
('6545a6fc2927edc195b93982f446917c','1','','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','10倍光学变焦 官方正品','<p><a href=\"https://detail.tmall.com/item.htm?spm=a21ag.7623864.0.0.1b3d3ba5emmXaw&amp;id=598332699918&amp;sku_properties=10004:36095;5919063:6536025;12304035:677288068&amp;scene=taobao_shop\" target=\"_blank\" style=\"color: rgb(41, 83, 166);\"><img src=\"https://gdp.alicdn.com/imgextra/i1/686947088/O1CN01TI1uVG22ELrXhTvSM_!!686947088.jpg\"></a><a href=\"https://detail.tmall.com/item.htm?spm=a21ag.7623864.0.0.14953ba5vM5tUC&amp;id=594719496850&amp;sku_properties=10004:385316259;5919063:6536025&amp;scene=taobao_shop\" target=\"_blank\" style=\"color: rgb(41, 83, 166);\"><img src=\"https://gdp.alicdn.com/imgextra/i1/686947088/O1CN01ZpgKun22ELrCoGxjb_!!686947088.jpg\"></a></p><p><img src=\"https://img.alicdn.com/imgextra/i2/686947088/O1CN01DLaQEi22ELrweWGjM_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN01iyjovP22ELqELmRn4_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01LcL89h22ELqCkrMzC_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01EGKfOh22ELqHdZNNA_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01tQaVEe22ELqDzORWv_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01pPpZO122ELqFikhfq_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN015rUfW422ELqELmmbb_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN012o5kwi22ELqCkqlbF_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN01EcuhWk22ELqELmNgr_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN01Am5ynR22ELq7MXDsS_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01vDIfhL22ELq7MWcRx_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i3/686947088/O1CN01A87agX22ELqGKyU5q_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i3/686947088/O1CN016sgogg22ELqEeejw8_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/686947088/O1CN01dTZ7qp22ELqCkr2Hx_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01G71mhe22ELqDzPNk4_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN0141QGol22ELqBt5bkT_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01555TaH22ELq7MW14H_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/686947088/O1CN01nh176Z22ELqFU3HYX_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/686947088/O1CN01otPMGD22ELqCkryUl_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/686947088/O1CN01FCMAtw22ELqFU4YYm_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/686947088/O1CN01uMuTeD22ELqEc1n7t_!!686947088.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/686947088/O1CN01fjPP8Y22ELqBt3jPF_!!686947088.jpg\"></p>','9bb404548cc6513c1c148b532b6db720','862a74f109f7f14bcbfff1d5adf73cdc','[\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/16.jpg\"]','1',0,4988.00,5488.00,464,'2019-08-26 14:37:45','2019-12-25 14:32:04','1','0','0',NULL,'0',NULL,NULL,'e2daad9554fc3206bab0ab4788840b42',NULL),
('87ec583e2883cbd2fd259f47ece0fe15','1','','可优惠900/送壕礼/Huawei/华为 Nova 4中移动手机正品官方旗舰店新款青春版3i2s 3e 32plus 4e 5高配版Pro','最高优惠900/全国联保/再送壕礼！','<p><a href=\"https://pages.tmall.com/wow/a/act/ju/dailygroup/165/wupr?wh_pid=daily-162671\" target=\"_blank\" style=\"color: rgb(51, 85, 170);\"><img src=\"https://img.alicdn.com/imgextra/i3/1776456424/O1CN01BuwjUK1xKEsjohG37_!!1776456424.jpg\"></a><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN01hjor4b1xKEslWIxDv_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN018hPVGP1xKEorbraLs_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01b5wdQ61xKEroGytUe_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN019q71Lm1xKEsZnF5ie_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01cu6iVy1xKEsSnTh4j_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN01Ao9iBe1xKEro8t36J_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i3/1776456424/O1CN01qprNEv1xKEsZyRPvC_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01WePTyw1xKErq70lQj_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN01yjG99b1xKEsWCXsiq_!!1776456424.jpg\"></span></p><p><span style=\"color: rgb(64, 64, 64);\"><img src=\"https://img.alicdn.com/imgextra/i4/1776456424/O1CN015HBfs11xKEoR25qqV_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/1776456424/O1CN01MO9oMd1xKEpK79BbJ_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i1/1776456424/O1CN01KSsv3u1xKEpNIadlG_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i3/1776456424/O1CN01zeuTlh1xKEpMc21z8_!!1776456424.jpg\"><img src=\"https://img.alicdn.com/imgextra/i2/1776456424/O1CN01Ru3j8T1xKEpMc3N8R_!!1776456424.jpg\"></span></p>','9bb404548cc6513c1c148b532b6db720','862a74f109f7f14bcbfff1d5adf73cdc','[\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/50.jpg\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/51.jpg\",\"http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/52.jpg\"]','1',0,2799.00,3599.00,67,'2019-08-26 14:48:33','2019-12-25 14:32:06','1','0','0',NULL,'0',5,1.00,'e2daad9554fc3206bab0ab4788840b42','1226515817257971713'),
('b13822de6c8ecddc06c167de4c054aeb','872f46d167f7428c8e9e252c17997fb5','','阿道夫','烦得很收到货房贷是','<p><img src=\"https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/872f46d167f7428c8e9e252c17997fb5/editor/2361ca4e-9e56-40b1-97ac-e5d6742f2b62.jpg\" style=\"width: 300px;\" class=\"fr-fic fr-dib\"></p><p data-f-id=\"pbf\" style=\"text-align: center; font-size: 14px; margin-top: 30px; opacity: 0.65; font-family: sans-serif;\">Powered by <a href=\"https://www.froala.com/wysiwyg-editor?pb=1\" title=\"Froala Editor\">Froala Editor</a></p>','235a1554567c92073b0ee1bc8c6772ca',NULL,'[\"https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/872f46d167f7428c8e9e252c17997fb5/material/b6ee51d3-60e3-4ea2-861f-e1a799f8746b.png\"]','1',0,8888.00,8888.00,999,'2019-12-16 20:59:16','2019-12-25 14:32:08','1','0','1',10,'1',30,0.10,'e2daad9554fc3206bab0ab4788840b42',NULL);

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
('1226518352706379778','1','87ec583e2883cbd2fd259f47ece0fe15','2','2020-02-09 22:48:57',NULL),
('1226518352718962690','1','87ec583e2883cbd2fd259f47ece0fe15','3','2020-02-09 22:48:57',NULL),
('1226518352718962691','1','87ec583e2883cbd2fd259f47ece0fe15','1','2020-02-09 22:48:57',NULL),
('1226548871385014273','1','4d06c5157cce971b89166e509cdf63e8','02c21865a7681cc77f9b7f60d48cf2a1','2020-02-10 00:50:13',NULL),
('4446477c1ef0c55c671675c798ce8d0e','1','6545a6fc2927edc195b93982f446917c','3','2019-09-27 16:55:23',NULL),
('465cbad4864a9bea035e23faa95ecd1e','1','6545a6fc2927edc195b93982f446917c','1','2019-09-27 16:55:23',NULL),
('951ebacbb53c3acf3547b45efce39df7','1','6545a6fc2927edc195b93982f446917c','7f3333f95900cf5fce3dc41ef93e46bc','2019-09-27 16:55:23',NULL),
('a4efc6367caa77dbf0c6938cd9aac91e','1','2835671ff031c18cb181b1a199f86b01','2','2020-01-04 22:23:58',NULL),
('afac75bf80d2d578e8e5175ed2a44852','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','2b2d479c89dfef05ea1e35386a3c4795','2019-12-16 20:59:16',NULL),
('bddb8cd08753feb5f0503f792eb228f9','1','2835671ff031c18cb181b1a199f86b01','3','2020-01-04 22:23:58',NULL),
('d509be14e45db6c956358e6c6f6b84c2','1','2835671ff031c18cb181b1a199f86b01','1','2020-01-04 22:23:58',NULL),
('e0d34a63c1e4e9e3bd2a6cc18d45dcb1','872f46d167f7428c8e9e252c17997fb5','b13822de6c8ecddc06c167de4c054aeb','a51fda1bb9fbfb0c3fdc16f988319185','2019-12-16 20:59:16',NULL);

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
('02a825aa19d9ed58ea3dbabbbb24aeb6','1','0','2019-11-01 17:24:22','2019-11-05 21:09:53','1','1',NULL,'QQ截图20190625164817.png','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/17.jpg'),
('05e598abb11205b206d826e5b928c57d','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:50:29','2019-11-11 22:50:29','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225845.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/d9d407a1-e044-4954-b1f1-707ad3f4e35c.png'),
('086dfabb2ea4593809432d273d0b0ea0','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:53:39','2019-11-11 22:53:39','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111230147.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/989d29a2-9b15-4b6b-962f-2adc9a4d7483.png'),
('0ed5e7cc4378c4d951a385da51dccfa5','f5c359e514a34617b27cef72dea646d5','0','2019-11-10 14:28:10','2019-11-10 14:28:10','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'11.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/68ae0f9b-4d1c-424d-8c2e-fdd807b6a27f.png'),
('0ee4a56d79e8cc0659156ccff02b1d33','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:28:19','2019-11-11 22:28:19','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111223612.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/22f4ca4f-9725-400b-ace4-5194d56268cb.png'),
('1','1','0','2019-10-30 16:01:44','2019-11-05 21:10:00','1','1','1','sagagasgf地','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/70.jpg'),
('11','1','0','2019-10-30 16:43:00','2019-11-05 21:14:44',NULL,'1','def6e4c80222c71bbc0993ac85bcb8ce','45646498498','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg'),
('12','1','0','2019-10-30 16:43:38','2019-11-05 21:10:14',NULL,'1','def6e4c80222c71bbc0993ac85bcb8ce','165165','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg'),
('13','1','0','2019-10-30 16:43:48','2019-11-05 21:14:24',NULL,'1','def6e4c80222c71bbc0993ac85bcb8ce','华为p30','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01R8Jql91mbDmjt4uXi_!!2201435294972.jpg'),
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
('90c47c161af99fa89920bba220689c44','1','0','2019-11-01 17:29:51','2019-11-05 21:11:12','1','1',NULL,'QQ图片20181022154030.gif','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7.jpg'),
('91eaf6fd5175391b6c59f1f05c3f3b1e','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:49:47','2019-11-11 22:49:47','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225756.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/f18f843b-0a41-4c31-af46-acc0a19a1393.png'),
('92976c48bacc52e52796ce469716df24','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:47:57','2019-11-11 22:47:57','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225606.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/b4a6c58f-31f9-4ee1-81e0-b6ec325ae221.png'),
('93b647266a6ab3b72871d3a5324ddffa','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:18:55','2019-11-11 22:18:55','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111222710.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/5bc59c17-244f-466c-90f2-bfe3ddab2957.png'),
('956896caccc6ab2ae0f79bfc98c877aa','f5c359e514a34617b27cef72dea646d5','0','2019-11-10 14:23:13','2019-11-10 14:23:13','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'微信截图_20191110143026.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/99ad9b24-8c61-44ae-bdf5-6d16d0e1f57a.png'),
('9e786f1d056578dca02b245a5c1dfc83','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:43:07','2019-11-11 22:43:07','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225122.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/0cd7bc42-dff3-43b2-a55a-7b4259225dcd.png'),
('a52b64fe9342765a567e553a7720fa3d','f5c359e514a34617b27cef72dea646d5','0','2019-11-10 14:25:07','2019-11-10 14:25:07','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'20190403152637496.jpg','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/1715a61f-ef75-474d-836f-6c5885b977dc.jpg'),
('a70b0ad998ef832eacfd114e067557c2','1','0','2019-11-01 17:30:00','2019-11-05 21:11:30','1','1',NULL,'QQ图片20180806102413.gif','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/6.jpg'),
('a8b2d938eb02aefc711a9d2bc0859e99','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:40:24','2019-11-11 22:40:24','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224839.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/94e1e5b9-e05c-4c1e-8242-1404d18de7d0.png'),
('ac47fc0ed9044211e28ba61a5c3b149f','1','0','2019-11-01 17:24:45','2019-11-05 21:11:35','1','1','19a4433a1b8c5e48e58bdb4db98abf3b','下载.png','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/5.jpg'),
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
('ea6df3613b101b5cc7e22d7fc879f736','1','0','2019-11-01 17:31:46','2020-02-10 20:11:01','1','1','1226720220971782145','QQ图片2018072708888883956.jpg','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/5.jpg'),
('efa3f224c92a0036014822b366e78522','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:52:00','2019-11-11 22:52:00','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111230013.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/ed25ae23-7390-4fd5-896d-d7f05052a5de.png'),
('f7709113226e18a01df0465fea2a57b9','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:41:27','2019-11-11 22:41:27','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111224942.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/1b4d0e1b-57bb-4aac-b794-4c7aa606b4e9.png'),
('f83dc89cb938ad3a37e55a8e1a273c3a','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:52:57','2019-11-11 22:52:57','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111230102.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/c05132e3-cef1-4fe8-808c-0b0eb7ce831a.png'),
('faad3cfb9c79e863f3c7f486476328a5','f5c359e514a34617b27cef72dea646d5','0','2019-11-11 22:46:14','2019-11-11 22:46:14','51aa2e8cea31663ac88695e6eaec735c','1',NULL,'QQ截图20191111225428.png','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/f5c359e514a34617b27cef72dea646d5/material/85fd8e12-c2ec-42c2-9a54-06427081a78e.png'),
('fc416ea0abf5b034abffe7b9ba214a12','1','0','2019-11-01 17:28:18','2019-11-05 21:13:10','1','1',NULL,'640.jpg','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/71.jpg');

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
  `payment_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付类型1、微信支付；2、支付宝支付',
  `is_pay` char(2) NOT NULL COMMENT '是否支付0、未支付 1、已支付',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '订单状态1、待发货 2、待收货 3、确认收货/已完成 5、已关闭',
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
  `order_type` char(2) DEFAULT '0' COMMENT '订单类型（0、普通订单；1、砍价订单）',
  `relation_id` varchar(32) DEFAULT NULL COMMENT '关联ID（砍价记录ID）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`,`order_no`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单';

/*Data for the table `order_info` */

insert  into `order_info`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`app_type`,`app_id`,`user_id`,`order_no`,`payment_way`,`payment_type`,`is_pay`,`status`,`appraises_status`,`freight_price`,`sales_price`,`payment_points_price`,`payment_coupon_price`,`payment_price`,`payment_points`,`payment_time`,`delivery_time`,`receiver_time`,`closing_time`,`user_message`,`logistics_id`,`transaction_id`,`order_type`,`relation_id`,`remark`) values 
('004b18fbcb8d7c7134030effe9408c55','1','0','2019-12-22 22:34:39','2019-12-22 22:34:39','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208757749479899136','2','1','0','5',NULL,0.00,100.00,0.00,8.69,50.00,500,NULL,NULL,NULL,NULL,NULL,'033bdaf4a231127bd3924cab56c01902',NULL,'0',NULL,NULL),
('03da2129901a6b05d884e89c48439e09','1','0','2019-12-10 19:54:44','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4a5e9b2f5812e571ae3da431f5fd02e3','1204368850674515968','2','1','0','5',NULL,0.00,10.00,0.00,0.00,5.00,5,NULL,NULL,NULL,NULL,NULL,'3d0afed287410d6b2a49753f795eaed1',NULL,'0',NULL,NULL),
('0454c03dc41b5de047b2f8d33c371646','1','0','2019-12-05 11:13:21','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1202425701500715008','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-12-05 11:13:28',NULL,NULL,NULL,NULL,'85f988c081f7284cc8e8e3a896882597','4200000471201912053667338702','0',NULL,NULL),
('08bf99cebd379b5b3c7f3b94d7233d5e','1','0','2019-12-10 17:12:46','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204328088641470464','2','1','0','5',NULL,0.00,300.00,0.00,0.00,270.00,3000,NULL,NULL,NULL,NULL,NULL,'193fbd99735020f8274a245dc382f65c',NULL,'0',NULL,NULL),
('0947d14da4abe73884f48c8fa785a5b7','1','0','2020-01-09 16:35:15','2020-01-09 16:35:15','1','wxd5b98bbec200013b','c9dd5a13672d3c7606d141c0efe29571','1215190283633819648','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,0,'2020-01-09 16:36:09',NULL,NULL,NULL,NULL,'fa30f89f6a1731be6fdb5c9b0517f45b','4200000520202001096071711495','0',NULL,NULL),
('0a48bd981415d0c147f1a2cf2f63b882','1','0','2019-09-22 21:36:54','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1175765920874758144','2','1','0','5',NULL,0.00,2999.00,0.00,0.00,2999.00,NULL,NULL,NULL,NULL,NULL,NULL,'414d802fd8a53e32664471ca3aff937f',NULL,'0',NULL,NULL),
('0b5d3836f5c6731345006f7ac70b3b1b','1','0','2019-12-10 15:38:45','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204304429109477376','2','1','0',NULL,NULL,0.00,150.00,0.00,0.00,135.00,1500,NULL,NULL,NULL,NULL,NULL,'0f7710cb03933b5c5b5b68ee32f3c0fd',NULL,'0',NULL,NULL),
('0ca5ef62ace5018a2c168b4a7929536f','1','0','2019-11-11 22:20:06','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1193896182187819008','2','1','0','5',NULL,0.00,0.01,0.00,0.00,0.01,NULL,NULL,NULL,NULL,NULL,NULL,'423f2fc45949303c919e0900d0c4bc5c',NULL,'0',NULL,NULL),
('0e920a987725e9cdae00b92ac1898785','1','0','2019-10-11 12:57:44','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182520634274480128','2','1','0','5',NULL,0.00,3999.00,0.00,0.00,3999.00,NULL,NULL,NULL,NULL,NULL,NULL,'725a7f71a3388646bc0d65b23c351314',NULL,'0',NULL,NULL),
('0ea55844e7a07ea042a425b16b0bb82d','1','0','2019-12-10 14:30:49','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204287330190360576','2','1','0','5',NULL,0.00,150.01,0.00,0.00,135.01,1500,NULL,NULL,NULL,NULL,NULL,'d3948d05b191e8c3eba2adb523a4f36e',NULL,'0',NULL,NULL),
('114a360651d2d2914a4b6a0fbb410d89','1','0','2019-12-25 13:36:35','2019-12-25 13:49:42','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1209709504615153664','2','1','1','5',NULL,5.00,0.03,0.00,0.00,5.03,0,'2019-12-25 13:37:05',NULL,NULL,NULL,NULL,'e84f451b5f84e90ead9665570728fa01','4200000471201912258459663087','0',NULL,NULL),
('1215643036660142082','1','0','2020-01-10 22:34:20','2020-01-10 22:34:20','1','wxd5b98bbec200013b','c9dd5a13672d3c7606d141c0efe29571','1215643036411756544','2','1','0','5',NULL,0.00,1905.00,0.00,209.55,1695.45,0,NULL,NULL,NULL,NULL,NULL,'8d105466300d35be18a4a04d1f8bbd01',NULL,'0',NULL,NULL),
('1215643229350662145','1','0','2020-01-10 22:35:06','2020-01-10 22:35:06','1','wxd5b98bbec200013b','c9dd5a13672d3c7606d141c0efe29571','1215643229211328512','2','1','0','5',NULL,0.00,2000.00,0.00,0.00,2000.00,0,NULL,NULL,NULL,NULL,NULL,'b5c8bd7947abb6a74499ee2d5125664c',NULL,'0',NULL,NULL),
('1215652314657718273','1','0','2020-01-10 23:11:12','2020-01-10 23:11:12','1','wxd5b98bbec200013b','c9dd5a13672d3c7606d141c0efe29571','1215652314493222912','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,0,'2020-01-10 23:11:19',NULL,NULL,NULL,NULL,'1215652314611580930','4200000520202001108009614964','0',NULL,NULL),
('1215652862719033346','1','0','2020-01-10 23:13:22','2020-01-10 23:13:22','1','wxd5b98bbec200013b','c9dd5a13672d3c7606d141c0efe29571','1215652862600675328','2','1','0','5',NULL,0.00,0.01,0.00,0.00,0.01,0,NULL,NULL,NULL,NULL,NULL,'1215652862672896002',NULL,'0',NULL,NULL),
('1215652895740788738','1','0','2020-01-10 23:13:30','2020-01-10 23:18:13','1','wxd5b98bbec200013b','c9dd5a13672d3c7606d141c0efe29571','1215652895647596544','2','1','1','5',NULL,0.00,0.01,0.00,0.00,0.01,0,'2020-01-10 23:13:37',NULL,NULL,NULL,NULL,'1215652895694651393','4200000502202001102291993943','0',NULL,NULL),
('121883467ada6b58ee4d85a228e2a673','1','0','2019-09-25 23:04:03','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1176875014138363904','2','1','0','5',NULL,0.00,597.00,0.00,0.00,597.00,NULL,NULL,NULL,NULL,NULL,NULL,'7d3ea7e16d4712eebd13b57c6764d14d',NULL,'0',NULL,NULL),
('1226746200524312578','1','0','2020-02-10 13:54:20','2020-02-10 13:54:20','1','wxd5b98bbec200013b','1216917231801151490','1226746200280006656','2','1','0','5',NULL,0.00,600.00,0.00,0.00,600.00,0,NULL,NULL,NULL,NULL,NULL,'1226746200490758146',NULL,'0',NULL,NULL),
('1226746303205068802','1','0','2020-02-10 13:54:45','2020-02-10 13:54:45','1','wxd5b98bbec200013b','1216917231801151490','1226746303103369216','2','1','0','5',NULL,0.00,5488.00,0.00,0.00,5488.00,0,NULL,NULL,NULL,NULL,NULL,'1226746303188291585',NULL,'0',NULL,NULL),
('1226748004116975617','1','0','2020-02-10 14:01:30','2020-02-10 14:01:30','1','wxd5b98bbec200013b','1216917231801151490','1226748004053024768','2','1','0','5',NULL,0.00,600.00,0.00,0.00,600.00,0,NULL,NULL,NULL,NULL,NULL,'1226748004104392706',NULL,'0',NULL,NULL),
('12431271a31fb138248e25c6c7b4dfb3','1','0','2019-11-10 13:29:04','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1193400155437531136','2','1','0','5',NULL,0.00,0.08,0.00,0.00,0.08,NULL,NULL,NULL,NULL,NULL,NULL,'04adb4d12812a25405c9156d6a0d01cd',NULL,'0',NULL,NULL),
('137a26bd00848c7547bcaaa65362727f','1','0','2020-01-09 16:40:29','2020-01-09 16:40:29','1','wxd5b98bbec200013b','c9dd5a13672d3c7606d141c0efe29571','1215191599126937600','2','1','1','1',NULL,0.00,1905.00,0.00,0.00,0.01,0,'2020-01-09 16:40:41',NULL,NULL,NULL,NULL,'1dce903847d3436e2425f154e94a7afd','4200000504202001090274640704','1','16ba2bb8ae11284a9526f23e3163e2c0',NULL),
('13945a4ba51a5516d9e3820394a5fe7e','1','0','2019-11-11 22:35:13','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1193899988648722432','2','1','0','5',NULL,0.00,0.01,0.00,0.00,0.01,NULL,NULL,NULL,NULL,NULL,NULL,'b1c4412ea562908c9fc43bee4d646785',NULL,'0',NULL,NULL),
('139d6d1839bacfa8fa9576b0301e46dc','1','0','2020-01-05 11:53:42','2020-01-05 11:53:42','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1213669878439870464','2','1','0','5',NULL,0.00,2600.00,0.00,0.00,1121.17,0,NULL,NULL,NULL,NULL,NULL,'e0af1e662dcb95dbe277e1909c06aef4',NULL,'1','740ab617f9f5054458fe03def0cac1b6',NULL),
('13ea5eab17fe3aea4117185d5f5e5bd3','1','0','2019-12-10 14:11:26','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204282453544402944','2','1','0','5',NULL,0.00,150.00,0.00,0.00,135.00,NULL,NULL,NULL,NULL,NULL,NULL,'17b92f7973f7378eae3edf9d4ecf790f',NULL,'0',NULL,NULL),
('14144c785656ca143fb21c413570cf44','1','0','2019-11-11 22:41:46','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1193901637245075456','2','1','1','3','1',0.00,0.01,0.00,0.00,0.01,NULL,'2019-11-11 22:42:14','2019-11-11 22:44:55','2019-11-11 23:16:25','2019-11-11 23:20:17',NULL,'9749a895fa5765146d5dfb455bb182b7','4200000460201911113234863352','0',NULL,NULL),
('146f0f91681bbda8551b7ff6a3c7f109','1','0','2019-12-22 23:23:29','2019-12-22 23:23:29','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208770038866116608','2','1','0','5',NULL,0.00,100.00,0.00,11.00,34.00,500,NULL,NULL,NULL,NULL,NULL,'5b7990c23c340cd586babb0c5c8f6287',NULL,'0',NULL,NULL),
('149561ccfe412569cdfb2eeace97d271','1','0','2019-12-25 14:21:05','2019-12-25 14:21:05','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1209720699950727168','2','1','0','5',NULL,5.00,100.00,0.00,10.00,95.00,0,NULL,NULL,NULL,NULL,NULL,'2775c5bab49bdeb488ca870b4b7c6202',NULL,'0',NULL,NULL),
('14d5547124b3b332241f6ee98581b497','1','0','2019-12-11 18:15:15','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1204706202131365888','2','1','0','5',NULL,0.00,25.00,0.00,0.00,13.00,12,NULL,NULL,NULL,NULL,NULL,'8e0708e38c0d1a9e1673f5a437d13412',NULL,'0',NULL,NULL),
('15151114044e407985cd9ae3c998a990','1','0','2019-12-22 23:21:19','2019-12-22 23:21:19','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208769493107474432','2','1','0','5',NULL,0.00,100.00,0.00,11.00,89.00,0,NULL,NULL,NULL,NULL,NULL,'f6d956c3f4fee766212391b66ffb1bcf',NULL,'0',NULL,NULL),
('17d415c706ba9c3367acc07cb8fc47e3','1','0','2019-10-11 12:55:58','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182520193155334144','2','1','0','5',NULL,0.00,2999.00,0.00,0.00,2999.00,NULL,NULL,NULL,NULL,NULL,NULL,'6a57365da50553760fc8be6b26c722fc',NULL,'0',NULL,NULL),
('18a84e4489b94308feac66e9b47e43b5','1','0','2019-12-10 19:13:37','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4a5e9b2f5812e571ae3da431f5fd02e3','1204358499283238912','2','1','0','5',NULL,0.00,300.01,0.00,0.00,270.01,3000,NULL,NULL,NULL,NULL,NULL,'53e529332944b6057dc6d6cd83918e14',NULL,'0',NULL,NULL),
('18ab28b4b5fde38271dbc129815892fe','1','0','2019-11-19 11:04:51','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1196625355218092032','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-11-19 11:04:58',NULL,NULL,NULL,NULL,'af689beb4451c54914ccd0ca00e26f52','4200000465201911196201403290','0',NULL,NULL),
('19ad9bf03dbd5f99dae47e8da1bda3ac','1','0','2019-11-12 09:41:32','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1194067668689223680','2','1','1','3','0',0.00,0.01,0.00,0.00,0.01,NULL,'2019-11-12 09:42:36','2019-11-12 09:43:45','2019-11-14 11:06:26',NULL,NULL,'088a5f037fc9603b7888b3fc4f6efd63','4200000455201911125804711332','0',NULL,NULL),
('1a35de6cfe2c67a5043a636030be8d4d','1','0','2019-09-24 08:44:14','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1176296245820391424','2','1','1','1',NULL,0.00,0.10,0.00,0.00,0.10,NULL,'2019-09-24 08:44:38',NULL,NULL,NULL,NULL,'9ca92fd0fdc75be1c0f9b35d7cc68b26',NULL,'0',NULL,NULL),
('1c17cbd0a96738abb10cef21ba5dbcde','1','0','2019-12-22 23:25:58','2019-12-22 23:25:58','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208770663737720832','2','1','0','5',NULL,0.00,100.00,0.00,5.00,29.00,500,NULL,NULL,NULL,NULL,NULL,'69766bdd9998cc5e7d7887dd531c2a60',NULL,'0',NULL,NULL),
('1ed7692628cd8bed4b9d73150cb36f8d','1','0','2020-01-04 21:16:15','2020-01-04 21:16:15','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1213449058375434240','2','1','0','5',NULL,0.00,3599.00,0.00,0.00,3215.58,0,NULL,NULL,NULL,NULL,NULL,'cb5278cba777a023a01c5c5bb2955bc0',NULL,'0',NULL,NULL),
('1f6e883c5dcb764eaa819263ec429199','1','0','2019-12-22 19:39:55','2019-12-22 19:39:55','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208713775067168768','2','1','0','5',NULL,0.00,2999.00,0.00,5.00,2999.00,0,NULL,NULL,NULL,NULL,NULL,'8770de8cb44ed6875f852e916e3e3dc4',NULL,'0',NULL,NULL),
('20f1e119ead6c2142828a75dbb72df69','1','0','2019-12-22 23:19:35','2019-12-22 23:19:35','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208769055712870400','2','1','0','5',NULL,0.00,100.00,0.00,11.00,23.00,500,NULL,NULL,NULL,NULL,NULL,'946ab609f7ce1e6729a47542d5a55b95',NULL,'0',NULL,NULL),
('2267ca8b3a956564ce73c3c3c962fb5e','1','0','2019-12-25 14:25:47','2019-12-25 14:25:47','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1209721883939831808','2','1','0','5',NULL,10.00,100.01,50.00,0.00,60.01,500,NULL,NULL,NULL,NULL,NULL,'ff89411d13130c489efee960a33ac50c',NULL,'0',NULL,NULL),
('22cc5376b98e18057a2ac550d352f072','1','0','2019-12-10 19:25:50','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4a5e9b2f5812e571ae3da431f5fd02e3','1204361577541664768','2','1','0','5',NULL,0.00,10.00,0.00,0.00,5.00,5,NULL,NULL,NULL,NULL,NULL,'01aafa7795e594e6da088563644fa85c',NULL,'0',NULL,NULL),
('232772db16accb556beadcc9a1e2e246','1','0','2019-12-09 14:40:05','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1203927278560477184','2','1','0','5',NULL,0.00,150.00,0.00,0.00,150.00,NULL,NULL,NULL,NULL,NULL,NULL,'fa7ae098ddafedc87808f13f2f15ac63',NULL,'0',NULL,NULL),
('237342b610874be926fe1820e8b392dd','1','0','2019-09-22 18:10:35','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1175713999484878848','2','1','1','3','1',0.00,0.01,0.00,0.00,0.01,NULL,'2019-09-22 18:11:20',NULL,NULL,NULL,NULL,'f10ecbf99adc7f192d928c301df23603',NULL,'0',NULL,NULL),
('24b90b86b137d579080a0123f01c3f60','1','0','2020-01-04 21:58:04','2020-01-04 21:58:04','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1213459585768095744','2','1','0','5',NULL,0.00,2599.00,0.00,0.00,2000.00,0,NULL,NULL,NULL,NULL,NULL,'d223a2bdb24e51b227dacc9fcbe3def5',NULL,'1','35226e5473099cdd8540a4bb19a7fd82',NULL),
('259aafab134d094d9125e7169c917671','1','0','2019-12-11 17:55:08','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1204701138759188480','2','1','0','5',NULL,0.00,15.00,0.00,0.00,15.00,0,NULL,NULL,NULL,NULL,NULL,'f281ffe6cbc4e2ccb7e1e6afbc8aa734',NULL,'0',NULL,NULL),
('25f5f07e6f7c92e8a8adacd5e035f53f','1','0','2019-11-16 22:15:22','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1195706932950728704','2','1','0','5',NULL,0.00,0.08,0.00,0.00,0.08,NULL,NULL,NULL,NULL,NULL,NULL,'700641e037b1a008ac3dc23109fac6d2',NULL,'0',NULL,NULL),
('292d832901abd331ae9aac33ce038dc6','1','0','2019-12-22 19:36:58','2019-12-22 19:36:58','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208713034265001984','2','1','0','5',NULL,0.00,5607.67,0.00,10.00,5597.67,0,NULL,NULL,NULL,NULL,NULL,'dc3575bb285015a218c52c163f87937f',NULL,'0',NULL,NULL),
('2cab62434e22f1706f3aad9169c14ce2','1','0','2019-12-22 22:34:25','2019-12-22 22:34:25','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208757690436681728','2','1','0','5',NULL,0.00,100.00,0.00,10.00,40.00,500,NULL,NULL,NULL,NULL,NULL,'f7aad003699aff5b699b9ed766d4452d',NULL,'0',NULL,NULL),
('2d614bb632b1c339561831552dc58078','1','0','2019-12-22 22:57:40','2019-12-22 22:57:40','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208763540433797120','2','1','0','5',NULL,0.00,100.00,0.00,11.00,39.00,500,NULL,NULL,NULL,NULL,NULL,'eb29960dd62de08d0253204da184d63c',NULL,'0',NULL,NULL),
('2db258cd6704269cda038772b525e2df','1','0','2019-09-26 14:50:03','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177113082040680448','2','1','1','3','1',0.00,0.10,0.00,0.00,0.10,NULL,'2019-09-26 14:50:13','2019-09-26 14:51:43','2019-09-26 14:52:08','2019-09-26 14:53:53',NULL,'0392add5633b13656062661854cb82c4','4200000403201909265484729890','0',NULL,NULL),
('2f72d8a30cc34a67462e11cc4f1535ae','1','0','2019-12-13 21:20:49','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1205477677293633536','2','1','1','5',NULL,0.00,0.01,0.00,0.00,0.01,0,'2019-12-13 21:21:06',NULL,NULL,NULL,NULL,'eb56dca213a8f345e9a4a671089465a3','4200000458201912137115648543','0',NULL,NULL),
('30d56fb3b36fa5cf78d30911c3d01754','1','0','2019-10-11 12:48:29','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182518309505990656','2','1','0','5',NULL,0.00,3999.00,0.00,0.00,3999.00,NULL,NULL,NULL,NULL,NULL,NULL,'98b7cf1c64e1883ae12dfacde0f668db',NULL,'0',NULL,NULL),
('31010048f676dd75d4165fa2993f38a6','1','0','2019-12-13 22:32:12','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205495641921290240','2','1','0',NULL,NULL,0.00,10.56,0.00,0.00,10.56,0,NULL,NULL,NULL,NULL,NULL,'507e78d1ece09add0100ae93099f63e6',NULL,'0',NULL,NULL),
('321f9e8cadbdbe6ce644a96879bea224','1','0','2019-09-24 20:12:17','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1176469399712825344','2','1','0','5',NULL,0.00,10387.00,0.00,0.00,10387.00,NULL,NULL,NULL,NULL,NULL,NULL,'bda4aefbc94348baad3747ef7a8493e6',NULL,'0',NULL,NULL),
('325146f0590a09785e52cd44eec24734','1','0','2019-12-13 22:26:32','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205494212854808576','2','1','0','5',NULL,0.00,10.56,0.00,0.00,5.56,5,NULL,NULL,NULL,NULL,NULL,'166dd2a253dd7152739b613b5994cade',NULL,'0',NULL,NULL),
('33644c8e4f806e5cdf8f9e9ba40fe575','1','0','2019-10-11 13:33:51','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182529726095294464','2','1','0','5',NULL,0.00,3999.00,0.00,0.00,3999.00,NULL,NULL,NULL,NULL,NULL,NULL,'e57288ba2b2cd94ffab299b5094fec50',NULL,'0',NULL,NULL),
('3423b6fec86fd7285f160f6f00b63815','1','0','2019-12-10 18:38:33','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204349677592379392','2','1','0',NULL,NULL,0.00,150.00,0.00,0.00,150.00,0,NULL,NULL,NULL,NULL,NULL,'1abc50d24b3e24aa2d27630ad3412912',NULL,'0',NULL,NULL),
('347167130f8d0c96bec85e385beaccfc','1','0','2019-09-27 17:01:45','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177508614043074560','2','1','1','3','1',0.00,0.20,0.00,0.00,0.20,NULL,'2019-09-27 17:01:53','2019-09-27 17:02:27','2019-09-27 17:02:35','2019-09-27 17:04:19',NULL,'f1527e94bc85171579ee279b9b14be8f','4200000405201909277838634350','0',NULL,NULL),
('34f9011949e5fc242123b282a662bc88','1','0','2019-12-10 14:16:19','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204283682248982528','2','1','0','5',NULL,0.00,150.00,0.00,0.00,135.00,1500,NULL,NULL,NULL,NULL,NULL,'0bbd833a181db8c05cff2a6ec43b9380',NULL,'0',NULL,NULL),
('35eeb0bd7d52bb8fff640b8c41b1b937','1','0','2019-12-10 19:53:51','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4a5e9b2f5812e571ae3da431f5fd02e3','1204368628028276736','2','1','0','5',NULL,0.00,10.00,0.00,0.00,5.00,5,NULL,NULL,NULL,NULL,NULL,'0a3d2e83f0a20541134e59e62c0f56be',NULL,'0',NULL,NULL),
('365cf8107b5d5ae9a07281831ca84611','1','0','2019-12-08 19:32:02','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1203638360942313472','2','1','1','5',NULL,0.00,0.02,0.00,0.00,0.02,NULL,'2019-12-08 19:32:18',NULL,NULL,NULL,NULL,'86d72e3f6b5fc4b74a063ca577561f69','4200000454201912080589721297','0',NULL,NULL),
('38818cc1a309b327516e14bc46f9157a','1','0','2019-12-10 18:47:58','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204352047197978624','2','1','0','5',NULL,0.00,150.00,0.00,0.00,150.00,0,NULL,NULL,NULL,NULL,NULL,'818d8e029e55be8897ee4d1097da1ea5',NULL,'0',NULL,NULL),
('3a5b1e9174b9e255202a5ec96c54434d','1','0','2019-12-10 19:26:54','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4a5e9b2f5812e571ae3da431f5fd02e3','1204361844735606784','2','1','1','5',NULL,0.00,10.02,0.00,0.00,5.02,5,'2019-12-10 19:27:10',NULL,NULL,NULL,NULL,'31ac318d4cd1e881c74c9044e6081f9d','4200000471201912109594520497','0',NULL,NULL),
('3af235b52fe58571d5fda0b9e2f207eb','1','0','2019-12-25 13:07:52','2019-12-25 13:07:52','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1209702274117402624','2','1','0','5',NULL,0.00,2599.00,0.00,0.00,2599.00,0,NULL,NULL,NULL,NULL,NULL,'94f20b6398cee0589a6c4b3b4827ccdb',NULL,'0',NULL,NULL),
('3bfdc1097f6894c076cd0ced1e8e441c','1','0','2019-12-10 19:54:35','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4a5e9b2f5812e571ae3da431f5fd02e3','1204368810396614656','2','1','0','5',NULL,0.00,10.00,0.00,0.00,10.00,0,NULL,NULL,NULL,NULL,NULL,'e6665794d9a45e34f4010ec55a64bde6',NULL,'0',NULL,NULL),
('3d0f7116d9778fa411820982e695583a','1','0','2019-12-07 21:15:13','2019-12-22 20:26:55','1','wxd5b98bbec200013b','720045fbea9fee72db9b85a1c4f7bb53','1203301939509460992','2','1','0','5',NULL,0.00,0.01,0.00,0.00,0.01,NULL,NULL,NULL,NULL,NULL,NULL,'d14c827f640d431fb868841ae4d0c11b',NULL,'0',NULL,NULL),
('3f2b18b858bab00986daede98686c5c3','1','0','2019-12-03 17:28:34','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1201795349354643456','2','1','1','1',NULL,0.00,0.08,0.00,0.00,0.08,NULL,'2019-12-03 17:28:55',NULL,NULL,NULL,NULL,'a6d342b0c65def79e56ff4f3cc8a7f9c','4200000455201912030578287728','0',NULL,NULL),
('4019a464bffd024e8a1023a7286c7b2a','1','0','2019-12-08 18:13:20','2019-12-22 20:26:55','1','wxd5b98bbec200013b','cfdf18f63da3129a15b4eaf76a562dcf','1203618554348306432','2','1','1','1',NULL,0.00,0.03,0.00,0.00,0.03,NULL,'2019-12-08 18:13:34',NULL,NULL,NULL,NULL,'fe16250b2d94da66942628e3f6eb9fee','4200000468201912081860872015','0',NULL,NULL),
('416b0222a029ba53712937a1e4fff8d6','1','0','2019-12-10 13:58:45','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204279261653893120','2','1','0','5',NULL,0.00,150.00,0.00,0.00,150.00,NULL,NULL,NULL,NULL,NULL,NULL,'4223ea42d24f3894e35b364908a6cce7',NULL,'0',NULL,NULL),
('42d56a01fa07401b93500891492f91b4','1','0','2019-12-23 11:54:44','2019-12-23 12:00:26','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208959094958850048','2','1','1','5',NULL,0.00,100.00,0.00,11.00,89.00,0,'2019-12-23 11:54:49','2019-12-23 11:58:13',NULL,NULL,NULL,'3969e4c47cb1496349da741451c4e8ba','4200000457201912239759633897','0',NULL,NULL),
('440c0344e18fa7634686b8d39f4e239b','1','0','2019-11-19 11:50:47','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1196636915109986304','2','1','1','5',NULL,0.00,0.02,0.00,0.00,0.02,NULL,'2019-11-19 11:51:06',NULL,NULL,NULL,NULL,'ed947e8cdd5b67644ecbf0935b7695f5','4200000452201911194141835967','0',NULL,NULL),
('46a9be50a863fd68c2b11067d3243c0e','1','0','2019-12-10 18:50:01','2019-12-22 20:26:55','1','wxd5b98bbec200013b','5ea925e292c7ec621865af76d557ce6a','1204352563713933312','2','1','0','5',NULL,0.00,150.00,0.00,0.00,135.00,1500,NULL,NULL,NULL,NULL,NULL,'6f1f808c87fc9fd6afa650d95d13b643',NULL,'0',NULL,NULL),
('4a56db8916471bc20cab4aad67049134','1','0','2019-09-26 14:55:27','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177114441091645440','2','1','1','3','1',0.00,0.10,0.00,0.00,0.10,NULL,'2019-09-26 14:55:36','2019-09-26 15:00:11','2019-09-26 15:00:24','2019-09-26 15:02:09',NULL,'0707185a19bf123aa680be9c2c5675be','4200000420201909268937617949','0',NULL,NULL),
('4b9a47cd30e1c5f17d1e53f2d7b1ba33','1','0','2019-10-11 09:57:50','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182475361623998464','2','1','1','5','0',0.00,0.10,0.00,0.00,0.10,NULL,'2019-10-11 09:58:08','2019-10-11 09:59:05','2019-11-11 23:39:29',NULL,NULL,'6e93fe489f78018b48c02f861d5d348d','4200000406201910113085485793','0',NULL,NULL),
('4d8110c160ce2a5ff7e70bd404dc2d2a','1','0','2020-01-05 11:46:19','2020-01-05 11:46:19','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1213668017381048320','2','1','1','1',NULL,0.00,1905.00,0.00,0.00,0.00,0,'2020-01-05 11:46:21',NULL,NULL,NULL,'咯','f822185b186b54fb2ce16fe842e3a06f',NULL,'1','ff376adefffd59591fd1d1384ad72120',NULL),
('4e213a6b3311c5235f05da78567459b1','1','0','2019-12-08 17:57:43','2019-12-22 20:26:55','1','wxd5b98bbec200013b','cfdf18f63da3129a15b4eaf76a562dcf','1203614624360955904','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-12-08 17:58:07',NULL,NULL,NULL,NULL,'4db98ff160a9272460fb6392f115c67c','4200000464201912088665437799','0',NULL,NULL),
('53ccf04b952e1980342bf1778e5b998a','1','0','2019-09-26 15:02:44','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177116273830526976','2','1','1','3','1',0.00,0.10,0.00,0.00,0.10,NULL,'2019-09-26 15:02:54','2019-09-26 22:28:10','2019-09-26 22:28:26','2019-09-26 22:29:20',NULL,'98c14d70aa39c43c1c5641d4dd221988','4200000416201909260481408191','0',NULL,NULL),
('57234484563133b8d44866da5b9edd3d','1','0','2019-09-22 21:39:17','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1175766520047861760','2','1','0','5',NULL,0.00,27994.50,0.00,0.00,27994.50,NULL,NULL,NULL,NULL,NULL,NULL,'a9cece6226b5cd1b6bbc4ddd21563635',NULL,'0',NULL,NULL),
('59b6a491c18727d34c29d577affa8357','1','0','2019-12-22 22:44:41','2019-12-22 22:44:41','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208760271561031680','2','1','0','5',NULL,0.00,100.00,0.00,10.00,50.00,500,NULL,NULL,NULL,NULL,NULL,'be12ba0d732f363733503961a34a7f78',NULL,'0',NULL,NULL),
('59c970dee9d68112f2f2c6efa3c8caef','1','0','2020-01-05 12:02:25','2020-01-05 12:02:25','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1213672072165720064','2','1','0','5',NULL,0.00,2600.00,0.00,0.00,5.00,0,NULL,NULL,NULL,NULL,NULL,'d01adf5a359f380810d1de179194ee6e',NULL,'1','740ab617f9f5054458fe03def0cac1b6',NULL),
('5ac6c10de98f5c0cffd9dcaebfc620be','1','0','2019-12-28 20:54:05','2019-12-28 20:54:05','1','wxd5b98bbec200013b','04a33a653dc5fc3f6b0f20994026528b','1210906765101629440','2','1','0','5',NULL,0.00,5488.00,0.00,15.00,5473.00,0,NULL,NULL,NULL,NULL,NULL,'b2eb88115ab3b9f0ff831cd2f7c2b83e',NULL,'0',NULL,NULL),
('5b64f3a06e744aca1c2caebd6a0054b8','1','0','2019-12-13 22:31:47','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205495535427911680','2','1','0',NULL,NULL,0.00,10.56,0.00,0.00,10.56,0,NULL,NULL,NULL,NULL,NULL,'6c5a093ff3c9788cba0cb1784528f7c0',NULL,'0',NULL,NULL),
('5b89c580123d15c2fcf8864442a41a0d','1','0','2019-12-09 14:40:43','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1203927434764746752','2','1','0','5',NULL,0.00,300.01,0.00,0.00,300.01,NULL,NULL,NULL,NULL,NULL,NULL,'268613dd1ab7380f874971dc1d2f0d40',NULL,'0',NULL,NULL),
('5bb598be27da4314c20f5d19d7b16314','1','0','2019-11-05 12:15:02','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1191569585338318848','2','1','0','5',NULL,0.00,15686.00,0.00,0.00,15686.00,NULL,NULL,NULL,NULL,NULL,NULL,'7ad2f1a05772732986b2c284190ebef7',NULL,'0',NULL,NULL),
('5d0fee215c983c7f56128ad6411c3dd6','1','0','2019-12-13 22:45:09','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205498897108041728','2','1','1','5',NULL,0.00,11.00,0.00,0.00,6.00,5,'2019-12-13 22:45:37',NULL,NULL,NULL,NULL,'8743e9bd446cfc9dd25a560db88e5578','4200000454201912134101194605','0',NULL,NULL),
('5d8ae3ab3f93cbf2d58af7afa32a8833','1','0','2019-09-26 23:21:34','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177241809256972288','2','1','1','3','1',0.00,0.10,0.00,0.00,0.10,NULL,'2019-09-26 23:21:46','2019-09-26 23:22:23','2019-09-26 23:22:29','2019-09-26 23:23:02','哈喽','28f18c73e25e271b59313d53b16855fc','4200000408201909260887725923','0',NULL,NULL),
('5e5a2db0541a440d194acc6996936eee','1','0','2019-09-22 21:40:01','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1175766703015985152','2','1','1','1',NULL,0.00,0.10,0.00,0.00,0.10,NULL,'2019-09-22 21:40:08',NULL,NULL,NULL,NULL,'11df2af2776c77dabd45a8d11a9fcc95',NULL,'0',NULL,NULL),
('5f1e9a65663da6450e73d623152ac806','1','0','2019-09-26 22:34:03','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177229853838016512','2','1','1','3','1',0.00,0.10,0.00,0.00,0.10,NULL,'2019-09-26 22:34:11','2019-09-26 22:34:51','2019-09-26 22:35:06','2019-09-26 22:36:50',NULL,'db8089b29b15242063753cc03d4d11a3','4200000415201909266403754746','0',NULL,NULL),
('6115800cf8afefa8250ce7984e5a7b0b','1','0','2019-11-11 23:09:02','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1193908496576282624','2','1','0','5',NULL,0.00,0.08,0.00,0.00,0.08,NULL,NULL,NULL,NULL,NULL,NULL,'82a8510a2c30d3344abb9f977e740336',NULL,'0',NULL,NULL),
('620c287b88d9093bba7b68d0216998f1','1','0','2019-12-13 22:22:54','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205493299092127744','2','1','0','5',NULL,0.00,0.02,0.00,0.00,0.02,0,NULL,NULL,NULL,NULL,NULL,'a7950c9d998da57050e497dd689dd7e3',NULL,'0',NULL,NULL),
('622877447d84516302040b0ffee97b5f','1','0','2019-12-10 19:54:17','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4a5e9b2f5812e571ae3da431f5fd02e3','1204368735331155968','2','1','0','5',NULL,0.00,2.00,0.00,0.00,2.00,0,NULL,NULL,NULL,NULL,NULL,'d064a418a510e63b9a46fb37df18703c',NULL,'0',NULL,NULL),
('62b6c7a2e0e25d1685a82fa2d66ff38f','1','0','2019-12-13 21:27:16','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1205479301000986624','2','1','1','5',NULL,0.00,0.01,0.00,0.00,0.01,0,'2019-12-13 21:27:22',NULL,NULL,NULL,NULL,'f950af32c8e43a112a29c69cfe77db2e','4200000466201912130483013387','0',NULL,NULL),
('62dade081db06cae9f2f3636b66c1b84','1','0','2019-12-08 18:09:55','2019-12-22 20:26:55','1','wxd5b98bbec200013b','cfdf18f63da3129a15b4eaf76a562dcf','1203617697070317568','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-12-08 18:10:11',NULL,NULL,NULL,NULL,'982323bd4b3f90a04a7d9a54d5113d4a','4200000465201912085934359889','0',NULL,NULL),
('630a070ac90008a20a4115f22bd48145','1','0','2019-09-25 21:15:39','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1176847736784289792','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-09-25 21:15:46',NULL,NULL,NULL,NULL,'2f13694e03e41dcb940a366c002960e6','4200000420201909257628684071','0',NULL,NULL),
('63563b797ace467d8207281a86758e79','1','0','2019-12-07 21:16:12','2019-12-22 20:26:55','1','wxd5b98bbec200013b','720045fbea9fee72db9b85a1c4f7bb53','1203302187053088768','2','1','0','5',NULL,0.00,0.01,0.00,0.00,0.01,NULL,NULL,NULL,NULL,NULL,NULL,'a1d70348a44a5b07ba842f767ec79552',NULL,'0',NULL,NULL),
('66c5b8ee5fc03ded38110f49c9c064fd','1','0','2019-09-26 23:26:03','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177242940829859840','2','1','1','3','1',0.00,0.10,0.00,0.00,0.10,NULL,'2019-09-26 23:26:17','2019-09-26 23:26:47','2019-09-26 23:26:56','2019-09-26 23:27:35',NULL,'f4b10b3f6b20a2613b93f6e89284b0e2','4200000417201909269276501629','0',NULL,NULL),
('6899afc86eac357fd8671f6ce5175c25','1','0','2019-09-27 16:11:34','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177495987048939520','2','1','1','3','1',0.00,1.00,0.00,0.00,1.00,NULL,'2019-09-27 16:11:42','2019-09-27 16:15:24','2019-09-27 16:15:32','2019-09-27 16:17:38',NULL,'80ad8e9d42acc772a8518af4e12a5d3f','4200000404201909277935290696','0',NULL,NULL),
('69b79dd87f089e116013c1ffefdf2c25','1','0','2020-01-04 21:43:59','2020-01-04 21:43:59','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1213456040771715072','2','1','0','5',NULL,0.00,2599.00,0.00,0.00,2000.00,0,NULL,NULL,NULL,NULL,NULL,'1eb4e02ed43b703b180c4f0bb26176ff',NULL,'0',NULL,NULL),
('6abfaf58a35a58807d1acaf96e321c18','1','0','2019-09-26 22:44:42','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177232534304456704','2','1','1','3','1',0.00,1.00,0.00,0.00,1.00,NULL,'2019-09-26 22:44:49','2019-09-26 22:53:17','2019-09-26 22:53:31','2019-09-26 22:54:21',NULL,'69c08672255bb0369c181701941feb40','4200000420201909265763000843','0',NULL,NULL),
('6be312492e1c46fcc53d3cf3e650a594','1','0','2019-12-11 18:13:59','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1204705879279009792','2','1','0','5',NULL,0.00,15.00,0.00,0.00,8.00,7,NULL,NULL,NULL,NULL,NULL,'45abad70d8dd98dba50177846f3d0f68',NULL,'0',NULL,NULL),
('6c72644f2f6b4944dedb343aec35fab2','1','0','2019-12-08 19:16:42','2019-12-22 20:26:55','1','wxd5b98bbec200013b','51dd99ae8131b7e5daed2a7babe67999','1203634501624791040','2','1','1','1',NULL,0.00,0.03,0.00,0.00,0.03,NULL,'2019-12-08 19:17:03',NULL,NULL,NULL,NULL,'bfc8ab7d2c50ad4fdf2dcc41abe357b7','4200000466201912085969577992','0',NULL,NULL),
('6d038bdf9d5a23f21a1b1d33e621c765','1','0','2019-12-10 16:59:03','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204324638591549440','2','1','0','5',NULL,0.00,300.01,0.00,0.00,270.01,3000,NULL,NULL,NULL,NULL,NULL,'84a095fbc28104bb6f74aebe177527cc',NULL,'0',NULL,NULL),
('6ecc17ad6a7ddd425e64b283bc98fe61','1','0','2019-12-13 22:26:13','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205494137193758720','2','1','0','5',NULL,0.00,10.56,0.00,0.00,10.56,0,NULL,NULL,NULL,NULL,NULL,'5507eee2a7c83e97ae7fd05975d2c776',NULL,'0',NULL,NULL),
('73d5c5aaa16e434dc377bd97a1f15345','1','0','2019-12-08 19:23:14','2019-12-22 20:26:55','1','wxd5b98bbec200013b','51dd99ae8131b7e5daed2a7babe67999','1203636143904522240','2','1','1','5',NULL,0.00,0.03,0.00,0.00,0.03,NULL,'2019-12-08 19:23:29',NULL,NULL,NULL,NULL,'9712d3a73c6a0d66e1d586d0a406a9a8','4200000471201912088443435466','0',NULL,NULL),
('7843aed947e1dcfeff83efedce7822c0','1','0','2019-12-22 22:46:06','2019-12-22 22:46:06','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208760629750398976','2','1','0','5',NULL,0.00,100.00,0.00,10.00,90.00,0,NULL,NULL,NULL,NULL,NULL,'e57fcc44ee3f369ed273f75546eb8b4b',NULL,'0',NULL,NULL),
('787a945f8c532022acc28dd1b5a69545','1','0','2019-10-11 12:53:15','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182519506249973760','2','1','0','5',NULL,0.00,2999.00,0.00,0.00,2999.00,NULL,NULL,NULL,NULL,NULL,NULL,'1ded60def368328f9b6e8531b60623c0',NULL,'0',NULL,NULL),
('7963c0b61a1bb94fdfb223a24393cb8c','1','0','2019-12-22 23:51:23','2019-12-22 23:51:23','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208777059480895488','2','1','0',NULL,NULL,0.00,100.00,0.00,5.00,45.00,500,NULL,NULL,NULL,NULL,NULL,'59a0c2dff69a8aa2e9969067c235788a',NULL,'0',NULL,NULL),
('7c9741cff22cf3de06168ee3e0d155b3','1','0','2019-12-10 15:11:09','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204297332451966976','2','1','0','5',NULL,0.00,150.00,0.00,0.00,135.00,1500,NULL,NULL,NULL,NULL,NULL,'7e4b68cd652264f352344eb76827fb8f',NULL,'0',NULL,NULL),
('7e8fe82cd6ca403407c571cebec837cc','1','0','2019-12-22 23:20:54','2019-12-22 23:20:54','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208769388790939648','2','1','0','5',NULL,0.00,100.00,0.00,11.00,89.00,0,NULL,NULL,NULL,NULL,NULL,'ba315d7c01e8b880ec86660e03724046',NULL,'0',NULL,NULL),
('7fcd8633f4528cf2cbcd33d3cec469f5','1','0','2019-12-25 13:08:51','2019-12-25 13:08:51','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1209702525641424896','2','1','0','5',NULL,0.00,4599.00,0.00,5.00,4594.00,0,NULL,NULL,NULL,NULL,NULL,'38e5d7cc913db5c5da9bd5c608801202',NULL,'0',NULL,NULL),
('8091efc67a4097d6815bf64522ff886f','1','0','2019-12-10 16:42:08','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204320379301003264','2','1','0','5',NULL,0.00,300.01,0.00,0.00,300.01,0,NULL,NULL,NULL,NULL,NULL,'553ff3c5a3f9b259fac7667333b48d5d',NULL,'0',NULL,NULL),
('831e13557faa7f8ade2a0108310ab33b','1','0','2019-12-22 19:48:48','2019-12-22 19:48:48','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208716008651489280','2','1','0','5',NULL,0.00,2999.00,0.00,5.00,2994.00,0,NULL,NULL,NULL,NULL,NULL,'27d660170a193fbbe9a610e0d59e3243',NULL,'0',NULL,NULL),
('83775cbec35630784ef07d0835f15b12','1','0','2019-09-24 20:31:37','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1176474264816058368','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-09-24 20:32:18',NULL,NULL,NULL,NULL,'b352149938112b88b6757cff1a609faf','4200000408201909245019633649','0',NULL,NULL),
('876b7d66fef43fafb91df56570ac5191','1','0','2019-09-24 14:13:39','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1176379146385752064','2','1','1','3','1',0.00,0.01,0.00,0.00,0.01,NULL,'2019-09-24 14:13:57',NULL,NULL,NULL,NULL,'d81b7ca0a9db9ee74b839dd813d303c5',NULL,'0',NULL,NULL),
('892a4cf26ffbfb01f5943fc65c76c961','1','0','2019-12-07 21:15:34','2019-12-22 20:26:55','1','wxd5b98bbec200013b','720045fbea9fee72db9b85a1c4f7bb53','1203302026641932288','2','1','0','5',NULL,0.00,0.01,0.00,0.00,0.01,NULL,NULL,NULL,NULL,NULL,NULL,'aec77aba14745c1329aa5a2e636e32d2',NULL,'0',NULL,NULL),
('892e059822941e4d9db157da07a457f2','1','0','2020-01-07 11:16:44','2020-01-07 11:16:44','1','wxd5b98bbec200013b','d6f42ee88d33d870cb3f333f6e21e247','1214385350961528832','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,0,'2020-01-07 11:17:02',NULL,NULL,NULL,NULL,'d7446aeb4279f8bcdddcd76cb56c3a18','4200000512202001070830809297','0',NULL,NULL),
('8a959bc7bcb45dcfc6783ddac83ac819','1','0','2019-12-22 22:54:50','2019-12-22 22:54:50','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208762826311598080','2','1','0','5',NULL,0.00,100.00,0.00,5.00,50.00,500,NULL,NULL,NULL,NULL,NULL,'d2e242d9c0973f70f8a6ca467d025e76',NULL,'0',NULL,NULL),
('8b26394ffdbeb4a48d8c1a834c2c7fc3','1','0','2019-12-23 12:27:00','2019-12-25 13:50:12','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208967217010442240','2','1','1','5',NULL,0.00,60.00,30.00,0.00,30.00,300,'2019-12-23 12:27:06',NULL,NULL,NULL,NULL,'adc3cce1b085c3d10b2f8fbbcec42eea','4200000471201912238816167044','0',NULL,NULL),
('91e879113d0df7481fa12842b0881193','1','0','2019-10-11 12:30:32','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182513791326224384','2','1','0','5',NULL,0.00,3999.00,0.00,0.00,3999.00,NULL,NULL,NULL,NULL,NULL,NULL,'8a2086e559b191c7318a5bb6e74524b5',NULL,'0',NULL,NULL),
('928de7300421aaa3b6cead635b9970f4','1','0','2019-12-13 21:07:32','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1205474333552541696','2','1','1','5',NULL,0.00,0.01,0.00,0.00,0.01,0,'2019-12-13 21:07:38',NULL,NULL,NULL,NULL,'8306885ada2a59e97c7cac66916dd18d','4200000455201912132388861370','0',NULL,NULL),
('930de4f191d7d35d5f99d7b693b28401','1','0','2019-12-10 18:40:32','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204350178492940288','2','1','0',NULL,NULL,0.00,150.00,0.00,0.00,150.00,0,NULL,NULL,NULL,NULL,NULL,'45d370d9ed78fb7fba79f2ecbb0039ff',NULL,'0',NULL,NULL),
('950241352d2ca62c3bbeb8b090db5b12','1','0','2019-12-10 16:06:13','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204311338860412928','2','1','0','5',NULL,0.00,150.00,0.00,0.00,150.00,0,NULL,NULL,NULL,NULL,NULL,'9c20cb7bed63de5a778305af728774f1',NULL,'0',NULL,NULL),
('9755037e9800d9278970e31307a81c22','1','0','2019-12-23 00:52:10','2019-12-23 00:52:10','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208792355688153088','2','1','0',NULL,NULL,0.00,5588.00,50.00,11.00,5527.00,500,NULL,NULL,NULL,NULL,NULL,'16234f7d436b897c8cf9c3d192eac161',NULL,'0',NULL,NULL),
('97cd22043056a49fca635dffe7a68b7a','1','0','2019-12-23 12:28:13','2019-12-23 12:28:13','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208967521894400000','2','1','0','5',NULL,0.00,120.00,60.00,5.00,55.00,600,NULL,NULL,NULL,NULL,NULL,'23f983f38b6c20894bd788e7c59d4411',NULL,'0',NULL,NULL),
('98edb7545734f4198c0133fc309e7639','1','0','2019-12-22 19:53:50','2019-12-22 19:53:50','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208717275587149824','2','1','0','5',NULL,0.00,2999.00,0.00,5.00,1495.00,1499,NULL,NULL,NULL,NULL,NULL,'f1f7aadfbd047abacf9d032a3722228c',NULL,'0',NULL,NULL),
('99ca0a3b389ba0f4ce4384efd8c65b27','1','0','2019-12-25 13:04:18','2019-12-25 13:04:18','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1209701379166175232','2','1','0','5',NULL,5.00,0.03,0.00,0.00,10.03,0,NULL,NULL,NULL,NULL,NULL,'9744cf514ce1c5d0cb44260c77dff88c',NULL,'0',NULL,NULL),
('9c00fa0679b50c496c050d1ae7512c4a','1','0','2019-11-17 16:30:45','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1195982592730464256','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-11-17 16:30:51',NULL,NULL,NULL,NULL,'e466ac92a8688fbd1c784a26f6b91285','4200000452201911177961178458','0',NULL,NULL),
('9caa8497211da2e81a1dc2dfddb9d159','1','0','2019-12-14 21:51:33','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205847800420499456','2','1','0','5',NULL,0.00,1.00,0.00,0.00,1.00,0,NULL,NULL,NULL,NULL,NULL,'34fac0fd99b74d140e4037c140bce918',NULL,'0',NULL,NULL),
('9d8f48766eb879f6bc985b59066c8a73','1','0','2019-12-10 16:09:32','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204312148021346304','2','1','0','5',NULL,0.00,300.02,0.00,0.00,240.02,6000,NULL,NULL,NULL,NULL,NULL,'15742b91aff03f3126542ba0b6176bac',NULL,'0',NULL,NULL),
('9da85ae06bd72bc02d7287b08ae15f14','1','0','2019-11-11 23:35:28','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1193915149384155136','2','1','1','3','1',0.00,0.03,0.00,0.00,0.03,NULL,'2019-11-11 23:35:52','2019-11-11 23:37:45','2019-11-11 23:38:17','2019-11-11 23:38:33','公我一下子a','4c52cf5f5746e8c0c225175e2e00a785','4200000469201911111757531749','0',NULL,NULL),
('9e12235fe6db8a619c7e868bd937ae02','1','0','2019-12-13 21:12:55','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1205475688967045120','2','1','1','5',NULL,0.00,1.00,0.00,0.00,1.00,0,'2019-12-13 21:13:01',NULL,NULL,NULL,NULL,'a1cf0999fda1a4c7c8716ed10dda1834','4200000457201912136666666972','0',NULL,NULL),
('9e65c7ffa45a27425f086fb1c4c2e0d9','1','0','2019-12-10 16:48:33','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204321959517618176','2','1','0','5',NULL,0.00,300.00,0.00,0.00,540.00,6000,NULL,NULL,NULL,NULL,NULL,'f2bdac68ad7652b5fb3e6dfa1b45fa60',NULL,'0',NULL,NULL),
('9edd79b02b3f9b01211e1a14276e8035','1','0','2019-12-10 19:57:27','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4a5e9b2f5812e571ae3da431f5fd02e3','1204369531191951360','2','1','1','5',NULL,0.00,12.00,0.00,0.00,6.00,6,'2019-12-10 19:57:42',NULL,NULL,NULL,NULL,'d8f101de8008e162cc30bffea29f7e9b','4200000460201912102968473001','0',NULL,NULL),
('9ef278ec8748a3ae20e21ace6aa70bc0','1','0','2019-12-10 16:03:16','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204310599404617728','2','1','0','5',NULL,0.00,150.00,0.00,0.00,150.00,0,NULL,NULL,NULL,NULL,NULL,'a670f841d6af1b68ad5f6916920a5ff8',NULL,'0',NULL,NULL),
('9fa0de8f3cf3e6ee22e39315f388c418','1','0','2019-12-22 23:33:57','2019-12-22 23:33:57','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208772669374201856','2','1','0','5',NULL,0.00,2000.00,0.00,100.00,1900.00,0,NULL,NULL,NULL,NULL,NULL,'ef04a93387459b06764e8abdf85fc8f2',NULL,'0',NULL,NULL),
('9fb19729e87dadb0daa45ee629109fc5','1','0','2019-09-24 18:02:10','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1176436651145035776','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-09-24 18:02:28',NULL,NULL,NULL,NULL,'9f863d28f9d5fa82cfe4beda1ba488d7',NULL,'0',NULL,NULL),
('a579eb33e49a65779c92154ab305b89b','1','0','2019-12-19 12:28:25','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1207518022323929088','2','1','0','5',NULL,0.00,2999.96,0.00,0.00,1500.96,1499,NULL,NULL,NULL,NULL,NULL,'ae6b7111bce74e201c777d43fb345fdb',NULL,'0',NULL,NULL),
('a68b57c3c77571824a71810684a9e76a','1','0','2019-12-24 21:46:35','2019-12-24 21:46:35','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1209470426036568064','2','1','0','5',NULL,0.00,200.00,100.00,22.00,78.00,1000,NULL,NULL,NULL,NULL,NULL,'0cd7ec34ef784439a7de411508028945',NULL,'0',NULL,NULL),
('aaa0c4218d62feb36b42e9150fd1f25b','1','0','2019-12-10 17:12:21','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204327982487830528','2','1','0','5',NULL,0.00,150.00,0.00,0.00,135.00,1500,NULL,NULL,NULL,NULL,NULL,'f9511fd1321a4f1f8757eb7d32a94491',NULL,'0',NULL,NULL),
('aad03004d906981dac23224400f6b9fb','1','0','2019-12-10 16:58:05','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204324394319478784','2','1','0','5',NULL,0.00,300.00,0.00,0.00,300.00,0,NULL,NULL,NULL,NULL,NULL,'8f7314a3d0dff13a3b3e607a414f6077',NULL,'0',NULL,NULL),
('ab2ad924fb04aaea7572a1e912b97475','1','0','2019-12-10 15:11:38','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204297566657708032','2','1','0','5',NULL,0.00,0.01,0.00,0.00,0.01,0,NULL,NULL,NULL,NULL,NULL,'a96d53d7bbe8d70897f23bb7d6dabe33',NULL,'0',NULL,NULL),
('ac0142a7747f294f9c3a3e98bab5af1a','1','0','2019-12-07 21:15:39','2019-12-22 20:26:55','1','wxd5b98bbec200013b','720045fbea9fee72db9b85a1c4f7bb53','1203302050549465088','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-12-07 21:15:50',NULL,NULL,NULL,NULL,'d610541e859d9b7e9902d227805d5313','4200000457201912070304444506','0',NULL,NULL),
('acc55e9d7cb355649cc981a5245f773a','1','0','2019-09-25 15:28:46','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1176760434431098880','2','1','0','5',NULL,0.00,0.10,0.00,0.00,0.10,NULL,NULL,NULL,NULL,NULL,NULL,'a6534a3db10211e701f80e5610fbdeb8',NULL,'0',NULL,NULL),
('acef5ea74ea57ec1c9fe682441c19d8c','1','0','2019-09-26 14:17:02','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177104774152060928','2','1','0','5',NULL,0.00,7899.00,0.00,0.00,7899.00,NULL,NULL,NULL,NULL,NULL,'噶咯','ba85486f349fc5683e933782484396cd',NULL,'0',NULL,NULL),
('ad1e87c5f0e67791d10c575420e139e4','1','0','2019-12-13 21:21:53','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1205477943908761600','2','1','1','5',NULL,0.00,10.00,0.00,0.00,5.00,5,'2019-12-13 21:21:59',NULL,NULL,NULL,NULL,'4bd54c086afa05dea8590bc6333b2b10','4200000452201912133391483449','0',NULL,NULL),
('aeecab1f6989d5286bad2347cc0cf586','1','0','2019-10-10 10:17:18','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182117869895286784','2','1','1','5','0',0.00,0.10,0.00,0.00,0.10,NULL,'2019-10-10 10:19:56','2019-10-10 10:21:21','2019-10-10 10:47:08',NULL,NULL,'7f52ba7b90a710781f852ce6950b9c2a','4200000421201910102571359595','0',NULL,NULL),
('af2e2dc83cb26351ebb3f93e110e55d5','1','0','2019-12-25 13:08:21','2019-12-25 13:08:21','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1209702398163943424','2','1','0','5',NULL,5.00,0.02,0.00,0.00,5.02,0,NULL,NULL,NULL,NULL,NULL,'294a3b1cb085bc1d6b42c810e6d37998',NULL,'0',NULL,NULL),
('af57473ecac0bbef1e8a6683ea25fd5e','1','0','2019-12-13 22:23:55','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205493554281971712','2','1','0','5',NULL,0.00,13.00,0.00,0.00,7.00,6,NULL,NULL,NULL,NULL,NULL,'405097a0db377f25e53f8eb33d9f87d7',NULL,'0',NULL,NULL),
('aff0c666e6e021fe476891a5f72289d0','1','0','2019-12-13 22:51:41','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1205500543867289600','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,0,'2019-12-13 22:51:51',NULL,NULL,NULL,NULL,'bc59379e9fa10380f793c584011f6e0c','4200000465201912130773787407','0',NULL,NULL),
('b0e385ed6d9842d8158bbd141bab7359','1','0','2019-10-12 12:24:36','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182874682911621120','2','1','0','5',NULL,0.00,0.01,0.00,0.00,0.01,NULL,NULL,NULL,NULL,NULL,NULL,'76d9a7a6a146cfb347459a0a8a1d29c7',NULL,'0',NULL,NULL),
('b2540f32b7c4ece122adbccaaf713d2c','1','0','2019-11-19 12:06:21','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1196640829683269632','2','1','1','5',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-11-19 12:06:38',NULL,NULL,NULL,NULL,'a1e71935d76fa9ff398b3f664f0f5561','4200000461201911191753572673','0',NULL,NULL),
('b33a4acac0fa8249fa7dfcc7fae50ee7','1','0','2019-12-07 21:10:31','2019-12-22 20:26:55','1','wxd5b98bbec200013b','720045fbea9fee72db9b85a1c4f7bb53','1203300755570688000','2','1','0','5',NULL,0.00,150.00,0.00,0.00,150.00,NULL,NULL,NULL,NULL,NULL,NULL,'a7bad42ca3c09feccd60089146341c4f',NULL,'0',NULL,NULL),
('b33f655c889fe31da4af66e3292d1be2','1','0','2019-12-25 20:36:52','2019-12-25 20:36:52','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1209815268746854400','2','1','0','5',NULL,0.00,3988.00,0.00,0.00,3988.00,0,NULL,NULL,NULL,NULL,NULL,'b77472458a11d5cdabb5b39520e7659d',NULL,'0',NULL,NULL),
('b56d19329930cf9593571de4e56abbe9','1','0','2019-12-22 23:23:03','2019-12-22 23:23:03','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208769926534266880','2','1','0','5',NULL,0.00,100.00,0.00,5.00,45.00,500,NULL,NULL,NULL,NULL,NULL,'e84c7497ef6be57e7b06cf51ae44988b',NULL,'0',NULL,NULL),
('b6afed4227d8ad1cf2f5a1cacd2b1ddc','1','0','2019-12-13 22:32:53','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205495813078253568','2','1','0',NULL,NULL,0.00,10.56,0.00,0.00,5.56,5,NULL,NULL,NULL,NULL,NULL,'e2d3b8af56a583b4b283ed2f429222cc',NULL,'0',NULL,NULL),
('b8fbedc79cf2976897a96d955eefcd2a','1','0','2020-01-04 22:26:15','2020-01-04 22:26:15','1','wxd5b98bbec200013b','e3af0f8e19857cd34b4f22be6504496f','1213466676159315968','2','1','1','1',NULL,0.00,1905.00,0.00,0.00,0.01,0,'2020-01-04 22:26:22',NULL,NULL,NULL,NULL,'c9fdbfab63c396069d7f737cfdf6d47c','4200000468202001042190931029','1','f0813b20a9d2fffc84f5f1a47daa7699',NULL),
('b9e6080eb363a11b575ea7b265eab817','1','0','2020-01-05 12:09:48','2020-01-05 12:09:48','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1213673930988978176','2','1','0','5',NULL,0.00,2600.00,0.00,0.00,5.00,0,NULL,NULL,NULL,NULL,NULL,'53dd7cdde7a135b84ebdc7e03ec54541',NULL,'1','740ab617f9f5054458fe03def0cac1b6',NULL),
('bb12631b1d7ece319d321e7b0989387f','1','0','2019-12-23 12:31:38','2019-12-23 12:31:38','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208968383962284032','2','1','0','5',NULL,0.00,120.00,0.00,13.20,106.80,0,NULL,NULL,NULL,NULL,NULL,'d9192465c4dbac432f92fcae953e223a',NULL,'0',NULL,NULL),
('bb4d1e9fe1f328aff59d32879dbc383b','1','0','2019-12-17 22:10:29','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1206939726754349056','2','1','0','5',NULL,0.00,0.01,0.00,0.00,0.01,0,NULL,NULL,NULL,NULL,NULL,'807330c3b31bb9843004bbc4523de0db',NULL,'0',NULL,NULL),
('bb8a6f0ed3d36e949cba3dd39c2f9f86','1','0','2019-12-22 23:29:42','2019-12-22 23:29:42','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208771599944122368','2','1','0','5',NULL,0.00,100.00,0.00,5.00,13.00,500,NULL,NULL,NULL,NULL,NULL,'c34cb09d7761426a4b8aba1cbea98b06',NULL,'0',NULL,NULL),
('bbdc4eb7d5125ad0650712d083676851','1','0','2019-12-23 20:01:46','2019-12-23 20:01:46','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1209081663200428032','2','1','0','5',NULL,0.00,6098.00,0.00,11.00,6087.00,0,NULL,NULL,NULL,NULL,NULL,'a016e5283ce7e7fe69313425b587ddb8',NULL,'0',NULL,NULL),
('bc40a1ddcbe88e721d681f044a1cc281','1','0','2019-12-10 16:03:26','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204310642375262208','2','1','0','5',NULL,0.00,150.00,0.00,0.00,135.00,1500,NULL,NULL,NULL,NULL,NULL,'b811b13844c39726fd4cd8b2eaf4f667',NULL,'0',NULL,NULL),
('bcbbfcf1cfd50fa238adb0e3e78c74e2','1','0','2019-12-10 20:42:20','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4a5e9b2f5812e571ae3da431f5fd02e3','1204380825752174592','2','1','0','5',NULL,0.00,10.00,0.00,0.00,5.00,5,NULL,NULL,NULL,NULL,NULL,'e8ead1d35c1f7e2ea65b176f2bda7d96',NULL,'0',NULL,NULL),
('bde4a4ffe68a9a839cd5a21ddadfa0e6','1','0','2019-12-08 18:31:38','2019-12-22 20:26:55','1','wxd5b98bbec200013b','cfdf18f63da3129a15b4eaf76a562dcf','1203623158305783808','2','1','1','1',NULL,0.00,0.02,0.00,0.00,0.02,NULL,'2019-12-08 18:31:56',NULL,NULL,NULL,NULL,'54fc956840a6e860b3c35ef7b686e600','4200000469201912083135289093','0',NULL,NULL),
('be09da098e6a5d494fd33f21804d81ca','1','0','2019-12-22 23:22:01','2019-12-22 23:22:01','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208769667015901184','2','1','0','5',NULL,0.00,100.00,0.00,11.00,39.00,500,NULL,NULL,NULL,NULL,NULL,'b2706cc2055a701554bdff47f4dade55',NULL,'0',NULL,NULL),
('be173ebbcfd19d20eabc6d668f579671','1','0','2019-10-11 12:45:58','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182517674488365056','2','1','0','5',NULL,0.00,2999.00,0.00,0.00,2999.00,NULL,NULL,NULL,NULL,NULL,NULL,'c6228667e48a755dfb5b8e9269e06522',NULL,'0',NULL,NULL),
('bea0b0bacc1905c24b16550d809e7ddb','1','0','2019-09-27 16:18:12','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177497654284779520','2','1','1','3','1',0.00,0.01,0.00,0.00,0.01,NULL,'2019-09-27 16:18:19','2019-09-27 16:18:51','2019-09-27 16:18:57','2019-09-27 16:20:50',NULL,'1a443047e9f5c353a078ff738e92570d','4200000408201909278684739898','0',NULL,NULL),
('c2eb7b16c87aaae0d68ddc9fc82749b2','1','0','2019-12-10 19:03:36','2019-12-22 20:26:55','1','wxd5b98bbec200013b','5ea925e292c7ec621865af76d557ce6a','1204355979240538112','2','1','0','5',NULL,0.00,150.00,0.00,0.00,135.00,1500,NULL,NULL,NULL,NULL,NULL,'df61cc84826c557af261f316fcfdb738',NULL,'0',NULL,NULL),
('c39af99cf5c2c0a5f1d7776a39d593a6','1','0','2019-09-26 22:26:08','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177227862759964672','2','1','0','5',NULL,0.00,1.00,0.00,0.00,1.00,NULL,NULL,NULL,NULL,NULL,NULL,'5eac97c3ce86b80502dea9d48b82d97e',NULL,'0',NULL,NULL),
('c46b00a554a130e32181703d96fe3bac','1','0','2019-09-27 16:22:29','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177498733441449984','2','1','1','3','1',0.00,1.00,0.00,0.00,1.00,NULL,'2019-09-27 16:22:36','2019-09-27 16:23:04','2019-09-27 16:23:09','2019-09-27 16:24:50',NULL,'41c643520b51995678d13321114ad3c8','4200000408201909274439352000','0',NULL,NULL),
('c873a913c6c5f6d4a7cf9688a8df1d2b','1','0','2019-12-10 16:06:22','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204311381159968768','2','1','0','5',NULL,0.00,150.00,0.00,0.00,150.00,0,NULL,NULL,NULL,NULL,NULL,'8c32387f1b02922e9c97a3cc81617bc2',NULL,'0',NULL,NULL),
('c89ea6f924fb4e2e358511f5a4366923','1','0','2019-12-13 22:23:08','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205493359200698368','2','1','0','5',NULL,0.00,7.68,0.00,0.00,7.68,0,NULL,NULL,NULL,NULL,NULL,'91c7009ec3c7e120b1d1da698851c2e4',NULL,'0',NULL,NULL),
('ca6814b085f2a6be6d73a35968c0289e','1','0','2019-12-05 11:10:47','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1202425055292686336','2','1','1','1',NULL,0.00,0.02,0.00,0.00,0.02,NULL,'2019-12-05 11:11:39',NULL,NULL,NULL,NULL,'f3928c4754a594ad8f0224c064285340','4200000469201912051874432311','0',NULL,NULL),
('cae005b6472f600ac4f6a253cd43e0a6','1','0','2019-12-25 20:17:49','2019-12-25 20:17:49','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1209810476398018560','2','1','0','5',NULL,0.00,3988.00,0.00,0.00,3988.00,0,NULL,NULL,NULL,NULL,NULL,'d7db6f62ffb4db3d302a922dc58decf5',NULL,'0',NULL,NULL),
('cbd486fff7c53290dbfc2f2cee52e0d0','1','0','2019-12-23 11:16:45','2019-12-23 11:49:30','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208949535993233408','2','1','1','5',NULL,0.00,100.00,50.00,11.00,39.00,500,'2019-12-23 11:16:55',NULL,NULL,NULL,'这些','2181b0694d5d5e938eeb18ccaab981cf','4200000457201912234837641136','0',NULL,NULL),
('cbfc47c2fba63318e74532c360453bb6','1','0','2019-10-11 13:38:11','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182530816152961024','2','1','0','5',NULL,0.00,3999.00,0.00,0.00,3999.00,NULL,NULL,NULL,NULL,NULL,NULL,'9ceaa24fc4d789258587fb6c6ed47abd',NULL,'0',NULL,NULL),
('ce7418e33f685c9fa9ddf0a126b90536','1','0','2019-12-11 14:55:59','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1204656052923006976','2','1','0','5',NULL,0.00,10.00,0.00,0.00,5.00,5,NULL,NULL,NULL,NULL,NULL,'9dfa93ffd17fded2d8f229833806e172',NULL,'0',NULL,NULL),
('ced951d0f55223feb46e8a04bdeffe39','1','0','2019-12-10 20:37:45','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4a5e9b2f5812e571ae3da431f5fd02e3','1204379675531411456','2','1','0','5',NULL,0.00,10.00,0.00,0.00,5.00,5,NULL,NULL,NULL,NULL,NULL,'c6a97a4965f6a2d958a9dde3dbd02ac4',NULL,'0',NULL,NULL),
('d18b276037bdef808f8618ab3a3aaf2c','1','0','2019-09-25 21:13:45','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1176847255139778560','2','1','0','5',NULL,0.00,0.01,0.00,0.00,0.01,NULL,NULL,NULL,NULL,NULL,NULL,'298c78c41937311d54190db40436270b',NULL,'0',NULL,NULL),
('d2cbcc9cef8fd57f6f250b35bb9f2091','1','0','2019-09-23 22:51:48','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1176147156965261312','2','1','1','1',NULL,0.00,0.20,0.00,0.00,0.20,NULL,'2019-09-23 22:51:57',NULL,NULL,NULL,NULL,'21e6fb4c38f345bf84723aa2e1321e0a',NULL,'0',NULL,NULL),
('d2e03cb83d650e72813b0dff4095e7c2','1','0','2019-12-22 22:25:19','2019-12-22 22:25:19','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208755400464138240','2','1','0','5',NULL,0.00,100.00,0.00,11.00,50.00,500,NULL,NULL,NULL,NULL,NULL,'07f038e1b6271f2726145723de3386f3',NULL,'0',NULL,NULL),
('d9c049a265763f00f40eb098564733d5','1','0','2019-12-10 16:58:17','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204324445263495168','2','1','0','5',NULL,0.00,300.00,0.00,0.00,270.00,3000,NULL,NULL,NULL,NULL,NULL,'01f9f9ef7c7da1c6092ce1b6f355db5d',NULL,'0',NULL,NULL),
('db64a11efa642c320457187c4475177f','1','0','2019-12-23 11:28:28','2019-12-23 11:28:28','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208952487394934784','2','1','0','5',NULL,0.00,100.00,50.00,10.00,40.00,500,NULL,NULL,NULL,NULL,NULL,'5942a8fda1ba1fb0c56bd81170d12212',NULL,'0',NULL,NULL),
('db77c548b30898f5a5ff5a73ec4de3f1','1','0','2019-12-23 00:43:35','2019-12-23 00:43:35','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208790195680313344','2','1','0',NULL,NULL,0.00,100.00,50.00,11.00,39.00,500,NULL,NULL,NULL,NULL,NULL,'cc89d881899f2d0c353639c0ba70bc4d',NULL,'0',NULL,NULL),
('dcdc6021ef51bcc95903cacdf1034dc9','1','0','2019-12-10 14:00:16','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204279645638230016','2','1','0','5',NULL,0.00,150.00,0.00,0.00,150.00,NULL,NULL,NULL,NULL,NULL,NULL,'d0a26457b84a7e7dfa953667f8836578',NULL,'0',NULL,NULL),
('dd444559680d7bf3357013dc80c4fadc','1','0','2019-12-11 16:30:41','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1204679885465845760','2','1','1','5',NULL,0.00,10.00,0.00,0.00,5.00,5,'2019-12-11 16:31:01',NULL,NULL,NULL,NULL,'f34e6166ac69217de2cc6530e47c989b','4200000466201912118256219191','0',NULL,NULL),
('e0630d408069ec12bfeaec7e7d41ef0a','1','0','2019-12-10 16:54:51','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204323577659129856','2','1','0','5',NULL,0.00,300.00,0.00,0.00,270.00,3000,NULL,NULL,NULL,NULL,NULL,'bdb5d0736f324b1df02a9bf3e4687e10',NULL,'0',NULL,NULL),
('e0e010f6e634ed02b56aa2fc9c4732bb','1','0','2019-10-10 10:35:07','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182122357804761088','2','1','0','5',NULL,0.00,3999.00,0.00,0.00,3999.00,NULL,NULL,NULL,NULL,NULL,NULL,'b937f74ce4dd4ada92c7920a485861da',NULL,'0',NULL,NULL),
('e501d748b2898d7048d684ab29164ef0','1','0','2019-12-22 23:01:20','2019-12-22 23:01:20','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208764462174044160','2','1','0','5',NULL,0.00,100.00,0.00,5.00,45.00,500,NULL,NULL,NULL,NULL,NULL,'6482b745f25e9ca29dbbb0eefea04522',NULL,'0',NULL,NULL),
('e540ae6ab29487d2bf9f5093665e779b','1','0','2019-12-13 22:31:58','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205495583226200064','2','1','0',NULL,NULL,0.00,10.56,0.00,0.00,5.56,5,NULL,NULL,NULL,NULL,NULL,'bdee3e1c1c8ce696f53e063202579e8d',NULL,'0',NULL,NULL),
('e56288074694855ca21b6d4e238d66e4','1','0','2019-12-08 19:29:29','2019-12-22 20:26:55','1','wxd5b98bbec200013b','51dd99ae8131b7e5daed2a7babe67999','1203637719104749568','2','1','1','5',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-12-08 19:29:42',NULL,NULL,NULL,NULL,'7575e4f08fe65437218f6b9b15fb124b','4200000455201912081290882202','0',NULL,NULL),
('e76b5af69f877e1dc34ec1613d1f40e8','1','0','2019-12-23 11:52:50','2019-12-25 13:50:21','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208958617949044736','2','1','1','5',NULL,0.00,0.01,0.00,0.00,0.01,0,'2019-12-23 11:53:49',NULL,NULL,NULL,NULL,'f69666b805f46d3e9c16e8f97d5a2c6b','4200000463201912233732814882','0',NULL,NULL),
('e7bcf3b65cf655aa884adc435995db4d','1','0','2019-11-10 13:50:43','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1193405605197381632','2','1','0','5',NULL,0.00,5488.00,0.00,0.00,5488.00,NULL,NULL,NULL,NULL,NULL,NULL,'a774240aa049d768ede9fd6127abd940',NULL,'0',NULL,NULL),
('e9497016faa3b937590e814ad0f9cf34','1','0','2019-09-26 23:23:15','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1177242235331149824','2','1','1','3','1',0.00,0.10,0.00,0.00,0.10,NULL,'2019-09-26 23:23:33','2019-09-26 23:24:09','2019-09-26 23:24:17','2019-09-26 23:25:30',NULL,'07931a31fa995ad08afc3a2d0679334a','4200000407201909264830265746','0',NULL,NULL),
('e94dde429ee43798f17bb4488ebbc356','1','0','2019-12-22 23:22:33','2019-12-22 23:22:33','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208769801816637440','2','1','0','5',NULL,0.00,100.00,0.00,11.00,39.00,500,NULL,NULL,NULL,NULL,NULL,'a1789b01ce1aa75b50a64b5830129447',NULL,'0',NULL,NULL),
('eb167ca7503b93b20d94ffb8c8f06497','1','0','2019-09-22 20:32:34','2019-12-22 20:26:55','1','wxd5b98bbec200013b','478d05c0ceb1bb61dcb4f658d7700511','1175749727585566720','2','1','0','5',NULL,0.00,17196.00,0.00,0.00,17196.00,NULL,NULL,NULL,NULL,NULL,NULL,'905b49bb049416960fbd185a79fa9f5c',NULL,'0',NULL,NULL),
('eb954bae32a17ce40184265b90e2c1c5','1','0','2019-10-11 13:39:45','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182531210656612352','2','1','0','5',NULL,0.00,3999.00,0.00,0.00,3999.00,NULL,NULL,NULL,NULL,NULL,NULL,'1f466648fae89b1ce7940d95492063d1',NULL,'0',NULL,NULL),
('ec813fc104cb34f09745f2f471dd864a','1','0','2019-11-17 16:29:23','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1195982250273931264','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-11-17 16:29:42',NULL,NULL,NULL,NULL,'9a01b8dd0b5dfa5c60c94220109823db','4200000459201911173499977036','0',NULL,NULL),
('ec8f3afc835ce71d213e77b28eda389f','1','0','2019-09-22 18:08:30','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1175713475159130112','2','1','1','3','1',0.00,0.03,0.00,0.00,0.03,NULL,'2019-09-22 18:09:12',NULL,NULL,NULL,NULL,'c53a5c416dc7ffb5937fc0ceda58e4bb',NULL,'0',NULL,NULL),
('ec92ab324cf8a7479675914af5f5e3e0','1','0','2020-01-05 12:04:55','2020-01-05 12:04:55','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1213672700669591552','2','1','0','5',NULL,0.00,2600.00,0.00,0.00,199.40,0,NULL,NULL,NULL,NULL,NULL,'517187b760951d8ba4c7ebce87aa467a',NULL,'1','7369d117fbff1ce4fe298aaff6f97e1b',NULL),
('ece24ceedfed55f147a4c4fff606afe2','1','0','2019-12-10 19:09:50','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4a5e9b2f5812e571ae3da431f5fd02e3','1204357549525041152','2','1','0','5',NULL,0.00,150.00,0.00,0.00,135.00,1500,NULL,NULL,NULL,NULL,NULL,'596303c74cde4aca6e7fd6224abae382',NULL,'0',NULL,NULL),
('f64db72b39fb95c2110d665866a29876','1','0','2019-12-22 23:00:38','2019-12-22 23:00:38','1','wxd5b98bbec200013b','06c9cc6609e7ca1d6322e6c7d8436658','1208764286936023040','2','1','0','5',NULL,0.00,100.00,0.00,4.95,40.05,500,NULL,NULL,NULL,NULL,NULL,'19cbcd46b2893f59a4ab5c5119920b05',NULL,'0',NULL,NULL),
('f6dbea4ce4c77034be3cda083a29779d','1','0','2019-12-10 16:06:35','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204311432468889600','2','1','0','5',NULL,0.00,150.00,0.00,0.00,135.00,1500,NULL,NULL,NULL,NULL,NULL,'9d1b7648ebf8b7eb03c145b246460ee7',NULL,'0',NULL,NULL),
('f8491ca4ec36b83fccf6164714df0a19','1','0','2019-12-23 11:08:42','2019-12-23 11:08:42','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208947512493211648','2','1','0','5',NULL,0.00,200.00,100.00,22.00,78.00,1000,NULL,NULL,NULL,NULL,NULL,'f6a699b43d4e869a146bec2f8cf35335',NULL,'0',NULL,NULL),
('f8c0502a4da10334aff326de2c90e77f','1','0','2019-12-13 20:41:16','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205467722612211712','2','1','1','5',NULL,0.00,1.00,0.00,0.00,1.00,0,'2019-12-13 20:41:38',NULL,NULL,NULL,NULL,'56db2d1eefbb47f84e686fc308347e99','4200000453201912136921835102','0',NULL,NULL),
('fa8bb487cda4d57d53d205965314a4bc','1','0','2019-12-10 16:06:43','2019-12-22 20:26:55','1','wxd5b98bbec200013b','8cd7e1322a9a2e8d8e001c42e8f18708','1204311468724453376','2','1','0','5',NULL,0.00,150.00,0.00,0.00,150.00,0,NULL,NULL,NULL,NULL,NULL,'e178b298c69496cb661d0a87a2c1d2d2',NULL,'0',NULL,NULL),
('fbbd2e59843b9b8d0ccd50d19c76aa13','1','0','2019-11-10 13:52:04','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1193405946479509504','2','1','1','1',NULL,0.00,0.01,0.00,0.00,0.01,NULL,'2019-11-10 13:52:12',NULL,NULL,NULL,NULL,'3af415212108edd59cae3da481909cd7','4200000463201911102224972976','0',NULL,NULL),
('fe5d7900b883725fa2ff04937abddc4b','1','0','2019-12-22 23:15:14','2019-12-22 23:15:14','1','wxd5b98bbec200013b','8f978497ad772d58b94d84b356e0e341','1208767960248745984','2','1','0','5',NULL,0.00,100.00,0.00,11.00,23.00,500,NULL,NULL,NULL,NULL,NULL,'78e898ac1642a56ffdd887f2f927215d',NULL,'0',NULL,NULL),
('ffa700b06cbf0094c0c2f0cce2891c56','1','0','2019-10-11 12:59:01','2019-12-22 20:26:55','1','wxd5b98bbec200013b','db2355c836d46016e7b2eb41146291ee','1182520960289341440','2','1','0','5',NULL,0.00,3999.00,0.00,0.00,3999.00,NULL,NULL,NULL,NULL,NULL,NULL,'b61913deb93a60f2dfeeb8fa12b862a5',NULL,'0',NULL,NULL),
('ffb41c44af103419a8604baf9065ce80','1','0','2019-12-13 22:18:33','2019-12-22 20:26:55','1','wxd5b98bbec200013b','4e132ba860e0e625bac8338bf00133bb','1205492205309919232','2','1','0','5',NULL,0.00,10.56,0.00,0.00,5.56,5,NULL,NULL,NULL,NULL,NULL,'368dcd2f42953da1b22557bde5014e6c',NULL,'0',NULL,NULL);

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
('01b9e5d4670ee0404b8d564b40f5a218','1','0','2019-12-10 19:54:44','2019-12-22 20:27:28','03da2129901a6b05d884e89c48439e09','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,5.00,0.00,5.00,NULL,0.00,5,NULL,NULL,'0','0'),
('0269446f75374c7d8b7f66a487d814fa','1','0','2019-11-12 09:41:32','2019-12-22 20:27:28','19ad9bf03dbd5f99dae47e8da1bda3ac','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'1','0'),
('037e287bc0c54f141760efb9aaac172f','1','0','2019-11-17 16:30:45','2019-12-22 20:27:28','9c00fa0679b50c496c050d1ae7512c4a','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','1'),
('0414d6acced0ed4d20842f8f4d9ea913','1','0','2019-12-22 23:01:20','2019-12-22 23:01:20','e501d748b2898d7048d684ab29164ef0','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,45.00,NULL,5.00,500,'bce80959b1f7e9a5eadf334cecac5036',NULL,'0','0'),
('04b396c51aadbe88823ccf50870f2176','1','0','2019-09-26 23:21:34','2019-12-22 20:27:28','5d8ae3ab3f93cbf2d58af7afa32a8833','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'0','0'),
('04b3d06de2808d8ec582860fe83afe7a','1','0','2019-09-26 22:26:08','2019-12-22 20:27:28','c39af99cf5c2c0a5f1d7776a39d593a6','1b46c10d275262533b352329cc6d3af0','SIEMENS/西门子 KG28NV290C 三体全无霜 风冷大容量三门冰箱','官方标配，欧若拉银','5a0a1c24928af80a732cd179faac2d58','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/17.jpg',1,1.00,0.00,1.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('04d4900b09067c500d703d91d199aad1','1','0','2019-12-25 13:36:35','2019-12-25 13:44:12','114a360651d2d2914a4b6a0fbb410d89','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',3,0.01,5.00,5.03,0.00,0.00,0,NULL,NULL,'3','1'),
('04ff599d061fa14fbeaaaa3ae6035e17','1','0','2019-12-10 16:06:13','2019-12-22 20:27:28','950241352d2ca62c3bbeb8b090db5b12','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,150.00,NULL,0.00,0,NULL,NULL,'0','0'),
('070af5eaaf4003c52c4e147bdbd819b2','1','0','2020-01-04 22:26:15','2020-01-04 22:26:15','b8fbedc79cf2976897a96d955eefcd2a','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','白色，移动，32G','106c4dc9184da01ce15e26f4256560d4','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',1,1905.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('0882f88d63207066078b45ba0ab30f8b','1','0','2019-12-10 18:50:01','2019-12-22 20:27:28','46a9be50a863fd68c2b11067d3243c0e','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,135.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('08b9c3419d5c863d8c2e036de58d3412','1','0','2019-10-12 12:24:36','2019-12-22 20:27:28','b0e385ed6d9842d8158bbd141bab7359','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/006r3PQBjw1f9xa634e8wj307w07ijrj.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('09c8783086878f332964b5e0832d835a','1','0','2020-01-09 16:35:15','2020-01-09 16:35:15','0947d14da4abe73884f48c8fa785a5b7','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('0c23194b7a5985a960e61f552a6421e1','1','0','2019-12-23 00:52:10','2019-12-23 00:52:10','9755037e9800d9278970e31307a81c22','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','4G全网通，256G，亮黑色','f3b7f08030e448c0aaca6895e65aa5e9','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,5488.00,0.00,5488.00,0.00,0.00,0,NULL,NULL,'0','0'),
('0ea7ec00b428279a3af54b4547544b17','1','0','2019-12-10 16:06:35','2019-12-22 20:27:28','f6dbea4ce4c77034be3cda083a29779d','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,135.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('0ffd0e99e1f3e2117f4079a046f35309','1','0','2019-09-26 14:17:02','2019-12-22 20:27:28','acef5ea74ea57ec1c9fe682441c19d8c','43768c89b11316e1edf56c2fd56f7751','佳能 M100微单15-45 EOS高清数码相机女学生款vlog美颜','套餐一','37a22f1afeef4c7e73501403f0c15468','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/9.jpg',1,7899.00,0.00,7899.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('1136ac9994ad3b2c33d18ced94c0e354','1','0','2019-12-07 21:16:12','2019-12-22 20:27:28','63563b797ace467d8207281a86758e79','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('114f3b9437d6c98141cc7ad0efa76505','1','0','2019-12-05 11:10:47','2019-12-22 20:27:28','ca6814b085f2a6be6d73a35968c0289e','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,0.02,0.00,0.02,NULL,0.00,NULL,NULL,NULL,'0','0'),
('1215652314674495489','1','0','2020-01-10 23:11:12','2020-01-10 23:11:12','1215652314657718273','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1215652862731616257','1','0','2020-01-10 23:13:22','2020-01-10 23:13:22','1215652862719033346','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('1215652895753371649','1','0','2020-01-10 23:13:30','2020-01-10 23:13:30','1215652895740788738','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,0.00,0.00,0,NULL,NULL,'3','1'),
('1226746200599810050','1','0','2020-02-10 13:54:20','2020-02-10 13:54:20','1226746200524312578','2b48a2f35352a4d87d51d6dd03bb874e','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro',NULL,'965bac3dbc101b6abe68b72469118f03','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,600.00,0.00,600.00,0.00,0.00,0,NULL,NULL,'0','0'),
('1226746303226040321','1','0','2020-02-10 13:54:45','2020-02-10 13:54:45','1226746303205068802','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','4G全网通，256G，亮黑色','f3b7f08030e448c0aaca6895e65aa5e9','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,5488.00,0.00,5488.00,0.00,0.00,0,NULL,NULL,'0','0'),
('1226748004137947138','1','0','2020-02-10 14:01:30','2020-02-10 14:01:30','1226748004116975617','2b48a2f35352a4d87d51d6dd03bb874e','华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro',NULL,'965bac3dbc101b6abe68b72469118f03','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,600.00,0.00,600.00,0.00,0.00,0,NULL,NULL,'0','0'),
('13b3c3e62c646c918b0e3155708b35c6','1','0','2020-01-07 11:16:44','2020-01-07 11:16:44','892e059822941e4d9db157da07a457f2','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('168c7c5a0ee7e6dd2ac43c74740e0fd7','1','0','2019-12-13 22:26:32','2019-12-22 20:27:28','325146f0590a09785e52cd44eec24734','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',11,0.96,0.00,5.56,NULL,0.00,5,NULL,NULL,'0','0'),
('18b8b9802c8b4eddde68c240d9922cd3','1','0','2019-09-25 23:04:03','2019-12-22 20:27:28','121883467ada6b58ee4d85a228e2a673','747306ce2a0adebab78a481e2c470fb8','Amii极简法式气质连衣裙女2019秋新款收腰显瘦中长款撞色外套裙子','160，白色','8f44b6c53ab79086fa6f7edbaa9d0c8b','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/28.jpg',1,199.00,0.00,199.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('1a660b048472f399858b9e079483c97c','1','0','2019-12-10 16:59:03','2019-12-22 20:27:28','6d038bdf9d5a23f21a1b1d33e621c765','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('1a7f9a71ac051c887e665a0e5cffbdc3','1','0','2019-12-25 20:17:49','2019-12-25 20:17:49','cae005b6472f600ac4f6a253cd43e0a6','28a43d02e7292131173fd0cc16cf3df8','Huawei/华为 P30全面屏超感光徕卡三摄变焦双景录像980芯片智能手机p30','8+128GB，赤茶橘，4g全网通','030365cfa79ad1a3c1d34af1fba6e8d5','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01R8Jql91mbDmjt4uXi_!!2201435294972.jpg',1,3988.00,0.00,3988.00,0.00,0.00,0,NULL,NULL,'0','0'),
('1bf16dc1535249bc398e8c38df17933b','1','0','2019-12-09 14:40:43','2019-12-22 20:27:28','5b89c580123d15c2fcf8864442a41a0d','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('1ee6b0e818223ba91bd5c09184ac6777','1','0','2019-11-11 23:35:28','2019-12-22 20:27:28','9da85ae06bd72bc02d7287b08ae15f14','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',2,0.01,0.00,0.02,NULL,0.00,NULL,NULL,NULL,'1','0'),
('1fe690def31e8d5eaf1830899ff2b3b5','1','0','2019-09-22 21:39:17','2019-12-22 20:27:28','57234484563133b8d44866da5b9edd3d','3d2c153cb94c0a3fa24fc07f47dd801d','佳能m50微单相机女学生款Canon/佳能eos M50数码高清旅游vlog相机','套餐一','45fd58fda0cf4b406408385265f86c8e','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',1,6899.00,0.00,6899.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('20a4befc49e5bae785cbdf27b8140cd0','1','0','2019-12-25 13:07:52','2019-12-25 13:07:52','3af235b52fe58571d5fda0b9e2f207eb','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，64G，红色','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,0.00,2599.00,0.00,0.00,0,NULL,NULL,'0','0'),
('20a5f680ee484caecfb50d4e13a9cdcc','1','0','2019-11-17 16:29:23','2019-12-22 20:27:28','ec813fc104cb34f09745f2f471dd864a','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'4','1'),
('20e75d5d7e3f511120147bd36eaa4edb','1','0','2019-09-26 23:26:03','2019-12-22 20:27:28','66c5b8ee5fc03ded38110f49c9c064fd','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'0','0'),
('22c6604298a9c165a82360753fd52a05','1','0','2019-09-27 16:22:29','2019-12-22 20:27:28','c46b00a554a130e32181703d96fe3bac','ff3d6dd5a37ff42e2b67b87bd12d1d01','VIOMI/云米 BCD-456WMSD电冰箱双开门对开门智能风冷无霜家用小型','星光金','2467663a7b6432b726d5205088445559','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/20.jpg',1,1.00,0.00,1.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('2364f7d6c1c001df3d8bdb1562f80533','1','0','2019-12-11 17:55:08','2019-12-22 20:27:28','259aafab134d094d9125e7169c917671','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',3,5.00,0.00,15.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('23a25935e41bcb187e81daf40c0704ac','1','0','2019-09-22 21:39:17','2019-12-22 20:27:28','57234484563133b8d44866da5b9edd3d','a6a347b17dd360c30d792638a956d0e7','现货速发正品联保/Huawei/华为 畅享 MAX全面屏4g手机正品官方旗舰店7降价nova3i大屏智能手机畅想8plus','128G，4g全网通，超值大礼包， 幻夜黑','6891bfaf1109cdcaa5385bd39e07b457','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/27.jpg',3,3099.00,0.00,9297.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('23fb5c5d174540d328a343f725ec18f1','1','0','2019-12-10 15:11:09','2019-12-22 20:27:28','7c9741cff22cf3de06168ee3e0d155b3','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,135.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('2483285ff19803729d49eee7e056a511','1','0','2019-09-27 16:11:34','2019-12-22 20:27:28','6899afc86eac357fd8671f6ce5175c25','1b46c10d275262533b352329cc6d3af0','SIEMENS/西门子 KG28NV290C 三体全无霜 风冷大容量三门冰箱','官方标配，欧若拉银','5a0a1c24928af80a732cd179faac2d58','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/17.jpg',1,1.00,0.00,1.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('252565018d63f6d676fe37ce6800d0d8','1','0','2019-12-10 18:40:32','2019-12-22 20:27:28','930de4f191d7d35d5f99d7b693b28401','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,150.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('28811fc64eb0376bfdd349219da9f195','1','0','2019-12-10 16:09:32','2019-12-22 20:27:28','9d8f48766eb879f6bc985b59066c8a73','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,150.00,0.00,120.00,NULL,0.00,3000,NULL,NULL,'0','0'),
('290ea42626e57b52bcd74a1a99aba82d','1','0','2019-12-13 21:07:32','2019-12-22 20:27:28','928de7300421aaa3b6cead635b9970f4','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'4','1'),
('295f4af31588b2ae9276ecadcb180a9f','1','0','2019-12-23 11:52:50','2019-12-23 11:52:50','e76b5af69f877e1dc34ec1613d1f40e8','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,0.00,0.00,0,NULL,NULL,'3','1'),
('2a379b3bd2beda774d9f507950fdf35a','1','0','2019-09-24 18:02:10','2019-12-22 20:27:28','9fb19729e87dadb0daa45ee629109fc5','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','128G，4G全网通，亮黑色','5002eafdeca30f4c590b3288de5fa217','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'2','0'),
('2c764e51e47302b75c88ffd3a932b9f5','1','0','2019-12-10 18:47:58','2019-12-22 20:27:28','38818cc1a309b327516e14bc46f9157a','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,150.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('2d288dcf90644c7c9d9174ea1681326a','1','0','2019-09-24 20:12:17','2019-12-22 20:27:28','321f9e8cadbdbe6ce644a96879bea224','3d2c153cb94c0a3fa24fc07f47dd801d','佳能m50微单相机女学生款Canon/佳能eos M50数码高清旅游vlog相机','官方标配','c66b30ce583ec53e13f8add38a5bb223','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',1,5899.00,0.00,5899.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('2fc26f319174ba341061881e45c23552','1','0','2019-12-10 19:26:54','2019-12-22 20:27:28','3a5b1e9174b9e255202a5ec96c54434d','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,5.00,0.00,5.00,NULL,0.00,5,NULL,NULL,'3','1'),
('32e48f94f09bbf1ba3d61dc1d65323a0','1','0','2019-12-22 22:34:25','2019-12-22 22:34:25','2cab62434e22f1706f3aad9169c14ce2','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,40.00,NULL,10.00,500,'323a60758e0ccdfd671fbab4294e73f7',NULL,'0','0'),
('33375398c43346bbe7f9d25a9bf76a9f','1','0','2019-11-11 23:09:02','2019-12-22 20:27:28','6115800cf8afefa8250ce7984e5a7b0b','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,0.08,0.00,0.08,NULL,0.00,NULL,NULL,NULL,'0','0'),
('33829a3c0c1fb5cf29ccb02bad458658','1','0','2019-12-10 16:42:08','2019-12-22 20:27:28','8091efc67a4097d6815bf64522ff886f','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,150.00,0.00,150.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('355342f74cdbaf2f9b6b5935e1416242','1','0','2019-12-22 22:54:50','2019-12-22 22:54:50','8a959bc7bcb45dcfc6783ddac83ac819','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,50.00,NULL,5.00,500,'e66c5c472a692435dbf5d30fdaac73dc',NULL,'0','0'),
('38409e8b4bc5d1505160be41c1acfe1c','1','0','2019-12-10 17:12:46','2019-12-22 20:27:28','08bf99cebd379b5b3c7f3b94d7233d5e','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,150.00,0.00,270.00,NULL,0.00,3000,NULL,NULL,'0','0'),
('3a863b243a1a51230e27da12b592c185','1','0','2019-12-08 19:32:02','2019-12-22 20:27:28','365cf8107b5d5ae9a07281831ca84611','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',2,0.01,0.00,0.02,NULL,0.00,NULL,NULL,NULL,'3','1'),
('3b24e301bae73cd9cac6736843b8c98a','1','0','2019-12-10 16:48:33','2019-12-22 20:27:28','9e65c7ffa45a27425f086fb1c4c2e0d9','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,150.00,0.00,270.00,NULL,0.00,3000,NULL,NULL,'0','0'),
('3c51ac41ea90aca539516f8e0d9d824b','1','0','2019-10-11 13:33:51','2019-12-22 20:27:28','33644c8e4f806e5cdf8f9e9ba40fe575','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,3999.00,0.00,3999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('3e316b46274ea6178dcb3fb43189001d','1','0','2019-12-10 15:11:38','2019-12-22 20:27:28','ab2ad924fb04aaea7572a1e912b97475','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('3ef78ebf2007ffd7286f293a31325574','1','0','2019-12-10 19:25:50','2019-12-22 20:27:28','22cc5376b98e18057a2ac550d352f072','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,5.00,0.00,5.00,NULL,0.00,5,NULL,NULL,'0','0'),
('402004e8e20913ecebd65cef738cf9a7','1','0','2019-12-22 23:25:58','2019-12-22 23:25:58','1c17cbd0a96738abb10cef21ba5dbcde','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,29.00,NULL,5.00,500,'ac09aaf0f48bbfe6e332e28495ff88f1',NULL,'0','0'),
('4037f92320a0ea2ea1795bf3c388dab0','1','0','2019-12-13 22:45:09','2019-12-22 20:27:28','5d0fee215c983c7f56128ad6411c3dd6','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',11,1.00,0.00,6.00,NULL,0.00,5,NULL,NULL,'3','1'),
('40bceddb838df84d0ab6fd78c58503de','1','0','2019-09-25 23:04:03','2019-12-22 20:27:28','121883467ada6b58ee4d85a228e2a673','747306ce2a0adebab78a481e2c470fb8','Amii极简法式气质连衣裙女2019秋新款收腰显瘦中长款撞色外套裙子','175，黑色','ddd4c69b164f70d0c8863b19ef84f741','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/28.jpg',2,199.00,0.00,398.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('429102c2cda2f92eaf846a3560418b97','1','0','2019-12-24 21:46:35','2019-12-24 21:46:35','a68b57c3c77571824a71810684a9e76a','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,100.00,0.00,78.00,100.00,22.00,1000,'836128b3d4a1aa3c2bf13689f9f1df9e',NULL,'0','0'),
('4320cb7005bb28dac9f96f94b787529f','1','0','2019-12-10 14:16:19','2019-12-22 20:27:28','34f9011949e5fc242123b282a662bc88','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,135.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('4425a186740a6313b5fddaf4c4e86a4b','1','0','2019-12-10 16:59:03','2019-12-22 20:27:28','6d038bdf9d5a23f21a1b1d33e621c765','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,150.00,0.00,270.00,NULL,0.00,3000,NULL,NULL,'0','0'),
('45ba46553b0dc4f9a1f118d45f5c2b92','1','0','2019-12-13 22:51:41','2019-12-22 20:27:28','aff0c666e6e021fe476891a5f72289d0','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('464d4370d37b665b584954b2e98f419b','1','0','2020-01-05 12:04:55','2020-01-05 12:04:55','ec92ab324cf8a7479675914af5f5e3e0','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','64G，移动，红色','954060498a28ba885c504d9e9234a009','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2600.00,0.00,199.40,0.00,0.00,0,NULL,NULL,'0','0'),
('46672dc8f8812bee21c252c7bac296d6','1','0','2019-12-13 20:41:16','2019-12-22 20:27:28','f8c0502a4da10334aff326de2c90e77f','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,1.00,0.00,1.00,NULL,0.00,NULL,NULL,NULL,'3','1'),
('46dfe1768252fe71135c67a71212f5e0','1','0','2019-12-22 19:48:48','2019-12-22 19:48:48','831e13557faa7f8ade2a0108310ab33b','ff3d6dd5a37ff42e2b67b87bd12d1d01','VIOMI/云米 BCD-456WMSD电冰箱双开门对开门智能风冷无霜家用小型','星光金','2467663a7b6432b726d5205088445559','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/20.jpg',1,2999.00,0.00,2994.00,NULL,5.00,0,'e93e27c49c9caa155840b8714eb4d089',NULL,'0','0'),
('473a38d9adb00b069503ac8e0c4db003','1','0','2019-12-22 19:39:55','2019-12-22 19:39:55','1f6e883c5dcb764eaa819263ec429199','ff3d6dd5a37ff42e2b67b87bd12d1d01','VIOMI/云米 BCD-456WMSD电冰箱双开门对开门智能风冷无霜家用小型','星光金','2467663a7b6432b726d5205088445559','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/20.jpg',1,2999.00,0.00,2999.00,NULL,5.00,0,'218a65c1392ba18c125bedd5aca2d4cb',NULL,'0','0'),
('486367ca07ad076c5d5f049bcbceaa32','1','0','2019-12-10 15:38:45','2019-12-22 20:27:28','0b5d3836f5c6731345006f7ac70b3b1b','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,135.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('49543b3455c55e69f7a51a9259e97f31','1','0','2019-09-26 22:34:03','2019-12-22 20:27:28','5f1e9a65663da6450e73d623152ac806','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'0','0'),
('4afd8f8326e6ae2772f38f76eaa8b275','1','0','2019-12-10 14:00:16','2019-12-22 20:27:28','dcdc6021ef51bcc95903cacdf1034dc9','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,15.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('4b2b043e9678805979d31d16eb058e1c','1','0','2019-12-17 22:10:29','2019-12-22 20:27:28','bb4d1e9fe1f328aff59d32879dbc383b','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,0,NULL,NULL,'0','0'),
('4c00f1b577fa484646a53bf64021ebba','1','0','2019-12-22 23:51:23','2019-12-22 23:51:23','7963c0b61a1bb94fdfb223a24393cb8c','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,45.00,NULL,5.00,500,'cfd62b8d174159236d73a4f1d9b0368b',NULL,'0','0'),
('4c90a939688b95fab85a91643b114829','1','0','2019-12-13 22:23:08','2019-12-22 20:27:28','c89ea6f924fb4e2e358511f5a4366923','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',8,0.96,0.00,7.68,NULL,0.00,NULL,NULL,NULL,'0','0'),
('4ca0f95c52c583f966febc8df5ee12d9','1','0','2019-12-10 14:30:49','2019-12-22 20:27:28','0ea55844e7a07ea042a425b16b0bb82d','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,135.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('4d143ec4922e9590964f5e7cefffbfd9','1','0','2019-12-23 11:54:44','2019-12-23 11:54:44','42d56a01fa07401b93500891492f91b4','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,89.00,0.00,11.00,0,'b27a4689c4141ca0e7f9cd2e1316b6c2',NULL,'4','1'),
('4de7b1c1e6b329a4f408ea2badcc4b6b','1','0','2019-12-22 23:20:54','2019-12-22 23:20:54','7e8fe82cd6ca403407c571cebec837cc','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,89.00,NULL,11.00,0,'ee593745c958fd1c764e57c59c6a1c1a',NULL,'0','0'),
('4e43de91970d85aa3c9c72be73f2d723','1','0','2019-12-11 18:15:15','2019-12-22 20:27:28','14d5547124b3b332241f6ee98581b497','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',5,5.00,0.00,13.00,NULL,0.00,12,NULL,NULL,'0','0'),
('4fd52eabcd152b08cc6e3349e8ca9769','1','0','2019-12-10 14:30:49','2019-12-22 20:27:28','0ea55844e7a07ea042a425b16b0bb82d','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('50553f9fef3f376f2b769515d0c15abe','1','0','2019-12-22 23:19:35','2019-12-22 23:19:35','20f1e119ead6c2142828a75dbb72df69','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,23.00,NULL,11.00,500,'6286e6d8ca64048dd096fdbc8976bbb7',NULL,'0','0'),
('515bd43627dc033451289815ffa253a0','1','0','2019-12-07 21:10:31','2019-12-22 20:27:28','b33a4acac0fa8249fa7dfcc7fae50ee7','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,150.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('5169ad418fceac0e46dc7ec79597791c','1','0','2019-12-22 23:15:14','2019-12-22 23:15:14','fe5d7900b883725fa2ff04937abddc4b','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,23.00,NULL,11.00,500,'d9446f4c4136aa943c0384a616c1361f',NULL,'0','0'),
('544b280cc496660829f961284f0bfcfe','1','0','2019-11-16 22:15:22','2019-12-22 20:27:28','25f5f07e6f7c92e8a8adacd5e035f53f','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,0.08,0.00,0.08,NULL,0.00,NULL,NULL,NULL,'0','0'),
('554686a85b5721c0484b688c0b64a25e','1','0','2019-12-08 19:16:42','2019-12-22 20:27:28','6c72644f2f6b4944dedb343aec35fab2','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'1','0'),
('559f878734cebd9dc14608c9ca981eb3','1','0','2019-12-14 21:51:33','2019-12-22 20:27:28','9caa8497211da2e81a1dc2dfddb9d159','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,1.00,0.00,1.00,NULL,0.00,0,NULL,NULL,'0','0'),
('56f5395a003dd898ee0d7c3ff44000d8','1','0','2019-12-08 19:23:14','2019-12-22 20:27:28','73d5c5aaa16e434dc377bd97a1f15345','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',3,0.01,0.00,0.03,NULL,0.00,NULL,NULL,NULL,'3','1'),
('57c476a09bde404fff87c3985e1b6876','1','0','2019-09-22 20:32:34','2019-12-22 20:27:28','eb167ca7503b93b20d94ffb8c8f06497','40759ad0d99420e1c1ed79b67282bd74','华为平板 M6 10.8英寸 安卓平板电脑二合一安卓全网通4G通话手机m5 AI智能超薄大屏游戏2019新款平板正品ipad','86G，蓝色','f645c36b6a4572bcf93640267ef813b0','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1.jpg',4,4299.00,0.00,17196.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('57f2abd9ce022fe8d8f3f4c32b1332d9','1','0','2019-12-22 23:00:38','2019-12-22 23:00:38','f64db72b39fb95c2110d665866a29876','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,40.05,NULL,4.95,500,'ea75011399c7691d4cf49acde782e63d',NULL,'0','0'),
('584a680a26d125f80c2438c2546a4728','1','0','2019-09-24 08:44:14','2019-12-22 20:27:28','1a35de6cfe2c67a5043a636030be8d4d','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'1','0'),
('59208ddca6e2aad09aca691f305afd0a','1','0','2019-12-08 18:13:20','2019-12-22 20:27:28','4019a464bffd024e8a1023a7286c7b2a','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',2,0.01,0.00,0.02,NULL,0.00,NULL,NULL,NULL,'0','0'),
('59eef46d8b732b6329d0fccade0d37ca','1','0','2019-12-13 21:27:16','2019-12-22 20:27:28','62b6c7a2e0e25d1685a82fa2d66ff38f','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'4','1'),
('5a1ee3c8f86870b8e9adec85cc8129af','1','0','2019-12-07 21:15:34','2019-12-22 20:27:28','892a4cf26ffbfb01f5943fc65c76c961','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('5d254ecbf6b050e714fd9a598324029f','1','0','2020-01-04 21:16:15','2020-01-04 21:16:15','1ed7692628cd8bed4b9d73150cb36f8d','87ec583e2883cbd2fd259f47ece0fe15','可优惠900/送壕礼/Huawei/华为 Nova 4中移动手机正品官方旗舰店新款青春版3i2s 3e 32plus 4e 5高配版Pro','256G，4g全网通，极光色','401c62d0a62226e6209728629645677d','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/50.jpg',1,3599.00,0.00,3215.58,0.00,0.00,0,NULL,NULL,'0','0'),
('5d3d51700ac07e859e4936aafe9815a4','1','0','2020-01-09 16:40:29','2020-01-09 16:40:29','137a26bd00848c7547bcaaa65362727f','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','白色，移动，32G','106c4dc9184da01ce15e26f4256560d4','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',1,1905.00,0.00,0.01,0.00,0.00,0,NULL,NULL,'0','0'),
('5dee155ce9ff749e3d74c22e8d8780ed','1','0','2019-12-09 14:40:43','2019-12-22 20:27:28','5b89c580123d15c2fcf8864442a41a0d','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,150.00,0.00,300.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('5e9dd22fab63947be44bb91484e930d9','1','0','2019-12-22 19:36:58','2019-12-22 20:27:28','292d832901abd331ae9aac33ce038dc6','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',3,0.01,0.00,0.03,NULL,0.00,0,NULL,NULL,'0','0'),
('5ece99866bc63f9e7589d5422fe4e1da','1','0','2019-11-10 13:29:04','2019-12-22 20:27:28','12431271a31fb138248e25c6c7b4dfb3','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,0.08,0.00,0.08,NULL,0.00,NULL,NULL,NULL,'0','0'),
('60fb4ae1df486e5bfb06def79657619a','1','0','2019-12-07 21:15:39','2019-12-22 20:27:28','ac0142a7747f294f9c3a3e98bab5af1a','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('6104633688f6b69ac19e30ecd1d2a83a','1','0','2019-12-10 16:42:08','2019-12-22 20:27:28','8091efc67a4097d6815bf64522ff886f','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('6349d18b382a9e0857628296da9fa69e','1','0','2019-12-22 19:36:58','2019-12-22 19:36:58','292d832901abd331ae9aac33ce038dc6','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','红色，移动，64G','954060498a28ba885c504d9e9234a009','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2600.00,0.00,2590.00,NULL,10.00,0,NULL,NULL,'0','0'),
('63cfd65632b57050129000d05e3ed544','1','0','2019-12-09 14:40:05','2019-12-22 20:27:28','232772db16accb556beadcc9a1e2e246','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,150.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('6444c79f88167a4d26a107e3b5b96fd2','1','0','2019-12-10 16:09:32','2019-12-22 20:27:28','9d8f48766eb879f6bc985b59066c8a73','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('6666f2868b8c922a6aa8ac408646fc24','1','0','2019-11-11 22:41:46','2019-12-22 20:27:28','14144c785656ca143fb21c413570cf44','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'1','0'),
('66a93270076cba0c4e15d62fbdccc459','1','0','2019-10-11 12:30:32','2019-12-22 20:27:28','91e879113d0df7481fa12842b0881193','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,3999.00,0.00,3999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('66e3ffe108bb3496188a79b1cf0ed552','1','0','2019-09-22 18:10:35','2019-12-22 20:27:28','237342b610874be926fe1820e8b392dd','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','128G，4G全网通，亮黑色','5002eafdeca30f4c590b3288de5fa217','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('68bc57a5401d5b4b2d4d19e3abf5a990','1','0','2019-12-10 19:54:35','2019-12-22 20:27:28','3bfdc1097f6894c076cd0ced1e8e441c','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,5.00,0.00,10.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('692548f99b5f85a98831637cd8919c80','1','0','2019-12-07 21:15:13','2019-12-22 20:27:28','3d0f7116d9778fa411820982e695583a','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('6a56d3f0e0a6d4b9dd6b0bb4a213376e','1','0','2019-12-22 22:46:06','2019-12-22 22:46:06','7843aed947e1dcfeff83efedce7822c0','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,90.00,NULL,10.00,0,'afa8bbb93d958c922ec63f4877e32873',NULL,'0','0'),
('6b0f7ff1650d24d63ea45d5087094bf5','1','0','2019-09-25 15:28:46','2019-12-22 20:27:28','acc55e9d7cb355649cc981a5245f773a','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'0','0'),
('6b3f21ba6e9ce1df0c70c57b12f10211','1','0','2019-12-08 17:57:43','2019-12-22 20:27:28','4e213a6b3311c5235f05da78567459b1','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('6b7388b3204fcfba8dd549c9f1052a4f','1','0','2019-12-19 12:28:25','2019-12-22 20:27:28','a579eb33e49a65779c92154ab305b89b','ff3d6dd5a37ff42e2b67b87bd12d1d01','VIOMI/云米 BCD-456WMSD电冰箱双开门对开门智能风冷无霜家用小型','星光金','2467663a7b6432b726d5205088445559','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/20.jpg',1,2999.00,0.00,1500.00,NULL,0.00,1499,NULL,NULL,'0','0'),
('6cee38fd3f85f8f8140c4183db587fd0','1','0','2020-01-04 21:43:59','2020-01-04 21:43:59','69b79dd87f089e116013c1ffefdf2c25','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','电信，64G，红色','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,0.00,2000.00,0.00,0.00,0,NULL,NULL,'0','0'),
('6d6b168127f6b01785036c41dfd3c58a','1','0','2019-09-23 22:51:48','2019-12-22 20:27:28','d2cbcc9cef8fd57f6f250b35bb9f2091','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',2,0.10,0.00,0.20,NULL,0.00,NULL,NULL,NULL,'0','0'),
('6d8d85eb152215853e6812bc2bc2874c','1','0','2019-12-10 19:54:17','2019-12-22 20:27:28','622877447d84516302040b0ffee97b5f','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',2,1.00,0.00,2.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('6e513ee250f71892f58a0ad1e5ffc465','1','0','2019-09-27 17:01:45','2019-12-22 20:27:28','347167130f8d0c96bec85e385beaccfc','4d06c5157cce971b89166e509cdf63e8','小程序付款演示',NULL,'84d7a885ce5ef3d692d92c6a81dd9f45','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20190619223905.png',2,0.10,0.00,0.20,NULL,0.00,NULL,NULL,NULL,'0','0'),
('70e6efbeb28f39348b3b3e954085782c','1','0','2019-12-10 16:58:17','2019-12-22 20:27:28','d9c049a265763f00f40eb098564733d5','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,150.00,0.00,270.00,NULL,0.00,3000,NULL,NULL,'0','0'),
('71d68fd084fc11ca5be1996fdadc21a0','1','0','2019-12-23 11:08:42','2019-12-23 11:08:42','f8491ca4ec36b83fccf6164714df0a19','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,100.00,0.00,78.00,100.00,22.00,1000,'72349c37d2a4737d539619e116a4bbe7',NULL,'0','0'),
('71f7c1024d458aa6d0ef63f7ba9b8a4b','1','0','2020-01-05 12:02:25','2020-01-05 12:02:25','59c970dee9d68112f2f2c6efa3c8caef','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','64G，移动，红色','954060498a28ba885c504d9e9234a009','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2600.00,0.00,5.00,0.00,0.00,0,NULL,NULL,'0','0'),
('733002b3b538879a67c0af195631da7d','1','0','2019-10-10 10:17:18','2019-12-22 20:27:28','aeecab1f6989d5286bad2347cc0cf586','4d06c5157cce971b89166e509cdf63e8','小程序付款演示',NULL,'84d7a885ce5ef3d692d92c6a81dd9f45','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20190619223905.png',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'4','1'),
('734337bb2ff5a3e67fc887eeee1e1a6a','1','0','2019-11-19 11:50:47','2019-12-22 20:27:28','440c0344e18fa7634686b8d39f4e239b','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'3','1'),
('7363147f2e766a0e6c73535d3b31ea28','1','0','2019-12-25 20:36:52','2019-12-25 20:36:52','b33f655c889fe31da4af66e3292d1be2','28a43d02e7292131173fd0cc16cf3df8','Huawei/华为 P30全面屏超感光徕卡三摄变焦双景录像980芯片智能手机p30','8+128GB，4g全网通，亮黑色','cae1ef8086573a965f711278aec76dac','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01R8Jql91mbDmjt4uXi_!!2201435294972.jpg',1,3988.00,0.00,3988.00,0.00,0.00,0,NULL,NULL,'0','0'),
('73825c79a57d56b7f2f3a2a2c31fd000','1','0','2019-12-22 22:34:39','2019-12-22 22:34:39','004b18fbcb8d7c7134030effe9408c55','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,50.00,NULL,8.69,500,'f3eaa8c480bd709bfb87e4e4fa3320b7',NULL,'0','0'),
('73e3c581a0e04cd2644f8b3dc1d7a7ae','1','0','2019-09-25 21:13:45','2019-12-22 20:27:28','d18b276037bdef808f8618ab3a3aaf2c','43768c89b11316e1edf56c2fd56f7751','佳能 M100微单15-45 EOS高清数码相机女学生款vlog美颜','官方标配','f3273ea5922fcdbf67c03eac71f28900','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/9.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('74b971e5e5b4717865f099ee4506ceb0','1','0','2019-12-13 21:20:49','2019-12-22 20:27:28','2f72d8a30cc34a67462e11cc4f1535ae','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'4','1'),
('756fd85ae8946648d9a4a80dbc54cae5','1','0','2019-10-11 12:48:29','2019-12-22 20:27:28','30d56fb3b36fa5cf78d30911c3d01754','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,3999.00,0.00,3999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('75f5bb18461f42617649c824a0eb43ab','1','0','2019-09-22 21:40:01','2019-12-22 20:27:28','5e5a2db0541a440d194acc6996936eee','32ba699e9c291e801740077ae9a1889e','【7.12英寸大屏幕】Huawei/华为 畅享 MAX 全面屏水滴屏大电池长待机正品官方旗舰店 4G全网通智能手机89spxi','天际白，4g全网通，128G','3e10e228e08b1c8815b3111899cc549f','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/59.jpg',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'0','0'),
('7658c1610ee80aca5e2b7c9d4bade297','1','0','2019-12-08 18:31:38','2019-12-22 20:27:28','bde4a4ffe68a9a839cd5a21ddadfa0e6','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',2,0.01,0.00,0.02,NULL,0.00,NULL,NULL,NULL,'0','0'),
('767f2c379560295c829058d44f230f50','1','0','2020-01-04 21:58:04','2020-01-04 21:58:04','24b90b86b137d579080a0123f01c3f60','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','红色，电信，64G','416ab6fc443778d2a9fc5e7f4a9b0e00','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2599.00,0.00,2000.00,0.00,0.00,0,NULL,NULL,'0','0'),
('7869607bff662f71007984884286cdf9','1','0','2019-12-22 23:29:42','2019-12-22 23:29:42','bb8a6f0ed3d36e949cba3dd39c2f9f86','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,13.00,NULL,5.00,500,'645191ddc8e7a131f29e2812af16dd1b',NULL,'0','0'),
('788513a689a88ebd78c297574d4a2c26','1','0','2019-09-24 14:13:39','2019-12-22 20:27:28','876b7d66fef43fafb91df56570ac5191','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','128G，4G全网通，亮黑色','5002eafdeca30f4c590b3288de5fa217','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('79998a68f29caa93d35d77f7aa460466','1','0','2019-12-22 19:36:58','2019-12-22 20:27:28','292d832901abd331ae9aac33ce038dc6','ff3d6dd5a37ff42e2b67b87bd12d1d01','VIOMI/云米 BCD-456WMSD电冰箱双开门对开门智能风冷无霜家用小型','星光金','2467663a7b6432b726d5205088445559','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/20.jpg',1,2999.00,0.00,2999.00,NULL,0.00,0,NULL,NULL,'0','0'),
('7ac0f10bc5593cb098b2e0a6a3271a90','1','0','2019-12-10 14:11:26','2019-12-22 20:27:28','13ea5eab17fe3aea4117185d5f5e5bd3','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,135.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('7b3f417c7204d3db5bc52e0258efeb59','1','0','2019-12-05 11:13:21','2019-12-22 20:27:28','0454c03dc41b5de047b2f8d33c371646','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('7b975e2158243dbae2287e260fc8a8b8','1','0','2019-09-22 21:39:17','2019-12-22 20:27:28','57234484563133b8d44866da5b9edd3d','40759ad0d99420e1c1ed79b67282bd74','华为平板 M6 10.8英寸 安卓平板电脑二合一安卓全网通4G通话手机m5 AI智能超薄大屏游戏2019新款平板正品ipad','蓝色，64G','6b18b7db33857f362830a0287a781188','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1.jpg',2,3299.00,0.00,6598.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('7eceea4815201df04a091344c5655d43','1','0','2019-12-13 22:32:53','2019-12-22 20:27:28','b6afed4227d8ad1cf2f5a1cacd2b1ddc','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',11,0.96,0.00,5.56,NULL,0.00,5,NULL,NULL,'0','0'),
('7efb7d53c1f4a4a7880c2d9b41dcb933','1','0','2019-12-13 21:21:53','2019-12-22 20:27:28','ad1e87c5f0e67791d10c575420e139e4','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',10,1.00,0.00,5.00,NULL,0.00,5,NULL,NULL,'4','1'),
('80c0887eb5a42898b9e94cea1f380958','1','0','2019-11-19 12:06:21','2019-12-22 20:27:28','b2540f32b7c4ece122adbccaaf713d2c','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'3','1'),
('80c599a660e742493f00e161946f37d6','1','0','2019-12-25 13:08:51','2019-12-25 13:08:51','7fcd8633f4528cf2cbcd33d3cec469f5','58c12341a226b641435b9aa435a1133c','顺丰包邮/多重好礼 Huawei/华为 P20 Pro 手机全面屏徕卡三摄旗舰官方旗舰店正品全网通4G/Mate20/荣耀v20','4g全网通，128G，官方标配，亮黑色','0deafa0838dd542aba60900f9e8d3bb6','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/14.jpg',1,4599.00,0.00,4594.00,0.00,5.00,0,'6bed327b4bca82d404484870de7fe0c1',NULL,'0','0'),
('8217efe04eb45561f5edd435a8bb4c38','1','0','2019-12-22 23:22:01','2019-12-22 23:22:01','be09da098e6a5d494fd33f21804d81ca','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,39.00,NULL,11.00,500,'4c09f23f40e3f299f9d3d8096f2ca4f1',NULL,'0','0'),
('822d4c8519e460d9f22d398ae3b18b11','1','0','2019-12-10 20:37:45','2019-12-22 20:27:28','ced951d0f55223feb46e8a04bdeffe39','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,5.00,0.00,5.00,NULL,0.00,5,NULL,NULL,'0','0'),
('85aeb8f2bc6be26c66720a540cf25b8b','1','0','2019-12-13 22:31:47','2019-12-22 20:27:28','5b64f3a06e744aca1c2caebd6a0054b8','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',11,0.96,0.00,10.56,NULL,0.00,NULL,NULL,NULL,'0','0'),
('85e75acb05723886f3d819347d464f78','1','0','2019-12-25 13:08:21','2019-12-25 13:08:21','af2e2dc83cb26351ebb3f93e110e55d5','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',2,0.01,0.00,0.02,0.00,0.00,0,NULL,NULL,'0','0'),
('8be415b20c5793287b07de0ad724d8c3','1','0','2019-09-22 21:39:17','2019-12-22 20:27:28','57234484563133b8d44866da5b9edd3d','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','红色，移动，64G','954060498a28ba885c504d9e9234a009','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',2,2600.00,0.00,5200.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('8bf85cc7a38bb874fba669742e2331b8','1','0','2019-10-11 13:38:11','2019-12-22 20:27:28','cbfc47c2fba63318e74532c360453bb6','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,3999.00,0.00,3999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('8c9164790adb0752fc946f1c3af0b7ab','1','0','2019-12-22 19:36:58','2019-12-22 20:27:28','292d832901abd331ae9aac33ce038dc6','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',9,0.96,0.00,8.64,NULL,0.00,0,NULL,NULL,'0','0'),
('8ff7d1557ca8bdfbd1fe73374be563e3','1','0','2019-09-22 18:08:30','2019-12-22 20:27:28','ec8f3afc835ce71d213e77b28eda389f','43768c89b11316e1edf56c2fd56f7751','佳能 M100微单15-45 EOS高清数码相机女学生款vlog美颜','官方标配','f3273ea5922fcdbf67c03eac71f28900','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/9.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('9079b6079f4fa75ffdf6788fa48ef920','1','0','2019-12-22 23:21:19','2019-12-22 23:21:19','15151114044e407985cd9ae3c998a990','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,89.00,NULL,11.00,0,'7b5c189a524effdce5864df8241236fb',NULL,'0','0'),
('908c42a24e167a60bfb8b847ef5d1601','1','0','2019-12-23 12:28:13','2019-12-23 12:28:13','97cd22043056a49fca635dffe7a68b7a','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'924bb50d984d3ac3206b42f561ccf400','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',2,60.00,0.00,55.00,60.00,5.00,600,'1fb6c5d552eff6f2c8030b758263dede',NULL,'0','0'),
('921227dfaeacc6132d7fdbe02bc84676','1','0','2019-12-23 20:01:46','2019-12-23 20:01:46','bbdc4eb7d5125ad0650712d083676851','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,89.00,0.00,11.00,0,'56bb42b72c74e72ba8b5d8b699e0c03b',NULL,'0','0'),
('94d03b19f556d54e1f444b1e3a4385d5','1','0','2019-12-10 19:53:51','2019-12-22 20:27:28','35eeb0bd7d52bb8fff640b8c41b1b937','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,5.00,0.00,5.00,NULL,0.00,5,NULL,NULL,'0','0'),
('9530f72e8aea98a01484fd60f32d5dcb','1','0','2019-12-22 23:33:57','2019-12-22 23:33:57','9fa0de8f3cf3e6ee22e39315f388c418','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','移动，32G，红色','5033e1f2bfa07231d1c2045392fa2f93','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',1,2000.00,0.00,1900.00,NULL,100.00,0,'7aa510bdd0109f3cb6b344802c29c24a',NULL,'0','0'),
('961b39a64fa5acfebd09c65e3a6faabb','1','0','2019-12-22 19:53:50','2019-12-22 19:53:50','98edb7545734f4198c0133fc309e7639','ff3d6dd5a37ff42e2b67b87bd12d1d01','VIOMI/云米 BCD-456WMSD电冰箱双开门对开门智能风冷无霜家用小型','星光金','2467663a7b6432b726d5205088445559','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/20.jpg',1,2999.00,0.00,1495.00,NULL,5.00,1499,'b6f4f91ac64912bbcc529c158d614f70',NULL,'0','0'),
('98399e0d803e0af29a3d90659c3f7436','1','0','2019-09-24 20:31:37','2019-12-22 20:27:28','83775cbec35630784ef07d0835f15b12','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','128G，4G全网通，亮黑色','5002eafdeca30f4c590b3288de5fa217','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'1','0'),
('993794d1f8e6d90818fa0370eb800372','1','0','2019-12-13 22:22:54','2019-12-22 20:27:28','620c287b88d9093bba7b68d0216998f1','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',2,0.01,0.00,0.02,NULL,0.00,NULL,NULL,NULL,'0','0'),
('9bce728748da73ca1b3ac7aa289b0645','1','0','2019-11-05 12:15:02','2019-12-22 20:27:28','5bb598be27da4314c20f5d19d7b16314','28a43d02e7292131173fd0cc16cf3df8','Huawei/华为 P30全面屏超感光徕卡三摄变焦双景录像980芯片智能手机p30','4g全网通，极光色，8+256GB','b3cfdef62cc4b5589bbf4ebcd1255d83','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01R8Jql91mbDmjt4uXi_!!2201435294972.jpg',1,4488.00,0.00,4488.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('9c2a5204b3eaf9a84f3f0a62ae4e61ed','1','0','2019-12-13 22:18:33','2019-12-22 20:27:28','ffb41c44af103419a8604baf9065ce80','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',11,0.96,0.00,5.56,NULL,0.00,5,NULL,NULL,'0','0'),
('9c96b839182161a98f93fb3760b779fe','1','0','2019-12-25 14:25:47','2019-12-25 14:25:47','2267ca8b3a956564ce73c3c3c962fb5e','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,5.00,5.01,0.00,0.00,0,NULL,NULL,'0','0'),
('9cd652beb1e0435a6eb0ae719f0ea6ea','1','0','2020-01-05 11:46:19','2020-01-05 11:46:19','4d8110c160ce2a5ff7e70bd404dc2d2a','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','白色，移动，32G','106c4dc9184da01ce15e26f4256560d4','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',1,1905.00,0.00,0.00,0.00,0.00,0,NULL,NULL,'0','0'),
('9e0fc22a593059f463c0b61d060370ce','1','0','2019-12-10 19:09:50','2019-12-22 20:27:28','ece24ceedfed55f147a4c4fff606afe2','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,135.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('9f1e7154f38fab7083375fe42017ef0c','1','0','2019-12-08 18:09:55','2019-12-22 20:27:28','62dade081db06cae9f2f3636b66c1b84','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('a1a6adfaa133f4ad0e3e4f75b06f47a9','1','0','2019-12-10 20:42:20','2019-12-22 20:27:28','bcbbfcf1cfd50fa238adb0e3e78c74e2','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,5.00,0.00,5.00,NULL,0.00,5,NULL,NULL,'0','0'),
('a1d777b4a0bcee0ba132753297ec7f89','1','0','2019-11-11 22:35:13','2019-12-22 20:27:28','13945a4ba51a5516d9e3820394a5fe7e','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('a2cbfaeeb2612c0a4298837ec2d3cf2f','1','0','2019-09-22 21:36:54','2019-12-22 20:27:28','0a48bd981415d0c147f1a2cf2f63b882','ff3d6dd5a37ff42e2b67b87bd12d1d01','VIOMI/云米 BCD-456WMSD电冰箱双开门对开门智能风冷无霜家用小型','星光金','2467663a7b6432b726d5205088445559','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/20.jpg',1,2999.00,0.00,2999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('a2d20f35e6e4cf74b4717e7a7de6bf3f','1','0','2020-01-10 22:34:20','2020-01-10 22:34:20','1215643036660142082','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','白色，移动，32G','106c4dc9184da01ce15e26f4256560d4','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',1,1905.00,0.00,1695.45,0.00,209.55,0,'137e76d63acab1c73e7106299b1d80f4',NULL,'0','0'),
('a30a9571548535ba476dc6b8ca9a0bef','1','0','2019-12-22 23:23:29','2019-12-22 23:23:29','146f0f91681bbda8551b7ff6a3c7f109','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,34.00,NULL,11.00,500,'43a458e96bbeab3da79731f2f4f34a15',NULL,'0','0'),
('a7e6677ffaf82ac741a4c2a65326a47f','1','0','2019-12-10 16:06:43','2019-12-22 20:27:28','fa8bb487cda4d57d53d205965314a4bc','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,150.00,NULL,0.00,0,NULL,NULL,'0','0'),
('a814695513304a2962b8d0100bf086c2','1','0','2019-11-05 12:15:02','2019-12-22 20:27:28','5bb598be27da4314c20f5d19d7b16314','40759ad0d99420e1c1ed79b67282bd74','华为平板 M6 10.8英寸 安卓平板电脑二合一安卓全网通4G通话手机m5 AI智能超薄大屏游戏2019新款平板正品ipad','蓝色，64G','6b18b7db33857f362830a0287a781188','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01BG5vmo1i7DMlX8MRI_!!0-item_pic.jpg',1,3299.00,0.00,3299.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('aa7bc00aad569669968c76b4de01e0e2','1','0','2019-11-11 22:20:06','2019-12-22 20:27:28','0ca5ef62ace5018a2c168b4a7929536f','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('aaa66c54ecbfb00ae7e9561a9e3ad1a2','1','0','2019-12-10 16:06:22','2019-12-22 20:27:28','c873a913c6c5f6d4a7cf9688a8df1d2b','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,150.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('ab10b1c7707e915c00f11f75079aa255','1','0','2019-10-10 10:35:07','2019-12-22 20:27:28','e0e010f6e634ed02b56aa2fc9c4732bb','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,3999.00,0.00,3999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('ac319fd659b725c3d6ccb9955e7db4cd','1','0','2020-01-05 11:53:42','2020-01-05 11:53:42','139d6d1839bacfa8fa9576b0301e46dc','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','64G，移动，红色','954060498a28ba885c504d9e9234a009','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2600.00,0.00,1121.17,0.00,0.00,0,NULL,NULL,'0','0'),
('aeccc8caf732f796c5d9c652e5e44fe1','1','0','2019-12-22 22:57:40','2019-12-22 22:57:40','2d614bb632b1c339561831552dc58078','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,39.00,NULL,11.00,500,'f530f13ab869cd3d01368dfb0c6e6748',NULL,'0','0'),
('b0be8090a06eabb6c91f860fb517925c','1','0','2019-10-11 12:57:44','2019-12-22 20:27:28','0e920a987725e9cdae00b92ac1898785','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,3999.00,0.00,3999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('b19dcde4a09eefaf5dfe3a4609d5e284','1','0','2019-09-26 15:02:44','2019-12-22 20:27:28','53ccf04b952e1980342bf1778e5b998a','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'0','0'),
('b2a47047d44dc0a304c3bdbbc2b6d778','1','0','2019-11-05 12:15:02','2019-12-22 20:27:28','5bb598be27da4314c20f5d19d7b16314','43768c89b11316e1edf56c2fd56f7751','佳能 M100微单15-45 EOS高清数码相机女学生款vlog美颜','套餐一','37a22f1afeef4c7e73501403f0c15468','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/9.jpg',1,7899.00,0.00,7899.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('b350cb7a1b81567401d91b46d7f5e46d','1','0','2019-09-26 22:44:42','2019-12-22 20:27:28','6abfaf58a35a58807d1acaf96e321c18','1b46c10d275262533b352329cc6d3af0','SIEMENS/西门子 KG28NV290C 三体全无霜 风冷大容量三门冰箱','官方标配，欧若拉银','5a0a1c24928af80a732cd179faac2d58','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/17.jpg',1,1.00,0.00,1.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('b752f7b875c344cba7ec189ea24d3948','1','0','2019-10-11 12:45:58','2019-12-22 20:27:28','be173ebbcfd19d20eabc6d668f579671','ff3d6dd5a37ff42e2b67b87bd12d1d01','VIOMI/云米 BCD-456WMSD电冰箱双开门对开门智能风冷无霜家用小型','星光金','2467663a7b6432b726d5205088445559','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/20.jpg',1,2999.00,0.00,2999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('b786b92b881fe2439f2d7c2e20f9e878','1','0','2019-12-13 22:26:13','2019-12-22 20:27:28','6ecc17ad6a7ddd425e64b283bc98fe61','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',11,0.96,0.00,10.56,NULL,0.00,NULL,NULL,NULL,'0','0'),
('b9bd4d9555f4b370ea72cc92721adc11','1','0','2019-12-10 19:26:54','2019-12-22 20:27:28','3a5b1e9174b9e255202a5ec96c54434d','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',2,0.01,0.00,0.02,NULL,0.00,NULL,NULL,NULL,'3','1'),
('bb39c551d6e5814c9f5bcaa778d800a4','1','0','2019-09-24 20:12:17','2019-12-22 20:27:28','321f9e8cadbdbe6ce644a96879bea224','28a43d02e7292131173fd0cc16cf3df8','Huawei/华为 P30全面屏超感光徕卡三摄变焦双景录像980芯片智能手机p30','4g全网通，8+256GB，天空之境','5a2b3c606fada8b8537f136058ca21d0','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190826115920.png',1,4488.00,0.00,4488.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('bdc5a9860b1176eb276d70d9b17c07cd','1','0','2019-12-23 12:27:00','2019-12-23 12:27:00','8b26394ffdbeb4a48d8c1a834c2c7fc3','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'924bb50d984d3ac3206b42f561ccf400','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,60.00,0.00,30.00,30.00,0.00,300,NULL,NULL,'3','1'),
('bdcb152cbd0cfa25259f7f79b1607459','1','0','2019-12-10 16:03:26','2019-12-22 20:27:28','bc40a1ddcbe88e721d681f044a1cc281','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,135.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('bf4330d56551296090c9d96b67062819','1','0','2019-10-11 12:53:15','2019-12-22 20:27:28','787a945f8c532022acc28dd1b5a69545','ff3d6dd5a37ff42e2b67b87bd12d1d01','VIOMI/云米 BCD-456WMSD电冰箱双开门对开门智能风冷无霜家用小型','星光金','2467663a7b6432b726d5205088445559','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/20.jpg',1,2999.00,0.00,2999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('bf460a809ff4b5886c6317633eed44a0','1','0','2019-09-25 21:15:39','2019-12-22 20:27:28','630a070ac90008a20a4115f22bd48145','58c12341a226b641435b9aa435a1133c','顺丰包邮/多重好礼 Huawei/华为 P20 Pro 手机全面屏徕卡三摄旗舰官方旗舰店正品全网通4G/Mate20/荣耀v20','64G，4g全网通，极光色，官方标配','37c5999bb7fc76116999b7a19b99a851','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/14.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('c2feed535a7abb02233d41fe2c094130','1','0','2019-12-13 22:23:55','2019-12-22 20:27:28','af57473ecac0bbef1e8a6683ea25fd5e','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',13,1.00,0.00,7.00,NULL,0.00,6,NULL,NULL,'0','0'),
('c6279144f00ae29da601602d52e89a19','1','0','2019-12-22 22:25:19','2019-12-22 22:25:19','d2e03cb83d650e72813b0dff4095e7c2','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,50.00,NULL,11.00,500,'24b1e934a34d6034dabacf959425c25f',NULL,'0','0'),
('c8b0cc6e9eaa3945746e5673af1238f8','1','0','2019-10-11 12:59:01','2019-12-22 20:27:28','ffa700b06cbf0094c0c2f0cce2891c56','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,3999.00,0.00,3999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('c8f014a9a63920d6ad7519a4e5997dde','1','0','2019-12-11 18:13:59','2019-12-22 20:27:28','6be312492e1c46fcc53d3cf3e650a594','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',3,5.00,0.00,8.00,NULL,0.00,7,NULL,NULL,'0','0'),
('cb83fa70ec51f9ae3c63c8ddec5c7af2','1','0','2019-12-28 20:54:05','2019-12-28 20:54:05','5ac6c10de98f5c0cffd9dcaebfc620be','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','4G全网通，256G，亮黑色','f3b7f08030e448c0aaca6895e65aa5e9','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,5488.00,0.00,5473.00,0.00,15.00,0,'d280b72df60c8421d294cc66396f69fd',NULL,'0','0'),
('cdd8d24b649a22b4a4b92640f40c6483','1','0','2019-12-25 14:21:05','2019-12-25 14:21:05','149561ccfe412569cdfb2eeace97d271','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,5.00,95.00,0.00,10.00,0,'b3c602aa013aa92a63a7e28c8dc51986',NULL,'0','0'),
('cef08e6c6d09cd4f8462a81178fc1c38','1','0','2019-12-23 20:01:46','2019-12-23 20:01:46','bbdc4eb7d5125ad0650712d083676851','ff3d6dd5a37ff42e2b67b87bd12d1d01','VIOMI/云米 BCD-456WMSD电冰箱双开门对开门智能风冷无霜家用小型','星光金','2467663a7b6432b726d5205088445559','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/20.jpg',2,2999.00,0.00,5998.00,0.00,0.00,0,NULL,NULL,'0','0'),
('cf8e6ba07e940d7deced1ec27c1d3c35','1','0','2019-09-27 16:18:12','2019-12-22 20:27:28','bea0b0bacc1905c24b16550d809e7ddb','43768c89b11316e1edf56c2fd56f7751','佳能 M100微单15-45 EOS高清数码相机女学生款vlog美颜','官方标配','f3273ea5922fcdbf67c03eac71f28900','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/9.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('d06534d9b85107c9114ffab13bffa020','1','0','2019-12-22 23:22:33','2019-12-22 23:22:33','e94dde429ee43798f17bb4488ebbc356','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,39.00,NULL,11.00,500,'5cd5ab0fe84041c90533de8b04eb934b',NULL,'0','0'),
('d0990cf76d977c66bb369cddb51087b0','1','0','2019-12-10 18:38:33','2019-12-22 20:27:28','3423b6fec86fd7285f160f6f00b63815','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,150.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('d180138965eaee488fa61cb604f70b3c','1','0','2019-12-13 22:32:12','2019-12-22 20:27:28','31010048f676dd75d4165fa2993f38a6','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',11,0.96,0.00,10.56,NULL,0.00,0,NULL,NULL,'0','0'),
('d31f61495d054cd58b3936a50a114391','1','0','2019-12-23 11:28:28','2019-12-23 11:28:28','db64a11efa642c320457187c4475177f','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,40.00,50.00,10.00,500,'459dfebda70afc6fc5c1d4dcd6f5a10d',NULL,'0','0'),
('d4bf104d03dbc1b6e51e137dbcd8add0','1','0','2019-09-26 14:50:03','2019-12-22 20:27:28','2db258cd6704269cda038772b525e2df','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'0','0'),
('d7ecf7835f73a2e15fcd5e84e4f21216','1','0','2019-09-22 21:39:17','2019-12-22 20:27:28','57234484563133b8d44866da5b9edd3d','32ba699e9c291e801740077ae9a1889e','【7.12英寸大屏幕】Huawei/华为 畅享 MAX 全面屏水滴屏大电池长待机正品官方旗舰店 4G全网通智能手机89spxi','天际白，4g全网通，128G','3e10e228e08b1c8815b3111899cc549f','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/59.jpg',5,0.10,0.00,0.50,NULL,0.00,NULL,NULL,NULL,'0','0'),
('d8e626e695c6e600e045a0678d93b889','1','0','2019-12-08 19:16:42','2019-12-22 20:27:28','6c72644f2f6b4944dedb343aec35fab2','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',2,0.01,0.00,0.02,NULL,0.00,NULL,NULL,NULL,'3','1'),
('d90d2459da7b65f5e8dca2ad0712cda4','1','0','2019-11-10 13:50:43','2019-12-22 20:27:28','e7bcf3b65cf655aa884adc435995db4d','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','4G全网通，256G，亮黑色','f3b7f08030e448c0aaca6895e65aa5e9','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',1,5488.00,0.00,5488.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('d9af5a386236a9f07ff170d8aa7306c7','1','0','2019-12-25 14:25:47','2019-12-25 14:25:47','2267ca8b3a956564ce73c3c3c962fb5e','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,5.00,55.00,50.00,0.00,500,NULL,NULL,'0','0'),
('da065831b7ee13cabc7702c72e76674e','1','0','2019-12-23 12:31:38','2019-12-23 12:31:38','bb12631b1d7ece319d321e7b0989387f','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'924bb50d984d3ac3206b42f561ccf400','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',2,60.00,0.00,106.80,0.00,13.20,0,'6376f9503c3d405bd7eb905e7f056251',NULL,'0','0'),
('ddae9e90681d85679121751469be770f','1','0','2020-01-05 12:09:48','2020-01-05 12:09:48','b9e6080eb363a11b575ea7b265eab817','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','64G，移动，红色','954060498a28ba885c504d9e9234a009','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg',1,2600.00,0.00,5.00,0.00,0.00,0,NULL,NULL,'0','0'),
('de4b46d6bebf9fb8ed6351527c5b951b','1','0','2019-12-10 16:58:05','2019-12-22 20:27:28','aad03004d906981dac23224400f6b9fb','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,150.00,0.00,300.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('df0d231afb33d6c119188fdaea94391d','1','0','2019-12-10 16:03:16','2019-12-22 20:27:28','9ef278ec8748a3ae20e21ace6aa70bc0','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,150.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('e2845ff6e406d89bfb70d6a34cb17d63','1','0','2019-12-13 21:12:55','2019-12-22 20:27:28','9e12235fe6db8a619c7e868bd937ae02','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,1.00,0.00,1.00,NULL,0.00,NULL,NULL,NULL,'4','1'),
('e29dd8b1de61622e2f13093ce53fed83','1','0','2019-12-11 16:30:41','2019-12-22 20:27:28','dd444559680d7bf3357013dc80c4fadc','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,5.00,0.00,5.00,NULL,0.00,5,NULL,NULL,'3','1'),
('e36b0fd8338dfb42042d4f6010b5c413','1','0','2019-12-22 22:44:41','2019-12-22 22:44:41','59b6a491c18727d34c29d577affa8357','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,50.00,NULL,10.00,500,'b3cd4063b43ab8ccf924fa8d25390359',NULL,'0','0'),
('e51e020c84c31b775156fea1d30a63cb','1','0','2019-12-10 19:13:37','2019-12-22 20:27:28','18a84e4489b94308feac66e9b47e43b5','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,150.00,0.00,270.00,NULL,0.00,3000,NULL,NULL,'0','0'),
('e5960b9437f6fedf70296cdf7382079e','1','0','2019-12-11 14:55:59','2019-12-22 20:27:28','ce7418e33f685c9fa9ddf0a126b90536','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,5.00,0.00,5.00,NULL,0.00,5,NULL,NULL,'0','0'),
('e5c920ae21c2a4c785ffd4d7aa238b18','1','0','2019-10-11 09:57:50','2019-12-22 20:27:28','4b9a47cd30e1c5f17d1e53f2d7b1ba33','4d06c5157cce971b89166e509cdf63e8','小程序付款演示',NULL,'84d7a885ce5ef3d692d92c6a81dd9f45','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20190619223905.png',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'3','1'),
('e79fcc8f5b34b36574b354feae94246e','1','0','2019-10-11 13:39:45','2019-12-22 20:27:28','eb954bae32a17ce40184265b90e2c1c5','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,3999.00,0.00,3999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('e84a03dbf7e037b3103321b83baff68a','1','0','2019-12-10 19:57:27','2019-12-22 20:27:28','9edd79b02b3f9b01211e1a14276e8035','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',2,1.00,0.00,1.00,NULL,0.00,1,NULL,NULL,'3','1'),
('e867a279af2cfe8c3e8169dd8daf4eaf','1','0','2019-09-22 18:08:30','2019-12-22 20:27:28','ec8f3afc835ce71d213e77b28eda389f','6545a6fc2927edc195b93982f446917c','Huawei/华为P30 Pro曲面屏超感光徕卡四摄变焦980芯片智能手机p30pro','128G，4G全网通，亮黑色','5002eafdeca30f4c590b3288de5fa217','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg',2,0.01,0.00,0.02,NULL,0.00,NULL,NULL,NULL,'0','0'),
('e896b95692f85ceb3bd9ce417688125c','1','0','2019-12-08 18:13:20','2019-12-22 20:27:28','4019a464bffd024e8a1023a7286c7b2a','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('e985681b381a923f9c9a061560eea77d','1','0','2019-12-10 19:13:37','2019-12-22 20:27:28','18a84e4489b94308feac66e9b47e43b5','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('eb59c132e953759b78d4c8bcc85b7322','1','0','2019-12-19 12:28:25','2019-12-22 20:27:28','a579eb33e49a65779c92154ab305b89b','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,0.96,0.00,0.96,NULL,0.00,0,NULL,NULL,'0','0'),
('ebe33583232de06302c252cd5852d34d','1','0','2019-09-26 23:23:15','2019-12-22 20:27:28','e9497016faa3b937590e814ad0f9cf34','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'0','0'),
('ecab0d3f8311d4e3d02d235616114ecf','1','0','2019-11-19 11:04:51','2019-12-22 20:27:28','18ab28b4b5fde38271dbc129815892fe','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'3','1'),
('ef6e88a7637e8f626f5cc8aeb937d6fb','1','0','2019-12-10 16:54:51','2019-12-22 20:27:28','e0630d408069ec12bfeaec7e7d41ef0a','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,150.00,0.00,270.00,NULL,0.00,3000,NULL,NULL,'0','0'),
('ef8a7e4633d821e0086e38b8d562c559','1','0','2019-09-26 14:55:27','2019-12-22 20:27:28','4a56db8916471bc20cab4aad67049134','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.10,0.00,0.10,NULL,0.00,NULL,NULL,NULL,'0','0'),
('f11ab366a47b52eb6d6d5cb6dc18437c','1','0','2019-10-11 12:55:58','2019-12-22 20:27:28','17d415c706ba9c3367acc07cb8fc47e3','ff3d6dd5a37ff42e2b67b87bd12d1d01','VIOMI/云米 BCD-456WMSD电冰箱双开门对开门智能风冷无霜家用小型','星光金','2467663a7b6432b726d5205088445559','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/20.jpg',1,2999.00,0.00,2999.00,NULL,0.00,NULL,NULL,NULL,'0','0'),
('f27f7f3c68a7bb619be425e6cc8c843c','1','0','2019-11-19 11:50:47','2019-12-22 20:27:28','440c0344e18fa7634686b8d39f4e239b','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'4','1'),
('f54415aae5345a0f4898329471fc6e2e','1','0','2019-12-23 11:16:45','2019-12-23 11:16:45','cbd486fff7c53290dbfc2f2cee52e0d0','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,39.00,50.00,11.00,500,'2a1ee12742eec9eabaae9eb689499dda',NULL,'3','1'),
('f67558d8f6405a8174b79ab401318a0c','1','0','2019-12-25 13:04:18','2019-12-25 13:04:18','99ca0a3b389ba0f4ce4384efd8c65b27','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',3,0.01,0.00,0.03,0.00,0.00,0,NULL,NULL,'0','0'),
('f6f291e26d443d611994d8f58ee3e659','1','0','2019-11-11 23:35:28','2019-12-22 20:27:28','9da85ae06bd72bc02d7287b08ae15f14','ff39bc8f64b1d9b524b28c6000af8191','海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',NULL,'55a7d46eb9893cab480c70378d4dcefa','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'1','0'),
('f7d9aff8b9b0591bfa11f949e2f517c1','1','0','2019-12-10 19:03:36','2019-12-22 20:27:28','c2eb7b16c87aaae0d68ddc9fc82749b2','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,135.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('f85ea068f440b1e3c7e044f22e6c3335','1','0','2019-12-10 16:09:32','2019-12-22 20:27:28','9d8f48766eb879f6bc985b59066c8a73','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'0','0'),
('f8eaf89ff5b5040b64fc3875036dfdfd','1','0','2019-11-10 13:52:04','2019-12-22 20:27:28','fbbd2e59843b9b8d0ccd50d19c76aa13','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'3','1'),
('f907b06284254f3d2797f1761d596727','1','0','2019-12-23 00:52:10','2019-12-23 00:52:10','9755037e9800d9278970e31307a81c22','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,39.00,50.00,11.00,500,'f2e6885e65b5b6d98a077ee3b676eb74',NULL,'0','0'),
('fadd2638df1f8ef1dbc0055cde9de014','1','0','2019-12-08 19:29:29','2019-12-22 20:27:28','e56288074694855ca21b6d4e238d66e4','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','裸机','894b591741d425ca9c1b1579ce299a5b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg',1,0.01,0.00,0.01,NULL,0.00,NULL,NULL,NULL,'3','1'),
('fb46a7c5a831f7026ffbb3623d678daa','1','0','2019-12-13 22:31:58','2019-12-22 20:27:28','e540ae6ab29487d2bf9f5093665e779b','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',11,0.96,0.00,5.56,NULL,0.00,5,NULL,NULL,'0','0'),
('fc090f72ad31d1748dad31be3127ddcc','1','0','2019-12-22 23:23:03','2019-12-22 23:23:03','b56d19329930cf9593571de4e56abbe9','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,45.00,NULL,5.00,500,'3dce0906f5e928fbc354d7840499e6fd',NULL,'0','0'),
('fd1aee470cc6746368a4eecb535a66b1','1','0','2019-12-10 13:58:45','2019-12-22 20:27:28','416b0222a029ba53712937a1e4fff8d6','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,15.00,NULL,0.00,1500,NULL,NULL,'0','0'),
('fd86eff7d602e673f9f6d1bf5e13521e','1','0','2019-12-03 17:28:34','2019-12-22 20:27:28','3f2b18b858bab00986daede98686c5c3','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,0.08,0.00,0.08,NULL,0.00,NULL,NULL,NULL,'0','0'),
('fe133f78309e1ae5f5318fec8538bb6c','1','0','2020-01-10 22:35:06','2020-01-10 22:35:06','1215643229350662145','2835671ff031c18cb181b1a199f86b01','小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机','移动，32G，红色','5033e1f2bfa07231d1c2045392fa2f93','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/8.jpg',1,2000.00,0.00,2000.00,0.00,0.00,0,NULL,NULL,'0','0'),
('ff1e417d8c4bf655fc5fc5e4d1df82da','1','0','2019-12-23 00:43:35','2019-12-23 00:43:35','db77c548b30898f5a5ff5a73ec4de3f1','4d06c5157cce971b89166e509cdf63e8','小程序付款演示，不发货，不退款','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,100.00,0.00,39.00,50.00,11.00,500,'9fed10b6bc92ca6813a1b029c8ca1127',NULL,'0','0'),
('ffdb4397260fcc847fc9282eef5d44e0','1','0','2019-12-10 19:57:27','2019-12-22 20:27:28','9edd79b02b3f9b01211e1a14276e8035','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',2,5.00,0.00,5.00,NULL,0.00,5,NULL,NULL,'3','1'),
('ffea2625812666a546a4770811d4aafd','1','0','2019-12-10 17:12:21','2019-12-22 20:27:28','aaa0c4218d62feb36b42e9150fd1f25b','4d06c5157cce971b89166e509cdf63e8','小程序付款演示','超值大礼包','7cee91d08568afe4f8c2a7651f52be8b','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif',1,150.00,0.00,135.00,NULL,0.00,1500,NULL,NULL,'0','0');

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
('01aafa7795e594e6da088563644fa85c','1','0','2019-12-10 19:25:50','2019-12-10 19:25:50',NULL,'看在','18608419761','山西省太原市小店区的脸仍',NULL,NULL,NULL,NULL,NULL),
('01f9f9ef7c7da1c6092ce1b6f355db5d','1','0','2019-12-10 16:58:17','2019-12-10 16:58:17',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('033bdaf4a231127bd3924cab56c01902','1','0','2019-12-22 22:34:39','2019-12-22 22:34:39',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('0392add5633b13656062661854cb82c4','1','0','2019-09-26 14:50:03','2019-09-26 14:50:03',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作','shentong','773004973595665','1',NULL,NULL),
('04adb4d12812a25405c9156d6a0d01cd','1','0','2019-11-10 13:29:04','2019-11-10 13:29:04',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('0707185a19bf123aa680be9c2c5675be','1','0','2019-09-26 14:55:27','2019-09-26 14:55:27',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作','shentong','773004973595666','1',NULL,NULL),
('07931a31fa995ad08afc3a2d0679334a','1','0','2019-09-26 23:23:15','2019-09-26 23:23:15',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作','shentong','773004973595678','1',NULL,NULL),
('07f038e1b6271f2726145723de3386f3','1','0','2019-12-22 22:25:19','2019-12-22 22:25:19',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('088a5f037fc9603b7888b3fc4f6efd63','1','0','2019-11-12 09:41:32','2019-11-12 09:41:32',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)','huitongkuaidi','71496984844846','3','1','您已在长沙明发国际城2栋1单元店完成取件，感谢使用菜鸟驿站，期待再次为您服务。'),
('0a3d2e83f0a20541134e59e62c0f56be','1','0','2019-12-10 19:53:51','2019-12-10 19:53:51',NULL,'看在','18608419761','山西省太原市小店区的脸仍',NULL,NULL,NULL,NULL,NULL),
('0bbd833a181db8c05cff2a6ec43b9380','1','0','2019-12-10 14:16:19','2019-12-10 14:16:19',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('0cd7ec34ef784439a7de411508028945','1','0','2019-12-24 21:46:35','2019-12-24 21:46:35',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('0f7710cb03933b5c5b5b68ee32f3c0fd','1','0','2019-12-10 15:38:45','2019-12-10 15:38:45',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('11df2af2776c77dabd45a8d11a9fcc95','1','0','2019-09-22 21:40:01','2019-09-22 21:40:01',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('1215652314611580930','1','0','2020-01-10 23:11:12','2020-01-10 23:11:12',NULL,'266','18608419762','山西省太原市小店区jijiooo99879874',NULL,NULL,NULL,NULL,NULL),
('1215652862672896002','1','0','2020-01-10 23:13:22','2020-01-10 23:13:22',NULL,'266','18608419762','山西省太原市小店区jijiooo99879874',NULL,NULL,NULL,NULL,NULL),
('1215652895694651393','1','0','2020-01-10 23:13:30','2020-01-10 23:13:30',NULL,'266','18608419762','山西省太原市小店区jijiooo99879874',NULL,NULL,NULL,NULL,NULL),
('1226746200490758146','1','0','2020-02-10 13:54:20','2020-02-10 13:54:20',NULL,'466','18608419512','河北省石家庄市长安区463636',NULL,NULL,NULL,NULL,NULL),
('1226746303188291585','1','0','2020-02-10 13:54:45','2020-02-10 13:54:45',NULL,'466','18608419512','河北省石家庄市长安区463636',NULL,NULL,NULL,NULL,NULL),
('1226748004104392706','1','0','2020-02-10 14:01:30','2020-02-10 14:01:30',NULL,'466','18608419512','河北省石家庄市长安区463636',NULL,NULL,NULL,NULL,NULL),
('15742b91aff03f3126542ba0b6176bac','1','0','2019-12-10 16:09:32','2019-12-10 16:09:32',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('16234f7d436b897c8cf9c3d192eac161','1','0','2019-12-23 00:52:10','2019-12-23 00:52:10',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('166dd2a253dd7152739b613b5994cade','1','0','2019-12-13 22:26:32','2019-12-13 22:26:32',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('17b92f7973f7378eae3edf9d4ecf790f','1','0','2019-12-10 14:11:26','2019-12-10 14:11:26',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('193fbd99735020f8274a245dc382f65c','1','0','2019-12-10 17:12:46','2019-12-10 17:12:46',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('19cbcd46b2893f59a4ab5c5119920b05','1','0','2019-12-22 23:00:38','2019-12-22 23:00:38',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('1a443047e9f5c353a078ff738e92570d','1','0','2019-09-27 16:18:12','2019-09-27 16:18:12',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作','shentong','7730049735956565','1',NULL,NULL),
('1abc50d24b3e24aa2d27630ad3412912','1','0','2019-12-10 18:38:33','2019-12-10 18:38:33',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('1dce903847d3436e2425f154e94a7afd','1','0','2020-01-09 16:40:29','2020-01-09 16:40:29',NULL,'266','18608419762','山西省太原市小店区jijiooo99879874',NULL,NULL,NULL,NULL,NULL),
('1ded60def368328f9b6e8531b60623c0','1','0','2019-10-11 12:53:15','2019-10-11 12:53:15',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('1eb4e02ed43b703b180c4f0bb26176ff','1','0','2020-01-04 21:43:59','2020-01-04 21:43:59',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('1f466648fae89b1ce7940d95492063d1','1','0','2019-10-11 13:39:45','2019-10-11 13:39:45',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('2181b0694d5d5e938eeb18ccaab981cf','1','0','2019-12-23 11:16:45','2019-12-23 11:16:45',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('21e6fb4c38f345bf84723aa2e1321e0a','1','0','2019-09-23 22:51:48','2019-09-23 22:51:48',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('23f983f38b6c20894bd788e7c59d4411','1','0','2019-12-23 12:28:13','2019-12-23 12:28:13',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('268613dd1ab7380f874971dc1d2f0d40','1','0','2019-12-09 14:40:43','2019-12-09 14:40:43',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('2775c5bab49bdeb488ca870b4b7c6202','1','0','2019-12-25 14:21:05','2019-12-25 14:21:05',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('27d660170a193fbbe9a610e0d59e3243','1','0','2019-12-22 19:48:48','2019-12-22 19:48:48',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('28f18c73e25e271b59313d53b16855fc','1','0','2019-09-26 23:21:34','2019-09-26 23:21:34',NULL,'小七','15575663233','江苏省南京市玄武区有一个姑娘','shentong','773004973595667','1',NULL,NULL),
('294a3b1cb085bc1d6b42c810e6d37998','1','0','2019-12-25 13:08:21','2019-12-25 13:08:21',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('298c78c41937311d54190db40436270b','1','0','2019-09-25 21:13:45','2019-09-25 21:13:45',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('2f13694e03e41dcb940a366c002960e6','1','0','2019-09-25 21:15:39','2019-09-25 21:15:39',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('31ac318d4cd1e881c74c9044e6081f9d','1','0','2019-12-10 19:26:54','2019-12-10 19:26:54',NULL,'看在','18608419761','山西省太原市小店区的脸仍',NULL,NULL,NULL,NULL,NULL),
('34fac0fd99b74d140e4037c140bce918','1','0','2019-12-14 21:51:33','2019-12-14 21:51:33',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('368dcd2f42953da1b22557bde5014e6c','1','0','2019-12-13 22:18:33','2019-12-13 22:18:33',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('38b29fc148c7f20cf5907ac404c1f38c','1','0','2019-09-24 20:09:12','2019-09-24 20:09:12',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('38e5d7cc913db5c5da9bd5c608801202','1','0','2019-12-25 13:08:51','2019-12-25 13:08:51',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('3969e4c47cb1496349da741451c4e8ba','1','0','2019-12-23 11:54:44','2019-12-23 11:54:44',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗','yunda','4302972526338','3','1','[湖南安化县公司梅城镇分部]快件已被 您的快件已送达 梅城启安新区一雨物流 保管，地址：207国道东150米。如有问题请电联业务员：彭俊仁【13786716027】。相逢是缘,如果您对我的服务感到满意,给个五星好不好？【请在评价小件员处给予五星好评】'),
('3af415212108edd59cae3da481909cd7','1','0','2019-11-10 13:52:04','2019-11-10 13:52:04',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('3d0afed287410d6b2a49753f795eaed1','1','0','2019-12-10 19:54:44','2019-12-10 19:54:44',NULL,'看在','18608419761','山西省太原市小店区的脸仍',NULL,NULL,NULL,NULL,NULL),
('405097a0db377f25e53f8eb33d9f87d7','1','0','2019-12-13 22:23:54','2019-12-13 22:23:54',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('414d802fd8a53e32664471ca3aff937f','1','0','2019-09-22 21:36:54','2019-09-22 21:36:54',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('41c643520b51995678d13321114ad3c8','1','0','2019-09-27 16:22:29','2019-09-27 16:22:29',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作','shentong','7730049735954565','1',NULL,NULL),
('4223ea42d24f3894e35b364908a6cce7','1','0','2019-12-10 13:58:45','2019-12-10 13:58:45',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('423f2fc45949303c919e0900d0c4bc5c','1','0','2019-11-11 22:20:06','2019-11-11 22:20:06',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('45abad70d8dd98dba50177846f3d0f68','1','0','2019-12-11 18:13:58','2019-12-11 18:13:58',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('45d370d9ed78fb7fba79f2ecbb0039ff','1','0','2019-12-10 18:40:32','2019-12-10 18:40:32',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('4bd54c086afa05dea8590bc6333b2b10','1','0','2019-12-13 21:21:53','2019-12-13 21:21:53',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('4c52cf5f5746e8c0c225175e2e00a785','1','0','2019-11-11 23:35:28','2019-11-11 23:35:28',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)','yuantong','YT4185035097283','3','1','客户签收人: 已签收，签收人凭取货码签收。 已签收 感谢使用圆通速递，期待再次为您服务 如有疑问请联系：17872173637，投诉电话：0731-88558800'),
('4db98ff160a9272460fb6392f115c67c','1','0','2019-12-08 17:57:43','2019-12-08 17:57:43',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('5042d635d0a7581d2e302144d6fd37d9','1','0','2019-11-11 22:47:57','2019-11-11 22:47:57',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('507e78d1ece09add0100ae93099f63e6','1','0','2019-12-13 22:32:12','2019-12-13 22:32:12',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('517187b760951d8ba4c7ebce87aa467a','1','0','2020-01-05 12:04:55','2020-01-05 12:04:55',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('53dd7cdde7a135b84ebdc7e03ec54541','1','0','2020-01-05 12:09:48','2020-01-05 12:09:48',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('53e529332944b6057dc6d6cd83918e14','1','0','2019-12-10 19:13:37','2019-12-10 19:13:37',NULL,'看在','18608419761','山西省太原市小店区的脸仍',NULL,NULL,NULL,NULL,NULL),
('54fc956840a6e860b3c35ef7b686e600','1','0','2019-12-08 18:31:38','2019-12-08 18:31:38',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('5507eee2a7c83e97ae7fd05975d2c776','1','0','2019-12-13 22:26:13','2019-12-13 22:26:13',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('553ff3c5a3f9b259fac7667333b48d5d','1','0','2019-12-10 16:42:08','2019-12-10 16:42:08',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('56db2d1eefbb47f84e686fc308347e99','1','0','2019-12-13 20:41:16','2019-12-13 20:41:16',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('5942a8fda1ba1fb0c56bd81170d12212','1','0','2019-12-23 11:28:28','2019-12-23 11:28:28',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('596303c74cde4aca6e7fd6224abae382','1','0','2019-12-10 19:09:50','2019-12-10 19:09:50',NULL,'看在','18608419761','山西省太原市小店区的脸仍',NULL,NULL,NULL,NULL,NULL),
('59a0c2dff69a8aa2e9969067c235788a','1','0','2019-12-22 23:51:23','2019-12-22 23:51:23',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('5b7990c23c340cd586babb0c5c8f6287','1','0','2019-12-22 23:23:29','2019-12-22 23:23:29',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('5eac97c3ce86b80502dea9d48b82d97e','1','0','2019-09-26 22:26:08','2019-09-26 22:26:08',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('6482b745f25e9ca29dbbb0eefea04522','1','0','2019-12-22 23:01:20','2019-12-22 23:01:20',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('69766bdd9998cc5e7d7887dd531c2a60','1','0','2019-12-22 23:25:58','2019-12-22 23:25:58',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('69c08672255bb0369c181701941feb40','1','0','2019-09-26 22:44:42','2019-09-26 22:44:42',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作','shentong','773004973595661','1',NULL,NULL),
('6a57365da50553760fc8be6b26c722fc','1','0','2019-10-11 12:55:58','2019-10-11 12:55:58',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('6c5a093ff3c9788cba0cb1784528f7c0','1','0','2019-12-13 22:31:47','2019-12-13 22:31:47',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('6e93fe489f78018b48c02f861d5d348d','1','0','2019-10-11 09:57:50','2019-10-11 09:57:50',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)','yuantong','YT4129493124045','3','1','客户 签收人: 已签收，签收人凭取货码签收。 已签收 感谢使用圆通速递，期待再次为您服务'),
('6f1f808c87fc9fd6afa650d95d13b643','1','0','2019-12-10 18:50:01','2019-12-10 18:50:01',NULL,'战时','18608419762','北京市北京市东城区问题提问',NULL,NULL,NULL,NULL,NULL),
('700641e037b1a008ac3dc23109fac6d2','1','0','2019-11-16 22:15:22','2019-11-16 22:15:22',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('725a7f71a3388646bc0d65b23c351314','1','0','2019-10-11 12:57:44','2019-10-11 12:57:44',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('7575e4f08fe65437218f6b9b15fb124b','1','0','2019-12-08 19:29:29','2019-12-08 19:29:29',NULL,'厢相','18602156421','北京市北京市丰台区杨艳玲有舱称 人',NULL,NULL,NULL,NULL,NULL),
('76d9a7a6a146cfb347459a0a8a1d29c7','1','0','2019-10-12 12:24:36','2019-10-12 12:24:36',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('77dee9fb41e95bb841e25f700cdcb63e','1','0','2019-11-11 22:45:38','2019-11-11 22:45:38',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('78e898ac1642a56ffdd887f2f927215d','1','0','2019-12-22 23:15:14','2019-12-22 23:15:14',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('7ad2f1a05772732986b2c284190ebef7','1','0','2019-11-05 12:15:02','2019-11-05 12:15:02',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('7d3ea7e16d4712eebd13b57c6764d14d','1','0','2019-09-25 23:04:03','2019-09-25 23:04:03',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('7e4b68cd652264f352344eb76827fb8f','1','0','2019-12-10 15:11:09','2019-12-10 15:11:09',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('7f52ba7b90a710781f852ce6950b9c2a','1','0','2019-10-10 10:17:18','2019-10-10 10:17:18',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)','yuantong','YT4126057190655','1',NULL,NULL),
('807330c3b31bb9843004bbc4523de0db','1','0','2019-12-17 22:10:29','2019-12-17 22:10:29',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('80ad8e9d42acc772a8518af4e12a5d3f','1','0','2019-09-27 16:11:34','2019-09-27 16:11:34',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作','shentong','773004973595445','1',NULL,NULL),
('818d8e029e55be8897ee4d1097da1ea5','1','0','2019-12-10 18:47:58','2019-12-10 18:47:58',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('82a8510a2c30d3344abb9f977e740336','1','0','2019-11-11 23:09:02','2019-11-11 23:09:02',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('8306885ada2a59e97c7cac66916dd18d','1','0','2019-12-13 21:07:32','2019-12-13 21:07:32',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('84a095fbc28104bb6f74aebe177527cc','1','0','2019-12-10 16:59:03','2019-12-10 16:59:03',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('85f988c081f7284cc8e8e3a896882597','1','0','2019-12-05 11:13:21','2019-12-05 11:13:21',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('86d72e3f6b5fc4b74a063ca577561f69','1','0','2019-12-08 19:32:02','2019-12-08 19:32:02',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('8743e9bd446cfc9dd25a560db88e5578','1','0','2019-12-13 22:45:09','2019-12-13 22:45:09',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('8770de8cb44ed6875f852e916e3e3dc4','1','0','2019-12-22 19:39:55','2019-12-22 19:39:55',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('8a2086e559b191c7318a5bb6e74524b5','1','0','2019-10-11 12:30:32','2019-10-11 12:30:32',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('8c32387f1b02922e9c97a3cc81617bc2','1','0','2019-12-10 16:06:22','2019-12-10 16:06:22',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('8d105466300d35be18a4a04d1f8bbd01','1','0','2020-01-10 22:34:20','2020-01-10 22:34:20',NULL,'266','18608419762','山西省太原市小店区jijiooo99879874',NULL,NULL,NULL,NULL,NULL),
('8e0708e38c0d1a9e1673f5a437d13412','1','0','2019-12-11 18:15:15','2019-12-11 18:15:15',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('8f7314a3d0dff13a3b3e607a414f6077','1','0','2019-12-10 16:58:05','2019-12-10 16:58:05',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('905b49bb049416960fbd185a79fa9f5c','1','0','2019-09-22 20:32:34','2019-09-22 20:32:34',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('91c7009ec3c7e120b1d1da698851c2e4','1','0','2019-12-13 22:23:08','2019-12-13 22:23:08',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('946ab609f7ce1e6729a47542d5a55b95','1','0','2019-12-22 23:19:35','2019-12-22 23:19:35',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('94f20b6398cee0589a6c4b3b4827ccdb','1','0','2019-12-25 13:07:52','2019-12-25 13:07:52',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('9712d3a73c6a0d66e1d586d0a406a9a8','1','0','2019-12-08 19:23:14','2019-12-08 19:23:14',NULL,'厢相','18602156421','北京市北京市丰台区杨艳玲有舱称 人',NULL,NULL,NULL,NULL,NULL),
('9744cf514ce1c5d0cb44260c77dff88c','1','0','2019-12-25 13:04:18','2019-12-25 13:04:18',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('9749a895fa5765146d5dfb455bb182b7','1','0','2019-11-11 22:41:46','2019-11-11 22:41:46',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)','shunfeng','SF1013431828625','0','0','[长沙星沙中转场]快件到达 【长沙星沙集散中心】'),
('982323bd4b3f90a04a7d9a54d5113d4a','1','0','2019-12-08 18:09:55','2019-12-08 18:09:55',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('98b7cf1c64e1883ae12dfacde0f668db','1','0','2019-10-11 12:48:29','2019-10-11 12:48:29',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('98c14d70aa39c43c1c5641d4dd221988','1','0','2019-09-26 15:02:44','2019-09-26 15:02:44',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作','shentong','7730049735956645','1',NULL,NULL),
('9a01b8dd0b5dfa5c60c94220109823db','1','0','2019-11-17 16:29:23','2019-11-17 16:29:23',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('9a9e47fe012a198a55a593b281ac6ff2','1','0','2019-09-26 17:20:13','2019-09-26 17:20:13',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('9c20cb7bed63de5a778305af728774f1','1','0','2019-12-10 16:06:13','2019-12-10 16:06:13',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('9ca92fd0fdc75be1c0f9b35d7cc68b26','1','0','2019-09-24 08:44:14','2019-09-24 08:44:14',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('9ceaa24fc4d789258587fb6c6ed47abd','1','0','2019-10-11 13:38:11','2019-10-11 13:38:11',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('9d1b7648ebf8b7eb03c145b246460ee7','1','0','2019-12-10 16:06:35','2019-12-10 16:06:35',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('9dfa93ffd17fded2d8f229833806e172','1','0','2019-12-11 14:55:59','2019-12-11 14:55:59',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('9f863d28f9d5fa82cfe4beda1ba488d7','1','0','2019-09-24 18:02:09','2019-09-24 18:02:09',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('a016e5283ce7e7fe69313425b587ddb8','1','0','2019-12-23 20:01:46','2019-12-23 20:01:46',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('a1789b01ce1aa75b50a64b5830129447','1','0','2019-12-22 23:22:33','2019-12-22 23:22:33',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('a1cf0999fda1a4c7c8716ed10dda1834','1','0','2019-12-13 21:12:55','2019-12-13 21:12:55',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('a1d70348a44a5b07ba842f767ec79552','1','0','2019-12-07 21:16:12','2019-12-07 21:16:12',NULL,'张三','18608419768','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('a1e71935d76fa9ff398b3f664f0f5561','1','0','2019-11-19 12:06:20','2019-11-19 12:06:20',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('a6534a3db10211e701f80e5610fbdeb8','1','0','2019-09-25 15:28:46','2019-09-25 15:28:46',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('a670f841d6af1b68ad5f6916920a5ff8','1','0','2019-12-10 16:03:16','2019-12-10 16:03:16',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('a6d342b0c65def79e56ff4f3cc8a7f9c','1','0','2019-12-03 17:28:34','2019-12-03 17:28:34',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('a774240aa049d768ede9fd6127abd940','1','0','2019-11-10 13:50:43','2019-11-10 13:50:43',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('a7950c9d998da57050e497dd689dd7e3','1','0','2019-12-13 22:22:54','2019-12-13 22:22:54',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('a7bad42ca3c09feccd60089146341c4f','1','0','2019-12-07 21:10:31','2019-12-07 21:10:31',NULL,'张三','18608419768','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('a96d53d7bbe8d70897f23bb7d6dabe33','1','0','2019-12-10 15:11:38','2019-12-10 15:11:38',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('a9cece6226b5cd1b6bbc4ddd21563635','1','0','2019-09-22 21:39:17','2019-09-22 21:39:17',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('adc3cce1b085c3d10b2f8fbbcec42eea','1','0','2019-12-23 12:27:00','2019-12-23 12:27:00',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('ae6b7111bce74e201c777d43fb345fdb','1','0','2019-12-19 12:28:25','2019-12-19 12:28:25',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('aec77aba14745c1329aa5a2e636e32d2','1','0','2019-12-07 21:15:34','2019-12-07 21:15:34',NULL,'张三','18608419768','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('af689beb4451c54914ccd0ca00e26f52','1','0','2019-11-19 11:04:51','2019-11-19 11:04:51',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('b1c4412ea562908c9fc43bee4d646785','1','0','2019-11-11 22:35:13','2019-11-11 22:35:13',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('b2706cc2055a701554bdff47f4dade55','1','0','2019-12-22 23:22:01','2019-12-22 23:22:01',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('b2eb88115ab3b9f0ff831cd2f7c2b83e','1','0','2019-12-28 20:54:05','2019-12-28 20:54:05',NULL,'而也让','18608419762','山西省太原市小店区3463463',NULL,NULL,NULL,NULL,NULL),
('b352149938112b88b6757cff1a609faf','1','0','2019-09-24 20:31:37','2019-09-24 20:31:37',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('b5c8bd7947abb6a74499ee2d5125664c','1','0','2020-01-10 22:35:06','2020-01-10 22:35:06',NULL,'266','18608419762','山西省太原市小店区jijiooo99879874',NULL,NULL,NULL,NULL,NULL),
('b61913deb93a60f2dfeeb8fa12b862a5','1','0','2019-10-11 12:59:01','2019-10-11 12:59:01',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('b77472458a11d5cdabb5b39520e7659d','1','0','2019-12-25 20:36:52','2019-12-25 20:36:52',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('b811b13844c39726fd4cd8b2eaf4f667','1','0','2019-12-10 16:03:26','2019-12-10 16:03:26',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('b937f74ce4dd4ada92c7920a485861da','1','0','2019-10-10 10:35:07','2019-10-10 10:35:07',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('ba315d7c01e8b880ec86660e03724046','1','0','2019-12-22 23:20:54','2019-12-22 23:20:54',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('ba85486f349fc5683e933782484396cd','1','0','2019-09-26 14:17:02','2019-09-26 14:17:02',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('bc59379e9fa10380f793c584011f6e0c','1','0','2019-12-13 22:51:41','2019-12-13 22:51:41',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('bda4aefbc94348baad3747ef7a8493e6','1','0','2019-09-24 20:12:17','2019-09-24 20:12:17',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('bdb5d0736f324b1df02a9bf3e4687e10','1','0','2019-12-10 16:54:51','2019-12-10 16:54:51',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('bdee3e1c1c8ce696f53e063202579e8d','1','0','2019-12-13 22:31:58','2019-12-13 22:31:58',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('be12ba0d732f363733503961a34a7f78','1','0','2019-12-22 22:44:41','2019-12-22 22:44:41',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('be430e8aa0dfc6b125df0d13ad901fce','1','0','2019-09-26 21:40:34','2019-09-26 21:40:34',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('bfc8ab7d2c50ad4fdf2dcc41abe357b7','1','0','2019-12-08 19:16:42','2019-12-08 19:16:42',NULL,'厢相','18602156421','北京市北京市丰台区杨艳玲有舱称 人',NULL,NULL,NULL,NULL,NULL),
('c34cb09d7761426a4b8aba1cbea98b06','1','0','2019-12-22 23:29:42','2019-12-22 23:29:42',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('c53a5c416dc7ffb5937fc0ceda58e4bb','1','0','2019-09-22 18:08:30','2019-09-22 18:08:30',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)','shentong','773005164547663','3','1','已签收,签收人是（冯斌代签）先生/女士，风里来，雨里去，汗也撒泪也流，申通小哥一刻不停留。不求服务惊天下，但求好评动我心，给个好评呗！！如有疑问请联系派件员梁文卓(18307362848)，感谢使用申通快递，期待再次为您服务'),
('c6228667e48a755dfb5b8e9269e06522','1','0','2019-10-11 12:45:58','2019-10-11 12:45:58',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('c6a97a4965f6a2d958a9dde3dbd02ac4','1','0','2019-12-10 20:37:45','2019-12-10 20:37:45',NULL,'看在','18608419761','山西省太原市小店区的脸仍',NULL,NULL,NULL,NULL,NULL),
('c9fdbfab63c396069d7f737cfdf6d47c','1','0','2020-01-04 22:26:15','2020-01-04 22:26:15',NULL,'哦路','18608491673','上海市上海市黄浦区普通朋友，',NULL,NULL,NULL,NULL,NULL),
('cb5278cba777a023a01c5c5bb2955bc0','1','0','2020-01-04 21:16:15','2020-01-04 21:16:15',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('cc89d881899f2d0c353639c0ba70bc4d','1','0','2019-12-23 00:43:35','2019-12-23 00:43:35',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('d01adf5a359f380810d1de179194ee6e','1','0','2020-01-05 12:02:25','2020-01-05 12:02:25',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('d064a418a510e63b9a46fb37df18703c','1','0','2019-12-10 19:54:17','2019-12-10 19:54:17',NULL,'看在','18608419761','山西省太原市小店区的脸仍',NULL,NULL,NULL,NULL,NULL),
('d0a26457b84a7e7dfa953667f8836578','1','0','2019-12-10 14:00:16','2019-12-10 14:00:16',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('d14c827f640d431fb868841ae4d0c11b','1','0','2019-12-07 21:15:13','2019-12-07 21:15:13',NULL,'张三','18608419768','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('d223a2bdb24e51b227dacc9fcbe3def5','1','0','2020-01-04 21:58:04','2020-01-04 21:58:04',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('d2e242d9c0973f70f8a6ca467d025e76','1','0','2019-12-22 22:54:50','2019-12-22 22:54:50',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('d3948d05b191e8c3eba2adb523a4f36e','1','0','2019-12-10 14:30:49','2019-12-10 14:30:49',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('d610541e859d9b7e9902d227805d5313','1','0','2019-12-07 21:15:39','2019-12-07 21:15:39',NULL,'张三','18608419768','广东省广州市海珠区新港中路397号',NULL,NULL,NULL,NULL,NULL),
('d7446aeb4279f8bcdddcd76cb56c3a18','1','0','2020-01-07 11:16:44','2020-01-07 11:16:44',NULL,'445','18608419862','河北省石家庄市长安区wgsgwetwt',NULL,NULL,NULL,NULL,NULL),
('d7db6f62ffb4db3d302a922dc58decf5','1','0','2019-12-25 20:17:49','2019-12-25 20:17:49',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('d81b7ca0a9db9ee74b839dd813d303c5','1','0','2019-09-24 14:13:39','2019-09-24 14:13:39',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)','shentong','773004093868347','3','1','已签收,签收人是（073189530393代签）先生/女士，风里来，雨里去，汗也撒泪也流，申通小哥一刻不停留。不求服务惊天下，但求好评动我心，给个好评呗！！如有疑问请联系派件员湖南望城(15111474320,0731-89520939)，感谢使用申通快递，期待再次为您服务'),
('d8f101de8008e162cc30bffea29f7e9b','1','0','2019-12-10 19:57:27','2019-12-10 19:57:27',NULL,'看在','18608419761','山西省太原市小店区的脸仍',NULL,NULL,NULL,NULL,NULL),
('d9192465c4dbac432f92fcae953e223a','1','0','2019-12-23 12:31:38','2019-12-23 12:31:38',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('db8089b29b15242063753cc03d4d11a3','1','0','2019-09-26 22:34:03','2019-09-26 22:34:03',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作','shentong','773004973595662','1',NULL,NULL),
('dc3575bb285015a218c52c163f87937f','1','0','2019-12-22 19:36:58','2019-12-22 19:36:58',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('df61cc84826c557af261f316fcfdb738','1','0','2019-12-10 19:03:36','2019-12-10 19:03:36',NULL,'战时','18608419762','北京市北京市东城区问题提问',NULL,NULL,NULL,NULL,NULL),
('e0af1e662dcb95dbe277e1909c06aef4','1','0','2020-01-05 11:53:42','2020-01-05 11:53:42',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('e178b298c69496cb661d0a87a2c1d2d2','1','0','2019-12-10 16:06:43','2019-12-10 16:06:43',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('e2d3b8af56a583b4b283ed2f429222cc','1','0','2019-12-13 22:32:53','2019-12-13 22:32:53',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('e466ac92a8688fbd1c784a26f6b91285','1','0','2019-11-17 16:30:45','2019-11-17 16:30:45',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('e57288ba2b2cd94ffab299b5094fec50','1','0','2019-10-11 13:33:51','2019-10-11 13:33:51',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('e57fcc44ee3f369ed273f75546eb8b4b','1','0','2019-12-22 22:46:06','2019-12-22 22:46:06',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('e6665794d9a45e34f4010ec55a64bde6','1','0','2019-12-10 19:54:35','2019-12-10 19:54:35',NULL,'看在','18608419761','山西省太原市小店区的脸仍',NULL,NULL,NULL,NULL,NULL),
('e84c7497ef6be57e7b06cf51ae44988b','1','0','2019-12-22 23:23:03','2019-12-22 23:23:03',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('e84f451b5f84e90ead9665570728fa01','1','0','2019-12-25 13:36:35','2019-12-25 13:36:35',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('e8ead1d35c1f7e2ea65b176f2bda7d96','1','0','2019-12-10 20:42:20','2019-12-10 20:42:20',NULL,'看在','18608419761','山西省太原市小店区的脸仍',NULL,NULL,NULL,NULL,NULL),
('eb29960dd62de08d0253204da184d63c','1','0','2019-12-22 22:57:40','2019-12-22 22:57:40',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('eb56dca213a8f345e9a4a671089465a3','1','0','2019-12-13 21:20:49','2019-12-13 21:20:49',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('ed947e8cdd5b67644ecbf0935b7695f5','1','0','2019-11-19 11:50:47','2019-11-19 11:50:47',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('ef04a93387459b06764e8abdf85fc8f2','1','0','2019-12-22 23:33:57','2019-12-22 23:33:57',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('f10ecbf99adc7f192d928c301df23603','1','0','2019-09-22 18:10:35','2019-09-22 18:10:35',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)','shentong','770000217334993','3','1','已签收,签收人是（时代倾城二期十四栋快递之家代收，电话16607499909）先生/女士，风里来，雨里去，汗也撒泪也流，申通小哥一刻不停留。不求服务惊天下，但求好评动我心，给个好评呗！！如有疑问请联系派件员时代倾城二三期(16607499427)，感谢使用申通快递，期待再次为您服务'),
('f1527e94bc85171579ee279b9b14be8f','1','0','2019-09-27 17:01:45','2019-09-27 17:01:45',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作','shentong','773004973595669','1',NULL,NULL),
('f1f7aadfbd047abacf9d032a3722228c','1','0','2019-12-22 19:53:50','2019-12-22 19:53:50',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('f281ffe6cbc4e2ccb7e1e6afbc8aa734','1','0','2019-12-11 17:55:08','2019-12-11 17:55:08',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('f2bdac68ad7652b5fb3e6dfa1b45fa60','1','0','2019-12-10 16:48:33','2019-12-10 16:48:33',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('f34e6166ac69217de2cc6530e47c989b','1','0','2019-12-11 16:30:41','2019-12-11 16:30:41',NULL,'三大','18608419762','河北省石家庄市长安区枯耳听为耳听为我',NULL,NULL,NULL,NULL,NULL),
('f3928c4754a594ad8f0224c064285340','1','0','2019-12-05 11:10:47','2019-12-05 11:10:47',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('f4b10b3f6b20a2613b93f6e89284b0e2','1','0','2019-09-26 23:26:03','2019-09-26 23:26:03',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作','shentong','7730049735958865','1',NULL,NULL),
('f69666b805f46d3e9c16e8f97d5a2c6b','1','0','2019-12-23 11:52:50','2019-12-23 11:52:50',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('f6a699b43d4e869a146bec2f8cf35335','1','0','2019-12-23 11:08:42','2019-12-23 11:08:42',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('f6bbd9c8c32bd8916c6169dc2d876956','1','0','2019-09-26 18:10:36','2019-09-26 18:10:36',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('f6d956c3f4fee766212391b66ffb1bcf','1','0','2019-12-22 23:21:19','2019-12-22 23:21:19',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL),
('f7aad003699aff5b699b9ed766d4452d','1','0','2019-12-22 22:34:25','2019-12-22 22:34:25',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('f822185b186b54fb2ce16fe842e3a06f','1','0','2020-01-05 11:46:19','2020-01-05 11:46:19',NULL,'中','15639986655','黑龙江省哈尔滨市道里区行吗',NULL,NULL,NULL,NULL,NULL),
('f950af32c8e43a112a29c69cfe77db2e','1','0','2019-12-13 21:27:16','2019-12-13 21:27:16',NULL,'我们','18499797632','湖南省长沙市芙蓉区谢谢支持你的工作的工作',NULL,NULL,NULL,NULL,NULL),
('f9511fd1321a4f1f8757eb7d32a94491','1','0','2019-12-10 17:12:21','2019-12-10 17:12:21',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('fa30f89f6a1731be6fdb5c9b0517f45b','1','0','2020-01-09 16:35:15','2020-01-09 16:35:15',NULL,'266','18608419762','山西省太原市小店区jijiooo99879874',NULL,NULL,NULL,NULL,NULL),
('fa7ae098ddafedc87808f13f2f15ac63','1','0','2019-12-09 14:40:05','2019-12-09 14:40:05',NULL,'蝇头小利','18608419762','山西省太原市小店区晃滚叔产上站9',NULL,NULL,NULL,NULL,NULL),
('fe16250b2d94da66942628e3f6eb9fee','1','0','2019-12-08 18:13:20','2019-12-08 18:13:20',NULL,'李斌','18608419762','湖南省长沙市岳麓区腾讯众创空间长沙(长沙市岳麓区)',NULL,NULL,NULL,NULL,NULL),
('ff89411d13130c489efee960a33ac50c','1','0','2019-12-25 14:25:47','2019-12-25 14:25:47',NULL,'fsfg','18608513121','山西省太原市小店区dhdfhdfhery',NULL,NULL,NULL,NULL,NULL);

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
('00009223dd7d52c99415ce159d3b4b48','1','0','2019-11-11 23:40:36','2019-11-11 23:40:36','4c52cf5f5746e8c0c225175e2e00a785','2019-11-08 08:11:51','【湖南省长沙市望城县公司】 派件中 派件人: 侯灶勇 电话 17872173637 如有疑问，请联系：0731-88558800'),
('01ee323634117a31a7d45b2c05515086','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-16 21:36:28','已到达-湖南长沙转运中心'),
('0310b94d5f74630e8d34259e051030a9','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-15 19:15:11','重庆两路公司-永盛(13996306988)-已收件'),
('038adf212ecd260565ae12abee805e3b','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-11 01:24:55','[泉州康美托管仓]您的订单已审核'),
('058909daec262f6a1ee83b4b2ca385be','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-22 18:18:12','湖南望城公司-已发往-湖南长沙转运中心'),
('077b12fc48ff023fb53cea23220749c7','1','0','2019-11-11 23:40:36','2019-11-11 23:40:36','4c52cf5f5746e8c0c225175e2e00a785','2019-11-06 21:19:20','【广东省东莞市寮步公司】 已打包'),
('0831a86089626251b7ead0d906898214','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-12 05:27:55','快件到达 【泉州晋江航空站点】'),
('0cd37b1425ffe516a9f3a63a19beadde','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-23 06:19:41','湖南常德公司-已发往-湖南常德鼎城营业部'),
('0d7130792fe09b986bcceba156c0c4d8','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-23 16:39:12','已签收,签收人是（冯斌代签）先生/女士，风里来，雨里去，汗也撒泪也流，申通小哥一刻不停留。不求服务惊天下，但求好评动我心，给个好评呗！！如有疑问请联系派件员梁文卓(18307362848)，感谢使用申通快递，期待再次为您服务'),
('12478aba7cd7f2cc6a7cc47aea26fb40','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-16 01:34:17','已到达-重庆转运中心'),
('188da3b98bd080988c7bb7419e261650','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-21 20:21:14','已到达-湖南长沙转运中心'),
('199ffbb2d057b7c26dcc63b93babb3c2','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-23 04:45:02','快件已在【湖南常德转运中心】进行卸车，扫描员【徐亮】'),
('1d9eccc3d2a550ccae42a04caae164d7','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-10 03:00:34','【郑州转运中心】 已收入'),
('1deabb9ebeb46e97b1fa749bf517a5fd','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-15 19:17:40','重庆两路公司-已进行装车扫描'),
('1e1559d04e67eb1f86e4eb06d11fac28','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-16 21:55:01','湖南长沙转运中心-已发往-湖南望城公司'),
('1eef2bac5992b82ea39d31fa5a4906b5','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-09 18:00:12','【河南省郑州市中牟县公司】 已收件'),
('21614c74e93e23adfe4c000074f2f21c','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-12 06:21:38','快件在【泉州晋江航空站点】已装车,准备发往下一站'),
('2450f32bd86ee7924d3110adbac2dd57','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-10 19:54:16','【长沙转运中心】 已发出 下一站 【湖南省长沙市望城县公司】'),
('24a9814706e54007a08d2fa2ce33f2c3','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-15 19:17:40','重庆两路公司-已发往-重庆转运中心'),
('24aa4638adda74521b62acd43d4271a9','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-17 05:47:23','已到达-湖南望城公司'),
('24f259a3312d971025f07f1bc65685b8','1','0','2019-12-23 12:06:08','2019-12-23 12:06:08','3969e4c47cb1496349da741451c4e8ba','2019-12-19 03:15:58','[湖南长沙分拨中心]在分拨中心进行卸车扫描'),
('2571add7eded6f8f6d790d23f88446b7','1','0','2019-11-12 10:05:10','2019-11-12 10:05:10','088a5f037fc9603b7888b3fc4f6efd63','2019-10-21 12:37:00','您的快件已暂存至长沙明发国际城2栋1单元店菜鸟驿站，请凭取货码及时领取。如有疑问请联系13924992690'),
('28759f3c39cfb11417d1f872c2d2b696','1','0','2019-12-23 12:06:08','2019-12-23 12:06:08','3969e4c47cb1496349da741451c4e8ba','2019-12-18 03:08:49','[山东潍坊分拨中心]在分拨中心进行卸车扫描'),
('297336ec331016befe503958a503c59e','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-12 08:40:00','[泉州晋江航空站点]快件在【泉州飞往长沙航班上】已起飞'),
('2c3e5a2d643394ebf67d797e636878bf','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-11 08:57:40','【湖南省长沙市望城县公司】 派件人: 侯灶勇 派件中 派件员电话17872173637'),
('2d5663159a5b90381d989815d6b3c662','1','0','2019-11-12 10:05:10','2019-11-12 10:05:10','088a5f037fc9603b7888b3fc4f6efd63','2019-10-19 20:40:31','到汕头市【汕头转运中心】'),
('358cfa34d6dca619ddec1de24117de71','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-21 03:01:28','广东佛山转运中心-已装袋发往-湖南长沙转运中心'),
('35a4f2072e578716e87170f2bdc73ca6','1','0','2019-11-12 10:05:10','2019-11-12 10:05:10','088a5f037fc9603b7888b3fc4f6efd63','2019-10-19 20:42:33','汕头市【汕头转运中心】，正发往【长沙转运中心】'),
('35a5c0405e922b557c199fc6e8f4f258','1','0','2019-11-12 10:05:10','2019-11-12 10:05:10','088a5f037fc9603b7888b3fc4f6efd63','2019-10-20 17:42:26','长沙市【长沙转运中心】，正发往【望城】'),
('3cf45a3fd28d2ccca8a18f769d97d7cd','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-11 15:23:36','快件在【康美项目营业点】已装车,准备发往下一站'),
('3de16c37501cfd55b57651f6be1356d0','1','0','2019-11-12 10:05:10','2019-11-12 10:05:10','088a5f037fc9603b7888b3fc4f6efd63','2019-10-19 14:11:43','等待揽收中'),
('3fbe1630cff5acc95af35f522c78ba96','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-22 22:09:43','已到达-湖南长沙转运中心'),
('43bd2be2277abbd88f21a00a9d2b7390','1','0','2019-12-23 12:06:08','2019-12-23 12:06:08','3969e4c47cb1496349da741451c4e8ba','2019-12-20 17:26:02','[湖南安化县公司梅城镇分部]快件已被 您的快件已送达 梅城启安新区一雨物流 保管，地址：207国道东150米。如有问题请电联业务员：彭俊仁【13786716027】。相逢是缘,如果您对我的服务感到满意,给个五星好不好？【请在评价小件员处给予五星好评】'),
('454c7be9664a93d450f9d251a216ec13','1','0','2019-11-12 10:05:10','2019-11-12 10:05:10','088a5f037fc9603b7888b3fc4f6efd63','2019-10-19 09:28:06','商品已经下单'),
('496ae8e9b71c3256632b81ee35bd1747','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-11 14:13:01','[泉州康美托管仓]您的订单己出库'),
('49a5a88902b92d5b12e694bbb337504a','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-11 09:13:30','[泉州康美托管仓]您的订单正准备拣货'),
('4c284e500edff8ff3d23122cb93e88ac','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-21 00:54:18','广东佛山公司--已收件'),
('4d02b07269fa6a8606aad72a9523dcf5','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-18 22:48:37','已签收,签收人是（073189530393代签）先生/女士，风里来，雨里去，汗也撒泪也流，申通小哥一刻不停留。不求服务惊天下，但求好评动我心，给个好评呗！！如有疑问请联系派件员湖南望城(15111474320,0731-89520939)，感谢使用申通快递，期待再次为您服务'),
('514b1ec01239e96eccb11c98b42dc5cb','1','0','2019-11-11 23:40:36','2019-11-11 23:40:36','4c52cf5f5746e8c0c225175e2e00a785','2019-11-07 16:12:15','【长沙转运中心】 已发出 下一站 【湖南省长沙市望城县】'),
('568a55979ce3266637d2cf6c076e8af7','1','0','2019-11-12 10:05:10','2019-11-12 10:05:10','088a5f037fc9603b7888b3fc4f6efd63','2019-10-21 03:21:45','到长沙市【望城】'),
('596f650f344decb60140c84c58446eb4','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-22 18:18:12','湖南望城公司-已进行装车扫描'),
('5a4ae933bf222ec6f7b1d28907598ec6','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-22 22:11:01','湖南长沙转运中心-已进行装车扫描'),
('5b7574976172c24c5b02327d7f1c30ec','1','0','2019-12-23 12:06:08','2019-12-23 12:06:08','3969e4c47cb1496349da741451c4e8ba','2019-12-17 22:21:42','[山东青岛分拨中心]在分拨中心进行称重扫描'),
('5be666d6383c02c3c2eefc4de5605234','1','0','2019-11-11 23:40:36','2019-11-11 23:40:36','4c52cf5f5746e8c0c225175e2e00a785','2019-11-07 00:53:06','【虎门转运中心】 已发出 下一站 【长沙转运中心】'),
('607a44d5d5f10b39d804db1e948c19d4','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-11 06:38:56','【湖南省长沙市望城县公司】 已收入'),
('60949b099f77e12e400e9f5bc9a3921b','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-10 19:48:24','【长沙转运中心】 已收入'),
('60c1f6cc632490b0b57e5d5314fc1404','1','0','2019-12-23 12:06:08','2019-12-23 12:06:08','3969e4c47cb1496349da741451c4e8ba','2019-12-17 18:26:42','[青岛市场部文昌路分部]进行揽件扫描'),
('62ad48d730da891ba8606895dcc1cebf','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-22 22:11:01','湖南长沙转运中心-已发往-湖南常德转运中心'),
('6365a9a0563d30892f1b7641834b4b64','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-18 22:42:47','湖南望城公司-湖南望城(15111474320,0731-89520939)-派件中'),
('671eb7f0e05b532d68916e9cec1bf3cb','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-10 03:04:57','【郑州转运中心】 已发出 下一站 【长沙转运中心】'),
('74d7408f489a856edad22efc7b54eda2','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-21 02:13:26','广东佛山转运中心-已进行装袋扫描'),
('76b0dbdb913699062548504899e79fea','1','0','2019-12-23 12:06:08','2019-12-23 12:06:08','3969e4c47cb1496349da741451c4e8ba','2019-12-18 03:11:06','[山东潍坊分拨中心]进行装车扫描，发往：湖南长沙分拨中心'),
('78176c2596fb38d179c84c520f79a7e0','1','0','2019-11-12 10:05:10','2019-11-12 10:05:10','088a5f037fc9603b7888b3fc4f6efd63','2019-10-21 17:46:57','您已在长沙明发国际城2栋1单元店完成取件，感谢使用菜鸟驿站，期待再次为您服务。'),
('7dad34842672e4396511bb37fda432ff','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-23 04:46:36','湖南常德转运中心-已发往-湖南常德公司'),
('80366d8c21188957dd7253bdffd3e251','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-22 13:38:00','已签收,签收人是（时代倾城二期十四栋快递之家代收，电话16607499909）先生/女士，风里来，雨里去，汗也撒泪也流，申通小哥一刻不停留。不求服务惊天下，但求好评动我心，给个好评呗！！如有疑问请联系派件员时代倾城二三期(16607499427)，感谢使用申通快递，期待再次为您服务'),
('8041b5637aae05715f24916c539c7726','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-11 17:23:49','[康美项目营业点]快件已发车'),
('8073aa5b1548704ceb4b4205f2bf7829','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-16 01:37:42','重庆转运中心-已发往-湖南长沙转运中心'),
('83b3d1d110933c1d0349b5bc7bdc015e','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-10 19:53:53','【长沙转运中心】 已收入'),
('8b9de4325501481d0f3b61d98ca32d74','1','0','2019-11-11 23:40:36','2019-11-11 23:40:36','4c52cf5f5746e8c0c225175e2e00a785','2019-11-07 00:48:49','【虎门转运中心公司】 已收入'),
('8fc4f308e76a6e981c3ad4cd54904b20','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-09 22:51:45','【河南省郑州市中牟县】 已发出 下一站 【郑州转运中心】'),
('90c32fd1eea762328a7d9e734b290e91','1','0','2019-11-11 23:40:36','2019-11-11 23:40:36','4c52cf5f5746e8c0c225175e2e00a785','2019-11-07 16:07:59','【长沙转运中心公司】 已收入'),
('931ec3e8e1999c9011bc0591672ea929','1','0','2019-11-12 10:05:10','2019-11-12 10:05:10','088a5f037fc9603b7888b3fc4f6efd63','2019-10-20 17:15:59','到长沙市【长沙转运中心】'),
('95784cf4d4585f67016ec52ce5eefd57','1','0','2019-11-12 10:05:10','2019-11-12 10:05:10','088a5f037fc9603b7888b3fc4f6efd63','2019-10-21 06:53:38','长沙市【望城】，【侯灶勇】正在派件'),
('95bd4cc11db34ef531cb4ce00255e10d','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-12 04:35:50','[泉州磁灶中转场]快件在【泉州磁灶集散中心】已装车,准备发往 【泉州晋江航空站点】'),
('98dc31fea1b512ff032dccc95631dd81','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-21 02:13:26','广东佛山转运中心-已发往-湖南长沙转运中心'),
('9d78ecd844db3695db73817ce8e364a6','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-12 09:49:00','[长沙星沙中转场]快件到达【长沙】，准备发往【长沙星沙集散中心】'),
('a2d80b2a2850fea5c2bb3b2334014566','1','0','2019-11-11 23:40:36','2019-11-11 23:40:36','4c52cf5f5746e8c0c225175e2e00a785','2019-11-08 11:15:00','快件已暂存至长沙明发国际城2栋1单元店菜鸟驿站，如有疑问请联系13924992690'),
('a431abc8a3bd19abdbc13091ebfde5d8','1','0','2019-12-23 12:06:08','2019-12-23 12:06:08','3969e4c47cb1496349da741451c4e8ba','2019-12-20 17:23:29','[湖南安化县公司梅城镇分部]进行派件扫描；派送业务员：彭俊仁；联系电话：13786716027'),
('a613ce95da5756de8ad71acf734f00e9','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-12 11:10:36','[长沙星沙中转场]快件到达 【长沙星沙集散中心】'),
('a63086d5cb828ed94b2a6f3f0688d6aa','1','0','2019-11-11 23:40:36','2019-11-11 23:40:36','4c52cf5f5746e8c0c225175e2e00a785','2019-11-08 16:56:41','客户签收人: 已签收，签收人凭取货码签收。 已签收 感谢使用圆通速递，期待再次为您服务 如有疑问请联系：17872173637，投诉电话：0731-88558800'),
('a707c7f971cea21fcec028eb678df0da','1','0','2019-11-11 23:40:36','2019-11-11 23:40:36','4c52cf5f5746e8c0c225175e2e00a785','2019-11-06 20:42:14','【广东省东莞市寮步公司】 已收件 取件人: 吉红梅 (18329150819)'),
('aa2eaf8e55dfcabd0bf3f90c33b8e39f','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-11 15:23:26','[康美项目营业点]顺丰速运 已收取快件'),
('ac32a5695e1310f6523ed6900905299b','1','0','2019-11-11 23:40:36','2019-11-11 23:40:36','4c52cf5f5746e8c0c225175e2e00a785','2019-11-06 21:31:11','【广东省东莞市寮步】 已发出 下一站 【虎门转运中心】'),
('ae9c1caad784b3216de0555c44df74ff','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-23 04:45:02','已到达-湖南常德转运中心'),
('aeb742b0854d2b7081beb61010fcff96','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-22 00:58:11','湖南长沙转运中心-已发往-湖南望城公司'),
('af2da175aaf37c532533dfc2df6329fd','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-09 21:27:42','【河南省郑州市中牟县公司】 已打包'),
('b010ed3dafb58e8e47680c591f726d5a','1','0','2019-12-23 12:06:08','2019-12-23 12:06:08','3969e4c47cb1496349da741451c4e8ba','2019-12-17 23:31:36','[山东青岛分拨中心]进行装车扫描，发往：山东潍坊分拨中心'),
('bcdde268b1360fc8f008c8003627de52','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-11 14:10:36','[泉州康美托管仓]您的订单已经打包完毕,准备出库.'),
('bda71494ee5219d9ac6d1c406608d8d7','1','0','2019-11-12 10:05:10','2019-11-12 10:05:10','088a5f037fc9603b7888b3fc4f6efd63','2019-10-19 16:55:06','【潮州潮安彩塘分部】揽收成功'),
('be2f93d68b037fb084789341d882be8b','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-11 21:38:50','[泉州磁灶中转场]快件到达 【泉州磁灶集散中心】'),
('bee0d8e7b87f6fe2fa9f912d446bf919','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-22 21:53:40','已到达-湖南长沙转运中心'),
('bf5df30cfadbc0fa9d81a094f5ce931e','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-23 12:55:24','已到达-湖南常德鼎城营业部'),
('bfdae63c43152f38acbc347c2cf8c8bb','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-22 08:12:17','湖南望城公司-时代倾城二三期(16607499427)-派件中'),
('c9b5740c518c3212b12f7b77eec2a8e3','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-23 15:20:37','湖南常德鼎城营业部-梁文卓(18307362848)-派件中'),
('c9c569e656651abd3e7326082e7efb24','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-16 01:37:42','重庆转运中心-已进行装车扫描'),
('ca48b922c3c03f62a3ec4d28d3144685','1','0','2019-12-23 12:06:08','2019-12-23 12:06:08','3969e4c47cb1496349da741451c4e8ba','2019-12-19 04:29:49','[湖南长沙分拨中心]从站点发出，本次转运目的地：湖南安化县公司梅城镇分部'),
('cf67ad06908a70ec946b07ba3bbfd3a8','1','0','2019-12-23 12:06:08','2019-12-23 12:06:08','3969e4c47cb1496349da741451c4e8ba','2019-12-17 23:22:39','[山东青岛分拨中心]进行中转集包扫描，发往：湘北地区包'),
('d4b61a9ed1cfa497498b7001bc05a39a','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-09 18:00:12','【河南省郑州市中牟县公司】 取件人: 王智慧 已收件'),
('dcf96000b5d4896a10a7b01a442e8826','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-11 14:28:44','快件已暂存至长沙明发国际城2栋1单元店菜鸟驿站，如有疑问请联系13924992690'),
('dfbf792bbad12c758ec0c1d78dc7535e','1','0','2019-10-11 18:07:29','2019-10-11 18:07:29','6e93fe489f78018b48c02f861d5d348d','2019-10-11 16:41:48','客户 签收人: 已签收，签收人凭取货码签收。 已签收 感谢使用圆通速递，期待再次为您服务'),
('dff6a5c69b954799803e1ea1cada7e96','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-17 22:18:53','派送不成功-原因：送无人,电话联系明日送'),
('e0e9bf99cdc5de2e06142534431d9708','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-21 01:57:07','已到达-广东佛山转运中心'),
('e85f44303925ff3b362ed238f5d37ae7','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-21 20:21:14','快件已在【湖南长沙转运中心】进行卸车，扫描员【进港五面扫6号】'),
('ea0ea62457703ecaeaacfd851a823150','1','0','2019-09-23 20:30:59','2019-09-23 20:30:59','c53a5c416dc7ffb5937fc0ceda58e4bb','2019-09-22 18:18:15','湖南望城公司-五十三区玫瑰园(16607499909,0731-89520939)-已收件'),
('ec431abe8436ef6b78c1677c9fc55bb8','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-22 07:57:31','已到达-湖南望城公司'),
('ef8b95c928f1a36d14a293f00fb3f8ab','1','0','2019-11-12 13:17:04','2019-11-12 13:17:04','9749a895fa5765146d5dfb455bb182b7','2019-11-12 05:01:48','[泉州磁灶中转场]快件已发车'),
('f8732fde5db654be0e51848586c7acd8','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-21 03:01:28','广东佛山转运中心-已进行装车扫描'),
('f8de47d86d5903b77950b31a263f5869','1','0','2019-09-22 18:22:37','2019-09-22 18:22:37','f10ecbf99adc7f192d928c301df23603','2019-09-20 17:57:20','广东佛山狮山分部-穆园075788721566(17689328751,0757-88048657)-已收件'),
('fce34c0d0e695ccaab9d1bced6140671','1','0','2019-09-24 15:45:04','2019-09-24 15:45:04','d81b7ca0a9db9ee74b839dd813d303c5','2019-09-18 22:45:30','派送不成功-原因：送无人,电话联系明日送');

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
('0378742a11a1d9c0b64e0345ef163bd6','1','0','2019-12-10 19:59:07','2019-12-10 19:59:20',NULL,'9edd79b02b3f9b01211e1a14276e8035','ffdb4397260fcc847fc9282eef5d44e0','11',5.00,NULL,'sh扔遥仍脸有 ',NULL),
('0539a7a7496de90b4c01d9e7f4f45633','1','0','2019-12-23 20:41:53','2019-12-25 13:50:07',NULL,'8b26394ffdbeb4a48d8c1a834c2c7fc3','bdc5a9860b1176eb276d70d9b17c07cd','11',60.00,'50300402562019122512880301654','咯',NULL),
('0e6345ff6d74a7d31babe848f9f5c518','1','0','2019-11-15 16:47:37','2019-11-18 18:57:49',NULL,'fbbd2e59843b9b8d0ccd50d19c76aa13','f8eaf89ff5b5040b64fc3875036dfdfd','11',0.01,'50300002412019111813280901976','大本营 仍 伤脑筋 人',NULL),
('1215653061583568898','1','0','2020-01-10 23:14:10','2020-01-10 23:18:08',NULL,'1215652895740788738','1215652895753371649','11',0.01,'50300702902020011014095699393','墨鱼JJ',NULL),
('1642754f710a13be236f99f0e4bd2ae6','1','0','2019-12-08 19:17:38','2019-12-08 19:18:06',NULL,'6c72644f2f6b4944dedb343aec35fab2','554686a85b5721c0484b688c0b64a25e','11',0.01,NULL,'而改为仍t和',NULL),
('165eb9b63af0081f0f64cbd55b4ef980','1','0','2019-12-23 11:26:49','2019-12-23 11:49:24',NULL,'cbd486fff7c53290dbfc2f2cee52e0d0','f54415aae5345a0f4898329471fc6e2e','11',100.00,'50300002732019122313765945567','们',NULL),
('18458c1adb3207aa630eafc61845fbed','1','0','2019-12-11 16:31:39','2019-12-11 16:31:52',NULL,'dd444559680d7bf3357013dc80c4fadc','e29dd8b1de61622e2f13093ce53fed83','11',5.00,NULL,'esgwe ',NULL),
('1a71776a06d78a8eae029ac8ab98410c','1','0','2019-12-08 19:24:06','2019-12-08 19:24:18',NULL,'73d5c5aaa16e434dc377bd97a1f15345','56f5395a003dd898ee0d7c3ff44000d8','11',0.01,NULL,'楔脸徐鹏',NULL),
('20729ee4cc42160ee344dcfffc8d140a','1','0','2019-12-23 20:42:13','2019-12-25 13:50:15',NULL,'e76b5af69f877e1dc34ec1613d1f40e8','295f4af31588b2ae9276ecadcb180a9f','11',0.01,'50300202722019122513814021174','咯',NULL),
('27913cf02b8e029605cdbb281d48473e','1','0','2019-12-25 13:45:39','2019-12-25 13:49:37',NULL,'114a360651d2d2914a4b6a0fbb410d89','04d4900b09067c500d703d91d199aad1','11',0.01,'50300702602019122513824717547','erwe',NULL),
('2bf55753adce6cc8626409982d160f2c','1','0','2019-12-13 21:13:17','2019-12-13 21:19:02',NULL,'9e12235fe6db8a619c7e868bd937ae02','e2845ff6e406d89bfb70d6a34cb17d63','211',1.00,'50300402652019121313631506263','啦啦',NULL),
('2f8ac35397b1cd35dae0bf1ffb2cccdf','1','0','2019-11-19 11:51:29','2019-11-19 11:52:44',NULL,'440c0344e18fa7634686b8d39f4e239b','734337bb2ff5a3e67fc887eeee1e1a6a','11',0.01,NULL,'按摩按摩',NULL),
('37a5b086075194b9cb0a0bfd9d8ff555','1','0','2019-11-19 11:53:37','2019-11-19 11:53:58',NULL,'440c0344e18fa7634686b8d39f4e239b','f27f7f3c68a7bb619be425e6cc8c843c','211',0.01,NULL,'控窑的他们都',NULL),
('3e0d5c4a8ec32de62137d29304124a19','1','0','2019-11-19 10:49:48','2019-11-19 10:50:29',NULL,'1a35de6cfe2c67a5043a636030be8d4d','584a680a26d125f80c2438c2546a4728','12',0.10,NULL,'sgsdgestwt','不奶亚克西仍徐鹏和'),
('3ebc7cc635601a4f0ac1af7550336d97','1','0','2019-12-13 21:09:29','2019-12-13 21:19:16',NULL,'928de7300421aaa3b6cead635b9970f4','290ea42626e57b52bcd74a1a99aba82d','211',0.01,'50300202812019121313644881396','嘻嘻',NULL),
('40c84c526b2b3f72375615a2b44b1d38','1','0','2019-12-10 19:43:29','2019-12-10 19:43:49',NULL,'3a5b1e9174b9e255202a5ec96c54434d','b9bd4d9555f4b370ea72cc92721adc11','11',0.01,NULL,'5999',NULL),
('43be93afcf8fa7498c970c6687104afa','1','0','2019-11-19 10:36:22','2019-11-19 10:41:12',NULL,'ec813fc104cb34f09745f2f471dd864a','20a5f680ee484caecfb50d4e13a9cdcc','211',0.01,NULL,'asfasfqwr',NULL),
('4af9522cc5680c3cbd90e0daa158dcaf','1','0','2019-12-13 20:42:10','2019-12-13 21:02:01',NULL,'f8c0502a4da10334aff326de2c90e77f','46672dc8f8812bee21c252c7bac296d6','11',1.00,'50300602782019121313612416734','杨艳玲e有人 ',NULL),
('5877913fccd8b8df3c9a69f7e9d6790a','1','0','2019-12-13 21:50:23','2019-12-13 22:55:08',NULL,'ad1e87c5f0e67791d10c575420e139e4','7efb7d53c1f4a4a7880c2d9b41dcb933','211',1.00,'50300102802019121313614342728','咯',NULL),
('6203b4eff61f52b8d08559143987bf47','1','0','2019-11-17 16:31:27','2019-11-18 15:40:39',NULL,'9c00fa0679b50c496c050d1ae7512c4a','037e287bc0c54f141760efb9aaac172f','21',0.01,NULL,'微信支付宝账号',NULL),
('62e25f7363d72ff6b12bc796dbd5034b','1','0','2019-11-19 12:06:51','2019-11-19 16:49:38',NULL,'b2540f32b7c4ece122adbccaaf713d2c','80c0887eb5a42898b9e94cea1f380958','11',0.01,NULL,'55555',NULL),
('6730d705a2e0fd3eacfc6fb115d784e5','1','0','2019-11-15 16:46:24','2019-11-18 17:33:10',NULL,'14144c785656ca143fb21c413570cf44','6666f2868b8c922a6aa8ac408646fc24','11',0.01,'50300002552019111813231618804','sdg伤脑筋仍欠',NULL),
('6ba089cb46722190dfc573ee838dedcb','1','0','2019-12-10 20:00:23','2019-12-10 20:00:34',NULL,'9edd79b02b3f9b01211e1a14276e8035','e84a03dbf7e037b3103321b83baff68a','11',1.00,NULL,'枯仍答',NULL),
('76b75e379712b3666d71171efc5489e4','1','0','2019-11-15 17:03:20','2019-11-15 17:03:20',NULL,'83775cbec35630784ef07d0835f15b12','98399e0d803e0af29a3d90659c3f7436','1',0.01,NULL,'ey的遥有人有遥',NULL),
('7d25d86b101ecb64fbedfdd300043e1e','1','0','2019-12-13 21:22:33','2019-12-13 21:28:05',NULL,'2f72d8a30cc34a67462e11cc4f1535ae','74b971e5e5b4717865f099ee4506ceb0','211',0.01,'50300702782019121313626372810','卡扣',NULL),
('7ebb4efd2be094a4e6eac88b4fc3d4a0','1','0','2019-11-15 11:58:19','2019-11-18 15:45:51',NULL,'19ad9bf03dbd5f99dae47e8da1bda3ac','0269446f75374c7d8b7f66a487d814fa','11',0.01,NULL,'346eyey',NULL),
('88b85fdc231782309997947fffe15b68','1','0','2019-12-08 19:32:51','2019-12-08 19:33:02',NULL,'365cf8107b5d5ae9a07281831ca84611','3a863b243a1a51230e27da12b592c185','11',0.01,NULL,'冰点小瞳87就',NULL),
('98ef7a4d12f634e9fb31e7f44f2055c1','1','0','2019-11-17 16:25:44','2019-11-17 16:25:44',NULL,'9fb19729e87dadb0daa45ee629109fc5','2a379b3bd2beda774d9f507950fdf35a','2',0.01,NULL,'䏌w你用w你答禾3人我作q我',NULL),
('98f06a11debd126ad5ac5bca64b855ed','1','0','2019-11-19 11:37:58','2019-11-19 11:40:04',NULL,'4b9a47cd30e1c5f17d1e53f2d7b1ba33','e5c920ae21c2a4c785ffd4d7aa238b18','11',0.10,NULL,'346436reyey',NULL),
('99fda35636fa4bd4887e9daecfae09b6','1','0','2019-11-15 13:59:08','2019-11-18 15:56:05',NULL,'9da85ae06bd72bc02d7287b08ae15f14','1ee6b0e818223ba91bd5c09184ac6777','11',0.01,NULL,'换地方 夺和人 有',NULL),
('b4a04c6d5c7fd8a23f28ccd3c375ca49','1','0','2019-11-19 11:48:30','2019-11-19 11:49:02',NULL,'aeecab1f6989d5286bad2347cc0cf586','733002b3b538879a67c0af195631da7d','211',0.10,NULL,'safsdgetwt',NULL),
('bb05df24e498c6c6999b2d9f58a0d287','1','0','2019-11-19 11:05:18','2019-11-19 11:05:55',NULL,'18ab28b4b5fde38271dbc129815892fe','ecab0d3f8311d4e3d02d235616114ecf','11',0.01,NULL,'噢噢噢哦哦',NULL),
('bff2885680280c5ea5087204f65c7ac6','1','0','2019-12-08 19:20:39','2019-12-08 19:20:51',NULL,'6c72644f2f6b4944dedb343aec35fab2','d8e626e695c6e600e045a0678d93b889','11',0.01,NULL,'在 舶请接受',NULL),
('c0832cc2f15b327040631effd7e09290','1','0','2019-11-15 16:39:56','2019-11-18 15:58:11',NULL,'9da85ae06bd72bc02d7287b08ae15f14','f6f291e26d443d611994d8f58ee3e659','11',0.01,NULL,'sgagwqt',NULL),
('c1b3f91f4a81a6cf4adf4dcf64b1aff1','1','0','2019-12-08 19:30:10','2019-12-08 19:30:28',NULL,'e56288074694855ca21b6d4e238d66e4','fadd2638df1f8ef1dbc0055cde9de014','11',0.01,NULL,'六产谰y',NULL),
('dd080b7e7f559eb54d3fb6adcc469334','1','0','2019-12-13 22:46:20','2019-12-13 22:47:40',NULL,'5d0fee215c983c7f56128ad6411c3dd6','4037f92320a0ea2ea1795bf3c388dab0','11',1.00,'50300502602019121313627938343','dfhsdsrhr在表热一热 衣的',NULL),
('e51fb2833be825ef855a992f407f8256','1','0','2019-12-10 19:33:48','2019-12-10 19:37:06',NULL,'3a5b1e9174b9e255202a5ec96c54434d','2fc26f319174ba341061881e45c23552','11',5.00,NULL,' 仍 仍2323 ',NULL),
('efbad989286b0ac126e63cc1876bd92d','1','0','2019-12-13 21:27:38','2019-12-13 21:27:59',NULL,'62b6c7a2e0e25d1685a82fa2d66ff38f','59eef46d8b732b6329d0fccade0d37ca','211',0.01,'50300302822019121313676706537','撒比',NULL),
('f00ca6aa1ae524ca7a68503ebd0a0ba3','1','0','2019-12-23 11:59:36','2019-12-23 12:00:20',NULL,'42d56a01fa07401b93500891492f91b4','4d143ec4922e9590964f5e7cefffbfd9','211',100.00,'50300102852019122313774037694','咯',NULL);

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
('1226519139465535490','1','0','2020-02-09 22:52:05','2020-02-09 22:52:05','1216917231801151490',3000,'会员初始积分',NULL,NULL,'1');

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
('07d647976e5ffd8ad1f98d3f7254a906','1','0','2019-12-06 15:54:39','2019-12-06 15:55:03','db2355c836d46016e7b2eb41146291ee','4d06c5157cce971b89166e509cdf63e8','7cee91d08568afe4f8c2a7651f52be8b',2,'小程序付款演示',150.00,'超值大礼包','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/61152cae-8dd2-4553-9992-33cd93075aff.gif'),
('1d23d6131f6c6df07ecc061e8df19cf7','1','0','2020-01-04 21:10:23','2020-01-04 21:10:31','8f978497ad772d58b94d84b356e0e341','4d06c5157cce971b89166e509cdf63e8','894b591741d425ca9c1b1579ce299a5b',1,'小程序付款演示，不发货，不退款',0.01,'裸机','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg'),
('25dad83047ec56e4b6710a59c2077e9c','1','0','2019-12-06 15:54:41','2019-12-06 15:54:41','db2355c836d46016e7b2eb41146291ee','4d06c5157cce971b89166e509cdf63e8','894b591741d425ca9c1b1579ce299a5b',1,'小程序付款演示',100.00,'裸机','https://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/1/material/0352cae9-2770-494e-9f08-97e474d90345.jpg'),
('2f366518ea60cfa3d82bdec65d5100b5','1','0','2019-09-26 17:49:44','2019-09-26 17:49:44','28b2540d9df9e078cd50548c1daae44f','ff39bc8f64b1d9b524b28c6000af8191','55a7d46eb9893cab480c70378d4dcefa',1,'海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',0.10,'','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg'),
('a47498c2e74e18d10bdef6230987c761','1','0','2019-12-05 19:59:15','2019-12-05 19:59:23','db2355c836d46016e7b2eb41146291ee','2835671ff031c18cb181b1a199f86b01','954060498a28ba885c504d9e9234a009',1,'小米9 4800万超广角三摄 6GB+128GB全息幻彩蓝 骁龙855 全网通4G 双卡双待 水滴全面屏拍照智能游戏手机',2600.00,'64G;红色;移动','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/7667c3f40823764d.jpg'),
('c9305454af1aaa61df7795c7f5fc000c','1','0','2019-12-05 11:14:24','2019-12-05 19:56:00','db2355c836d46016e7b2eb41146291ee','ff39bc8f64b1d9b524b28c6000af8191','55a7d46eb9893cab480c70378d4dcefa',2,'海信 BCD-220D/Q电冰箱家用三开门冷藏冷冻节能静音小型租房宿舍',0.01,'','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/21.jpg'),
('f71541feedd3b0c9b8f00e3d826eb0fc','1','0','2020-01-04 21:10:13','2020-01-04 21:10:13','8f978497ad772d58b94d84b356e0e341','2b48a2f35352a4d87d51d6dd03bb874e','965bac3dbc101b6abe68b72469118f03',1,'现货速发/分期免息/送座充榨汁机剃须刀Huawei/华为 P30 Pro手机正品官方旗舰店20降价mate20pro新款nova5pro',600.00,'','http://joolun-base-test.oss-cn-zhangjiakou.aliyuncs.com/O1CN01fSka3s1IOudDI765b_!!2616970884.jpg');

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
('1226746186997682177','1','0','2020-02-10 13:54:17','2020-02-10 13:54:17','1216917231801151490','466',NULL,'河北省','石家庄市','长安区','463636','18608419512','1'),
('1237e7b2c5c5c34476603eaeefbe2a07','1','0','2019-09-21 20:54:25','2019-09-21 21:40:52','db2355c836d46016e7b2eb41146291ee','李斌',NULL,'湖南省','长沙市','岳麓区','腾讯众创空间长沙(长沙市岳麓区)','18608419762','1'),
('2adcbadbdb3844dfc762e8e5467fa5d7','1','0','2019-12-17 22:10:27','2019-12-17 22:10:27','8f978497ad772d58b94d84b356e0e341','fsfg',NULL,'山西省','太原市','小店区','dhdfhdfhery','18608513121','1'),
('3451ef085cc8504d79d6128bdd597ac6','1','0','2019-12-08 19:32:00','2019-12-08 19:32:00','8cd7e1322a9a2e8d8e001c42e8f18708','蝇头小利',NULL,'山西省','太原市','小店区','晃滚叔产上站9','18608419762','1'),
('4941b1408a6c67e3fd75b065ffd05c6c','1','0','2019-12-22 21:57:46','2019-12-22 21:57:46','06c9cc6609e7ca1d6322e6c7d8436658','中',NULL,'黑龙江省','哈尔滨市','道里区','行吗','15639986655',NULL),
('566df44ba5e0fb1a4b647530ce6a491a','1','0','2019-12-10 19:09:33','2019-12-10 19:09:33','4a5e9b2f5812e571ae3da431f5fd02e3','看在',NULL,'山西省','太原市','小店区','的脸仍','18608419761','1'),
('5a5b870c53c1bfe95ac1e238517f9494','1','0','2019-09-21 21:24:23','2019-09-21 21:29:31','478d05c0ceb1bb61dcb4f658d7700511','我们',NULL,'湖南省','长沙市','芙蓉区','谢谢支持你的工作的工作','18499797632','1'),
('5d7afebc2532b3648e4e4494fdf66b4e','1','0','2020-01-09 16:35:09','2020-01-09 16:35:09','c9dd5a13672d3c7606d141c0efe29571','266',NULL,'山西省','太原市','小店区','jijiooo99879874','18608419762','1'),
('69f886f572270a3621cad1b59221e69b','1','0','2019-12-28 20:54:01','2019-12-28 20:54:01','04a33a653dc5fc3f6b0f20994026528b','而也让',NULL,'山西省','太原市','小店区','3463463','18608419762','1'),
('8366ae0279914ce31ebe5e1ad5fe1e7c','1','0','2019-12-07 21:10:27','2019-12-07 21:10:27','720045fbea9fee72db9b85a1c4f7bb53','张三',NULL,'广东省','广州市','海珠区','新港中路397号','18608419768','1'),
('92ab276cb59f0b9e23b0d26fc7807ee0','1','0','2019-12-10 18:49:56','2019-12-10 18:49:56','5ea925e292c7ec621865af76d557ce6a','战时',NULL,'北京市','北京市','东城区','问题提问','18608419762','1'),
('a3239b4e585bc93e5cf7b431b67c933c','1','0','2020-01-04 22:26:12','2020-01-04 22:26:12','e3af0f8e19857cd34b4f22be6504496f','哦路',NULL,'上海市','上海市','黄浦区','普通朋友，','18608491673','1'),
('aa847fb1f6d77237bb87ae1dd20cdb28','1','0','2019-12-08 19:16:36','2019-12-08 19:16:36','51dd99ae8131b7e5daed2a7babe67999','厢相',NULL,'北京市','北京市','丰台区','杨艳玲有舱称 人','18602156421','1'),
('ad04a9174dbcf85d0a7d12fba5af8af3','1','0','2019-12-08 16:17:52','2019-12-08 16:17:52','cfdf18f63da3129a15b4eaf76a562dcf','李斌',NULL,'湖南省','长沙市','岳麓区','腾讯众创空间长沙(长沙市岳麓区)','18608419762','1'),
('afd61362c2efa5418852a91d38b1339e','1','0','2019-09-26 23:21:24','2019-09-26 23:21:24','478d05c0ceb1bb61dcb4f658d7700511','小七',NULL,'江苏省','南京市','玄武区','有一个姑娘','15575663233',NULL),
('dc064a90c5a35fba59e7587fb23b6e0b','1','0','2020-01-07 11:16:41','2020-01-07 11:16:41','d6f42ee88d33d870cb3f333f6e21e247','445',NULL,'河北省','石家庄市','长安区','wgsgwetwt','18608419862','1'),
('e24c590f9183d9827b5e77c72d23ded9','1','0','2019-12-11 14:55:56','2019-12-11 14:55:56','4e132ba860e0e625bac8338bf00133bb','三大',NULL,'河北省','石家庄市','长安区','枯耳听为耳听为我','18608419762','1');

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
('07274498b9863565f9e9ae1abde0783f','1','0','2019-09-27 08:50:56','2019-09-27 08:50:56','1','db2355c836d46016e7b2eb41146291ee','1b46c10d275262533b352329cc6d3af0'),
('1215648420133208065','1','0','2020-01-10 22:55:43','2020-01-10 22:55:43','1','c9dd5a13672d3c7606d141c0efe29571','2835671ff031c18cb181b1a199f86b01'),
('1215648454765576193','1','0','2020-01-10 22:55:51','2020-01-10 22:55:51','1','c9dd5a13672d3c7606d141c0efe29571','6545a6fc2927edc195b93982f446917c'),
('1215648472402624514','1','0','2020-01-10 22:55:56','2020-01-10 22:55:56','1','c9dd5a13672d3c7606d141c0efe29571','87ec583e2883cbd2fd259f47ece0fe15'),
('1215648516396679170','1','0','2020-01-10 22:56:06','2020-01-10 22:56:06','1','c9dd5a13672d3c7606d141c0efe29571','2b48a2f35352a4d87d51d6dd03bb874e'),
('34791cede23b53ede693a414cf4f19a7','1','0','2019-09-27 08:51:19','2019-09-27 08:51:19','1','db2355c836d46016e7b2eb41146291ee','28a43d02e7292131173fd0cc16cf3df8'),
('abf1b7e3b9c96b560f46a87ec19041d8','1','0','2019-12-26 13:02:56','2019-12-26 13:02:56','1','8f978497ad772d58b94d84b356e0e341','87ec583e2883cbd2fd259f47ece0fe15'),
('bd5f03f138b4de974142b77ac5ad6e70','1','0','2019-09-27 00:03:58','2019-09-27 00:03:58','1','5fe98e483b0b64ade7f26674d172fd12','2835671ff031c18cb181b1a199f86b01'),
('bdd714d06b5b27ba186084708d49d103','1','0','2019-12-14 21:49:54','2019-12-14 21:49:54','1','4e132ba860e0e625bac8338bf00133bb','4d06c5157cce971b89166e509cdf63e8'),
('beb91d547731e545d62a95652010fa90','1','0','2019-12-22 21:23:35','2019-12-22 21:23:35','1','8f978497ad772d58b94d84b356e0e341','4d06c5157cce971b89166e509cdf63e8'),
('fa19047a26ffddc36b00d6e6fa0a37f1','1','0','2019-09-27 08:51:15','2019-09-27 08:51:15','1','db2355c836d46016e7b2eb41146291ee','2835671ff031c18cb181b1a199f86b01');

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
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商城用户';

/*Data for the table `user_info` */

insert  into `user_info`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`user_code`,`app_type`,`app_id`,`phone`,`user_grade`,`points_current`,`nick_name`,`sex`,`headimg_url`,`city`,`country`,`province`) values 
('1216917231801151490','1','0','2020-01-14 10:57:32','2020-01-14 10:57:32',108,'1','wxd5b98bbec200013b',NULL,1,3100,'JL','1','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJjjQuibXQqVVhEdrm7WbCHbcERL7m4LYLY1DgPAHsmc3NIiajXzacRP9GMmfcBIHDmbWjyIde3Unew/132','深圳','中国','广东');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
