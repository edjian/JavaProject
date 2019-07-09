/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 8.0.15 : Database - base_config
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`base_config` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `base_config`;

/*Table structure for table `config_info` */

DROP TABLE IF EXISTS `config_info`;

CREATE TABLE `config_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info';

/*Data for the table `config_info` */

insert  into `config_info`(`id`,`data_id`,`group_id`,`content`,`md5`,`gmt_create`,`gmt_modified`,`src_user`,`src_ip`,`app_name`,`tenant_id`,`c_desc`,`c_use`,`effect`,`type`,`c_schema`) values (1,'application-dev.yml','DEFAULT_GROUP','# 加解密根密码\njasypt:\n  encryptor:\n    password: joolun #根密码\n# redis 相关\nspring:\n  redis:\n    password: \n    host: ${REDIS-HOST:base-redis}\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n# hystrix If you need to use ThreadLocal bound variables in your RequestInterceptor`s\n# you will need to either set the thread isolation strategy for Hystrix to `SEMAPHORE or disable Hystrix in Feign.\nhystrix:\n  command:\n    default:\n      execution:\n        isolation:\n          strategy: SEMAPHORE\n          thread:\n            timeoutInMilliseconds: 60000\n  shareSecurityContext: true\n\n#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# mybaits-plus配置\nmybatis-plus:\n  # MyBatis Mapper所对应的XML文件位置\n  mapper-locations: classpath:/mapper/*Mapper.xml\n  # 自定义TypeHandler\n  type-handlers-package: com.joolun.cloud.common.data.mybatis.typehandler\n  global-config:\n    # 关闭MP3.0自带的banner\n    banner: false\n    db-config:\n      # 主键类型\n      id-type: auto\n\n#swagger公共信息\nswagger:\n  title: Swagger API\n  description: Spring Cloud微服务开发脚手架\n  license: Powered By joolun\n  licenseUrl: http://joolun.com/\n  terms-of-service-url: http://joolun.com/\n  contact:\n    name: jl\n    email: jl@gmail.com\n    url: http://joolun.com/about.html\n  authorization:\n    name: OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: server all\n    token-url-list:\n      - http://${GATEWAY-HOST:base-gateway}:${GATEWAY-PORT:9999}/auth/oauth/token\n\n## spring security 配置\nsecurity:\n  oauth2:\n    client:\n      # 默认放行url,如果子模块重写这里的配置就会被覆盖\n      ignore-urls:\n        - /actuator/**\n        - /v2/api-docs\n    resource:\n      loadBalanced: true\n      token-info-uri: http://${AUTH-HOST:base-auth}/oauth/check_token\n\n# 文件系统\nminio:\n  url: http://192.168.31.100:9000\n  access-key: XQ44HV303HP88P3PBOY6\n  secret-key: zE1fBCosJocrw0yA3EVJ6bjBf854PT6Os75BcR2X','ffe0f1a50cdff7c73b63e714e5fe6b6c','2019-04-18 02:10:20','2019-06-06 19:25:27',NULL,'192.168.31.203','','','通用配置文件',NULL,NULL,'yaml',NULL),(3,'base-auth-dev.yml','DEFAULT_GROUP','# 数据源\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: ${MYSQL-USER:root}\n      password: ${MYSQL-PWD:root}\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_upms}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\n  freemarker:\n    allow-request-override: false\n    allow-session-override: false\n    cache: true\n    charset: UTF-8\n    check-template-location: true\n    content-type: text/html\n    enabled: true\n    expose-request-attributes: false\n    expose-session-attributes: false\n    expose-spring-macro-helpers: true\n    prefer-file-system-access: true\n    suffix: .ftl\n    template-loader-path: classpath:/templates/','f8f481e11e51d1afc0cbc86d78c1a78a','2019-04-18 02:11:32','2019-06-11 11:05:13',NULL,'192.168.31.203','','','认证中心配置文件',NULL,NULL,'yaml',NULL),(4,'base-codegen-dev.yml','DEFAULT_GROUP','## spring security 配置\nsecurity:\n  oauth2:\n    client:\n      client-id: gen\n      client-secret: gen\n      scope: server\n# 数据源配置\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: ${MYSQL-USER:root}\n      password: ${MYSQL-PWD:root}\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_upms}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\n  resources:\n    static-locations: classpath:/static/,classpath:/views/\n\n\nbase:\n  tenant:\n    column: tenant_id\n    tables:\n      - sys_datasource_conf','18b65f8dd5b2f458374fc201085cdbbc','2019-04-18 02:12:10','2019-06-11 11:05:35',NULL,'192.168.31.203','','','',NULL,NULL,'yaml',NULL),(7,'base-gateway-dev.yml','DEFAULT_GROUP','security:\n  encode:\n    # 前端密码密钥，必须16位\n    key: \'1234567891234567\'\n\n# 不校验验证码终端\nignore:\n  clients:\n    - test\n  swagger-providers:\n    - ${AUTH-HOST:base-auth}','4a1833d875a5e008837cf36f5c0f4c41','2019-04-18 02:13:52','2019-04-18 02:13:52',NULL,'127.0.0.1','','','网关配置文件',NULL,NULL,'yaml',NULL),(14,'base-upms-biz-dev.yml','DEFAULT_GROUP','## spring security 配置\nsecurity:\n  oauth2:\n    client:\n      client-id: upms\n      client-secret: upms\n      scope: server\n\n# 数据源\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: ${MYSQL-USER:root}\n      password: ${MYSQL-PWD:root}\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_upms}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\n\n# Logger Config\nlogging:\n  level:\n    com.joolun.cloud.admin.mapper: debug\n\n# 租户表维护\nbase:\n  tenant:\n    column: tenant_id\n    tables:\n      - sys_user\n      - sys_role\n      - sys_dept\n      - sys_log\n      - sys_social_details\n      - sys_dict\n      - sys_dict_item\n      - sys_public_param','92ae2c4580de0e105d8c33543950e22d','2019-04-18 02:32:44','2019-06-11 11:06:03',NULL,'192.168.31.203','','','通用用户权限配置',NULL,NULL,'yaml',NULL),(19,'base-weixin-mp-dev.yml','DEFAULT_GROUP','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/portal/**\'\r\n        - \'/wxmaterial/materialFileUpload\'\r\n        - \'/wxmaterial/newsImgUpload\'\r\n        - \'/ws/**\'\r\n        - \'/open/notify/**\'\r\n        - \'/open/auth/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.wxmp.mapper: debug\r\n    \r\n# 租户表维护\r\nbase:\r\n  tenant:\r\n    column: tenant_id\r\n    tables:\r\n      - wx_app\r\n      - wx_menu\r\n      - wx_user\r\n      - wx_auto_reply\r\n      - wx_msg\r\n      - wx_mass_msg\r\n\r\n# 微信第三方平台配置\r\nwx:\r\n  component:\r\n    appId: wxedb42aa502a8b83d\r\n    appSecret: a76dc60602a6783058bf1661433ebb28\r\n    token: gh_26fd6cdbd78b\r\n    aesKey: DYnwvIfD47b7QkIKrO6a3OKgI172VrRaXLil48JEjr0','73c87d1cbf179257963502cbc0b98c33','2019-05-14 14:56:03','2019-07-02 17:54:54',NULL,'192.168.1.117','','','微信公众号',NULL,NULL,'yaml',NULL);

/*Table structure for table `config_info_aggr` */

DROP TABLE IF EXISTS `config_info_aggr`;

CREATE TABLE `config_info_aggr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='增加租户字段';

/*Data for the table `config_info_aggr` */

/*Table structure for table `config_info_beta` */

DROP TABLE IF EXISTS `config_info_beta`;

CREATE TABLE `config_info_beta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_beta';

/*Data for the table `config_info_beta` */

/*Table structure for table `config_info_tag` */

DROP TABLE IF EXISTS `config_info_tag`;

CREATE TABLE `config_info_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_tag';

/*Data for the table `config_info_tag` */

/*Table structure for table `config_tags_relation` */

DROP TABLE IF EXISTS `config_tags_relation`;

CREATE TABLE `config_tags_relation` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_tag_relation';

/*Data for the table `config_tags_relation` */

/*Table structure for table `group_capacity` */

DROP TABLE IF EXISTS `group_capacity`;

CREATE TABLE `group_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='集群、各Group容量信息表';

/*Data for the table `group_capacity` */

/*Table structure for table `his_config_info` */

DROP TABLE IF EXISTS `his_config_info`;

CREATE TABLE `his_config_info` (
  `id` bigint(64) unsigned NOT NULL,
  `nid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin,
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`),
  KEY `idx_gmt_create` (`gmt_create`),
  KEY `idx_gmt_modified` (`gmt_modified`),
  KEY `idx_did` (`data_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多租户改造';

/*Data for the table `his_config_info` */

insert  into `his_config_info`(`id`,`nid`,`data_id`,`group_id`,`app_name`,`content`,`md5`,`gmt_create`,`gmt_modified`,`src_user`,`src_ip`,`op_type`,`tenant_id`) values (0,45,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.wxopen.mapper: error','6f37bad00c0166ebf507217a65e6b08a','2010-05-05 00:00:00','2019-06-20 09:00:25',NULL,'192.168.1.117','I',''),(62,46,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.wxopen.mapper: error','6f37bad00c0166ebf507217a65e6b08a','2010-05-05 00:00:00','2019-06-20 09:43:49',NULL,'192.168.1.117','U',''),(62,47,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.wxopen.mapper: error','f64e4a9a223653b0c751f6ecd5830ef9','2010-05-05 00:00:00','2019-06-20 11:41:57',NULL,'192.168.1.117','U',''),(62,48,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/auth/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.wxopen.mapper: error','600ecaa874ced5241a03c825e5e5d6ed','2010-05-05 00:00:00','2019-06-20 11:59:16',NULL,'192.168.1.117','U',''),(62,49,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/auth/**\'\r\n        - \'/notify/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.wxopen.mapper: error','a5033898aeb9f50902c2249eb34cbd2c','2010-05-05 00:00:00','2019-06-20 14:50:27',NULL,'192.168.1.117','U',''),(62,50,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/auth/**\'\r\n        - \'/notify/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/','4ea2dcd044ad4bd5fe165b4e71a41ad7','2010-05-05 00:00:00','2019-06-20 14:56:16',NULL,'192.168.1.117','U',''),(62,51,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/auth/**\'\r\n        - \'/test/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/','99b9619626c146e9fbb72cd608c70df5','2010-05-05 00:00:00','2019-06-20 14:56:34',NULL,'192.168.1.117','U',''),(62,52,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/test/**\'\r\n        - \'/notify/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/','48a2ac0addfe1aa8c7418e97dbc29c29','2010-05-05 00:00:00','2019-06-20 14:57:29',NULL,'192.168.1.117','U',''),(62,53,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/test/**\'\r\n        - \'/notify/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/','48a2ac0addfe1aa8c7418e97dbc29c29','2010-05-05 00:00:00','2019-06-20 14:59:54',NULL,'192.168.1.117','U',''),(62,54,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/auth/**\'\r\n        - \'/notify/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/','4ea2dcd044ad4bd5fe165b4e71a41ad7','2010-05-05 00:00:00','2019-06-20 15:04:09',NULL,'192.168.1.117','U',''),(62,55,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/notify/**\'\r\n        - \'/auth/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/','f9e5630346a4f77fd2f9aafd660f0f45','2010-05-05 00:00:00','2019-06-20 15:05:54',NULL,'192.168.1.117','U',''),(62,56,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/auth/**\'\r\n        - \'/notify/receive_ticket\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/','ecfbc092ba8ed653fcfa37a0c8264f7a','2010-05-05 00:00:00','2019-06-20 15:10:22',NULL,'192.168.1.117','U',''),(62,57,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/auth/**\'\r\n        - \'/notify/**\'\r\n        - \'/asdfg/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/','9505556f0baed83a5ed817c9769322a1','2010-05-05 00:00:00','2019-06-20 15:11:49',NULL,'192.168.1.117','U',''),(62,58,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/auth/**\'\r\n        - \'/notify/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/','4ea2dcd044ad4bd5fe165b4e71a41ad7','2010-05-05 00:00:00','2019-06-20 15:15:28',NULL,'192.168.1.117','U',''),(62,59,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/auth/**\'\r\n        - \'/test/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/','99b9619626c146e9fbb72cd608c70df5','2010-05-05 00:00:00','2019-06-20 15:16:28',NULL,'192.168.1.117','U',''),(62,60,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/auth/**\'\r\n        - \'/notify/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/','4ea2dcd044ad4bd5fe165b4e71a41ad7','2010-05-05 00:00:00','2019-06-21 09:30:03',NULL,'192.168.1.117','U',''),(62,61,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/auth/**\'\r\n        - \'/notify/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n# 微信第三方平台配置\r\nwx:\r\n  component:\r\n    appId: wx15f84b97be667ed4\r\n    appSecret: 6a2b41bb800f6520bc998a45a75f628c\r\n    token: gh_26fd6cdbd78b\r\n    aesKey: DYnwvIfD47b7QkIKrO6a3OKgI172VrRaXLil48JEjr0','0c496c548c427636112416ce0d682259','2010-05-05 00:00:00','2019-06-21 11:22:40',NULL,'192.168.1.117','U',''),(19,62,'base-weixin-mp-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/portal/**\'\r\n        - \'/wxmaterial/materialFileUpload\'\r\n        - \'/wxmaterial/newsImgUpload\'\r\n        - \'/ws/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.wxmp.mapper: debug\r\n    \r\n# 租户表维护\r\nbase:\r\n  tenant:\r\n    column: tenant_id\r\n    tables:\r\n      - wx_app\r\n      - wx_menu\r\n      - wx_user\r\n      - wx_auto_reply\r\n      - wx_msg','b019473b41126c71b7e733086f306f1b','2010-05-05 00:00:00','2019-06-21 11:23:10',NULL,'192.168.1.117','U',''),(19,63,'base-weixin-mp-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/portal/**\'\r\n        - \'/wxmaterial/materialFileUpload\'\r\n        - \'/wxmaterial/newsImgUpload\'\r\n        - \'/ws/**\'\r\n        - \'/wxopenauth/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.wxmp.mapper: debug\r\n    \r\n# 租户表维护\r\nbase:\r\n  tenant:\r\n    column: tenant_id\r\n    tables:\r\n      - wx_app\r\n      - wx_menu\r\n      - wx_user\r\n      - wx_auto_reply\r\n      - wx_msg','6f63d4bcf0b8bb3c6d35ef7a8282cf93','2010-05-05 00:00:00','2019-06-21 14:47:39',NULL,'192.168.1.117','U',''),(62,64,'base-weixin-open-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/notify/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n# 微信第三方平台配置\r\nwx:\r\n  component:\r\n    appId: wx15f84b97be667ed4\r\n    appSecret: 6a2b41bb800f6520bc998a45a75f628c\r\n    token: gh_26fd6cdbd78b\r\n    aesKey: DYnwvIfD47b7QkIKrO6a3OKgI172VrRaXLil48JEjr0','6a636244d76494d8102345c7a5b16ce4','2010-05-05 00:00:00','2019-06-21 14:48:08',NULL,'192.168.1.117','U',''),(19,65,'base-weixin-mp-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/portal/**\'\r\n        - \'/wxmaterial/materialFileUpload\'\r\n        - \'/wxmaterial/newsImgUpload\'\r\n        - \'/ws/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.wxmp.mapper: debug\r\n    \r\n# 租户表维护\r\nbase:\r\n  tenant:\r\n    column: tenant_id\r\n    tables:\r\n      - wx_app\r\n      - wx_menu\r\n      - wx_user\r\n      - wx_auto_reply\r\n      - wx_msg\r\n\r\n# 微信第三方平台配置\r\nwx:\r\n  component:\r\n    appId: wx15f84b97be667ed4\r\n    appSecret: 6a2b41bb800f6520bc998a45a75f628c\r\n    token: gh_26fd6cdbd78b\r\n    aesKey: DYnwvIfD47b7QkIKrO6a3OKgI172VrRaXLil48JEjr0','a2bbc8c69fce2391eab122910817f98f','2010-05-05 00:00:00','2019-06-25 09:13:36',NULL,'192.168.1.117','U',''),(19,66,'base-weixin-mp-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/portal/**\'\r\n        - \'/wxmaterial/materialFileUpload\'\r\n        - \'/wxmaterial/newsImgUpload\'\r\n        - \'/ws/**\'\r\n        - \'/open/notify/**\'\r\n        - \'/open/auth/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.wxmp.mapper: debug\r\n    \r\n# 租户表维护\r\nbase:\r\n  tenant:\r\n    column: tenant_id\r\n    tables:\r\n      - wx_app\r\n      - wx_menu\r\n      - wx_user\r\n      - wx_auto_reply\r\n      - wx_msg\r\n\r\n# 微信第三方平台配置\r\nwx:\r\n  component:\r\n    appId: wx15f84b97be667ed4\r\n    appSecret: 6a2b41bb800f6520bc998a45a75f628c\r\n    token: gh_26fd6cdbd78b\r\n    aesKey: DYnwvIfD47b7QkIKrO6a3OKgI172VrRaXLil48JEjr0','b2256dba25655dd61a2b619011f6e240','2010-05-05 00:00:00','2019-06-25 09:49:17',NULL,'192.168.1.117','U',''),(19,67,'base-weixin-mp-dev.yml','DEFAULT_GROUP','','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: gen\r\n      client-secret: gen\r\n      scope: server\r\n      # 默认放行url,子模块重写时application-dev.yml中的公共配置会被覆盖,所以要把公共配置中的放行url再写一次\r\n      ignore-urls:\r\n        - \'/portal/**\'\r\n        - \'/wxmaterial/materialFileUpload\'\r\n        - \'/wxmaterial/newsImgUpload\'\r\n        - \'/ws/**\'\r\n        - \'/open/notify/**\'\r\n        - \'/open/auth/**\'\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.wxmp.mapper: debug\r\n    \r\n# 租户表维护\r\nbase:\r\n  tenant:\r\n    column: tenant_id\r\n    tables:\r\n      - wx_app\r\n      - wx_menu\r\n      - wx_user\r\n      - wx_auto_reply\r\n      - wx_msg\r\n\r\n# 微信第三方平台配置\r\nwx:\r\n  component:\r\n    appId: wxedb42aa502a8b83d\r\n    appSecret: a76dc60602a6783058bf1661433ebb28\r\n    token: gh_26fd6cdbd78b\r\n    aesKey: DYnwvIfD47b7QkIKrO6a3OKgI172VrRaXLil48JEjr0','00972af75b79e7ed114d8c6698d28af8','2010-05-05 00:00:00','2019-07-02 17:54:54',NULL,'192.168.1.117','U','');

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `username` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `roles` */

/*Table structure for table `tenant_capacity` */

DROP TABLE IF EXISTS `tenant_capacity`;

CREATE TABLE `tenant_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='租户容量信息表';

/*Data for the table `tenant_capacity` */

/*Table structure for table `tenant_info` */

DROP TABLE IF EXISTS `tenant_info`;

CREATE TABLE `tenant_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(20) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='tenant_info';

/*Data for the table `tenant_info` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`username`,`password`,`enabled`) values ('nacos','$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
