/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : chat-new

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 11/07/2023 15:02:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_collect
-- ----------------------------
DROP TABLE IF EXISTS `tb_collect`;
CREATE TABLE `tb_collect`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `deleted_at` datetime(6) NULL DEFAULT NULL COMMENT '删除时间',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `music_mid` int(0) NOT NULL COMMENT '歌曲mid',
  `music_album` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌曲专辑',
  `music_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌曲名字',
  `is_delete` int(0) NOT NULL DEFAULT 1 COMMENT '软删除 1:正常 -1:已删除',
  `music_cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌曲封面图',
  `music_albumpic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌曲专辑大图',
  `music_singer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌曲作者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 482 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_message
-- ----------------------------
DROP TABLE IF EXISTS `tb_message`;
CREATE TABLE `tb_message`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `user_id` int(0) NOT NULL COMMENT '用户id',
  `room_id` int(0) NOT NULL COMMENT '房间ID',
  `message_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `message_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息类型',
  `quote_user_id` int(0) NULL DEFAULT NULL COMMENT '引用消息人的id[引用了谁的消息]',
  `quote_message_id` int(0) NULL DEFAULT NULL COMMENT '引用的消息ID',
  `message_status` int(0) NOT NULL DEFAULT 1 COMMENT '消息状态： 1: 正常 -1: 已撤回',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45778 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_message
-- ----------------------------
INSERT INTO `tb_message` VALUES (1, '2023-07-11 14:59:59', '2023-07-11 14:59:59', NULL, 2, 888, 'test', 'text', NULL, NULL, 1);
INSERT INTO `tb_message` VALUES (2, '2023-07-11 15:00:19', '2023-07-11 15:00:19', NULL, 1, 888, '[西瓜]', 'text', 2, 1, 1);
INSERT INTO `tb_message` VALUES (3, '2023-07-11 15:00:32', '2023-07-11 15:00:50', NULL, 2, 888, '[菜刀]', 'text', NULL, NULL, -1);
INSERT INTO `tb_message` VALUES (4, '2023-07-11 15:00:42', '2023-07-11 15:00:42', NULL, 1, 888, '[衰]', 'text', 2, 3, 1);

-- ----------------------------
-- Table structure for tb_music
-- ----------------------------
DROP TABLE IF EXISTS `tb_music`;
CREATE TABLE `tb_music`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `deleted_at` datetime(6) NULL DEFAULT NULL COMMENT '删除时间',
  `music_album` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌曲专辑',
  `music_name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌曲名称',
  `music_mid` int(0) NOT NULL COMMENT '歌曲mid',
  `music_duration` int(0) NOT NULL COMMENT '歌曲时长',
  `music_singer` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌曲作者',
  `is_recommend` int(0) NOT NULL DEFAULT 0 COMMENT '是否推荐到热门歌曲 1:是 -1:不是',
  `music_pic120` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'https://blog.wangscaler.com/back.jpg' COMMENT '歌曲封面图',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `IDX_48371586263a8079833f775e83`(`music_mid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 629 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_music
-- ----------------------------
INSERT INTO `tb_music` VALUES (1, '2022-03-23 11:15:58.047488', '2022-03-23 11:15:58.047488', NULL, '程式情歌', '分开那天', 4991635, 268, '程响', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (2, '2022-03-23 11:15:58.098599', '2022-03-23 11:15:58.098599', NULL, '喝酒三分醉 想你到心碎', '喝酒三分醉 想你到心碎', 192927379, 192, '胡小宝', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (3, '2022-03-23 11:15:58.149275', '2022-03-23 11:15:58.149275', NULL, '男人花', '男人花', 22803947, 310, '黄勇', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (4, '2022-03-23 11:15:58.202328', '2022-03-23 11:15:58.202328', NULL, '你选择冷漠，我选择洒脱', '你选择冷漠，我选择洒脱', 96102478, 225, '吴姗姗', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (5, '2022-03-23 11:15:58.253331', '2022-03-23 11:15:58.253331', NULL, '下定决心忘记你', '下定决心忘记你', 834687, 222, '正云', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (6, '2022-03-23 11:15:58.302449', '2022-03-23 18:07:25.000000', NULL, '放手也是另一种爱', '放手也是另一种爱', 163753249, 206, '天嵊', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (7, '2022-03-23 11:15:58.356104', '2022-03-29 14:07:28.000000', NULL, '十二年', '十二年', 5450172, 237, '邱永传', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (8, '2022-03-23 11:15:58.408882', '2022-03-23 11:15:58.408882', NULL, '挣不脱的枷锁', '挣不脱的枷锁', 172737717, 183, '洪三岁', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (9, '2022-03-23 11:15:58.463039', '2022-08-01 10:42:11.000000', NULL, '宇光十色', '该死的温柔', 228642, 222, '马天宇', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (10, '2022-03-23 11:15:58.512980', '2022-03-23 11:15:58.512980', NULL, '变了心忘了情', '变了心忘了情', 209613100, 181, '杨优秀', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (11, '2022-03-23 11:15:58.564071', '2022-06-30 15:32:24.000000', NULL, '如果寂寞了', '如果寂寞了', 4079308, 207, '郑晓填', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (12, '2022-03-23 11:15:58.615077', '2022-03-23 11:15:58.615077', NULL, '多幸运', '多幸运', 6672344, 249, '韩安旭', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (13, '2022-03-23 11:15:58.666032', '2022-03-23 11:15:58.666032', NULL, '破坏定律', '不再联系', 5834394, 204, '夏天Alex', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (14, '2022-03-23 11:15:58.715837', '2022-07-26 13:15:20.000000', NULL, '老婆最大', '卜卦', 5843110, 216, '崔子格', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (15, '2022-03-23 11:15:58.768241', '2022-03-23 11:15:58.768241', NULL, '孤独的乐章', '雪', 827267, 226, '杜婧荧&王艺翔', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (16, '2022-03-23 11:15:58.822085', '2022-03-23 11:15:58.822085', NULL, '我选择原谅', '断了乱了', 6334323, 287, '庄心妍', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (17, '2022-03-23 11:15:58.870743', '2022-03-23 14:49:33.000000', NULL, '林中鸟', '林中鸟', 6976836, 231, '葛林', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (18, '2022-03-23 11:15:58.929865', '2022-07-27 16:42:38.000000', NULL, '默认专辑', '秋殇别恋(DJ版)', 72619393, 277, '格子兮', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (19, '2022-03-23 11:15:58.984202', '2022-03-23 11:15:58.984202', NULL, '有一种爱叫做放手', '有一种爱叫做放手', 242615, 261, '阿木', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (20, '2022-03-23 11:15:59.041935', '2022-03-23 11:15:59.041935', NULL, '恋人心', '恋人心', 4762774, 208, '魏新雨', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (21, '2022-03-23 11:15:59.102266', '2022-10-14 13:43:53.000000', NULL, '精彩TRY', '不是因为寂寞才想你', 961393, 260, 'T.R.Y.', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (22, '2022-03-23 11:15:59.156285', '2022-03-23 11:15:59.156285', NULL, '不想做朋友', '不想做朋友', 30368505, 235, '星弟&小贱', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (23, '2022-03-23 11:15:59.207675', '2022-12-05 10:51:21.000000', NULL, '十一年', '十一年', 735003, 254, '邱永传', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (24, '2022-03-23 11:15:59.257574', '2022-03-23 11:15:59.257574', NULL, '丁香花', '丁香花(弦乐版)', 534163, 269, '唐磊', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (25, '2022-03-23 11:15:59.307389', '2022-03-23 11:15:59.307389', NULL, '进音三年', '别想她', 929944, 229, '高进', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (26, '2022-03-23 11:15:59.357487', '2022-03-23 11:15:59.357487', NULL, '新娘不是我', '新娘不是我', 2556975, 282, '程响', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (27, '2022-03-23 11:15:59.412575', '2022-03-23 11:15:59.412575', NULL, '情一动心就痛', '情一动心就痛', 6332815, 232, '海生', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (28, '2022-03-23 11:15:59.463512', '2022-03-23 11:15:59.463512', NULL, '做你的爱人', '做你的爱人', 443935, 283, '饶天亮', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (29, '2022-03-23 11:15:59.748594', '2022-09-08 09:32:56.000000', NULL, '日积月磊 选歌集', '车站', 69879335, 246, '曹磊', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (30, '2022-03-23 11:15:59.798204', '2022-03-30 14:58:16.000000', NULL, '你到底有没有爱过我', '你到底有没有爱过我', 4798821, 258, '蓝波', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (31, '2022-03-23 11:15:59.857578', '2022-03-23 14:38:53.000000', NULL, '雪龙吟', '雪龙吟', 207699170, 207, '张杰', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (32, '2022-03-23 11:15:59.909677', '2022-03-23 11:15:59.909677', NULL, '念平生', '念平生', 174969524, 168, '郭飞宏', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (33, '2022-03-23 11:15:59.961069', '2022-12-01 18:25:33.000000', NULL, '烟雨话江南', '烟雨话江南', 206969121, 213, '吴姗姗', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (34, '2022-03-23 11:16:00.012907', '2022-03-23 11:16:00.012907', NULL, '谪仙', '谪仙', 89560911, 178, '伊格赛听&叶里', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (35, '2022-03-23 11:16:00.294201', '2022-03-23 11:16:00.294201', NULL, '雷池', '雷池', 190120785, 207, '刘振宇', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (36, '2022-03-23 11:16:00.355449', '2022-04-01 15:01:55.000000', NULL, '红尘万里的过客', '红尘万里的过客', 205805410, 169, '掉掉', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (37, '2022-03-23 11:16:00.406271', '2022-12-01 17:11:33.000000', NULL, '探窗', '探窗', 181158353, 217, '国风新语&浮生梦&汐音社', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (38, '2022-03-23 11:16:00.456087', '2022-09-14 15:39:17.000000', NULL, '红尘如梦聚又离', '红尘如梦聚又离', 195243548, 227, '刘振宇', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (39, '2022-03-23 11:16:00.507563', '2022-03-23 11:16:00.507563', NULL, '探花', '探花', 204940252, 232, '西木子', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (40, '2022-03-23 11:16:00.791482', '2022-03-23 16:44:46.000000', NULL, '城南以东（独唱版）', '城南以东', 201558449, 211, '郭飞宏', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (41, '2022-03-23 11:16:00.847815', '2022-03-23 11:16:00.847815', NULL, '明月', '明月', 192347176, 228, '掉掉', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (42, '2022-03-23 11:16:00.898347', '2022-03-23 11:16:00.898347', NULL, '不负人间', '不负人间', 185344673, 205, '阿YueYue', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (43, '2022-03-23 11:16:00.950788', '2022-03-23 11:16:00.950788', NULL, '花间酒', '花间酒', 158119930, 180, 'IRiS七叶', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (44, '2022-03-23 11:16:01.002575', '2022-04-01 14:50:23.000000', NULL, '春庭雪', '春庭雪', 144914539, 240, '等什么君(邓寓君)', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (45, '2022-03-23 11:16:01.053501', '2022-03-23 11:16:01.053501', NULL, '不如吃茶去', '惊鸿一面', 4856712, 256, '许嵩&黄龄', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (46, '2022-03-23 11:16:01.103114', '2022-03-23 11:16:01.103114', NULL, '长安姑娘', '长安姑娘', 92277097, 254, '李常超', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (47, '2022-03-23 11:16:01.154174', '2022-03-23 11:16:01.154174', NULL, '云水谣', '云水谣', 72374055, 241, 'en', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (48, '2022-03-23 11:16:01.205483', '2022-03-23 11:16:01.205483', NULL, '刺客', '刺客', 171092880, 194, '灼夭&国风新语&戾格&小田音乐社', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (49, '2022-03-23 11:16:01.258870', '2022-03-23 11:16:01.258870', NULL, '沈园外', '沈园外', 160373899, 223, '阿YueYue&戾格&小田音乐社', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (50, '2022-03-23 11:16:01.310240', '2022-03-23 11:16:01.310240', NULL, '难渡', '难渡', 171750792, 161, '等什么君(邓寓君)', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (51, '2022-03-23 11:16:01.363629', '2022-06-24 16:00:10.000000', NULL, '画离弦', '画离弦', 186917318, 226, '海伦', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (52, '2022-03-23 11:16:01.880004', '2022-04-15 10:43:28.000000', NULL, '浮生记', '浮生记', 194098849, 199, '海来阿木', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (53, '2022-03-23 11:16:01.930255', '2022-03-23 11:16:01.930255', NULL, '归来是故乡', '归来是故乡', 164195485, 228, '亦伊', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (54, '2022-03-23 11:16:01.981455', '2022-07-27 09:07:01.000000', NULL, '一曲相思', '一曲相思', 54761734, 167, '半阳', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (55, '2022-03-23 11:16:02.032499', '2022-03-23 11:16:02.032499', NULL, '游山恋', '游山恋', 141494937, 223, '海伦', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (56, '2022-03-23 11:16:02.087706', '2022-03-30 15:03:54.000000', NULL, '缘定今生', '我的楼兰', 59141878, 329, '云朵', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (57, '2022-03-23 11:16:02.141823', '2022-03-23 11:16:02.141823', NULL, '三生石下', '三生石下', 153495578, 263, '大欢', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (58, '2022-03-23 11:16:02.215393', '2022-08-01 11:00:18.000000', NULL, '天地龙鳞', '天地龙鳞', 201182467, 196, '王力宏', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (59, '2022-03-23 11:16:02.268200', '2022-04-01 15:13:57.000000', NULL, '予·君', '踏雪', 202132722, 210, '等什么君(邓寓君)&FOX胡天渝', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (60, '2022-03-23 11:16:02.319683', '2022-03-23 11:16:02.319683', NULL, '耗', '耗', 161234843, 247, '楚南', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (61, '2022-03-23 11:16:02.370258', '2022-08-24 10:43:11.000000', NULL, '成全', '成全', 59156062, 309, '林宥嘉', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (62, '2022-03-23 11:16:02.421340', '2022-03-23 11:16:02.421340', NULL, '就像爱', '就像爱', 142721566, 207, '吴佳忆', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (63, '2022-03-23 11:16:02.476574', '2022-03-23 11:16:02.476574', NULL, '烟雨行舟', '烟雨行舟', 54559867, 258, '司南', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (64, '2022-03-23 11:16:02.526289', '2022-03-23 11:16:02.526289', NULL, '宝藏女孩', '宝藏女孩', 158208916, 186, '大鱼', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (65, '2022-03-23 11:16:02.580399', '2022-03-23 11:16:02.580399', NULL, '孤独与诗', '孤独与诗', 70931765, 301, '鞠婧祎', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (66, '2022-03-23 11:16:02.631614', '2022-03-23 11:16:02.631614', NULL, 'ABCD', 'ABCD', 95870235, 187, '乔星儿', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (67, '2022-03-23 11:16:02.694120', '2022-03-23 11:16:02.694120', NULL, '暗恋橘生淮南 电视剧原声专辑', '漫长的告白', 162283619, 288, '双笙（陈元汐）', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (68, '2022-03-23 11:16:02.751532', '2022-03-23 11:16:02.751532', NULL, '星辰的夜', '星辰的夜', 203925205, 199, '楚南', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (69, '2022-03-23 11:16:02.811062', '2022-03-23 11:16:02.811062', NULL, '烟火人间', '烟火人间', 141920088, 265, '添儿呗', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (70, '2022-03-23 11:16:02.862557', '2022-03-23 11:16:02.862557', NULL, '我的少女时代 电影原声带', '小幸运', 6717048, 263, '田馥甄', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (71, '2022-03-23 11:16:02.913151', '2022-03-23 11:16:02.913151', NULL, '非酋', '非酋', 26383907, 172, '薛黛霏&朱贺', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (72, '2022-03-23 11:16:02.963793', '2022-03-23 11:16:02.963793', NULL, '甜甜咸咸', '甜甜咸咸', 141133839, 197, '赵芷彤Cassie', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (73, '2022-03-23 11:16:03.015242', '2022-03-23 11:16:03.015242', NULL, '飞云之下', '飞云之下', 41212233, 266, '韩红&林俊杰', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (74, '2022-03-23 11:16:03.066495', '2022-03-23 11:16:03.066495', NULL, '单恋一枝花', '单恋一枝花', 96596360, 110, '丫蛋蛋（马启涵）', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (75, '2022-03-23 11:16:03.118428', '2022-03-23 13:57:01.000000', NULL, '丢了幸福的猪', '痛彻心扉', 484036, 314, '姜玉阳', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (76, '2022-03-23 11:16:03.169760', '2022-05-20 11:20:55.000000', NULL, '圈住你', '圈住你', 70397655, 178, '一口甜', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (77, '2022-03-23 11:16:03.232031', '2022-03-23 11:16:03.232031', NULL, '当真', '当真', 52444076, 189, '蒋蒋&曲肖冰', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (78, '2022-03-23 11:16:03.282282', '2022-03-23 11:16:03.282282', NULL, '情火', '情火', 63255516, 210, '孙艺琪', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (79, '2022-03-23 11:16:03.335061', '2022-03-23 11:16:03.335061', NULL, '萧音弥漫', '不谓侠', 28513834, 266, '萧忆情Alex', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (80, '2022-03-23 11:16:03.384049', '2022-03-23 17:52:21.000000', NULL, 'Fighting！生存之道', '三国恋', 126336, 247, 'Tank', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (81, '2022-03-23 11:16:03.435082', '2022-03-23 11:16:03.435082', NULL, '我们不一样', '我们不一样', 24720751, 270, '大壮', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (82, '2022-03-23 11:16:03.502010', '2022-03-23 11:16:03.502010', NULL, '太阳', '太阳(正式版)', 77809522, 257, '曲肖冰', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (83, '2022-03-23 11:16:03.554126', '2022-03-31 10:41:47.000000', NULL, '依然', '贝加尔湖畔', 1116274, 245, '李健', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (84, '2022-03-23 11:16:03.604922', '2022-03-23 11:16:03.604922', NULL, '另一个我', '后来遇见他', 91609449, 249, '胡66', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (85, '2022-03-23 11:16:03.658832', '2022-03-23 11:16:03.658832', NULL, '我好想', '爱就一个字', 993960, 273, '张信哲', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (86, '2022-03-23 11:16:03.711313', '2022-03-23 11:16:03.711313', NULL, '说散就散(”前任3:再见前任”电影主题曲)', '说散就散', 36960360, 242, '袁娅维TIA RAY', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (87, '2022-03-23 11:16:03.764071', '2022-03-23 11:16:03.764071', NULL, '包容', '包容', 838765, 263, '郑源', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (88, '2022-03-23 11:16:03.817130', '2022-07-29 13:11:22.000000', NULL, '爱难求情难断', '爱难求情难断', 148567401, 237, '张鑫雨', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (89, '2022-03-23 11:16:03.868081', '2022-03-23 11:16:03.868081', NULL, '谁为我停留', '把悲伤留给自己', 7001108, 288, '孙露', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (90, '2022-03-23 11:16:03.918300', '2022-06-02 13:18:32.000000', NULL, '城春草木深', '城春草木深', 214094021, 205, '河图', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (91, '2022-03-23 11:16:03.985353', '2022-07-27 15:44:30.000000', NULL, '红颜江湖录——雪中悍刀行女性角色群像', '红颜江湖录——雪中悍刀行女性角色群像', 214009882, 259, '故也Lauren&祀绾&秦子钦&紫纥&挽君&北二姜酒&兔姬&潼关不是肉夹馍&柚子ya', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (92, '2022-03-23 11:16:04.036664', '2022-07-27 13:28:33.000000', NULL, '三春序', '三春序', 213264970, 226, '浮生梦&汐音社', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (93, '2022-03-23 11:16:04.088407', '2022-03-23 11:16:04.088407', NULL, '一盏流萤', '一盏流萤', 212959978, 243, 'cici_', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (94, '2022-03-23 11:16:04.143006', '2022-07-27 16:14:26.000000', NULL, '芊芊', '芊芊', 213625412, 210, '阿YueYue', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (95, '2022-03-23 11:16:04.192982', '2022-03-23 11:16:04.192982', NULL, '桃花愿', '桃花愿', 213887155, 299, '诺言Jason&南风ZJN', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (96, '2022-03-23 11:16:04.246190', '2022-03-23 11:16:04.246190', NULL, '一曲', '一曲', 211912585, 210, '旺仔小乔', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (97, '2022-03-23 11:16:04.311910', '2023-01-06 14:15:19.000000', NULL, '永夜天光', '永夜天光', 213426996, 240, '萧忆情Alex&天涯明月刀', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (98, '2022-03-23 11:16:04.363112', '2022-03-23 11:16:04.363112', NULL, '烂酒坛', '烂酒坛', 213216890, 204, '国风集&音频怪物', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (99, '2022-03-23 11:16:04.416075', '2022-03-23 11:16:04.416075', NULL, '彩', '彩', 213239210, 212, '小时姑娘', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (100, '2022-03-23 11:16:04.467115', '2022-04-24 09:14:16.000000', NULL, '弹指芳华', '弹指芳华', 213239122, 203, '姜姜', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (101, '2022-03-23 11:16:04.524007', '2022-07-27 13:44:47.000000', NULL, '鬓上曾簪花', '鬓上曾簪花', 212535616, 176, '姜姜', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (102, '2022-03-23 11:16:04.574036', '2022-03-23 11:16:04.574036', NULL, '花尚在——《江南百景图》同人曲', '花尚在', 213155926, 224, '兔妃星子&橝栖&米九十发', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (103, '2022-03-23 11:16:04.624928', '2022-04-07 10:07:30.000000', NULL, '泪千行', '泪千行', 212999801, 172, '伊格赛听&曾昭昭', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (104, '2022-03-23 11:16:04.678307', '2022-03-23 11:16:04.678307', NULL, '十年春', '十年春', 213012480, 222, '小魂', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (105, '2022-03-23 11:16:04.730971', '2022-03-23 11:16:04.730971', NULL, '千秋迭梦', '千秋迭梦', 212990821, 225, '阿YueYue&镜予歌', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (106, '2022-03-23 11:16:04.781958', '2022-08-17 15:03:16.000000', NULL, '岁月长', '岁月长', 212175568, 186, '音谋论&楚然', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (107, '2022-03-23 11:16:04.832562', '2022-05-20 11:25:53.000000', NULL, '爱莲说', '爱莲说', 212708343, 201, '奇然&沈谧仁', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (108, '2022-03-23 11:16:04.882920', '2022-03-23 11:16:04.882920', NULL, '海棠依旧笑春风【刘诗诗2022.03.10生贺曲】', '海棠依旧笑春风', 212815233, 258, '琼楼妙音&Babystop_山竹&玉霜&痴笑&草鱼欣', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (109, '2022-03-23 11:16:04.935154', '2022-12-01 17:37:39.000000', NULL, '【薛晓】不肯赦当年', '【薛晓】不肯赦当年', 28037533, 283, '若以止白', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (110, '2022-03-23 11:16:04.996892', '2022-03-23 15:52:56.000000', NULL, '昭阳', '昭阳（花亦山心之月昭阳公主角色曲） (cover: 祖娅纳惜/三无Marblue)', 212140214, 221, '易生君&沐闇', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (111, '2022-03-23 11:16:05.061230', '2022-03-23 11:16:05.061230', NULL, '舒游', '舒游', 212666387, 203, '叶小墨&橘子酒&艾潭&言启', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (112, '2022-03-23 11:16:05.112931', '2022-03-23 11:16:05.112931', NULL, '慢漫游', '慢漫游', 212672516, 252, '棠霜icing', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (113, '2022-03-23 11:16:05.165782', '2022-03-23 11:16:05.165782', NULL, '折枝花满衣', '折枝花满衣 (cover: 泽典)', 211871181, 211, '橝栖', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (114, '2022-03-23 11:16:05.218019', '2022-03-23 14:10:53.000000', NULL, '江湖入酒', '江湖入酒（纯歌版）(其他)', 211870404, 253, '蓝凌若溪&破烂神&凉w风', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (115, '2022-03-23 11:16:05.270962', '2022-06-22 20:03:30.000000', NULL, '月老牵红线 (甜蜜版）', '月老牵红线(甜蜜版)', 212520680, 170, '水歌', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (116, '2022-03-23 11:16:05.322073', '2022-03-23 11:16:05.322073', NULL, '神都风起-《风起洛阳》同人曲', '神都风起', 212551719, 255, '珺锦queena', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (117, '2022-03-23 11:16:05.373833', '2022-03-23 11:16:05.373833', NULL, '过江寒', '过江寒 (cover: 黄诗扶)', 212389066, 245, '茶了了', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (118, '2022-03-23 11:16:05.425147', '2022-03-23 11:16:05.425147', NULL, '游仙梦觉 无问音乐x肥皂菌          ——梦蕉系列原创曲之三', '游仙梦觉', 212153980, 272, '肥皂菌丨珉珉的猫咪丨&无问', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (119, '2022-03-23 11:16:05.476129', '2022-03-23 11:16:05.476129', NULL, '人间烟花', '人间烟花', 211780612, 235, '伯虎', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (120, '2022-03-23 11:16:05.526894', '2022-03-23 11:16:05.526894', NULL, '心蓝', '当我遇上你', 22851724, 269, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (121, '2022-03-23 11:16:05.588021', '2022-03-23 11:16:05.588021', NULL, '如果你是我的传说', '如果你是我的传说', 4830209, 283, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (122, '2022-03-23 11:16:05.639010', '2022-03-23 11:16:05.639010', NULL, '回家真好 新曲+精选', '一起走过的日子', 148993, 239, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (123, '2022-03-23 11:16:05.690079', '2022-03-23 11:16:05.690079', NULL, '来生缘', '来生缘', 45851778, 236, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (124, '2022-03-23 11:16:05.741066', '2022-04-01 15:18:27.000000', NULL, '真我的风采', '假装', 536506, 299, '刘德华', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (125, '2022-03-23 11:16:05.792030', '2022-03-23 11:16:05.792030', NULL, 'Wonderful World 香港演唱会 2007', '暗里着迷(粤)', 28422327, 226, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (126, '2022-03-23 11:16:05.844045', '2022-03-23 11:16:05.844045', NULL, '真永远', '今天', 329669, 229, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (127, '2022-03-23 11:16:05.899226', '2022-03-23 11:16:05.899226', NULL, '夏日Fiesta', '鸽子情缘', 215041, 222, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (128, '2022-03-23 11:16:05.949913', '2022-04-21 22:05:39.000000', NULL, '真我的风采', '谢谢你的爱(粤语)', 22798825, 276, '刘德华', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (129, '2022-03-23 11:16:06.001380', '2022-03-23 11:16:06.001380', NULL, '情感的禁区', '情感的禁区', 325760, 224, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (130, '2022-03-23 11:16:06.057224', '2022-03-23 11:16:06.057224', NULL, '如果有一天', '17岁', 79245, 240, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (131, '2022-03-23 11:16:06.120881', '2022-03-23 11:16:06.120881', NULL, '爱在刻骨铭心时', '冰雨', 327687, 279, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (132, '2022-03-23 11:16:06.171059', '2022-04-28 15:43:23.000000', NULL, '忘情水', '缠绵', 325766, 274, '刘德华', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (133, '2022-03-23 11:16:06.224154', '2022-03-23 11:16:06.224154', NULL, '幻影中国巡回演唱会Live', '男人哭吧不是罪(Live)', 269582, 315, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (134, '2022-03-23 11:16:06.274232', '2022-07-22 08:54:35.000000', NULL, 'The Melody Andy Vol.8', '爱你一万年', 148745, 291, '刘德华', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (135, '2022-03-23 11:16:06.326901', '2022-03-23 11:16:06.326901', NULL, '人间爱', '都怪我', 327771, 263, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (136, '2022-03-23 11:16:06.610872', '2022-03-23 11:16:06.610872', NULL, '真我的风采', '独自去偷欢', 1026489, 248, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (137, '2022-03-23 11:16:06.690628', '2022-03-23 11:16:06.690628', NULL, '忘情水', '忘情水', 325771, 263, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (138, '2022-03-23 11:16:06.741410', '2022-03-23 11:16:06.741410', NULL, '我们的刘德华 Greatest Hits 2012 (粤)', '真我的风采', 1967796, 251, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (139, '2022-03-23 11:16:06.792495', '2022-05-26 22:47:48.000000', NULL, '天意', '天意', 981432, 271, '刘德华', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (140, '2022-03-23 11:16:06.844164', '2022-03-23 11:16:06.844164', NULL, '5时30分', '钻石眼泪', 251323, 272, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (141, '2022-03-23 11:16:06.897921', '2022-03-23 11:16:06.897921', NULL, 'Wonderful World 香港演唱会 2007', '笨小孩(国)', 28422325, 230, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (142, '2022-03-23 11:16:06.948301', '2022-03-23 11:16:06.948301', NULL, '美丽的一天', '练习', 92088, 260, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (143, '2022-03-23 11:16:07.000051', '2022-03-23 11:16:07.000051', NULL, '爱在刻骨铭心时', '孤星泪', 327690, 338, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (144, '2022-03-23 11:16:07.049306', '2022-03-23 11:16:07.049306', NULL, '复黑王 - 可不可以 - 刘德华', '缘尽(电影”龙凤茶楼”主题曲)', 1170404, 289, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (145, '2022-03-23 11:16:07.102129', '2022-03-23 11:16:07.102129', NULL, '你是我的骄傲演唱会', '谢谢你的爱(国)', 140205217, 337, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (146, '2022-03-23 11:16:07.154089', '2022-03-23 11:16:07.154089', NULL, '一个人的感觉', '我恨我痴心', 3933998, 250, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (147, '2022-03-23 11:16:07.206187', '2022-03-23 11:16:07.206187', NULL, '男人的爱', '我不够爱你', 148954, 249, '刘德华&陈慧琳', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (148, '2022-03-23 11:16:07.256809', '2022-03-23 11:16:07.256809', NULL, 'Memories', '天各一方', 292526, 192, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (149, '2022-03-23 11:16:07.307912', '2022-03-23 11:16:07.307912', NULL, '爱如此神奇', '爱如潮水', 628042, 265, '刘德华', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (150, '2022-03-23 11:16:07.366856', '2022-03-23 11:16:07.366856', NULL, 'Normal No More (Explicit)', 'Normal No More(Explicit)', 94345412, 199, 'Tysm', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (151, '2022-03-23 11:16:07.428299', '2022-03-23 11:16:07.428299', NULL, '两只老虎爱跳舞', '抖音最火(抖音热播版)', 166117562, 210, '抖音音乐', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (152, '2022-03-23 11:16:07.710383', '2022-03-23 11:16:07.710383', NULL, 'Star Unkind', 'Star Unkind(Lanfranchi & Farina Remix)', 48764240, 372, '2Someone', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (153, '2022-03-23 11:16:07.761462', '2022-04-26 23:07:17.000000', NULL, 'Angels', 'Angels(Extended Mix)', 28619361, 250, 'Vicetone&Kat Nestel', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (154, '2022-03-23 11:16:07.813160', '2022-03-23 11:16:07.813160', NULL, '罪恶王冠/甲铁城（徐梦圆Remix）', 'ninelie(Easylistening)', 20275386, 141, '徐梦圆', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (155, '2022-03-23 11:16:07.864283', '2022-03-23 11:16:07.864283', NULL, '遇见你', 'Breather(抖音BGM)', 176693347, 124, 'BGM供货商', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (156, '2022-03-23 11:16:07.914971', '2022-03-23 11:16:07.914971', NULL, '好想抱住你', '好想抱住你(DJR7版)', 203671695, 172, '程佳佳', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (157, '2022-03-23 11:16:07.965328', '2022-03-23 11:16:07.965328', NULL, '璐爷翻唱电台', '大天蓬(弹唱片段)', 151197370, 43, '璐爷', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (158, '2022-03-23 11:16:08.015129', '2022-03-23 11:16:08.015129', NULL, 'Yasuo（面对疾风吧！）', 'Yasuo', 195399372, 279, 'MMZ-BOY', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (159, '2022-03-23 11:16:08.065393', '2022-07-04 08:33:02.000000', NULL, '温柔风起词', '玫瑰少年(小提琴版)', 172563317, 100, '风起词', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (160, '2022-03-23 11:16:08.118333', '2022-03-23 11:16:08.118333', NULL, '仙儿', 'Toby Fox', 173561427, 124, '小猫多鱼', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (161, '2022-03-23 11:16:08.169311', '2022-03-23 11:16:08.169311', NULL, 'Drown (feat. Clinton Kane) [Alle Farben Remix]', 'Drown (feat. Clinton Kane)', 93146891, 169, 'Martin Garrix&Clinton Kane&Alle Farben', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (162, '2022-03-23 11:16:08.225001', '2022-03-23 11:16:08.225001', NULL, '浪子', '迪迦奥特曼(热搜枪声卡点)', 158598597, 114, '小猫多鱼', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (163, '2022-03-23 11:16:08.274204', '2022-04-25 17:59:52.000000', NULL, '一路生花', '一路生花', 162582615, 256, '温奕心', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (164, '2022-03-23 11:16:08.324935', '2022-04-02 13:38:06.000000', NULL, '我不是小朋友', '我不是小朋友(Remix)', 181145116, 113, '老怪怪怪的&JF', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (165, '2022-03-23 11:16:08.376588', '2022-03-23 11:16:08.376588', NULL, '问心', '问心', 201547089, 186, '就是南方凯', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (166, '2022-03-23 11:16:08.427158', '2022-04-02 13:33:35.000000', NULL, 'Revolver', 'Turn All the Lights On', 45804669, 218, 'T-Pain&Ne-Yo', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (167, '2022-03-23 11:16:08.478913', '2022-03-23 11:16:08.478913', NULL, '官方回答', 'Maria(抖音原声版)', 145807588, 121, '98k', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (168, '2022-03-23 11:16:08.529153', '2022-03-23 11:16:08.529153', NULL, '', 'Nevada (绝地求生枪声完整版)', 67960763, 231, '网络歌手', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (169, '2022-03-23 11:16:09.681047', '2022-03-23 11:16:09.681047', NULL, '广寒谣', '广寒谣(DJ名龙版)', 156408042, 242, '伊格赛听&不靠谱组合', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (170, '2022-03-23 11:16:09.735407', '2022-03-23 11:16:09.735407', NULL, 'Phut Hon', 'Phut Hon(抖音原唱)', 156406928, 352, '9妹', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (171, '2022-03-23 11:16:09.794359', '2022-03-23 11:16:09.794359', NULL, '燕无歇', '燕无歇(抖音DJ完整版)', 156419921, 121, '小鹏鹏', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (172, '2022-03-23 11:16:09.849716', '2022-03-23 11:16:09.849716', NULL, 'In The End', 'In The End(Mellen Gi Remix)', 65974473, 218, 'Tommee Profitt&Fleurie', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (173, '2022-03-23 11:16:09.901886', '2022-04-06 08:57:46.000000', NULL, '网抑云', 'You(Bootleg 混音版)', 144466757, 80, 'P.W.W.画风风', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (174, '2022-03-23 11:16:09.955693', '2022-03-30 16:23:16.000000', NULL, '炸街舞曲', 'Frontier(枪声版)', 71105945, 184, '泽亦龙', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (175, '2022-03-23 11:16:10.009826', '2022-03-23 11:16:10.009826', NULL, 'Last Reunion (Epicmusicvn Series)', 'Last Reunion (Epicmusicvn Series)', 7209224, 275, 'Peter Roe', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (176, '2022-03-23 11:16:10.063653', '2022-03-23 11:16:10.063653', NULL, '酒醉的恰恰(DJ默涵版)', '酒醉的恰恰(DJ默涵版)', 207943985, 199, '莫叫姐姐', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (177, '2022-03-23 11:16:10.120608', '2022-03-23 11:16:10.120608', NULL, '爱过恨过心伤过', '爱过恨过心伤过（DJ小鑫版）', 210785559, 219, '洪三岁', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (178, '2022-03-23 11:16:10.407780', '2022-03-23 13:41:47.000000', NULL, '月老掉线', '月老掉线(DJ阿卓版)', 207231743, 206, '王不醒', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (179, '2022-03-23 11:16:10.461861', '2022-10-13 17:28:50.000000', NULL, '变了心忘了情', '变了心忘了情（DJ小鑫版）', 210514854, 173, '杨优秀', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (180, '2022-03-23 11:16:10.515837', '2022-03-23 11:16:10.515837', NULL, '今夜', '今夜(DJ R7版)', 207079689, 198, '小阿枫&R7[DJ]', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (181, '2022-03-23 11:16:10.565821', '2022-06-20 11:31:56.000000', NULL, '滑过嘴角的眼泪', '滑过嘴角的眼泪（DJ小鑫版）', 210389302, 212, '吴姗姗', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (182, '2022-03-23 11:16:10.616960', '2022-04-02 19:01:00.000000', NULL, '逃之夭夭(DJheap九天版)', '逃之夭夭(DJheap九天版)', 150373516, 225, '张禾禾', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (183, '2022-03-23 11:16:10.669326', '2022-03-23 11:16:10.669326', NULL, '孤零零', '孤零零(DJ小鑫版)', 197270871, 193, '吴姗姗', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (184, '2022-03-23 11:16:10.722401', '2022-03-23 16:08:26.000000', NULL, '红尘彼岸却无她', '红尘彼岸却无她(DJEva版)', 201199659, 182, '迈兮', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (185, '2022-03-23 11:16:10.775739', '2022-05-30 09:52:10.000000', NULL, '秋天你别离开我', '秋天你别离开我（DJ小鑫版）', 202957196, 217, '尤小米', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (186, '2022-03-23 11:16:10.833801', '2022-04-02 13:51:22.000000', NULL, '浪子闲话', '浪子闲话(DJ沈念版)', 155255068, 252, '花僮', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (187, '2022-03-23 11:16:10.886645', '2022-03-23 11:22:01.000000', NULL, '离开我，你怎么不难过', '离开我，你怎么不难过(DJ小鑫版)', 197270735, 199, '吴姗姗', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (188, '2022-03-23 11:16:10.939973', '2022-03-23 11:16:10.939973', NULL, '一个多情又无情的人 (Dj沈念)', '一个多情又无情的人(沈念DJ版)', 171152385, 238, '花姐', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (189, '2022-03-23 11:16:10.990712', '2022-03-23 11:16:10.990712', NULL, '广西桃花运(DJR7版)', '桃花运(DJR7版)', 190839484, 146, 'R7[DJ]', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (190, '2022-03-23 11:16:11.042721', '2022-03-23 11:16:11.042721', NULL, '越痛越上瘾', '越痛越上瘾（DJ沈念版）', 143353463, 200, '郭飞宏', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (191, '2022-03-23 11:16:11.097040', '2022-07-27 13:17:15.000000', NULL, '扛过枪 放过羊', '扛过枪 放过羊(DJ伟然版)', 154376562, 232, '半吨兄弟', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (192, '2022-03-23 11:16:11.147911', '2022-03-23 11:16:11.147911', NULL, '野摩托', '野摩托(Dj阿卓版）', 173539612, 165, 'HM郭镐鸣', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (193, '2022-03-23 11:16:11.200331', '2022-03-23 11:16:11.200331', NULL, '放手也是另一种爱', '放手也是另一种爱(DJAilward版)', 177101994, 203, '动人心弦', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (194, '2022-03-23 11:16:11.252441', '2022-04-02 16:16:42.000000', NULL, '1314公里', '1314公里(DJ版)', 206220451, 230, '魏佳艺&R7[DJ]', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (195, '2022-03-23 11:16:11.303564', '2022-03-23 11:16:11.303564', NULL, '爱情这杯酒，一碰就上头', '爱情这杯酒，一碰就上头（DJheap九天版）', 161742494, 181, '吴姗姗', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (196, '2022-03-23 11:16:11.354923', '2022-03-23 11:16:11.354923', NULL, '时间对谁下了手', '时间对谁下了手(DJEthan翊轩版)', 180660108, 264, '野生先生', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (197, '2022-03-23 11:16:11.406551', '2022-09-29 10:53:38.000000', NULL, '怎叹', '怎叹(DJ沈念版)', 182188479, 292, '郑鱼', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (198, '2022-03-23 11:16:11.458058', '2022-03-23 11:16:11.458058', NULL, '你选择冷漠，我选择洒脱', '你选择冷漠，我选择洒脱（DJ沈念）(伴奏)', 141665990, 244, '郭飞宏', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (199, '2022-03-23 11:16:11.508711', '2022-03-23 11:16:11.508711', NULL, '须尽欢', '须尽欢(DJ沈念版)', 153575840, 320, 'Hot Music', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (200, '2022-03-23 11:16:11.559815', '2022-03-23 11:16:11.559815', NULL, '逛红尘', '逛红尘(DJheap九天版)', 197471273, 214, '关剑', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (201, '2022-03-23 11:16:11.611411', '2022-11-02 14:38:28.000000', NULL, '来迟', '来迟(DJ名龙版)', 175171734, 255, '戴羽彤', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (202, '2022-03-23 11:16:11.667874', '2022-03-23 13:53:33.000000', NULL, '破釜沉舟(DJheap九天版)', '破釜沉舟(DJheap九天版)', 156491152, 215, '张禾禾', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (203, '2022-03-23 11:16:11.721579', '2022-03-23 11:16:11.721579', NULL, '金玉良缘', '金玉良缘(DJ沐羽曦版)', 199946303, 136, '付雪&沐羽曦', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (204, '2022-03-23 11:16:11.772856', '2022-03-23 11:16:11.772856', NULL, '烟雨人间', '烟雨人间(DJ沈念版)', 176729863, 284, '海来阿木', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (205, '2022-03-23 11:16:11.825668', '2022-03-23 13:49:28.000000', NULL, '最后的人', '最后的人(DJ阿卓版)', 188635372, 198, '杨小壮', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (206, '2022-03-23 11:16:11.879215', '2022-03-23 11:16:11.879215', NULL, 'Empty Love (feat. Kid Princess)', 'Empty Love', 92184594, 170, 'Lulleaux&Kid Princess', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (207, '2022-03-23 11:16:11.931697', '2022-07-27 14:42:00.000000', NULL, 'The New Kings', 'The New Kings', 28459978, 222, 'Vicetone&Popeska&Luciana', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (208, '2022-03-23 11:16:11.983786', '2022-03-23 11:16:11.983786', NULL, 'Future House Shuffle 2', 'U Make Me(Natan Chaim & Asketa Remix)', 82549378, 156, 'Raquel Castro&Disco Fries', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (209, '2022-03-23 11:16:12.035708', '2022-03-23 11:16:12.035708', NULL, 'This Is Acting', 'Move Your Body', 6881776, 247, 'Sia', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (210, '2022-03-23 11:16:12.085797', '2022-03-23 11:16:12.085797', NULL, 'Play', 'Play', 75869297, 167, 'K-391&Alan Walker&TUNGEVAAG&Mangoo', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (211, '2022-03-23 11:16:12.142078', '2022-03-23 11:16:12.142078', NULL, '', 'Time Bomb', 6857641, 211, 'Veela&Feint&Boyinaband', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (212, '2022-03-23 11:16:12.192768', '2022-03-23 17:51:34.000000', NULL, 'Hands in the Fire (Explicit)', 'Hands in the Fire(Explicit)', 54471374, 176, 'James Carter&Nevve', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (213, '2022-03-23 11:16:12.244891', '2022-07-27 13:44:21.000000', NULL, 'Nevada', 'Nevada', 27780075, 208, 'Vicetone&Cozi Zuehlsdorff', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (214, '2022-03-23 11:16:12.295695', '2022-03-23 11:16:12.295695', NULL, 'Way Back', 'Way Back', 40757957, 208, 'Vicetone&Cozi Zuehlsdorff', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (215, '2022-03-23 11:16:12.346099', '2022-03-23 11:16:12.346099', NULL, 'On My Way', 'On My Way', 65633689, 193, 'Alan Walker&Sabrina Carpenter&Farruko', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (216, '2022-03-23 11:16:12.399633', '2022-03-23 11:16:12.399633', NULL, 'Remember Our Summer', 'Remember Our Summer', 148356772, 163, 'FrogMonster', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (217, '2022-03-23 11:16:12.450689', '2022-03-23 11:16:12.450689', NULL, 'This Is Acting', 'Unstoppable', 6881777, 217, 'Sia', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (218, '2022-03-23 11:16:12.503955', '2022-03-23 11:16:12.503955', NULL, 'Lost Control (feat. Bianca)', 'Lost Control(feat. Bianca)', 51567593, 269, 'Tyron Hapi&Bianca', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (219, '2022-03-23 11:16:12.555615', '2022-03-23 11:16:12.555615', NULL, 'Superstar', 'Superstar', 27189826, 217, 'Beatrich', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (220, '2022-03-23 11:16:12.607680', '2022-03-23 11:16:12.607680', NULL, 'Dancing With Your Ghost', 'Dancing With Your Ghost', 71509954, 197, 'Sasha Sloan', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (221, '2022-03-23 11:16:12.670687', '2022-03-25 09:00:54.000000', NULL, 'Zella Day', 'East of Eden', 5835006, 186, 'Zella Day', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (222, '2022-03-23 11:16:12.723922', '2022-07-27 13:53:22.000000', NULL, 'Cannibals EP', 'Come Back Down(Original Mix)', 13239595, 248, 'Mediks', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (223, '2022-03-23 11:16:12.775430', '2022-03-23 11:16:12.775430', NULL, 'We Won’t Be Alone', 'We Won’t Be Alone', 7207346, 234, 'Feint&Laura Brehm', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (224, '2022-03-23 11:16:12.825869', '2022-03-23 11:16:12.825869', NULL, 'Power (In Your Soul)', 'Power (In Your Soul)', 177180308, 215, 'Interupt&Luna LePage', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (225, '2022-03-23 11:16:12.878798', '2022-03-23 11:16:12.878798', NULL, 'Walk Thru Fire', 'Walk Thru Fire', 51257017, 194, 'Vicetone&Meron Ryan', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (226, '2022-03-23 11:16:12.931816', '2022-03-23 11:16:12.931816', NULL, 'Alchemy (Liquicity Presents)', 'Vagrant', 180657031, 268, 'Feint&Veela', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (227, '2022-03-23 11:16:12.985486', '2022-03-23 11:16:12.985486', NULL, 'Motion (Explicit)', 'Outside', 5835268, 227, 'Calvin Harris&Ellie Goulding', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (228, '2022-03-28 14:17:33.837472', '2022-07-01 15:37:54.850163', NULL, '画(Live Piano Session Ⅱ)', '画(Live Piano Session Ⅱ)', 7087465, 168, 'G.E.M.邓紫棋', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (243, '2022-07-01 15:39:07.097428', '2022-07-01 15:39:07.097428', NULL, 'Chill Vibes (Feel Good Music : Deep House & Electro Pop Tunes)', 'You Don’t Know Me', 49831865, 147, 'Ofenbach&Brodie Barclay', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (413, '2022-07-26 15:05:09.698000', '2022-07-26 15:05:09.698000', NULL, '最伟大的作品', '最伟大的作品', 226555043, 265, '周杰伦', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (414, '2022-07-26 15:09:42.660000', '2022-07-26 15:09:42.660000', NULL, '最伟大的作品', '最伟大的作品', 226555044, 257, '周杰伦', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (415, '2022-07-26 15:15:28.748000', '2022-07-26 15:15:28.748000', NULL, '最伟大的作品', '最伟大的作品', 226555045, 257, '周杰伦', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (416, '2022-07-26 15:21:54.470000', '2022-11-02 14:05:34.000000', NULL, '最伟大的作品', '最伟大的作品', 226555041, 234, '周杰伦', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (417, '2022-07-26 16:04:16.663000', '2022-07-26 16:04:16.663000', NULL, '青年晚报', '青年晚报', 7056885, 249, '许嵩', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (418, '2022-07-26 16:12:23.242000', '2022-12-01 11:49:58.000000', NULL, '天龙八部之宿敌', '天龙八部之宿敌', 1090336, 264, '许嵩', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (419, '2022-07-26 17:03:28.260000', '2022-07-26 17:03:28.260000', NULL, '', '', 173482008, 286, '景默', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (421, '2022-07-27 11:28:57.479000', '2022-07-27 11:28:57.479000', NULL, '千古', '千古', 6564220, 221, '许嵩', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (422, '2022-07-27 11:37:30.518000', '2022-07-27 11:37:30.518000', NULL, '江湖', '江湖', 9561239, 268, '许嵩', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (423, '2022-07-27 11:44:06.707000', '2022-07-27 11:44:06.707000', NULL, '赘婿 影视剧原声带', '赘婿 影视剧原声带', 166067066, 228, '许嵩', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (433, '2022-07-27 16:16:07.106000', '2022-07-27 16:16:07.106000', NULL, '孤勇者', '孤勇者', 198554068, 256, '陈奕迅', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (435, '2022-07-28 09:25:57.331000', '2022-07-28 09:25:57.331000', NULL, '叹', '叹', 202367109, 251, '黄龄&Tăng Duy Tân', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (436, '2022-07-28 09:44:23.102000', '2022-12-01 11:36:28.000000', NULL, '半壶纱', '半壶纱', 6826036, 237, '刘珂矣', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (437, '2022-07-28 10:08:52.793000', '2022-07-28 10:08:52.793000', NULL, '起风了', '起风了', 149121488, 311, '周深', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (438, '2022-07-28 10:34:54.517000', '2022-07-28 10:34:54.517000', NULL, '悟空', '悟空', 25335337, 442, '戴荃', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (443, '2022-08-02 08:50:32.895000', '2022-08-02 08:50:32.895000', NULL, '阎维文单曲集', '阎维文单曲集', 12862011, 114, '阎维文', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (444, '2022-08-02 08:53:31.170000', '2022-08-02 08:53:31.170000', NULL, '', '', 54963555, 213, '群星', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (445, '2022-08-06 18:46:57.565000', '2022-08-06 18:46:57.565000', NULL, '月老掉线', '月老掉线', 206542158, 238, '王不醒', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (448, '2022-08-24 08:23:38.621000', '2022-08-24 08:23:38.621000', NULL, '我很忙', '我很忙', 324244, 237, '周杰伦', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (449, '2022-08-24 08:45:52.257000', '2022-08-24 08:45:52.257000', NULL, '叶惠美', '叶惠美', 228908, 269, '周杰伦', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (450, '2022-08-24 10:11:32.040000', '2022-08-24 10:11:32.040000', NULL, '步步 自选作品辑 the Best of 1999-2013', '步步 自选作品辑 the Best of 1999-2013', 56218340, 263, '五月天', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (452, '2022-08-25 15:54:07.376000', '2022-08-25 15:54:07.376000', NULL, '', '', 28392064, 434, '张卫', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (453, '2022-08-30 17:13:10.400000', '2022-10-13 16:50:38.000000', NULL, '诗画中国', '诗画中国', 236362975, 252, '许嵩&谭维维', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (455, '2022-09-13 14:41:08.118000', '2022-09-13 14:41:42.000000', NULL, '2022湖南卫视中秋晚会', '2022湖南卫视中秋晚会', 238982871, 313, '许嵩', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (459, '2022-09-30 17:14:42.227000', '2022-09-30 17:14:42.227000', NULL, '吉姆餐厅', '吉姆餐厅', 5381582, 311, '赵雷', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (460, '2022-10-13 16:43:15.515000', '2022-10-13 16:43:15.515000', NULL, '纸上雪', '纸上雪', 237784473, 261, '许嵩', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (463, '2022-10-13 17:32:29.259000', '2022-10-13 17:32:29.259000', NULL, '在你的身边', '在你的身边', 69978943, 262, '盛哲', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (465, '2022-10-31 10:33:57.192000', '2022-10-31 10:33:57.192000', NULL, '魔杰座', '魔杰座', 440616, 253, '周杰伦', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (468, '2022-11-03 13:49:51.071000', '2022-11-03 13:49:51.071000', NULL, '曼陀山庄', '曼陀山庄', 246445364, 256, '许嵩', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (469, '2022-11-30 15:37:27.842000', '2022-12-01 11:44:28.000000', NULL, '赐我', '赐我', 247519552, 155, '一只白羊', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (470, '2022-11-30 15:39:36.799000', '2022-11-30 15:39:36.799000', NULL, '小城画师', '小城画师', 233476655, 154, '李小贝', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (471, '2022-11-30 15:42:06.777000', '2022-11-30 15:42:06.777000', NULL, '三两三', '三两三', 220609548, 180, '凌丰', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (475, '2022-12-01 14:28:40.562000', '2022-12-01 14:28:40.562000', NULL, '1st.星球', '1st.星球', 142683102, 334, '柳爽', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (481, '2023-01-11 09:28:01.946000', '2023-01-11 09:28:01.946000', NULL, '我的战鹰绕着宝岛飞', '我的战鹰绕着宝岛飞', 87504449, 202, '韩召', 0, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (527, '2022-03-28 17:17:10.122014', '2022-03-28 17:17:10.122014', NULL, '林子祥 & 陈奕迅 拉阔压轴', '十分十二寸 (Live)', 28652006, 601, '林子祥&陈奕迅', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (528, '2022-03-29 14:49:26.368973', '2022-03-29 14:49:26.368973', NULL, '', '奢香夫人 (2021时光音乐会第3期现场)', 206515968, 255, '林志炫', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (529, '2022-03-29 15:33:53.827423', '2022-03-29 15:33:53.827423', NULL, '谈钞票伤感情 谈感情又伤钞票又伤感情', '义务为豪大大鸡排所作个广告歌', 3574636, 241, '顶楼的马戏团', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (530, '2022-03-29 16:57:50.869214', '2022-03-29 16:57:50.869214', NULL, '温奕心的翻唱盒子', '一样的月光 (cover: 徐佳莹)', 212656577, 234, '温奕心', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (531, '2022-03-29 17:17:13.421127', '2022-03-29 17:17:13.421127', NULL, '孤芳自赏', '夜色(DJ版)', 78935951, 168, 'MC新旭', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (532, '2022-03-31 11:02:59.536626', '2022-03-31 11:02:59.536626', NULL, 'My Love', '魔鬼中的天使', 1083767, 238, '田馥甄', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (533, '2022-03-31 16:07:18.381151', '2022-03-31 16:07:18.381151', NULL, '郭德纲于谦超清相声伴眠专享', '《托妻献子》', 82788486, 2056, '郭德纲', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (534, '2022-04-01 16:23:45.866211', '2022-05-09 10:03:56.000000', NULL, '眉间雪', '眉间雪(剧情版)', 40782297, 288, 'Charlize', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (535, '2022-04-02 13:22:57.093729', '2022-04-02 13:22:57.093729', NULL, '粤曲的希望', '帝女花', 92026882, 285, '陈艺鹏', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (536, '2022-04-02 13:26:39.225873', '2022-04-02 13:26:39.225873', NULL, '红 马', '红 马(女生版)', 173947450, 238, '一颗狼星-许蓝心', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (537, '2022-04-02 13:27:18.624674', '2022-04-02 13:27:18.624674', NULL, '回马枪', '回马枪', 171857221, 220, '张晓棠', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (538, '2022-04-02 13:27:51.826188', '2022-04-02 13:27:51.826188', NULL, '', '你的眼神', 144581418, 48, '卫兰', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (539, '2022-04-02 13:29:46.953947', '2022-04-02 13:29:46.953947', NULL, '红马 (女生版)', '红马(女生版)', 173905623, 227, '一颗狼星-许蓝心', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (540, '2022-04-02 15:09:01.681249', '2022-04-02 15:09:01.681249', NULL, '偶遇2000精选', '初恋', 164585, 229, '林志美', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (541, '2022-04-02 15:34:28.420946', '2022-04-02 15:34:28.420946', NULL, '画离弦', '画离弦', 191614693, 217, '浅影阿', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (542, '2022-04-02 15:47:31.505097', '2022-04-02 15:47:31.505097', NULL, '直接影响2', '让她降落', 1653975, 243, '何璐', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (543, '2022-04-02 15:56:01.623326', '2022-04-02 15:56:01.623326', NULL, 'Grasshopper IV', '半点心', 3202719, 232, '草蜢', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (544, '2022-04-02 15:56:36.430001', '2022-04-02 15:56:36.430001', NULL, '秋色', '人生何处不相逢', 699784, 237, '陈慧娴', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (545, '2022-04-06 12:00:23.121923', '2022-04-21 13:17:20.000000', NULL, '落日与晚风', '落日与晚风', 183981434, 175, 'IN-K&王忻辰&苏星婕', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (546, '2022-04-06 12:03:39.544035', '2022-04-06 12:03:39.544035', NULL, '流行星选', '小城大事', 2302324, 208, '杨千嬅', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (547, '2022-04-06 12:04:02.633289', '2022-04-06 12:04:02.633289', NULL, '娴情', '傻女', 159834, 228, '陈慧娴', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (548, '2022-04-06 12:04:58.326566', '2022-04-06 12:04:58.326566', NULL, '别为我好', '别为我好', 92283319, 207, '许靖韵', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (549, '2022-04-06 12:07:56.048884', '2022-04-08 15:05:12.000000', NULL, '风中有朵雨做的云(粤语版)', '风中有朵雨做的云(粤语版)', 180550791, 227, '亮声open', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (550, '2022-04-06 12:18:44.745590', '2022-04-06 12:18:44.745590', NULL, '先说谎的人', '先说谎的人', 203562811, 168, 'h3R3', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (551, '2022-04-06 15:10:01.457535', '2022-04-06 15:10:01.457535', NULL, '归来吧', '月亮', 159822, 281, '陈慧娴', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (552, '2022-04-06 15:10:23.471117', '2022-04-06 15:10:23.471117', NULL, 'Crazy Love', '忘川', 1147417, 213, '陈僖仪', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (553, '2022-04-07 14:08:08.116289', '2022-04-07 14:08:08.116289', NULL, 'Hello World', 'Hello World', 206012969, 171, 'Alan Walker&Torine', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (554, '2022-04-08 15:01:28.349586', '2022-04-08 15:01:28.349586', NULL, 'Di Dar', '暧昧', 326887, 279, '王菲', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (555, '2022-04-08 15:16:38.815563', '2022-04-08 15:16:38.815563', NULL, '一起梵唱大悲咒', '大悲咒', 7185704, 171, '佛教音乐', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (556, '2022-04-12 10:05:26.186518', '2022-04-12 10:05:26.186518', NULL, '成长 (Older)', '成长 (Older)', 196965437, 164, 'Alec Benjamin', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (557, '2022-04-14 09:52:36.250492', '2022-04-14 09:52:36.250492', NULL, '致你（正式版）', '致你(正式版)', 201065296, 259, 'yihui以慧', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (558, '2022-04-14 09:53:19.018394', '2022-04-14 09:53:19.018394', NULL, '你从未离去 (女生版)', '你从未离去(女生版)', 209519651, 227, '旺仔小Q', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (559, '2022-04-14 09:54:04.710542', '2022-04-14 09:54:04.710542', NULL, '金钗叹', '金钗叹', 197645928, 182, '泽典', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (560, '2022-04-14 09:54:26.177684', '2022-04-14 09:54:26.177684', NULL, '王靖雯 (Remastered 2019)', '爱听谎言', 27156892, 253, '王菲', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (561, '2022-04-14 10:02:30.329979', '2022-04-14 10:02:30.329979', NULL, '无限循环好歌曲此生不负你深情', '书中有 - 叶里', 214319489, 253, '寻薇蓝鸣', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (562, '2022-04-14 10:56:37.139902', '2022-04-14 10:56:37.139902', NULL, '1+1=2', '1+1=2', 83382728, 267, '邹念慈', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (563, '2022-04-15 09:34:05.436401', '2022-04-15 09:34:05.436401', NULL, 'Shadow Of Mine', 'Shadow Of Mine', 211298989, 165, 'Alec Benjamin', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (564, '2022-04-15 09:41:49.726537', '2022-04-15 09:41:49.726537', NULL, '未.末', '往生净土神咒', 28079580, 228, '方磊', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (565, '2022-04-15 12:37:04.488273', '2022-04-15 12:37:04.488273', NULL, '探窗 (416女团热搜版)', '探窗(416女团热搜版)', 198576566, 188, '叶聪明&ya妖精&小淅儿&边靖婷&可爱晨&汐音社', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (566, '2022-04-22 10:58:02.751145', '2022-04-22 10:58:02.751145', NULL, '给你十万安全感', '拉黑', 205593257, 207, '王胜娚', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (567, '2022-04-24 12:15:47.413404', '2022-04-24 12:15:47.413404', NULL, '悠悠戏腔', '《囍（女生版）》-等什么君 ', 197110440, 250, '我爱曲艺', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (568, '2022-04-25 10:22:15.524884', '2022-04-25 10:22:15.524884', NULL, '现在的我', '现在的我(吉他版)', 217898591, 226, '刘大壮', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (569, '2022-04-25 10:30:15.819465', '2022-04-25 10:30:15.819465', NULL, '步履不停', '火烧云', 156789022, 198, '陈鸿宇', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (570, '2022-04-25 10:30:32.044709', '2022-04-25 10:30:32.044709', NULL, '夏如白鸟飞', '夏如白鸟飞', 213400107, 208, '陈鸿宇', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (571, '2022-04-25 10:31:34.088785', '2022-04-25 10:31:34.088785', NULL, '红气球', '红气球', 206826670, 234, '陈鸿宇', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (572, '2022-04-25 10:32:12.079901', '2022-04-25 10:32:12.079901', NULL, '类人', '类人', 209480452, 214, '陈鸿宇', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (573, '2022-04-25 10:40:29.199150', '2022-04-25 10:40:29.199150', NULL, '伯虎说 (feat.唐伯虎Annie)', '伯虎说 (feat.唐伯虎Annie)', 157042638, 220, '伯爵Johnny&唐伯虎Annie', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (574, '2022-04-25 10:41:34.188200', '2022-04-25 10:41:34.188200', NULL, '游山恋', '游山恋', 148050506, 236, '赵乙择&鹿瑶', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (575, '2022-04-25 10:42:16.614470', '2022-04-25 10:42:16.614470', NULL, '万疆', '万疆', 175381933, 234, '李玉刚', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (576, '2022-04-25 11:42:48.812973', '2022-04-25 11:42:48.812973', NULL, 'COLLAGE', '虹', 211282787, 257, '菅田将暉 (すだ まさき)', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (577, '2022-04-25 11:43:43.364778', '2022-04-25 11:43:43.364778', NULL, 'COVER LIFE', 'Endless Road(choir ver.)', 174589081, 277, 'Fumika', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (578, '2022-04-25 13:26:18.244643', '2022-04-25 13:26:18.244643', NULL, 'アイラブユー', '友だち', 41264114, 298, '西野カナ', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (579, '2022-04-26 18:16:24.649981', '2022-04-26 18:16:24.649981', NULL, '天黑', '撕夜', 96832, 278, '阿杜', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (580, '2022-04-27 11:35:53.160398', '2022-04-27 11:35:53.160398', NULL, '不要停止我的音乐', '西湖', 439394, 253, '痛仰乐队', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (581, '2022-04-27 12:50:59.333475', '2022-04-27 12:50:59.333475', NULL, '星の中の君', '星の中の君', 178180298, 255, 'Uru', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (582, '2022-04-27 12:51:47.645374', '2022-04-27 12:51:47.645374', NULL, '涙そうそう', '涙そうそう (泪光闪闪)', 56466641, 258, '夏川りみ', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (583, '2022-04-27 12:55:26.135774', '2022-04-27 12:55:26.135774', NULL, '再会 (produced by Ayase)', '再会(produced by Ayase)', 154916176, 242, 'LiSA&Uru', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (584, '2022-04-27 12:55:53.500672', '2022-04-27 12:55:53.500672', NULL, 'I beg you / 花びらたちのマーチ / Sailing', '花びらたちのマーチ', 63060644, 194, 'Aimer', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (585, '2022-04-27 12:57:29.141901', '2022-04-27 12:57:29.141901', NULL, 'さよなら大好きだったよ', 'あとひとつ', 3257098, 332, 'ケラケラ', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (586, '2022-04-27 12:58:00.529215', '2022-04-27 12:58:00.529215', NULL, 'Panorama', 'それがいいな', 6477622, 215, '南壽あさ子', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (587, '2022-04-27 13:00:03.293769', '2022-04-27 13:00:03.293769', NULL, 'マリーゴールド', 'マリーゴールド', 48027008, 308, 'Aimyon', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (588, '2022-04-27 13:02:15.297505', '2022-04-27 13:02:15.297505', NULL, 'Sun Dance', '思い出は奇麗で', 54376644, 211, 'Aimer', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (589, '2022-04-27 13:05:10.975256', '2022-04-27 13:05:10.975256', NULL, '《玛丽与魔女之花》原声大碟', 'RAIN', 28659959, 311, 'SEKAI NO OWARI', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (590, '2022-04-27 13:06:16.573089', '2022-04-27 13:06:16.573089', NULL, 'Goose house Phrase #07 Soundtrack?', 'ごはんを食べよう', 3432357, 268, 'Goose House', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (591, '2022-05-07 17:27:41.598767', '2022-05-07 17:27:41.598767', NULL, '爱就爱了', '爱就爱了', 23641846, 248, '陈琳', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (592, '2022-05-07 17:27:54.654421', '2022-05-07 17:27:54.654421', NULL, '时光背面的我', '时光背面的我', 184274130, 181, '刘至佳&韩瞳', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (593, '2022-05-07 17:28:11.369738', '2022-05-07 17:28:11.369738', NULL, '金曲百分百（上）', '其实我介意', 22865284, 242, '林汉洋&小雪', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (594, '2022-05-18 11:50:16.140270', '2022-05-18 11:50:16.140270', NULL, '月牙儿', '月牙儿', 220151552, 215, '方磊', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (595, '2022-05-25 11:42:31.798736', '2022-05-25 11:42:31.798736', NULL, 'Shall We Talk (Tre Lune MMXIX)', 'Shall We Talk(Tre Lune MMXIX)', 145198682, 261, '陈奕迅', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (596, '2022-06-27 10:26:32.283385', '2022-06-27 10:26:32.283385', NULL, '仙瑶', '仙瑶 (cover: 叶里)', 224752743, 219, '兰音Reine', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (597, '2022-06-27 10:26:36.790295', '2022-06-27 10:26:36.790295', NULL, '雾里', '雾里 (cover: 姚六一)', 193876059, 246, '兰音Reine', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (598, '2022-06-27 10:26:47.151365', '2022-06-27 10:26:47.151365', NULL, '盗墓笔记·十年人间', '盗墓笔记·十年人间 (cover: 李常超)', 224752627, 277, '兰音Reine', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (599, '2022-07-01 16:45:46.503247', '2022-07-01 16:45:46.503247', NULL, '红歌100首 献给党诞辰90周年', '没有共产党就没有新中国', 2288403, 114, '华语群星', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (600, '2022-07-01 16:48:16.393151', '2022-07-01 16:48:16.393151', NULL, '我和我的祖国', '我和我的祖国', 78217929, 243, '华语群星', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (601, '2022-07-01 16:51:49.701582', '2022-07-01 16:51:49.701582', NULL, '致吾辈', '致吾辈', 218737091, 231, '张杰', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (602, '2022-07-01 16:58:05.594937', '2022-07-01 16:58:05.594937', NULL, '灯火里的中国 (舒楠监制 官方正式版)', '灯火里的中国(舒楠监制 官方正式版)', 173571850, 240, '张也&周深', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (603, '2022-07-01 16:59:43.937661', '2022-07-01 16:59:43.937661', NULL, '红歌100首 献给党诞辰90周年', '东方红', 22802027, 189, '华语群星', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (604, '2022-07-01 17:03:48.843126', '2022-07-01 17:03:48.843126', NULL, '青年说', '青年说', 219588212, 166, '龚俊', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (605, '2022-07-01 17:08:50.053806', '2022-07-01 17:08:50.053806', NULL, '红色经典', '我的祖国', 376964, 340, '刀郎', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (606, '2022-07-01 17:15:30.511087', '2022-07-01 17:15:30.511087', NULL, '我的祖国', '唱支山歌给党听', 2330602, 245, '张芯', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (607, '2022-07-01 17:19:52.283139', '2022-07-01 17:19:52.283139', NULL, '张也', '走进新时代', 222737310, 246, '张也', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (608, '2022-07-01 17:22:57.862550', '2022-07-01 17:22:57.862550', NULL, '红歌100首 献给党诞辰90周年', '大中国', 2288398, 224, '华语群星', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (609, '2022-07-01 17:26:45.634497', '2022-07-01 17:26:45.634497', NULL, '祖国颂', '祖国颂', 40925388, 191, '群星', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (610, '2022-07-01 17:36:22.730296', '2022-07-01 17:36:22.730296', NULL, '中国原创金曲', '爱我中华', 222605510, 213, '宋祖英', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (611, '2022-07-01 17:39:39.491868', '2022-07-01 17:39:39.491868', NULL, '2018中央电视台春节联欢晚会', '赞赞新时代(Live)', 40614181, 218, '李易峰&景甜&江疏影', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (612, '2022-07-01 17:43:58.679928', '2022-07-01 17:43:58.679928', NULL, '声生不息 第10期', '东方之珠(Live)', 225425567, 249, '林子祥&谭咏麟&叶蒨文&李克勤&那英&林晓峰&杨千嬅&李健&CoCo李玟&周笔畅&糖妹&刘惜君&马赛克&Mike 曾比特&毛不易&安崎&魔动闪霸&单依纯&炎明熹&吴若希&陈豪&方力申&Maria Cordero&谭俊彦&林夏薇&马德钟', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (613, '2022-07-01 17:44:04.329587', '2022-07-01 17:44:04.329587', NULL, 'Binary', '喜帖街', 466292, 213, '谢安琪', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (614, '2022-07-01 17:47:46.849120', '2022-07-01 17:47:46.849120', NULL, '黄河大合唱(完整珍藏版)', '保卫黄河', 5227931, 182, '中国交响乐团', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (615, '2022-07-01 18:00:53.792611', '2022-07-01 18:00:53.792611', NULL, '音乐会组曲', '红色娘子军 序曲(Live)', 2778311, 72, '中国交响乐团', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (616, '2022-07-01 18:12:19.820676', '2022-07-01 18:12:19.820676', NULL, '致敬经典', '青春舞曲', 3426775, 180, '玖月奇迹', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (617, '2022-07-13 13:28:43.799107', '2022-07-27 14:25:29.000000', NULL, '最伟大的作品', '最伟大的作品', 226543302, 244, '周杰伦', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (621, '2022-07-13 13:34:01.506736', '2022-07-13 13:34:01.506736', NULL, '最伟大的作品', '说好不哭 (with 五月天阿信)', 226544164, 222, '周杰伦', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (622, '2022-07-13 13:36:27.871864', '2022-07-13 13:36:27.871864', NULL, '最伟大的作品', 'Mojito', 226544163, 185, '周杰伦', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (623, '2022-07-13 15:45:44.729636', '2022-07-13 15:45:44.729636', NULL, '最伟大的作品', '等你下课 (with 杨瑞代)', 226544165, 270, '周杰伦', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (624, '2022-07-13 15:45:47.828517', '2022-07-13 15:45:47.828517', NULL, '最伟大的作品', '我是如此相信', 226546151, 266, '周杰伦', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (625, '2022-07-13 15:45:49.036632', '2022-07-26 15:01:34.000000', NULL, '最伟大的作品', '不爱我就拉倒', 226543301, 245, '周杰伦', 1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (626, '2022-07-19 10:26:47.323258', '2022-07-19 10:26:47.323258', NULL, '时光与火焰', 'Upupu', 210910861, 264, '小皮皮爱习题', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (627, '2022-07-19 10:57:06.299158', '2022-07-19 10:57:06.299158', NULL, 'さよならくちびる', '誰にだって訳がある', 69571721, 173, 'ハルレオ', -1, 'https://blog.wangscaler.com/back.jpg');
INSERT INTO `tb_music` VALUES (628, '2022-07-19 11:35:08.692139', '2022-07-19 11:35:08.692139', NULL, '茶太 Works Best Ⅱ', '夢笑顔 (「真恋姫無双 萌将伝」　挿入歌)', 1517920, 279, '茶太', -1, 'https://blog.wangscaler.com/back.jpg');

-- ----------------------------
-- Table structure for tb_room
-- ----------------------------
DROP TABLE IF EXISTS `tb_room`;
CREATE TABLE `tb_room`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `deleted_at` datetime(6) NULL DEFAULT NULL COMMENT '删除时间',
  `room_user_id` int(0) NOT NULL COMMENT '房间创建人id',
  `room_id` int(0) NOT NULL COMMENT '房间ID',
  `room_logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间logo',
  `room_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '房间名称',
  `room_need_password` int(0) NOT NULL DEFAULT 1 COMMENT '房间是否需要密码 1:公开 2:加密',
  `room_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间密码',
  `room_notice` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '房间空空如也呢' COMMENT '房间公告',
  `room_bg_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间背景图片',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `IDX_5e3006c98f4812d4b8e582eeb4`(`room_user_id`) USING BTREE,
  UNIQUE INDEX `IDX_7c90be7623eecf597b8ffac1f4`(`room_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_room
-- ----------------------------
INSERT INTO `tb_room` VALUES (1, '2022-07-26 09:25:36.000000', '2022-09-08 09:56:30.000000', NULL, 1, 888, 'https://public-1300678944.cos.ap-shanghai.myqcloud.com/blog/1661390926523135937807-fd3e0fd2-a31a-47a4-90c6-b0bb1d0704d4.png', '官方大厅', 1, NULL, '1.本房间禁止任何违法非法行为。\n\n\n\n2.禁止谈论关于色情、政治等任何敏感信息。\n3.聊天室属于开放平台，有任何以上行为与本人无关。\n4.如果有以上行为，请及时举报至Q/V:1349320519。\n5.感谢spirit、nihao的资金支持。\n6.感谢九儿的书屋、摸鱼大王、古月_歌的代码贡献。', NULL);

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `deleted_at` datetime(6) NULL DEFAULT NULL COMMENT '删除时间',
  `user_name` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `user_nick` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_password` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户密码',
  `user_status` int(0) NOT NULL DEFAULT 1 COMMENT '用户状态',
  `user_sex` int(0) NOT NULL DEFAULT 1 COMMENT '用户性别',
  `user_email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户邮箱',
  `user_avatar` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户头像',
  `user_role` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'viewer' COMMENT '用户权限',
  `user_room_bg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户个人聊天室背景图',
  `user_room_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户个人创建的房间Id',
  `user_sign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '每个人都有签名、我希望你也有...',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 953 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1, '2023-07-03 15:22:11.770291', '2023-07-06 16:47:21.888149', NULL, 'test', 'test', '391d86f10f63bf80c3294fb4a99ee3bd', 1, 1, 'wangscaler@163.com', 'https://img1.baidu.com/it/u=1738531146,3909274171&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500', 'viewer', NULL, NULL, '每个人都有签名、我希望你也有...');
INSERT INTO `tb_user` VALUES (2, '2023-07-05 16:44:45.033393', '2023-07-10 15:00:42.730627', NULL, 'wangscaler', 'wang', '391d86f10f63bf80c3294fb4a99ee3bd', 1, 1, 'wangscaler@qq.com', 'https://img1.baidu.com/it/u=1738531146,3909274171&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500', 'viewer', NULL, NULL, '每个人都有签名、我希望你也有...');

-- ----------------------------
-- Table structure for undo_log
-- ----------------------------
DROP TABLE IF EXISTS `undo_log`;
CREATE TABLE `undo_log`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(0) NOT NULL,
  `xid` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `context` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int(0) NOT NULL,
  `log_created` datetime(0) NULL,
  `log_modified` datetime(0) NULL,
  `ext` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ux_undo_log`(`xid`, `branch_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
