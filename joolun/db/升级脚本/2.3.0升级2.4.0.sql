ALTER TABLE `base_mall`.`vip_user` ADD COLUMN `vip_code` INT NOT NULL AUTO_INCREMENT COMMENT '��Ա��' AFTER `update_time`, ADD KEY(`vip_code`), DROP PRIMARY KEY, ADD PRIMARY KEY (`id`, `vip_code`); 
ALTER TABLE `base_mall`.`vip_user` CHANGE `headimg_url` `headimg_url` VARCHAR(1000) NULL COMMENT 'ͷ��'; 
ALTER TABLE `base_mall`.`vip_user` CHANGE `vip_grade` `vip_grade` SMALLINT(6) DEFAULT 0 NULL COMMENT '��Ա�ȼ�', CHANGE `points_current` `points_current` INT(11) DEFAULT 0 NULL COMMENT '��ǰ����', CHANGE `points_accrued` `points_accrued` INT(11) DEFAULT 0 NULL COMMENT '�ۻ�����', CHANGE `amount_accrued` `amount_accrued` DECIMAL(10,2) DEFAULT 0 NULL COMMENT '�ۻ����ѽ��', CHANGE `number_accrued` `number_accrued` INT(11) DEFAULT 0 NULL COMMENT '�ۻ����Ѵ���'; 
ALTER TABLE `base_wx`.`wx_user` ADD COLUMN `vip_id` VARCHAR(32) NULL COMMENT '��ԱID' AFTER `session_key`; 
ALTER TABLE `base_wx`.`wx_user` CHANGE `vip_id` `vip_user_id` VARCHAR(32) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '��Ա�û�ID'; 
ALTER TABLE `base_mall`.`vip_user` CHANGE `app_id` `app_id` VARCHAR(32) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '��ԴӦ��id'; 
ALTER TABLE `base_mall`.`vip_user` CHANGE `phone` `phone` VARCHAR(15) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '�ֻ�����' AFTER `app_id`; 

ALTER TABLE `base_mall`.`goods_spu` CHANGE `shelf` `shelf` CHAR(2) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' NOT NULL COMMENT '�Ƿ��ϼܣ�0�� 1�ǣ�';

CREATE TABLE `base_mall`.`points_record` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `vip_user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '��Ա�û�ID',
  `amount` int(11) DEFAULT NULL COMMENT '����',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '����',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='���ֱ䶯��¼';

ALTER TABLE `base_mall`.`order_info` ADD COLUMN `payment_points` INT NULL COMMENT '֧������' AFTER `payment_price`; 
ALTER TABLE `base_mall`.`order_item` ADD COLUMN `payment_points` INT NULL COMMENT '֧������' AFTER `sales_price`; 

CREATE TABLE `points_config` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `init_posts` int(11) DEFAULT '0' COMMENT '��Ա��ʼ��������',
  `premise_num` int(11) DEFAULT '0' COMMENT '�������������ٿ�ʹ�õֿ�',
  `default_deduct_scale` int(11) DEFAULT NULL COMMENT 'Ĭ�ϵֿ۱���',
  `default_deduct_amount` decimal(10,2) DEFAULT NULL COMMENT 'Ĭ��1�������ɵֶ���Ԫ',
  PRIMARY KEY (`id`,`tenant_id`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='��������';

ALTER TABLE `base_mall`.`points_record` CHANGE `vip_user_id` `user_id` VARCHAR(32) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '�û�ID';

RENAME TABLE `base_mall`.`vip_user` TO `base_mall`.`mall_user`; 

ALTER TABLE `base_wx`.`wx_user` CHANGE `vip_user_id` `mall_user_id` VARCHAR(32) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '�̳��û�ID';

ALTER TABLE `base_mall`.`mall_user` COMMENT='�̳��û�'; 

RENAME TABLE `base_mall`.`mall_user` TO `base_mall`.`user_info`; 

ALTER TABLE `base_wx`.`wx_user` DROP INDEX `uk_openid`, DROP PRIMARY KEY, ADD PRIMARY KEY (`id`, `open_id`);

ALTER TABLE `base_mall`.`user_info` CHANGE `vip_grade` `user_grade` SMALLINT(6) DEFAULT 0 NULL COMMENT '�û��ȼ���0����ͨ�û���1����ͨ��Ա��'; 

ALTER TABLE `base_mall`.`points_config` CHANGE `init_posts` `init_posts` INT(11) DEFAULT 0 NULL COMMENT '�û���ʼ������', ADD COLUMN `init_vip_posts` INT NULL COMMENT '��Ա��ʼ������' AFTER `init_posts`; 

ALTER TABLE `base_mall`.`points_config` CHANGE `init_vip_posts` `init_vip_posts` INT(11) DEFAULT 0 NULL COMMENT '��Ա��ʼ������'; 

#����֮ǰ�汾������
INSERT INTO `base_mall`.`user_info` (
  `id`,
  `tenant_id`,
  `del_flag`,
  `create_time`,
  `update_time`,
  `app_type`,
  `app_id`,
  `phone`,
  `user_grade`,
  `points_current`,
  `points_accrued`,
  `amount_accrued`,
  `number_accrued`,
  `nick_name`,
  `sex`,
  `headimg_url`,
  `city`,
  `country`,
  `province`
)
SELECT
  `id`,
  `tenant_id`,
  '0',
  `create_time`,
  now(),
  `app_type`,
  `app_id`,
  `phone`,
  IF(`headimg_url` IS NULL,0,1),
  0,
  0,
  '0',
  0,
  `nick_name`,
  `sex`,
  `headimg_url`,
  `city`,
  `country`,
  `province`
FROM
  `base_wx`.`wx_user`
  where `mall_user_id` is null and `app_type` = '1';

#����֮ǰ�汾������
update
  `base_wx`.`wx_user`
SET
  `mall_user_id` = `id`
where `mall_user_id` is null
  and `app_type` = '1';

ALTER TABLE `base_mall`.`user_info` DROP COLUMN `points_accrued`, DROP COLUMN `amount_accrued`, DROP COLUMN `number_accrued`;

ALTER TABLE `base_mall`.`points_record` ADD COLUMN `spu_id` VARCHAR(32) NULL COMMENT '��ƷID' AFTER `description`, ADD COLUMN `order_item_id` VARCHAR(32) NULL COMMENT '��������ID' AFTER `spu_id`; 

ALTER TABLE `base_mall`.`points_record` ADD COLUMN `record_type` CHAR(2) NULL COMMENT '��¼����1��ϵͳ��ʼ����2����Ʒ���ͣ�3���˿����ͼ��أ�4����Ʒ�ֿۣ�5���˿�ֿۼӻ�' AFTER `order_item_id`; 
ALTER TABLE `base_mall`.`points_record` CHANGE `record_type` `record_type` CHAR(2) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '��¼����0���û���ʼ����1����Ա��ʼ����2����Ʒ���ͣ�3���˿����ͼ��أ�4����Ʒ�ֿۣ�5���˿�ֿۼӻ�'; 

ALTER TABLE `base_mall`.`points_config` CHANGE `premise_num` `premise_amount` DECIMAL(10,2) NULL COMMENT '������������ٿ�ʹ�õֿ�'; 

ALTER TABLE `base_mall`.`order_item` ADD COLUMN `payment_price` DECIMAL(10,2) NULL COMMENT '֧�����' AFTER `sales_price`; 

UPDATE `base_mall`.`order_item` SET `payment_price` = `sales_price`*`quantity`;

ALTER TABLE `base_mall`.`order_info` CHANGE `sales_price` `sales_price` DECIMAL(10,2) NOT NULL COMMENT '���۽��' AFTER `appraises_status`, CHANGE `logistics_price` `logistics_price` DECIMAL(10,2) NOT NULL COMMENT '�������' AFTER `sales_price`, CHANGE `payment_price` `payment_price` DECIMAL(10,2) NOT NULL COMMENT '֧�������۽��+������'; 

ALTER TABLE `base_mall`.`points_record` CHANGE `record_type` `record_type` CHAR(2) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '��¼����0���û���ʼ����1����Ա��ʼ����2����Ʒ���ͣ�3���˿����ͼ��أ�4����Ʒ�ֿۣ�5������ȡ���ֿۼӻأ�6���˿�ֿۼӻ�'; 

ALTER TABLE `base_mall`.`user_info` ADD COLUMN `city` VARCHAR(64) NULL COMMENT '���ڳ���' AFTER `headimg_url`, ADD COLUMN `country` VARCHAR(64) NULL COMMENT '���ڹ���' AFTER `city`, ADD COLUMN `province` VARCHAR(64) NULL COMMENT '����ʡ��' AFTER `country`; 

ALTER TABLE `base_mall`.`user_info` CHANGE `vip_code` `user_code` INT(11) NOT NULL AUTO_INCREMENT COMMENT '�û�����'; 

UPDATE `base_mall`.`goods_spu` SET `points_give_switch` = '0' WHERE `points_give_switch` IS NULL;
UPDATE `base_mall`.`goods_spu` SET `points_deduct_switch` = '0' WHERE `points_deduct_switch` IS NULL;
ALTER TABLE `base_mall`.`order_item` CHANGE `payment_points` `payment_points` INT(11) DEFAULT 0 NULL COMMENT '֧������'; 
ALTER TABLE `base_mall`.`order_info` CHANGE `payment_points` `payment_points` INT(11) DEFAULT 0 NULL COMMENT '֧������'; 


CREATE TABLE `base_mall`.`coupon_info` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '������ID',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '�����ֶ�',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '����',
  `type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '����1������ȯ��2���ۿ�ȯ',
  `premise_amount` decimal(10,2) DEFAULT NULL COMMENT '������������ٿ�ʹ��',
  `expire_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '��������1����ȯ����Ч��2���̶�ʱ���',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '���',
  `reduce_amount` decimal(10,2) NOT NULL COMMENT '���������ȯ���У�',
  `discount` decimal(10,1) NOT NULL COMMENT '�ۿ��ʣ��ۿ�ȯ���У�',
  `valid_days` int(3) NOT NULL COMMENT '��Ч��������ȯ����Ч���У�',
  `valid_begin_time` datetime NOT NULL COMMENT '��Ч��ʼʱ�䣨�̶�ʱ������У�',
  `valid_end_time` datetime NOT NULL COMMENT '��Ч����ʱ�䣨�̶�ʱ������У�',
  `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '��ע',
  `enable` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '��1��������0���رգ�',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='����ȯ';

CREATE TABLE `base_mall`.`coupon_goods` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '������ID',
  `coupon_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '����ȯID',
  `spu_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '��ƷId',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='����ȯ��Ʒ����';

ALTER TABLE `base_mall`.`coupon_info` CHANGE `name` `name` VARCHAR(30) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '����', CHANGE `reduce_amount` `reduce_amount` DECIMAL(10,2) NULL COMMENT '���������ȯ���У�', CHANGE `discount` `discount` DECIMAL(10,1) NULL COMMENT '�ۿ��ʣ��ۿ�ȯ���У�', CHANGE `valid_days` `valid_days` INT(3) NULL COMMENT '��Ч��������ȯ����Ч���У�', CHANGE `valid_begin_time` `valid_begin_time` DATETIME NULL COMMENT '��Ч��ʼʱ�䣨�̶�ʱ������У�', CHANGE `valid_end_time` `valid_end_time` DATETIME NULL COMMENT '��Ч����ʱ�䣨�̶�ʱ������У�', CHANGE `enable` `enable` CHAR(2) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '��1��������0���رգ�'; 

CREATE TABLE `base_mall`.`coupon_user` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `create_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '������ID',
  `coupon_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '����ȯID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�û�id',
  `coupon_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '����ȯ��',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '״̬0��δʹ�ã�1����ʹ��',
  `used_time` datetime DEFAULT NULL COMMENT 'ʹ��ʱ��',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='����ȯ�û���¼';

ALTER TABLE `base_mall`.`coupon_user` ADD KEY `ids_user` (`user_id`); 

ALTER TABLE `base_upms`.`sys_role_menu` ADD COLUMN `create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL COMMENT '����ʱ��' AFTER `menu_id`; 

ALTER TABLE `base_mall`.`coupon_info` ADD COLUMN `suit_type` CHAR(2) NULL COMMENT '��������1��ȫ����Ʒ��2��������Ʒ' AFTER `valid_end_time`; 

ALTER TABLE `base_mall`.`coupon_user` ADD COLUMN `valid_begin_time` DATETIME NULL COMMENT '��Ч��ʼʱ��' AFTER `coupon_code`, ADD COLUMN `valid_end_time` DATETIME NULL COMMENT '��Ч����ʱ��' AFTER `valid_begin_time`, CHANGE `status` `status` CHAR(2) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' NULL COMMENT '״̬0��δʹ�ã�1����ʹ��' AFTER `valid_end_time`; 

ALTER TABLE `base_mall`.`coupon_user` DROP PRIMARY KEY, ADD PRIMARY KEY (`id`, `coupon_code`); 

ALTER TABLE `base_mall`.`coupon_user` CHANGE `coupon_code` `coupon_code` INT NOT NULL AUTO_INCREMENT COMMENT '����ȯ��', ADD KEY(`coupon_code`); 
ALTER TABLE `base_mall`.`coupon_info` CHANGE `suit_type` `suit_type` CHAR(2) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '��������1��ȫ����Ʒ��2��ָ����Ʒ����'; 
ALTER TABLE `base_mall`.`coupon_user` ADD COLUMN `name` VARCHAR(30) NOT NULL COMMENT '����' AFTER `used_time`, ADD COLUMN `type` CHAR(2) NULL COMMENT '����1������ȯ��2���ۿ�ȯ' AFTER `name`, ADD COLUMN `premise_amount` DECIMAL(10,2) NULL COMMENT '������������ٿ�ʹ��' AFTER `type`, ADD COLUMN `reduce_amount` DECIMAL(10,2) NULL COMMENT '���������ȯ���У�' AFTER `premise_amount`, ADD COLUMN `discount` DECIMAL(10,1) NULL COMMENT '�ۿ��ʣ��ۿ�ȯ���У�' AFTER `reduce_amount`; 
ALTER TABLE `base_mall`.`coupon_user` ADD COLUMN `suit_type` CHAR(2) NULL COMMENT '��������1��ȫ����Ʒ��2��ָ����Ʒ����' AFTER `discount`; 
ALTER TABLE `base_mall`.`order_info` ADD COLUMN `payment_coupon` DECIMAL(10,2) NULL COMMENT '����ȯ֧�����' AFTER `payment_points`; 
ALTER TABLE `base_mall`.`order_item` ADD COLUMN `payment_coupon` DECIMAL(10,2) NULL COMMENT '����ȯ֧�����' AFTER `payment_points`, ADD COLUMN `coupon_user_id` VARCHAR(32) NULL COMMENT '�û�����ȯID' AFTER `payment_coupon`; 
ALTER TABLE `base_mall`.`coupon_info` ADD COLUMN `version` INT DEFAULT 0 NULL COMMENT '�汾��' AFTER `enable`; 

ALTER TABLE `base_mall`.`order_info` CHANGE `sales_price` `sales_price` DECIMAL(10,2) DEFAULT 0 NOT NULL COMMENT '���۽��', CHANGE `logistics_price` `logistics_price` DECIMAL(10,2) DEFAULT 0 NOT NULL COMMENT '�������', CHANGE `payment_price` `payment_price` DECIMAL(10,2) DEFAULT 0 NOT NULL COMMENT '֧�������۽��+������', CHANGE `payment_coupon` `payment_coupon` DECIMAL(10,2) DEFAULT 0 NULL COMMENT '����ȯ֧�����'; 
ALTER TABLE `base_mall`.`order_item` CHANGE `payment_price` `payment_price` DECIMAL(10,2) DEFAULT 0 NULL COMMENT '֧�����', CHANGE `payment_coupon` `payment_coupon` DECIMAL(10,2) DEFAULT 0 NULL COMMENT '����ȯ֧�����'; 
UPDATE `base_mall`.`order_info` SET `payment_coupon` = 0 WHERE `payment_coupon` IS NULL;
UPDATE `base_mall`.`order_item` SET `payment_coupon` = 0 WHERE `payment_coupon` IS NULL;

ALTER TABLE `base_mall`.`order_info` CHANGE `payment_coupon` `payment_coupon_price` DECIMAL(10,2) DEFAULT 0.00 NULL COMMENT '����ȯ�ֿ۽��'; 
ALTER TABLE `base_mall`.`order_item` CHANGE `payment_coupon` `payment_coupon_price` DECIMAL(10,2) DEFAULT 0.00 NULL COMMENT '����ȯ�ֿ۽��'; 
ALTER TABLE `base_mall`.`order_item` ADD COLUMN `payment_points_price` DECIMAL(10,2) NULL COMMENT '���ֵֿ۽��' AFTER `payment_price`, CHANGE `payment_coupon_price` `payment_coupon_price` DECIMAL(10,2) DEFAULT 0.00 NULL COMMENT '����ȯ֧�����' AFTER `payment_points_price`; 
ALTER TABLE `base_mall`.`order_item` CHANGE `payment_points_price` `payment_points_price` DECIMAL(10,2) DEFAULT 0.00 NULL COMMENT '���ֵֿ۽��'; 
ALTER TABLE `base_mall`.`order_info` ADD COLUMN `payment_points_price` DECIMAL(10,2) DEFAULT 0.00 NULL COMMENT '���ֵֿ۽��' AFTER `payment_price`, CHANGE `payment_coupon_price` `payment_coupon_price` DECIMAL(10,2) DEFAULT 0.00 NULL COMMENT '����ȯ�ֿ۽��' AFTER `payment_points_price`; 

CREATE TABLE `base_mall`.`freight_templat` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '�����⻧',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '�߼�ɾ����ǣ�0����ʾ��1�����أ�',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '������ʱ��',
  `sort` int(11) NOT NULL COMMENT '�����ֶ�',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '����',
  `type` char(2) NOT NULL COMMENT 'ģ������1����ҳе��˷ѣ�2�����Ұ���',
  `charge_type` char(2) NOT NULL COMMENT '�Ʒѷ�ʽ1����������2����������3�������',
  `first_num` decimal(10,2) DEFAULT '0.00' COMMENT '�׼����������������',
  `first_freight` decimal(10,2) DEFAULT '0.00' COMMENT '���˷�',
  `continue_num` decimal(10,2) DEFAULT '0.00' COMMENT '�������������������',
  `continue_freight` decimal(10,2) DEFAULT '0.00' COMMENT '���˷�',
  PRIMARY KEY (`id`),
  KEY `ids_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='�˷�ģ��';