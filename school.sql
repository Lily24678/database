/*
Navicat MySQL Data Transfer

Source Server         : 本机MYSQL
Source Server Version : 50724
Source Host           : localhost:3306
Source Database       : school

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2018-12-27 15:22:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `c_id` int(11) NOT NULL COMMENT '课程编号',
  `c_name` varchar(20) DEFAULT NULL COMMENT '课程名称',
  `t_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`c_id`),
  KEY `t_id` (`t_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`t_id`) REFERENCES `teacher` (`t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程表';

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', '语文', '2');
INSERT INTO `course` VALUES ('2', '数学', '1');
INSERT INTO `course` VALUES ('3', '英语', '3');

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
  `s_id` int(11) DEFAULT NULL COMMENT '学生编号',
  `c_id` int(11) DEFAULT NULL COMMENT '课程编号',
  `s_score` decimal(4,2) DEFAULT NULL COMMENT '分数',
  KEY `c_id` (`c_id`),
  KEY `s_id` (`s_id`),
  CONSTRAINT `score_ibfk_2` FOREIGN KEY (`c_id`) REFERENCES `course` (`c_id`),
  CONSTRAINT `score_ibfk_3` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分数表';

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES ('1', '1', '80.00');
INSERT INTO `score` VALUES ('1', '2', '90.00');
INSERT INTO `score` VALUES ('1', '3', '99.00');
INSERT INTO `score` VALUES ('2', '1', '70.00');
INSERT INTO `score` VALUES ('2', '2', '60.00');
INSERT INTO `score` VALUES ('2', '3', '80.00');
INSERT INTO `score` VALUES ('3', '1', '80.00');
INSERT INTO `score` VALUES ('3', '2', '80.00');
INSERT INTO `score` VALUES ('3', '3', '80.00');
INSERT INTO `score` VALUES ('4', '1', '50.00');
INSERT INTO `score` VALUES ('4', '2', '30.00');
INSERT INTO `score` VALUES ('4', '3', '20.00');
INSERT INTO `score` VALUES ('5', '1', '76.00');
INSERT INTO `score` VALUES ('5', '2', '87.00');
INSERT INTO `score` VALUES ('6', '1', '31.00');
INSERT INTO `score` VALUES ('6', '3', '34.00');
INSERT INTO `score` VALUES ('7', '2', '89.00');
INSERT INTO `score` VALUES ('7', '3', '98.00');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `s_id` int(11) NOT NULL COMMENT '学生编号',
  `s_name` varchar(20) DEFAULT NULL COMMENT '学生姓名',
  `s_sex` varchar(20) DEFAULT NULL COMMENT '学生性别',
  `s_birth` varchar(20) DEFAULT NULL COMMENT '出生年月',
  `s_address` varchar(20) DEFAULT NULL COMMENT '家庭住址',
  `s_tel` varchar(20) DEFAULT NULL COMMENT '电话号码',
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生表';

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '赵雷', '男', '1990-01-01', null, null);
INSERT INTO `student` VALUES ('2', '钱电', '男', '1990-12-21', null, null);
INSERT INTO `student` VALUES ('3', '孙风', '男', '1990-05-20', null, null);
INSERT INTO `student` VALUES ('4', '李云', '男', '1990-08-06', null, null);
INSERT INTO `student` VALUES ('5', '周梅', '女', '1991-12-29', null, null);
INSERT INTO `student` VALUES ('6', '吴兰', '女', '1992-03-01', null, null);
INSERT INTO `student` VALUES ('7', '郑竹', '女', '1989-07-01', null, null);
INSERT INTO `student` VALUES ('8', '王菊', '女', '', null, null);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '存在数据表中的唯一标识符id',
  `username` varchar(100) NOT NULL COMMENT '登录用户名',
  `password` varchar(100) NOT NULL COMMENT '登录用户的密码',
  `cretime` datetime DEFAULT NULL COMMENT '用户创建的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `t_id` int(11) NOT NULL COMMENT '教师编号',
  `t_name` varchar(20) DEFAULT NULL COMMENT '教师姓名',
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师表';

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1', '张三');
INSERT INTO `teacher` VALUES ('2', '李四');
INSERT INTO `teacher` VALUES ('3', '王五');
