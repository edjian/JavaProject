/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 8.0.15 : Database - base_config
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`base_config` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='config_info';

/*Data for the table `config_info` */

insert  into `config_info`(`id`,`data_id`,`group_id`,`content`,`md5`,`gmt_create`,`gmt_modified`,`src_user`,`src_ip`,`app_name`,`tenant_id`,`c_desc`,`c_use`,`effect`,`type`,`c_schema`) values 
(1,'dynamic_routes','DEFAULT_GROUP','routes:\r\n# base-auth\r\n- id: base-auth\r\n  predicates:\r\n  - name: Path\r\n    args: \r\n      _genkey_0: /auth/**\r\n  filters:\r\n  - name: ValidateCodeGatewayFilter\r\n    args: {}\r\n  - name: PasswordDecoderFilter\r\n    args: {}\r\n  uri: lb://base-auth\r\n  order: 0\r\n# base-upms-admin\r\n- id: base-upms-admin\r\n  predicates:\r\n  - name: Path\r\n    args: \r\n      _genkey_0: /admin/**\r\n  filters:\r\n  - name: RequestRateLimiter\r\n    args: \r\n      # 限流策略\r\n      key-resolver: \'#{@remoteAddrKeyResolver}\'\r\n      # 令牌桶每秒填充率\r\n      redis-rate-limiter.burstCapacity: 20\r\n      # 令牌桶容量\r\n      redis-rate-limiter.replenishRate: 10\r\n  # 熔断\r\n  - name: Hystrix\r\n    args: \r\n      fallbackUri: \'forward:/fallback\'\r\n      name: default\r\n  uri: lb://base-upms-admin\r\n  order: 0\r\n# base-codegen\r\n- id: base-codegen\r\n  predicates:\r\n  - name: Path\r\n    args: \r\n      _genkey_0: /gen/**\r\n  filters: []\r\n  uri: lb://base-codegen\r\n  order: 0\r\n# base-weixin-admin\r\n- id: base-weixin-admin\r\n  predicates:\r\n  - name: Path\r\n    args: \r\n      _genkey_0: /weixin/**\r\n  filters: []\r\n  uri: lb://base-weixin-admin\r\n  order: 0\r\n# base-mall-admin\r\n- id: base-mall-admin\r\n  predicates:\r\n  - name: Path\r\n    args: \r\n      _genkey_0: /mall/**\r\n  filters: []\r\n  uri: lb://base-mall-admin\r\n  order: 0','329faf07128e6e0a984d5ce275ebfe39','2019-07-30 14:26:08','2019-11-28 23:15:44',NULL,'192.168.0.102','','','动态路由配置','null','null','yaml','null'),
(2,'application-dev.yml','DEFAULT_GROUP','# 加解密根密码\njasypt:\n  encryptor:\n    #根密码，改完密码要把base_upms.sys_datasource数据库表清空，否则代码生成器无法启动\n    password: joolun\n# redis 相关\nspring:\n  redis:\n    host: ${REDIS-HOST:base-redis}\n    port: 6379\n    password: \n    database: 1\n# logging日志\nlogging:\n  level:\n    com.alibaba.nacos.client.naming: error\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n# hystrix If you need to use ThreadLocal bound variables in your RequestInterceptor`s\n# you will need to either set the thread isolation strategy for Hystrix to `SEMAPHORE or disable Hystrix in Feign.\nhystrix:\n  command:\n    default:\n      execution:\n        isolation:\n          strategy: SEMAPHORE\n          thread:\n            timeoutInMilliseconds: 60000\n  shareSecurityContext: true\n\n#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# mybaits-plus配置\nmybatis-plus:\n  # MyBatis Mapper所对应的XML文件位置\n  mapper-locations: classpath:/mapper/*Mapper.xml\n  # 自定义TypeHandler\n  type-handlers-package: com.joolun.cloud.common.data.mybatis.typehandler\n  global-config:\n    sql-parser-cache: true\n    # 关闭MP3.0自带的banner\n    banner: false\n    db-config:\n      # 主键类型\n      id-type: auto\n\n#swagger公共信息\nswagger:\n  title: JooLun API\n  description: JooLun微信快速开发框架\n  license: Powered By joolun\n  licenseUrl: http://www.joolun.com/\n  terms-of-service-url: http://www.joolun.com/\n  authorization:\n    name: OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: server all\n    token-url-list:\n      - http://${GATEWAY-HOST:base-gateway}:${GATEWAY-PORT:9999}/auth/oauth/token\n\n## spring security 配置\nsecurity:\n  oauth2:\n    client:\n      # 无需token访问的url,如果子模块重写这里的配置就会被覆盖\n      release-urls:\n        - /actuator/**\n        - /v2/api-docs\n    resource:\n      loadBalanced: true\n      token-info-uri: http://${AUTH-HOST:base-auth}/oauth/check_token\n\n## 文件存放目录配置\nhome-dir:\n  windows: D:/joolun-file/\n  linux: /mnt/install/joolun-file/','808fce241d2286ecebd5d7987db43f58','2019-07-28 23:14:26','2020-02-04 21:35:17',NULL,'0:0:0:0:0:0:0:1','','','主配置文件','null','null','yaml','null'),
(3,'base-gateway-dev.yml','DEFAULT_GROUP','security:\n  encode:\n    # 前端密码密钥，必须16位\n    key: \'1234567891234567\'\n\n# 不校验验证码终端\nignore:\n  clients:\n    - swagger\n  swagger-providers:\n    - ${AUTH-HOST:base-auth}','951580823377e19ddbae79a4276ff678','2019-07-28 23:14:26','2019-07-30 14:29:24',NULL,'192.168.1.117','','','网关配置','null','null','yaml','null'),
(4,'base-auth-dev.yml','DEFAULT_GROUP','# 数据源\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: ${MYSQL-USER:root}\n      password: ${MYSQL-PWD:root}\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_upms}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n  freemarker:\n    allow-request-override: false\n    allow-session-override: false\n    cache: true\n    charset: UTF-8\n    check-template-location: true\n    content-type: text/html\n    enabled: true\n    expose-request-attributes: false\n    expose-session-attributes: false\n    expose-spring-macro-helpers: true\n    prefer-file-system-access: true\n    suffix: .ftl\n    template-loader-path: classpath:/templates/','3476b23886681325f3b3ca7ac6a800fc','2019-07-28 23:14:26','2019-11-21 14:54:23',NULL,'192.168.1.13','','','认证授权配置','null','null','yaml','null'),
(5,'base-upms-admin-dev.yml','DEFAULT_GROUP','## spring security 配置\nsecurity:\n  oauth2:\n    client:\n      client-id: admin\n      client-secret: admin\n      scope: server\n      # 无需token访问的url\n      release-urls:\n        - /actuator/**\n        - /v2/api-docs\n        - /user/register\n\n# 数据源\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: ${MYSQL-USER:root}\n      password: ${MYSQL-PWD:root}\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_upms}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n\n# Logger Config sql日志\nlogging:\n  level:\n    com.joolun.cloud.upms.admin.mapper: debug\n\nbase:\n  # 租户表维护\n  tenant:\n    column: tenant_id\n    tables:\n      - sys_user\n      - sys_role\n      - sys_organ\n      - sys_log\n      - sys_config_storage\n      - sys_config_editor\n  #数据权限配置\n  datascope:\n    mapperIds:\n      - com.joolun.cloud.upms.admin.mapper.SysUserMapper.getUserVosPage\n        \n#邮箱配置\nemail:\n  mailSmtpHost: smtpdm.aliyun.com\n  mailSmtpUsername: your-mailSmtpUsername\n  mailSmtpPassword: your-mailSmtpPassword\n  siteName: JooLun','85b3bc8db5863d2281f4a96361602256','2019-07-28 23:14:26','2020-02-10 14:24:20',NULL,'0:0:0:0:0:0:0:1','','','用户权限管理配置','null','null','yaml','null'),
(6,'base-codegen-dev.yml','DEFAULT_GROUP','## spring security 配置\nsecurity:\n  oauth2:\n    client:\n      client-id: gen\n      client-secret: gen\n      scope: server\n# 数据源配置\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: ${MYSQL-USER:root}\n      password: ${MYSQL-PWD:root}\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_upms}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n  resources:\n    static-locations: classpath:/static/,classpath:/views/\n\n\nbase:\n  tenant:\n    column: tenant_id\n    tables:\n      - sys_datasource','a16d6b5a6f63d37b5febaedc525156a8','2019-07-28 23:14:26','2019-11-21 14:54:45',NULL,'192.168.1.13','','','代码生成配置','null','null','yaml','null'),
(7,'base-weixin-admin-dev.yml','DEFAULT_GROUP','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: weixin\r\n      client-secret: weixin\r\n      scope: server\r\n      # 无需token访问的url\r\n      release-urls:\r\n        - /actuator/**\r\n        - /v2/api-docs\r\n        - /portal/**\r\n        - /ws/**\r\n        - /open/notify/**\r\n        - /open/auth/**\r\n        - /api/**\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_wx}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config sql日志\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.weixin.admin.mapper: debug\r\n    \r\n# 租户表维护\r\nbase:\r\n  tenant:\r\n    column: tenant_id\r\n    tables:\r\n      - wx_app\r\n      - wx_menu\r\n      - wx_user\r\n      - wx_auto_reply\r\n      - wx_msg\r\n      - wx_mass_msg\r\n  #数据权限配置\r\n  datascope:\r\n    mapperIds:\r\n      - com.joolun.cloud.weixin.mp.mapper.WxAppMapper.selectPage\r\n\r\n# 微信第三方平台配置，请自行申请(https://open.weixin.qq.com/)\r\nwx:\r\n  component:\r\n    appId: your-appId\r\n    appSecret: your-appSecret\r\n    token: your-token\r\n    aesKey: your-aesKey','cb9c67db33d49046fc18db74e2e238cd','2019-07-28 23:14:26','2019-12-28 18:13:39',NULL,'192.168.31.203','','','微信公众号配置','null','null','yaml','null'),
(8,'base-mall-admin-dev.yml','DEFAULT_GROUP','## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: weixin\r\n      client-secret: weixin\r\n      scope: server\r\n      # 无需token访问的url\r\n      release-urls:\r\n        - /actuator/**\r\n        - /v2/api-docs\r\n        - /api/**\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      driver-class-name: com.mysql.cj.jdbc.Driver\r\n      username: ${MYSQL-USER:root}\r\n      password: ${MYSQL-PWD:root}\r\n      url: jdbc:mysql://${MYSQL-HOST:base-mysql}:${MYSQL-PORT:3306}/${MYSQL-DB:base_mall}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# Logger Config sql日志\r\nlogging:\r\n  level:\r\n    com.joolun.cloud.mall.admin.mapper: debug\r\n    \r\n# 租户表维护\r\nbase:\r\n  tenant:\r\n    column: tenant_id\r\n    tables:\r\n      - goods_category\r\n      - goods_spu\r\n      - goods_spu_spec\r\n      - goods_sku\r\n      - goods_sku_spec_value\r\n      - goods_spec\r\n      - goods_spec_value\r\n      - goods_appraises\r\n      - shopping_cart\r\n      - order_info\r\n      - order_item\r\n      - order_logistics\r\n      - order_logistics_detail\r\n      - user_address\r\n      - user_collect\r\n      - material\r\n      - material_group\r\n      - notice\r\n      - notice_item\r\n      - order_refunds\r\n      - user_info\r\n      - points_record\r\n      - points_config\r\n      - coupon_info\r\n      - coupon_goods\r\n      - coupon_user\r\n      - freight_templat\r\n      - bargain_info\r\n      - bargain_user\r\n      - bargain_cut\r\n      - delivery_place\r\n      - ensure\r\n      - ensure_goods\r\n  #商城相关配置\r\n  mall:\r\n    #支付、物流回调地址域名，注：快递100不支持https回调\r\n    notify-host: http://test.joolun.com\r\n    #快递100授权key\r\n    logistics-key: your-logistics','b42c6259396163b5167d067c769afbd1','2019-08-12 12:03:16','2020-02-09 23:41:06',NULL,'0:0:0:0:0:0:0:1','','','商城管理配置','null','null','yaml','null'),
(171,'transport.type','SEATA_GROUP','TCP','b136ef5f6a01d816991fe3cf7a6ac763','2020-01-01 23:39:08','2020-01-01 23:39:08',NULL,'192.168.31.203','','',NULL,NULL,NULL,'text',NULL),
(172,'transport.server','SEATA_GROUP','NIO','b6d9dfc0fb54277321cebc0fff55df2f','2020-01-01 23:47:04','2020-01-01 23:47:04',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(173,'transport.heartbeat','SEATA_GROUP','true','b326b5062b2f0e69046810717534cb09','2020-01-01 23:47:32','2020-01-01 23:47:32',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(174,'transport.enable-client-batch-send-request','SEATA_GROUP','false','68934a3e9455fa72420237eb05902327','2020-01-01 23:47:58','2020-01-01 23:47:58',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(175,'transport.thread-factory.boss-thread-prefix','SEATA_GROUP','NettyBoss','0f8db59a3b7f2823f38a70c308361836','2020-01-01 23:48:11','2020-01-01 23:48:11',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(176,'transport.thread-factory.worker-thread-prefix','SEATA_GROUP','NettyServerNIOWorker','a78ec7ef5d1631754c4e72ae8a3e9205','2020-01-01 23:48:24','2020-01-01 23:48:24',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(177,'transport.thread-factory.server-executor-thread-prefix','SEATA_GROUP','NettyServerBizHandler','11a36309f3d9df84fa8b59cf071fa2da','2020-01-01 23:49:23','2020-01-01 23:49:23',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(178,'transport.thread-factory.share-boss-worker','SEATA_GROUP','false','68934a3e9455fa72420237eb05902327','2020-01-01 23:49:35','2020-01-01 23:49:35',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(179,'transport.thread-factory.client-selector-thread-prefix','SEATA_GROUP','NettyClientSelector','cd7ec5a06541e75f5a7913752322c3af','2020-01-01 23:49:52','2020-01-01 23:49:52',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(180,'transport.thread-factory.client-selector-thread-size','SEATA_GROUP','1','c4ca4238a0b923820dcc509a6f75849b','2020-01-01 23:50:06','2020-01-01 23:50:06',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(181,'transport.thread-factory.client-worker-thread-prefix','SEATA_GROUP','NettyClientWorkerThread','61cf4e69a56354cf72f46dc86414a57e','2020-01-01 23:50:22','2020-01-01 23:50:22',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(182,'transport.thread-factory.boss-thread-size','SEATA_GROUP','1','c4ca4238a0b923820dcc509a6f75849b','2020-01-01 23:50:35','2020-01-01 23:50:35',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(183,'transport.thread-factory.worker-thread-size','SEATA_GROUP','8','c9f0f895fb98ab9159f51fd0297e236d','2020-01-01 23:50:52','2020-01-01 23:50:52',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(184,'transport.shutdown.wait','SEATA_GROUP','3','eccbc87e4b5ce2fe28308fd9f2a7baf3','2020-01-01 23:51:05','2020-01-01 23:51:05',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(187,'service.default.grouplist','SEATA_GROUP','127.0.0.1:8091','c32ce0d3e264525dcdada751f98143a3','2020-01-01 23:51:48','2020-01-01 23:51:48',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(188,'service.enableDegrade','SEATA_GROUP','false','68934a3e9455fa72420237eb05902327','2020-01-01 23:52:01','2020-01-01 23:52:01',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(189,'service.disableGlobalTransaction','SEATA_GROUP','false','68934a3e9455fa72420237eb05902327','2020-01-01 23:52:12','2020-01-01 23:52:12',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(190,'client.rm.async.commit.buffer.limit','SEATA_GROUP','10000','b7a782741f667201b54880c925faec4b','2020-01-01 23:52:26','2020-01-01 23:52:26',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(191,'client.rm.lock.retry.internal','SEATA_GROUP','10','d3d9446802a44259755d38e6d163e820','2020-01-01 23:52:40','2020-01-01 23:52:40',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(192,'client.rm.lock.retry.times','SEATA_GROUP','30','34173cb38f07f89ddbebc2ac9128303f','2020-01-01 23:52:53','2020-01-01 23:52:53',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(193,'client.rm.report.retry.count','SEATA_GROUP','5','e4da3b7fbbce2345d7772b0674a318d5','2020-01-01 23:53:06','2020-01-01 23:53:06',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(194,'client.rm.lock.retry.policy.branch-rollback-on-conflict','SEATA_GROUP','true','b326b5062b2f0e69046810717534cb09','2020-01-01 23:53:21','2020-01-01 23:53:21',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(195,'client.rm.table.meta.check.enable','SEATA_GROUP','false','68934a3e9455fa72420237eb05902327','2020-01-01 23:53:37','2020-01-01 23:53:37',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(196,'client.rm.report.success.enable','SEATA_GROUP','true','b326b5062b2f0e69046810717534cb09','2020-01-01 23:53:50','2020-01-01 23:53:50',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(197,'client.tm.commit.retry.count','SEATA_GROUP','5','e4da3b7fbbce2345d7772b0674a318d5','2020-01-01 23:54:03','2020-01-01 23:54:03',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(198,'client.tm.rollback.retry.count','SEATA_GROUP','5','e4da3b7fbbce2345d7772b0674a318d5','2020-01-01 23:54:17','2020-01-01 23:54:17',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(199,'store.mode','SEATA_GROUP','file','8c7dd922ad47494fc02c388e12c00eac','2020-01-01 23:54:32','2020-01-01 23:54:32',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(200,'store.file.dir','SEATA_GROUP','file_store/data','6a8dec07c44c33a8a9247cba5710bbb2','2020-01-01 23:54:45','2020-01-01 23:54:45',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(201,'store.file.max-branch-session-size','SEATA_GROUP','16384','c76fe1d8e08462434d800487585be217','2020-01-01 23:54:58','2020-01-01 23:54:58',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(202,'store.file.max-global-session-size','SEATA_GROUP','512','10a7cdd970fe135cf4f7bb55c0e3b59f','2020-01-01 23:55:09','2020-01-01 23:55:09',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(203,'store.file.file-write-buffer-cache-size','SEATA_GROUP','16384','c76fe1d8e08462434d800487585be217','2020-01-01 23:55:23','2020-01-01 23:55:23',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(204,'store.file.flush-disk-mode','SEATA_GROUP','async','0df93e34273b367bb63bad28c94c78d5','2020-01-01 23:55:36','2020-01-01 23:55:36',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(205,'store.file.session.reload.read_size','SEATA_GROUP','100','f899139df5e1059396431415e770c6dd','2020-01-01 23:55:49','2020-01-01 23:55:49',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(206,'store.db.datasource','SEATA_GROUP','dbcp','3a9f384fb40c59fbdc67024ee97d94b1','2020-01-01 23:56:01','2020-01-01 23:56:01',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(207,'store.db.db-type','SEATA_GROUP','mysql','81c3b080dad537de7e10e0987a4bf52e','2020-01-01 23:56:16','2020-01-01 23:56:16',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(208,'store.db.driver-class-name','SEATA_GROUP','com.mysql.jdbc.Driver','683cf0c3a5a56cec94dfac94ca16d760','2020-01-01 23:56:32','2020-01-01 23:56:32',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(209,'store.db.url','SEATA_GROUP','jdbc:mysql://127.0.0.1:3306/seata?useUnicode=true','cbb3bd573704f125fb4f2489208abaec','2020-01-01 23:57:06','2020-01-01 23:57:06',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(210,'store.db.user','SEATA_GROUP','mysql','81c3b080dad537de7e10e0987a4bf52e','2020-01-01 23:57:21','2020-01-01 23:57:21',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(211,'store.db.password','SEATA_GROUP','mysql','81c3b080dad537de7e10e0987a4bf52e','2020-01-01 23:57:34','2020-01-01 23:57:34',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(212,'store.db.min-conn','SEATA_GROUP','1','c4ca4238a0b923820dcc509a6f75849b','2020-01-01 23:57:48','2020-01-01 23:57:48',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(213,'store.db.max-conn','SEATA_GROUP','3','eccbc87e4b5ce2fe28308fd9f2a7baf3','2020-01-01 23:58:01','2020-01-01 23:58:01',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(214,'store.db.global.table','SEATA_GROUP','global_table','8b28fb6bb4c4f984df2709381f8eba2b','2020-01-01 23:58:14','2020-01-01 23:58:14',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(215,'store.db.branch.table','SEATA_GROUP','branch_table','54bcdac38cf62e103fe115bcf46a660c','2020-01-01 23:58:31','2020-01-01 23:58:31',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(216,'store.db.query-limit','SEATA_GROUP','100','f899139df5e1059396431415e770c6dd','2020-01-01 23:58:47','2020-01-01 23:58:47',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(217,'store.db.lock-table','SEATA_GROUP','lock_table','55e0cae3b6dc6696b768db90098b8f2f','2020-01-01 23:59:05','2020-01-01 23:59:05',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(218,'server.recovery.committing-retry-period','SEATA_GROUP','1000','a9b7ba70783b617e9998dc4dd82eb3c5','2020-01-01 23:59:34','2020-01-01 23:59:34',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(219,'server.recovery.asyn-committing-retry-period','SEATA_GROUP','1000','a9b7ba70783b617e9998dc4dd82eb3c5','2020-01-02 00:00:01','2020-01-02 00:00:01',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(220,'server.recovery.rollbacking-retry-period','SEATA_GROUP','1000','a9b7ba70783b617e9998dc4dd82eb3c5','2020-01-02 00:00:16','2020-01-02 00:00:16',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(221,'server.recovery.timeout-retry-period','SEATA_GROUP','1000','a9b7ba70783b617e9998dc4dd82eb3c5','2020-01-02 00:00:32','2020-01-02 00:00:32',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(222,'server.max.commit.retry.timeout','SEATA_GROUP','-1','6bb61e3b7bce0931da574d19d1d82c88','2020-01-02 00:01:26','2020-01-02 00:01:26',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(223,'server.max.rollback.retry.timeout','SEATA_GROUP','-1','6bb61e3b7bce0931da574d19d1d82c88','2020-01-02 00:01:41','2020-01-02 00:01:41',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(224,'client.undo.data.validation','SEATA_GROUP','true','b326b5062b2f0e69046810717534cb09','2020-01-02 00:01:56','2020-01-02 00:01:56',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(225,'client.undo.log.serialization','SEATA_GROUP','jackson','b41779690b83f182acc67d6388c7bac9','2020-01-02 00:02:10','2020-01-02 00:02:10',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(226,'server.undo.log.save.days','SEATA_GROUP','7','8f14e45fceea167a5a36dedd4bea2543','2020-01-02 00:02:28','2020-01-02 00:02:28',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(227,'server.undo.log.delete.period','SEATA_GROUP','86400000','f4c122804fe9076cb2710f55c3c6e346','2020-01-02 00:02:45','2020-01-02 00:02:45',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(228,'client.undo.log.table','SEATA_GROUP','undo_log','2842d229c24afe9e61437135e8306614','2020-01-02 00:02:59','2020-01-02 00:02:59',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(229,'client.log.exceptionRate','SEATA_GROUP','100','f899139df5e1059396431415e770c6dd','2020-01-02 00:03:13','2020-01-02 00:03:13',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(230,'transport.serialization','SEATA_GROUP','seata','b943081c423b9a5416a706524ee05d40','2020-01-02 00:03:26','2020-01-02 00:03:26',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(231,'transport.compressor','SEATA_GROUP','none','334c4a4c42fdb79d7ebc3e73b517e6f8','2020-01-02 00:03:41','2020-01-02 00:03:41',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(232,'metrics.enabled','SEATA_GROUP','false','68934a3e9455fa72420237eb05902327','2020-01-02 00:04:02','2020-01-02 00:04:02',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(233,'metrics.registry-type','SEATA_GROUP','compact','7cf74ca49c304df8150205fc915cd465','2020-01-02 00:04:16','2020-01-02 00:04:16',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(234,'metrics.exporter-list','SEATA_GROUP','prometheus','e4f00638b8a10e6994e67af2f832d51c','2020-01-02 00:04:28','2020-01-02 00:04:28',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(235,'metrics.exporter-prometheus-port','SEATA_GROUP','9898','7b9dc501afe4ee11c56a4831e20cee71','2020-01-02 00:04:47','2020-01-02 00:04:47',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(236,'client.support.spring.datasource.autoproxy','SEATA_GROUP','false','68934a3e9455fa72420237eb05902327','2020-01-02 00:05:03','2020-01-02 00:05:03',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(400,'service.vgroup_mapping.base-mall-admin-fescar-service-group','SEATA_GROUP','default','c21f969b5f03d33d43e04f8f136e7682','2020-01-01 23:51:17','2020-01-01 23:51:17',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL),
(401,'service.vgroup_mapping.base-weixin-admin-fescar-service-group','SEATA_GROUP','default','c21f969b5f03d33d43e04f8f136e7682','2020-01-01 23:51:32','2020-01-01 23:51:32',NULL,'192.168.31.247','','',NULL,NULL,NULL,'text',NULL);

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='增加租户字段';

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='config_info_beta';

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='config_info_tag';

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
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='config_tag_relation';

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='集群、各Group容量信息表';

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
  PRIMARY KEY (`nid`) USING BTREE,
  KEY `idx_gmt_create` (`gmt_create`) USING BTREE,
  KEY `idx_gmt_modified` (`gmt_modified`) USING BTREE,
  KEY `idx_did` (`data_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='多租户改造';

/*Data for the table `his_config_info` */

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `roles` */

insert  into `roles`(`username`,`role`) values 
('nacos','ROLE_ADMIN');

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='租户容量信息表';

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='tenant_info';

/*Data for the table `tenant_info` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `users` */

insert  into `users`(`username`,`password`,`enabled`) values 
('nacos','$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
