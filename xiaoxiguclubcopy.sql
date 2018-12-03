/*
 Navicat Premium Data Transfer

 Source Server         : 腾讯云数据库
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : 123.206.56.225:3306
 Source Schema         : xiaoxiguclubcopy

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 30/11/2018 15:08:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '姓名',
  `account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录账号',
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登陆密码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '性别(0:女，1：男）',
  `age` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '年龄',
  `birthday` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '出生日期',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系方式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('05339b5fbee54b8982babbb59a0c093e', '周漾玥', 'zhouyangyue', '000000000a', '0', '11', '2007-09-25', '15313300001');
INSERT INTO `user` VALUES ('16576d15860b4f7bacd1947a3dd212e3', '钟宝儿', 'zhongbaoer', '000000000a', '0', '13', '2005-05-01', '15313300002');
INSERT INTO `user` VALUES ('27fb3aa1759e472faf23ffafd90a62b9', '陶冰蓝', 'taobinglan', '000000000a', '0', '13', '2005-06-12', '15313300010');
INSERT INTO `user` VALUES ('2ebf6d367c9d4af7b5df9ac2cbd06ede', '崔傲菲儿', 'cuiaofeier', '000000000a', '0', '8', '2010-08-04', '15313300006');
INSERT INTO `user` VALUES ('391b1c6b1f10436dacd54b6cea760ad1', '罗熙怡', 'luoxiyi', '000000000a', '0', '10', '2008-05-31', '15313300011');
INSERT INTO `user` VALUES ('399e3bb027e245c08dc0b9d980b46d79', '王明亮', 'lianggepeinixueJava', '000000000a', '1', '23', '1995-01-01', '15313300000');
INSERT INTO `user` VALUES ('53199251feac4d878cb775d7949ecfbb', '陈舒宜', 'chenshuyi', '000000000a', '0', '13', '2005-06-27', '15313300008');
INSERT INTO `user` VALUES ('5de10b2eabbb4cf9918ad6b8c2080f0d', '刘戴恩', 'liudaien', '000000000a', '0', '11', '2007-10-22', '15313300004');
INSERT INTO `user` VALUES ('6afae65e5e9d41f494cad69be228b21f', '释小松', 'shixiaosong', '000000000a', '1', '12', '2006-03-09', '15313300003');
INSERT INTO `user` VALUES ('7e6eaead4bf0435797dd9746c6c716a4', '郭飞歌', 'guofeige', '000000000a', '0', '11', '2007-07-03', '15313300005');
INSERT INTO `user` VALUES ('8d161b12a0f3444da66602c614d42455', '肖杨博涵', 'xiaoyangbohan', '000000000a', '1', '14', '2004-01-12', '15313300007');
INSERT INTO `user` VALUES ('efa6fb25fdeb4e90b46a002889bb3a6d', '钟奕儿', 'zhongyier', '000000000a', '0', '12', '2006-09-25', '15313300009');

SET FOREIGN_KEY_CHECKS = 1;
