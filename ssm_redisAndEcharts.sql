/*
Navicat MySQL Data Transfer

Source Server         : 133
Source Server Version : 50713
Source Host           : 192.168.1.181:3306
Source Database       : ssm_redis

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-03-17 18:01:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for alldata
-- ----------------------------
DROP TABLE IF EXISTS `alldata`;
CREATE TABLE `alldata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taizhan_num` varchar(255) DEFAULT NULL,
  `tem` varchar(255) DEFAULT NULL,
  `hum` varchar(255) DEFAULT NULL,
  `pa` varchar(255) DEFAULT NULL,
  `rain` varchar(255) DEFAULT NULL,
  `win_dir` varchar(255) DEFAULT NULL,
  `win_sp` varchar(255) DEFAULT NULL,
  `dateStr` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alldata
-- ----------------------------
INSERT INTO `alldata` VALUES ('1', 'A0001', '23', '321', '122', '232', '232', '321', '2017-03-08 00:00:00', '2017-03-08 00:00:00');
INSERT INTO `alldata` VALUES ('2', 'A0001', '32', '231', '323', '323', '663', '322', '2017-03-08 00:00:00', '2017-03-08 00:00:00');
INSERT INTO `alldata` VALUES ('3', 'A0001', '22', '321', '324', '323', '322', '322', '2017-03-08 00:00:00', '2017-03-08 00:00:00');
INSERT INTO `alldata` VALUES ('4', 'A0001', '32', '323', '321', '322', '322', '324', '2017-03-08 00:00:00', '2017-03-08 00:00:00');
INSERT INTO `alldata` VALUES ('5', 'A0001', '32', '234', '321', '322', '325', '421', '2017-03-08 00:00:00', '2017-03-08 00:00:00');
