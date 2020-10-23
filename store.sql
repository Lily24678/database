/*
Navicat MySQL Data Transfer

Source Server         : MySQL测试
Source Server Version : 50549
Source Host           : localhost:3306
Source Database       : store

Target Server Type    : MYSQL
Target Server Version : 50549
File Encoding         : 65001

Date: 2020-03-19 01:14:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` varchar(64) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `code` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO store.user (uid, username, password, name, email, telephone, birthday, sex, state, code) VALUES ('25b2d909-e565-43a3-aa00-f1500d5367e0', 'xiaoming3', '123', '小明3', 'xiaoming@163.com', '123xxxxxxxxxxx', '2020-10-23', '男', 1, '322423xxxxxxxxxxxx');
INSERT INTO store.user (uid, username, password, name, email, telephone, birthday, sex, state, code) VALUES ('50e59e85-197c-4e4b-9d44-9d79309d8479', 'xiaoming', '123', '小明', 'xiaoming@163.com', '123xxxxxxxxxxx', '2020-10-23', '男', 1, '322423xxxxxxxxxxxx');
INSERT INTO store.user (uid, username, password, name, email, telephone, birthday, sex, state, code) VALUES ('d154349d-5cbd-40da-8353-e44fdd26f4d4', 'xiaoming2', '123', '小明2', 'xiaoming@163.com', '123xxxxxxxxxxx', '2020-10-23', '男', 1, '322423xxxxxxxxxxxx');
-- ----------------------------
-- Records of user
-- ----------------------------
