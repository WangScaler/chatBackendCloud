/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : chat-config

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 07/07/2023 10:57:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
  `encrypted_data_key` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 195 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'application-dev.yml', 'DEFAULT_GROUP', 'spring:\n# 兼容swagger3和springboot2.6\n  mvc:\n    pathmatch:\n      matching-strategy: ant_path_matcher\n  autoconfigure:\n    exclude: com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\nseata:\n  data-source-proxy-mode: AT\n  registry:\n    type: nacos\n    nacos:\n      server-addr: 192.168.1.11:8848\n      group : \"SEATA_GROUP\"\n      namespace: \"\"\n      username: \"nacos\"\n      password: \"nacos\"\n  tx-service-group: seata-modules\n  service:\n    vgroup-mapping:\n      seata-modules: DEFAULT\n\n', '7160e29bc815360462c40a9f4cc5c7e4', '2020-05-20 12:00:00', '2023-06-13 14:38:25', 'nacos', '192.168.48.1', '', '', '全局配置', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (2, 'chat-gateway-dev.yml', 'DEFAULT_GROUP', 'spring:\n  cloud:\n    gateway:\n      globalcors:\n        add-to-simple-url-handler-mapping: true #解决OPTION被拦截的问题\n        cors-configurations:\n          \'[/**]\':\n            allowedOrigins: # 允许哪些网站的跨域请求\n              - \"http://blog.dilicili.cn\"\n              - \"http://chat.dilicili.cn\"\n              - \"http://localhost:8081\"\n              - \"http://localhost:8080\"\n            allowedMethods: #允许的请求方式\n              - \"GET\"\n              - \"POST\"\n              - \"DELETE\"\n              - \"PUT\"\n              - \"OPTIONS\"\n            allowedHeaders: \"*\" #允许在请求中携带头信息\n            allowedCredentials: true #是否允许携带cookie\n            maxAge: 360000 #跨越的有效期\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        - id: chat-user #路由标识\n          uri: lb://chat-user #路由的目标地址\n          predicates:\n            - Path=/user/** # 路径断言\n          filters:\n            - StripPrefix=1\n        - id: chat-websocket #路由标识\n          uri: lb://chat-websocket #路由的目标地址\n          predicates:\n            - Path=/websocket/** # 路径断言\n          filters:\n            - StripPrefix=1\n        - id: chat-room #路由标识\n          uri: lb://chat-room #路由的目标地址\n          predicates:\n              - Path=/room/** # 路径断言\n          filters:\n            - StripPrefix=1\n        - id: chat-message #路由标识\n          uri: lb://chat-message #路由的目标地址\n          predicates:\n              - Path=/message/** # 路径断言\n          filters:\n            - StripPrefix=1\n# 安全配置\nsecurity:\n  # 防止XSS攻击\n  xss:\n    enabled: true\n  crypto:\n    enabled: false\n  # 不校验白名单\n  ignore:\n    whites:\n      - /*/v2/api-docs\n      - /csrf\n      - /user/login\n      - /user/register\n      - /websocket/conn\n      - /user/down', '8523c8ec8d4ffad52091fdd3a1f8cad4', '2020-05-14 14:17:55', '2023-07-06 16:48:08', 'nacos', '192.168.48.1', '', '', '', '', '', 'text', '', '');
INSERT INTO `config_info` VALUES (5, 'chat-modules-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring:\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n        master:\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://192.168.1.11:3306/chat-new?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8&&allowPublicKeyRetrieval=true\n          username: root\n          password: 123456\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.wangscaler\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  enable: true\n  title: 系统模块接口文档\n  license: Powered By WangScaler\n  licenseUrl: https://blog.dilicili.cn', '7a43ff6408e76286eb4acdb65fa171c0', '2020-11-20 00:00:00', '2023-06-13 14:29:12', 'nacos', '192.168.48.1', '', '', '业务模块', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (23, 'sentinel-flow-gateway', 'DEFAULT_GROUP', ' [ \n   { \n     \"resource\": \"/chat-user\", \n     \"controlBehavior\": 0, \n     \"count\": 3, \n     \"grade\": 1, \n     \"limitApp\": \"default\", \n     \"strategy\": 0 \n   },\n   { \n     \"resource\": \"/chat-room\", \n     \"controlBehavior\": 0, \n     \"count\": 3, \n     \"grade\": 1, \n     \"limitApp\": \"default\", \n     \"strategy\": 0 \n   } \n]\n', '854f8f07fb07119f62983e318b40b529', '2023-02-02 16:48:04', '2023-06-12 17:11:35', 'nacos', '192.168.48.1', '', '', '流控配置', '', '', 'json', '', NULL);
INSERT INTO `config_info` VALUES (37, 'sentinel-grade-gateway', 'DEFAULT_GROUP', '[\r\n	  {\r\n	       \"resource\":\"/chat-user\",\r\n	       \"count\":200, \r\n	       \"grade\":0,\r\n	       \"timeWindow\":5\r\n	   },\r\n       {\r\n	       \"resource\":\"/chat-room\",\r\n	       \"count\":200, \r\n	       \"grade\":0,\r\n	       \"timeWindow\":5\r\n	   }\r\n \r\n]', 'b6ad27475ab2c2d060fd120f027dcade', '2023-02-03 14:33:23', '2023-02-03 14:33:23', NULL, '172.17.0.1', '', '', '降级熔断规则', NULL, NULL, 'json', NULL, NULL);
INSERT INTO `config_info` VALUES (140, 'seataServer.properties', 'SEATA_GROUP', 'store.mode=db\nstore.db.datasource=druid\nstore.db.dbType=mysql\nstore.db.driverClassName=com.mysql.cj.jdbc.Driver\nstore.db.url=jdbc:mysql://192.168.1.11:3306/seata?rewriteBatchedStatements=true\nstore.db.user=root\nstore.db.password=123456\nstore.db.minConn=5\nstore.db.maxConn=30\nstore.db.globalTable=global_table\nstore.db.branchTable=branch_table\nstore.db.distributedLockTable=distributed_lock\nstore.db.queryLimit=100\nstore.db.lockTable=lock_table\nstore.db.maxWait=5000\n', '80fd7ca7340918098b153f3b3d889c76', '2023-06-12 16:32:18', '2023-06-12 17:12:04', 'nacos', '192.168.48.1', '', '', 'seata启动配置', '', '', 'properties', '', NULL);
INSERT INTO `config_info` VALUES (143, 'seata-server.yml', 'SEATA_GROUP', 'service:\n	#需要修改为自己的group，与客户端相对应，目前先这样\n    vgroupMapping:\n        netty-seata-test-group: seata-modules\n        netty-system-platform-group: seata-modules\n        netty-mybatis-plus-test-group: seata-modules\n    default:\n        grouplist: 192.168.1.11:8091\n    enableDegrade: false\n    disableGlobalTransaction: false\n\nclient:\n    rm:\n        asyncCommitBufferLimit: 10000\n        lock:\n            retryInterval: 10\n            retryTimes: 30\n            retryPolicyBranchRollbackOnConflict: true\n        reportRetryCount: 5\n        tableMetaCheckEnable: true\n        tableMetaCheckerInterval: 60000\n        sqlParserType: druid\n        reportSuccessEnable: false\n        sagaBranchRegisterEnable: false\n        sagaJsonParser: fastjson\n        tccActionInterceptorOrder: -2147482648\n    tm:\n        commitRetryCount: 5\n        rollbackRetryCount: 5\n        defaultGlobalTransactionTimeout: 60000\n        degradeCheck: false\n        degradeCheckAllowTimes: 10\n        degradeCheckPeriod: 2000\n        interceptorOrder: -2147482648\n    undo:\n        dataValidation: true\n        logSerialization: jackson\n        onlyCareUpdateColumns: true\n        logTable: undo_log\n        compress:\n            enable: true\n            type: zip\n            threshold: 64k\nserver:\n    undo:\n        logSaveDays: 7\n        logDeletePeriod: 86400000\n    recovery:\n        committingRetryPeriod: 1000\n        asynCommittingRetryPeriod: 1000\n        rollbackingRetryPeriod: 1000\n        timeoutRetryPeriod: 1000\n    maxCommitRetryTimeout: -1\n    maxRollbackRetryTimeout: -1\n    rollbackRetryTimeoutUnlockEnable: false\n    distributedLockExpireTime: 10000\n    xaerNotaRetryTimeout: 60000\n    session:\n        branchAsyncQueueSize: 5000\n        enableBranchAsyncRemove: false\n    enableParallelRequestHandle: false\ntcc:\n    fence:\n        logTableName: tcc_fence_log\n        cleanPeriod: 1h\nlog:\n    exceptionRate: 100\nstore:\n    mode: db\n    lock:\n        mode: db\n    session:\n        mode: db\n    #publicKey: \'\'\n    db:\n        datasource: druid\n        dbType: mysql\n        driverClassName: com.mysql.cj.jdbc.Driver\n        url: jdbc:mysql://192.168.1.11:3306/seata?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=GMT%2B8&allowMultiQueries=true&autoReconnect=true\n        user: root\n        password: 123456\n        minConn: 5\n        maxConn: 30\n        globalTable: global_table\n        branchTable: branch_table\n        distributedLockTable: distributed_lock\n        queryLimit: 100\n        lockTable: lock_table\n        maxWait: 5000\nmetrics:\n    enabled: false\n    registryType: compact\n    exporterList: prometheus\n    exporterPrometheusPort: 9898\n    \ntransport:\n    type: TCP\n    server: NIO\n    heartbeat: true\n    enableTmClientBatchSendRequest: false\n    enableRmClientBatchSendRequest: true\n    enableTcServerBatchSendResponse: false\n    rpcRmRequestTimeout: 30000\n    rpcTmRequestTimeout: 30000\n    rpcTcRequestTimeout: 30000\n    threadFactory:\n        bossThreadPrefix: NettyBoss\n        workerThreadPrefix: NettyServerNIOWorker\n        serverExecutorThreadPrefix: NettyServerBizHandler\n        shareBossWorker: false\n        clientSelectorThreadPrefix: NettyClientSelector\n        clientSelectorThreadSize: 1\n        clientWorkerThreadPrefix: NettyClientWorkerThread\n        bossThreadSize: 1\n        workerThreadSize: default\n    shutdown:\n        wait: 3\n    serialization: seata\n    compressor: none\n\n', 'ad3df013a45dbc719bb33e95a0aa0613', '2023-06-12 16:46:36', '2023-06-12 17:12:30', 'nacos', '192.168.48.1', '', '', 'seata微服务配置', '', '', 'yaml', '', NULL);

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint(0) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(0) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint unsigned NOT NULL COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int unsigned NOT NULL COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL COMMENT '使用量',
  `max_size` int unsigned NOT NULL COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int unsigned NOT NULL COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint unsigned NOT NULL,
  `nid` int unsigned NOT NULL,
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT '秘钥',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint unsigned NOT NULL COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int unsigned NOT NULL COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL COMMENT '使用量',
  `max_size` int unsigned NOT NULL COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL COMMENT '聚合子配置最大个数',
  `max_aggr_size` int unsigned NOT NULL COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(0) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------
INSERT INTO `tenant_info` VALUES (1, '1', '9cb16ee6-5f13-4533-b994-90deb5d11bd7', 'seata', 'seata', 'nacos', 1676279558528, 1676279558528);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
