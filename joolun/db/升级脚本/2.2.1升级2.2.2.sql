CREATE TABLE `base_mall`.`material` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '������ID',
  `type` char(2) NOT NULL COMMENT '����1��ͼƬ��2����Ƶ',
  `group_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '����ID',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�ز���',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '�ز�����',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='�زĿ�';

CREATE TABLE `base_mall`.`material_group` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '������ID',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '������',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='�زķ���';


ALTER TABLE `base_mall`.`goods_spu` ADD COLUMN `points_give_switch` CHAR(2) NULL COMMENT '�������Ϳ��أ�1�� 0�أ�' AFTER `del_flag`, ADD COLUMN `points_give_scale` INT NULL COMMENT '�������ͱ�����0~100��' AFTER `points_give_switch`, ADD COLUMN `points_deduct_switch` CHAR(2) NULL COMMENT '���ֵֿۿ��أ�1�� 0�أ�' AFTER `points_give_scale`, ADD COLUMN `points_deduct_scale` INT NULL COMMENT '���ֵֿ۱�����0~100��' AFTER `points_deduct_switch`, ADD COLUMN `points_deduct_max` INT NULL COMMENT '���ֵֿ����ʹ�û�����' AFTER `points_deduct_scale`, ADD COLUMN `points_deduct_min` INT NULL COMMENT '���ֵֿ�����ʹ�û�����' AFTER `points_deduct_max`; 

ALTER TABLE `base_mall`.`goods_spu` DROP COLUMN `points_deduct_min`, CHANGE `points_give_scale` `points_give_num` INT(11) NULL COMMENT '������������', CHANGE `points_deduct_scale` `points_deduct_scale` INT(11) NULL COMMENT '���ֵֿ���Ʒ��������0~100��', CHANGE `points_deduct_max` `points_deduct_amount` INT(11) NULL COMMENT '1�������ɵֶ���Ԫ'; 

ALTER TABLE `base_mall`.`goods_spu` CHANGE `points_deduct_amount` `points_deduct_amount` DECIMAL(10,2) NULL COMMENT '1�������ɵֶ���Ԫ'; 

CREATE TABLE `base_mall`.`vip_user` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '�ֻ�����',
  `app_type` char(2) NOT NULL COMMENT '��ԴӦ������1��С����2�����ں�',
  `app_id` char(2) NOT NULL COMMENT '��ԴӦ��id',
  `vip_grade` smallint(6) DEFAULT NULL COMMENT '��Ա�ȼ�',
  `points_current` int(11) DEFAULT NULL COMMENT '��ǰ����',
  `points_accrued` int(11) DEFAULT NULL COMMENT '�ۻ�����',
  `amount_accrued` decimal(10,2) DEFAULT NULL COMMENT '�ۻ����ѽ��',
  `number_accrued` int(11) DEFAULT NULL COMMENT '�ۻ����Ѵ���',
  `nick_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '�ǳ�',
  `sex` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '�Ա�1���У�2��Ů��0��δ֪��',
  `headimg_url` varbinary(1000) DEFAULT NULL COMMENT 'ͷ��',
  PRIMARY KEY (`id`,`phone`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='vip�û�';


DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '������ID',
  `app_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Ӧ��ID',
  `type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '����1��С������ҳ�ֲ�ͼ��2��С������ҳ����',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '֪ͨ��',
  `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '��ע',
  `enable` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '��1��������0���رգ�',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='�̳�֪ͨ';

/*Data for the table `notice` */

insert  into `notice`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`app_id`,`type`,`name`,`remarks`,`enable`) values 
('1','1','0','2019-11-09 20:08:12','2019-11-10 16:07:41','1','wxd5b98bbec200013b','1','С������ҳ�ֲ�ͼ',NULL,'1'),
('2','1','0','2019-11-09 20:19:26','2019-11-10 16:14:16','1','wxd5b98bbec200013b','2','С������ҳ����',NULL,'1');

/*Table structure for table `notice_item` */

DROP TABLE IF EXISTS `notice_item`;

CREATE TABLE `notice_item` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '������ID',
  `notice_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '֪ͨID',
  `type` char(2) NOT NULL COMMENT '����1��ͼƬ��2����Ƶ��3������',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '����',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '֪ͨ����',
  `page` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '��תҳ��',
  `content` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '����',
  `tag` varchar(10) DEFAULT NULL COMMENT '��ǩ',
  `enable` char(2) DEFAULT NULL COMMENT '��1��������0���رգ�',
  `sort` int(11) DEFAULT NULL COMMENT '�����ֶ�',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='�̳�֪ͨ����';

/*Data for the table `notice_item` */

insert  into `notice_item`(`id`,`tenant_id`,`del_flag`,`create_time`,`update_time`,`create_id`,`notice_id`,`type`,`name`,`url`,`page`,`content`,`tag`,`enable`,`sort`) values 
('1','1','0','2019-11-09 20:10:10','2019-11-10 18:38:18','1','1','1',NULL,'http://img14.360buyimg.com/cms/jfs/t1/41875/15/15234/177824/5d7e4bbdE9d92026d/a22352695fb54048.jpg','/pages/goods/goods-detail/index?id=2835671ff031c18cb181b1a199f86b01',NULL,NULL,'1',1),
('2','1','0','2019-11-09 20:10:36','2019-11-10 18:38:19','1','1','1',NULL,'http://img10.360buyimg.com/cms/jfs/t1/63177/15/10387/240991/5d7f9dceEeeb37fc9/836c313d04150d0f.jpg','/pages/goods/goods-list/index?categorySecond=862a74f109f7f14bcbfff1d5adf73cdc&title=%E5%8D%8E%E4%B8%BA',NULL,NULL,'1',2),
('3','1','0','2019-11-09 20:11:07','2019-11-10 18:38:19','1','1','1',NULL,'http://img12.360buyimg.com/cms/jfs/t1/52071/29/11410/442751/5d84357aE3604f88b/0da811f943ecd2d3.jpg','/pages/goods/goods-detail/index?id=58c12341a226b641435b9aa435a1133c',NULL,NULL,'1',3),
('4','1','0','2019-11-09 20:20:08','2019-11-10 18:38:24','1','2','3',NULL,'','/pages/goods/goods-detail/index?id=58c12341a226b641435b9aa435a1133c','С�����̳ǰ���ʽ���ߣ�Դ��0�����룬��������','����','1',1),
('5','1','0','2019-11-09 21:00:27','2019-11-10 18:38:25','1','2','3',NULL,'','','����ģ�鼴�����ߣ��۸��ϵ�����1999����������','�Ǽ�֪ͨ','1',2);

ALTER TABLE `base_mall`.`order_info` ADD COLUMN `app_type` CHAR(2) NOT NULL COMMENT 'Ӧ������1��С����' AFTER `update_time`, ADD COLUMN `payment_way` CHAR(2) NOT NULL COMMENT '֧����ʽ1���������2������֧��' AFTER `logistics_price`, CHANGE `payment_type` `payment_type` CHAR(2) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '֧������1��΢��֧����2��֧����֧��', ADD COLUMN `is_pay` CHAR(2) NOT NULL COMMENT '�Ƿ�֧��0��δ֧�� 1����֧��' AFTER `payment_type`, CHANGE `status` `status` CHAR(2) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '����״̬1�������� 2�����ջ� 3��ȷ���ջ�/����� 5���ѹر� 6���˿���' AFTER `is_pay`, ADD COLUMN `is_refund` CHAR(2) NULL COMMENT '�Ƿ��˿�1���ǣ�0����' AFTER `status`, ADD COLUMN `appraises_status` CHAR(2) NULL COMMENT '����״̬0��δ����1��������2����׷��' AFTER `is_refund`; 

UPDATE `order_info` SET `app_type` = '1' WHERE `app_type` = '';
UPDATE `order_info` SET `payment_way` = '2' WHERE `payment_way` = '';
UPDATE `order_info` SET `is_pay` = '1' WHERE `status` IN('1','2','3','4');
UPDATE `order_info` SET `is_pay` = '0' WHERE `status` IN('0','5');
UPDATE `order_info` SET `appraises_status` = '0' WHERE `status` IN('3');
UPDATE `order_info` SET `appraises_status` = '1' WHERE `status` IN('4');
UPDATE `order_info` SET `status` = '3' WHERE `status` IN('4');

UPDATE `goods_sku` SET `enable` = '1' WHERE `enable` = 'true';
UPDATE `goods_sku` SET `enable` = '0' WHERE `enable` = 'false';
ALTER TABLE `base_mall`.`goods_sku` CHANGE `enable` `enable` CHAR(2) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1' NOT NULL COMMENT '�Ƿ�����1���ǣ�0��'; 

ALTER TABLE `base_mall`.`order_info` DROP COLUMN `is_refund`, CHANGE `status` `status` CHAR(2) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '����״̬1�������� 2�����ջ� 3��ȷ���ջ�/����� 5���ѹر�'; 


CREATE TABLE `order_refunds` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '������ID',
  `order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '����ID',
  `order_item_id` varchar(32) DEFAULT NULL COMMENT '��������ID',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '�˿�״̬1�������� 2��ͬ�� 3���ܾ�',
  `refund_amount` decimal(10,2) NOT NULL COMMENT '�˿���',
  `refund_trade_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '�˿���ˮ��',
  `refund_reson` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '�˿�ԭ��',
  `refuse_refund_reson` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '�ܾ��˿�ԭ��',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='�����˿��¼��';
