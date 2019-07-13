/*
Navicat MySQL Data Transfer

Source Server         : javaweb
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : vote

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2019-07-13 15:37:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `vote_item`
-- ----------------------------
DROP TABLE IF EXISTS `vote_item`;
CREATE TABLE `vote_item` (
  `vi_id` int(11) NOT NULL AUTO_INCREMENT,
  `vo_id` int(11) NOT NULL,
  `vs_id` int(11) NOT NULL,
  `vu_user_id` int(11) NOT NULL,
  `vi_create_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`vi_id`),
  KEY `f_vo_id` (`vo_id`),
  KEY `f_vs_id` (`vs_id`),
  KEY `f_vu_user_id` (`vu_user_id`),
  CONSTRAINT `f_vo_id` FOREIGN KEY (`vo_id`) REFERENCES `vote_option` (`vo_id`),
  CONSTRAINT `f_vs_id` FOREIGN KEY (`vs_id`) REFERENCES `vote_subject` (`vs_id`),
  CONSTRAINT `f_vu_user_id` FOREIGN KEY (`vu_user_id`) REFERENCES `vote_user` (`vu_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vote_item
-- ----------------------------
INSERT INTO `vote_item` VALUES ('11', '537', '657', '1', null);
INSERT INTO `vote_item` VALUES ('12', '537', '657', '6', null);
INSERT INTO `vote_item` VALUES ('14', '544', '659', '7', null);
INSERT INTO `vote_item` VALUES ('15', '545', '659', '7', null);
INSERT INTO `vote_item` VALUES ('16', '546', '659', '7', null);
INSERT INTO `vote_item` VALUES ('17', '547', '659', '7', null);
INSERT INTO `vote_item` VALUES ('18', '538', '658', '7', null);
INSERT INTO `vote_item` VALUES ('19', '537', '657', '9', null);
INSERT INTO `vote_item` VALUES ('20', '542', '658', '9', null);
INSERT INTO `vote_item` VALUES ('21', '544', '659', '9', null);
INSERT INTO `vote_item` VALUES ('22', '545', '659', '9', null);
INSERT INTO `vote_item` VALUES ('23', '546', '659', '9', null);
INSERT INTO `vote_item` VALUES ('24', '547', '659', '9', null);
INSERT INTO `vote_item` VALUES ('25', '553', '660', '9', null);
INSERT INTO `vote_item` VALUES ('26', '563', '661', '9', null);
INSERT INTO `vote_item` VALUES ('27', '565', '662', '9', null);
INSERT INTO `vote_item` VALUES ('28', '565', '662', '6', null);
INSERT INTO `vote_item` VALUES ('29', '540', '658', '6', null);
INSERT INTO `vote_item` VALUES ('30', '544', '659', '6', null);
INSERT INTO `vote_item` VALUES ('31', '545', '659', '6', null);
INSERT INTO `vote_item` VALUES ('32', '546', '659', '6', null);
INSERT INTO `vote_item` VALUES ('33', '553', '660', '6', null);
INSERT INTO `vote_item` VALUES ('34', '563', '661', '6', null);
INSERT INTO `vote_item` VALUES ('35', '572', '663', '6', null);
INSERT INTO `vote_item` VALUES ('36', '573', '663', '6', null);
INSERT INTO `vote_item` VALUES ('37', '574', '663', '6', null);
INSERT INTO `vote_item` VALUES ('38', '575', '663', '6', null);
INSERT INTO `vote_item` VALUES ('39', '576', '664', '6', null);
INSERT INTO `vote_item` VALUES ('40', '577', '664', '6', null);
INSERT INTO `vote_item` VALUES ('41', '578', '664', '6', null);
INSERT INTO `vote_item` VALUES ('42', '572', '663', '11', null);
INSERT INTO `vote_item` VALUES ('43', '573', '663', '11', null);
INSERT INTO `vote_item` VALUES ('44', '576', '664', '11', null);
INSERT INTO `vote_item` VALUES ('45', '539', '658', '20', null);
INSERT INTO `vote_item` VALUES ('46', '541', '658', '17', null);
INSERT INTO `vote_item` VALUES ('47', '569', '662', '17', null);
INSERT INTO `vote_item` VALUES ('48', '536', '657', '17', null);
INSERT INTO `vote_item` VALUES ('49', '546', '659', '17', null);
INSERT INTO `vote_item` VALUES ('50', '573', '663', '17', null);
INSERT INTO `vote_item` VALUES ('51', '575', '663', '17', null);
INSERT INTO `vote_item` VALUES ('52', '577', '664', '17', null);
INSERT INTO `vote_item` VALUES ('53', '578', '664', '17', null);
INSERT INTO `vote_item` VALUES ('54', '583', '666', '17', null);
INSERT INTO `vote_item` VALUES ('55', '544', '659', '14', null);
INSERT INTO `vote_item` VALUES ('56', '546', '659', '14', null);
INSERT INTO `vote_item` VALUES ('57', '547', '659', '14', null);
INSERT INTO `vote_item` VALUES ('58', '562', '661', '14', null);
INSERT INTO `vote_item` VALUES ('59', '620', '674', '14', null);
INSERT INTO `vote_item` VALUES ('60', '585', '666', '14', null);
INSERT INTO `vote_item` VALUES ('61', '546', '659', '12', null);
INSERT INTO `vote_item` VALUES ('62', '547', '659', '12', null);
INSERT INTO `vote_item` VALUES ('63', '561', '661', '12', null);
INSERT INTO `vote_item` VALUES ('64', '565', '662', '12', null);
INSERT INTO `vote_item` VALUES ('65', '570', '662', '11', null);
INSERT INTO `vote_item` VALUES ('66', '587', '667', '11', null);
INSERT INTO `vote_item` VALUES ('67', '536', '657', '11', null);
INSERT INTO `vote_item` VALUES ('68', '620', '674', '6', null);
INSERT INTO `vote_item` VALUES ('69', '540', '658', '16', null);
INSERT INTO `vote_item` VALUES ('70', '542', '658', '21', null);
INSERT INTO `vote_item` VALUES ('71', '623', '676', '6', null);
INSERT INTO `vote_item` VALUES ('72', '624', '676', '6', null);
INSERT INTO `vote_item` VALUES ('73', '622', '675', '6', null);
INSERT INTO `vote_item` VALUES ('74', '536', '657', '23', null);

-- ----------------------------
-- Table structure for `vote_option`
-- ----------------------------
DROP TABLE IF EXISTS `vote_option`;
CREATE TABLE `vote_option` (
  `vo_id` int(11) NOT NULL AUTO_INCREMENT,
  `vo_option` varchar(100) NOT NULL,
  `vs_id` int(11) NOT NULL,
  `vo_order` int(11) DEFAULT NULL,
  `vo_image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`vo_id`),
  KEY `f_vs_is` (`vs_id`),
  CONSTRAINT `f_vs_is` FOREIGN KEY (`vs_id`) REFERENCES `vote_subject` (`vs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=642 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vote_option
-- ----------------------------
INSERT INTO `vote_option` VALUES ('536', '吴亦凡', '657', null, 'vote/869fe19a-f0d4-48b4-a968-8809686c1eaf_1.jpg');
INSERT INTO `vote_option` VALUES ('537', '霍建华', '657', null, 'vote/5ec54bc1-ec08-4c17-bd27-02de4fa1d94c_28f2e8338115140_size75_w366_h550.jpg');
INSERT INTO `vote_option` VALUES ('538', '榴莲', '658', null, null);
INSERT INTO `vote_option` VALUES ('539', '猕猴桃', '658', null, null);
INSERT INTO `vote_option` VALUES ('540', '苹果', '658', null, null);
INSERT INTO `vote_option` VALUES ('541', '牛油果', '658', null, null);
INSERT INTO `vote_option` VALUES ('542', '草莓', '658', null, null);
INSERT INTO `vote_option` VALUES ('543', '草莓', '658', null, null);
INSERT INTO `vote_option` VALUES ('544', '米饭', '659', null, null);
INSERT INTO `vote_option` VALUES ('545', '面食', '659', null, null);
INSERT INTO `vote_option` VALUES ('546', '水果', '659', null, null);
INSERT INTO `vote_option` VALUES ('547', '肉类', '659', null, null);
INSERT INTO `vote_option` VALUES ('553', '网易云音乐', '660', null, null);
INSERT INTO `vote_option` VALUES ('554', 'QQ音乐', '660', null, null);
INSERT INTO `vote_option` VALUES ('555', '酷狗音乐', '660', null, null);
INSERT INTO `vote_option` VALUES ('556', '酷我音乐', '660', null, null);
INSERT INTO `vote_option` VALUES ('557', '千千静听', '660', null, null);
INSERT INTO `vote_option` VALUES ('561', '会', '661', null, null);
INSERT INTO `vote_option` VALUES ('562', '不会', '661', null, null);
INSERT INTO `vote_option` VALUES ('563', '有钱就会', '661', null, null);
INSERT INTO `vote_option` VALUES ('564', '无论如何都会', '661', null, null);
INSERT INTO `vote_option` VALUES ('565', '侏罗纪', '662', null, null);
INSERT INTO `vote_option` VALUES ('566', '原始社会', '662', null, null);
INSERT INTO `vote_option` VALUES ('567', '夏朝', '662', null, null);
INSERT INTO `vote_option` VALUES ('568', '战国时期', '662', null, null);
INSERT INTO `vote_option` VALUES ('569', '大唐盛世', '662', null, null);
INSERT INTO `vote_option` VALUES ('570', '清朝', '662', null, null);
INSERT INTO `vote_option` VALUES ('571', '民国时期', '662', null, null);
INSERT INTO `vote_option` VALUES ('572', '唱', '663', null, null);
INSERT INTO `vote_option` VALUES ('573', '跳', '663', null, null);
INSERT INTO `vote_option` VALUES ('574', 'RAP', '663', null, null);
INSERT INTO `vote_option` VALUES ('575', '篮球', '663', null, null);
INSERT INTO `vote_option` VALUES ('576', '大碗宽面', '664', null, null);
INSERT INTO `vote_option` VALUES ('577', '红烧电鳗', '664', null, null);
INSERT INTO `vote_option` VALUES ('578', '铁石心肠', '664', null, null);
INSERT INTO `vote_option` VALUES ('579', '暹罗猫', '665', null, 'vote/58063201-4b2f-4353-b572-050905b1977b_cat1.jpg');
INSERT INTO `vote_option` VALUES ('580', '布偶', '665', null, 'vote/7278efdf-72c8-484d-9e01-171e7102e544_cat3.jpg');
INSERT INTO `vote_option` VALUES ('581', '美短', '665', null, 'vote/fce7507d-a132-4c22-aedc-ebad1db55334_cat2.jpg');
INSERT INTO `vote_option` VALUES ('582', '狸花猫', '665', null, 'vote/937b0788-ebcf-4f36-b508-e4c932adb21a_cat4.jpg');
INSERT INTO `vote_option` VALUES ('583', '湘西赶尸', '666', null, null);
INSERT INTO `vote_option` VALUES ('584', '旅游景点', '666', null, null);
INSERT INTO `vote_option` VALUES ('585', '特色美食', '666', null, null);
INSERT INTO `vote_option` VALUES ('586', '哈士奇', '667', null, 'vote/5107f55e-5630-49ca-b1c9-b5c95d81291a_dog1.jpg');
INSERT INTO `vote_option` VALUES ('587', '金毛', '667', null, 'vote/f0bd5f52-9571-4685-bd77-7925d0ed28b7_dog4.jpg');
INSERT INTO `vote_option` VALUES ('588', '牧羊犬', '667', null, 'vote/98f20dc9-5741-4a9e-bcd5-27923ab88c35_dog2.jpg');
INSERT INTO `vote_option` VALUES ('589', '萨摩耶', '667', null, 'vote/cee83910-b540-4efb-9f51-f8553432ee7b_dog5.jpg');
INSERT INTO `vote_option` VALUES ('590', '柴犬', '667', null, 'vote/c452a685-b085-4d80-a762-bdd1bccaf82c_dog3jpg.jpg');
INSERT INTO `vote_option` VALUES ('617', '抢劫路人手机后跑到警察局', '673', null, null);
INSERT INTO `vote_option` VALUES ('618', '网恋5年的女友奔现后变成五旬老汉', '673', null, null);
INSERT INTO `vote_option` VALUES ('619', '华为', '674', null, null);
INSERT INTO `vote_option` VALUES ('620', '小米', '674', null, null);
INSERT INTO `vote_option` VALUES ('621', '单选1', '675', null, null);
INSERT INTO `vote_option` VALUES ('622', '单选2', '675', null, null);
INSERT INTO `vote_option` VALUES ('623', '多选1', '676', null, null);
INSERT INTO `vote_option` VALUES ('624', '多选2', '676', null, null);
INSERT INTO `vote_option` VALUES ('625', '111111111111', '677', null, null);
INSERT INTO `vote_option` VALUES ('626', '222222222222', '677', null, null);
INSERT INTO `vote_option` VALUES ('627', '0', '668', null, null);
INSERT INTO `vote_option` VALUES ('628', '1', '668', null, null);
INSERT INTO `vote_option` VALUES ('629', '2', '668', null, null);
INSERT INTO `vote_option` VALUES ('630', '3', '668', null, null);
INSERT INTO `vote_option` VALUES ('631', '4', '668', null, null);
INSERT INTO `vote_option` VALUES ('632', '5', '668', null, null);
INSERT INTO `vote_option` VALUES ('633', '6', '668', null, null);
INSERT INTO `vote_option` VALUES ('634', '7', '668', null, null);
INSERT INTO `vote_option` VALUES ('635', '8', '668', null, null);
INSERT INTO `vote_option` VALUES ('636', '9', '668', null, null);
INSERT INTO `vote_option` VALUES ('637', '马化腾', '678', null, null);
INSERT INTO `vote_option` VALUES ('638', '马云', '678', null, null);
INSERT INTO `vote_option` VALUES ('639', '李嘉诚', '678', null, null);
INSERT INTO `vote_option` VALUES ('640', '星月夜', '679', null, 'vote/b1c5fb6d-2f56-4d6a-9d0c-fd0c8d7a1f68_星月夜.jpg');
INSERT INTO `vote_option` VALUES ('641', '向日葵', '679', null, 'vote/1bfa09aa-d45e-440b-8f70-c16f6b03b8b1_向日葵.jpg');

-- ----------------------------
-- Table structure for `vote_subject`
-- ----------------------------
DROP TABLE IF EXISTS `vote_subject`;
CREATE TABLE `vote_subject` (
  `vs_id` int(11) NOT NULL AUTO_INCREMENT,
  `vu_user_id` int(11) DEFAULT NULL,
  `vs_title` varchar(200) NOT NULL,
  `vs_type` int(11) NOT NULL,
  `vs_end` bigint(30) NOT NULL,
  `vs_status` int(1) NOT NULL DEFAULT '0',
  `vs_cover_url` varchar(50) DEFAULT NULL,
  `vs_create_time` bigint(20) DEFAULT NULL,
  `vs_start_time` bigint(20) DEFAULT NULL,
  `vs_option_num` int(2) DEFAULT NULL,
  `vs_category` int(2) DEFAULT NULL,
  PRIMARY KEY (`vs_id`),
  KEY `f_vs_user_id` (`vu_user_id`),
  CONSTRAINT `f_vs_user_id` FOREIGN KEY (`vu_user_id`) REFERENCES `vote_user` (`vu_user_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=680 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vote_subject
-- ----------------------------
INSERT INTO `vote_subject` VALUES ('657', '5', '心动男生', '1', '1562947000', '0', null, null, '1562774000', '2', null);
INSERT INTO `vote_subject` VALUES ('658', '6', '选出你认为的水果之王', '1', '1562947000', '0', null, null, '1562674000', '7', null);
INSERT INTO `vote_subject` VALUES ('659', '7', '你喜欢吃什么', '2', '1562860800', '0', null, null, '1562774000', '4', null);
INSERT INTO `vote_subject` VALUES ('660', '6', '你最喜欢用什么听歌软件', '1', '1562774400', '0', null, null, '1562774000', '5', null);
INSERT INTO `vote_subject` VALUES ('661', '8', '你会花高于物品原本价值十倍钱去买一个自己喜欢的物品吗', '1', '1562947000', '0', null, null, '1562774000', '4', null);
INSERT INTO `vote_subject` VALUES ('662', '9', '如果可以穿越时空，你想回到哪个时代', '1', '1562774400', '0', null, null, '1562774000', '7', null);
INSERT INTO `vote_subject` VALUES ('663', '6', '练习生应该掌握哪些技能', '2', '1562774400', '0', null, null, '1562774000', '4', null);
INSERT INTO `vote_subject` VALUES ('664', '6', '吴亦凡的拿手绝活', '2', '1562774400', '0', null, null, '1562774000', '3', null);
INSERT INTO `vote_subject` VALUES ('665', '6', '选出你喜欢的猫', '2', '1562860800', '0', null, null, '1562861000', '4', null);
INSERT INTO `vote_subject` VALUES ('666', '6', '你觉得张家界什么比较出名', '1', '1562947000', '0', null, null, '1562861000', '3', null);
INSERT INTO `vote_subject` VALUES ('667', '6', '选择喜欢的犬', '1', '1562947000', '0', null, null, '1562861000', '5', null);
INSERT INTO `vote_subject` VALUES ('668', '6', 'Choose your luck number ', '1', '1564070000', '-1', null, null, '1564000000', '10', null);
INSERT INTO `vote_subject` VALUES ('673', '20', '2019年最沙雕的新闻', '1', '1563811200', '-1', null, '1562504508226', '1563811000', '5', null);
INSERT INTO `vote_subject` VALUES ('674', '20', '华为与小米哪个更牛逼', '1', '1562947000', '0', null, '1562504698098', '1563034000', '2', null);
INSERT INTO `vote_subject` VALUES ('675', '1', '这是一条测试投票（单选）', '1', '1563293000', '0', null, '1562677929445', '1563000000', null, null);
INSERT INTO `vote_subject` VALUES ('676', '1', '这是第二条测试投票（多选）', '2', '1563984000', '0', null, '1562677962049', '1564000000', null, null);
INSERT INTO `vote_subject` VALUES ('677', '1', '这是第三条测试投票', '1', '1562947000', '0', null, '1562678078411', '1564000000', null, null);
INSERT INTO `vote_subject` VALUES ('678', '22', '竞选优秀员工', '1', '1564156800', '0', null, '1562914137', '1562860800', '3', null);
INSERT INTO `vote_subject` VALUES ('679', '23', '选出你喜欢的画作', '1', '1563465600', '0', null, '1562919251', '1562860800', '2', null);

-- ----------------------------
-- Table structure for `vote_user`
-- ----------------------------
DROP TABLE IF EXISTS `vote_user`;
CREATE TABLE `vote_user` (
  `vu_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `vu_user_nick` varchar(20) DEFAULT NULL,
  `vu_user_name` varchar(20) NOT NULL,
  `vu_password` varchar(50) NOT NULL,
  `vu_phone` varchar(11) NOT NULL,
  `vu_status` int(1) NOT NULL DEFAULT '0',
  `vu_version` int(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT '用户级别 0 普通 / 1 高级 / 2 管理员',
  `vu_free_times` int(1) NOT NULL DEFAULT '3',
  `vu_create_time` bigint(20) DEFAULT NULL,
  `vu_active_time` bigint(20) DEFAULT NULL,
  `vu_sex` int(1) DEFAULT NULL,
  `vu_birthday` bigint(20) DEFAULT NULL,
  `vu_addr` varchar(20) DEFAULT NULL,
  `vu_hobby` varchar(50) DEFAULT NULL,
  `vu_emal` varchar(20) DEFAULT NULL,
  `vu_career` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`vu_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vote_user
-- ----------------------------
INSERT INTO `vote_user` VALUES ('1', '213123', 'hhh', '96e79218965eb72c92a549dd5a330112', '33', '0', '1', '3', '1561874082', '1562764082', '0', '1105718400', '2', '1,2,3', null, '3');
INSERT INTO `vote_user` VALUES ('3', null, '132033', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561874082', '1562764082', '1', '836750006', null, null, null, null);
INSERT INTO `vote_user` VALUES ('4', null, '123456', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561874082', '1562764082', '0', '331828406', null, null, null, null);
INSERT INTO `vote_user` VALUES ('5', null, '999999', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561874082', '1562764082', '1', '994516406', null, null, null, null);
INSERT INTO `vote_user` VALUES ('6', '牛逼的名字', 'admini', '96e79218965eb72c92a549dd5a330112', '33', '0', '2', '3', '1561874082', '1563002282', '0', '156225600', null, null, null, null);
INSERT INTO `vote_user` VALUES ('7', null, '123456789', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561874082', '1562764082', '1', '1000000000', null, null, null, null);
INSERT INTO `vote_user` VALUES ('8', null, 'user11', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561874082', '1562835596', '0', '946737206', null, null, null, null);
INSERT INTO `vote_user` VALUES ('9', null, 'user22', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561874082', '1562764082', '1', '647357606', null, null, null, null);
INSERT INTO `vote_user` VALUES ('10', null, 'user33', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561874082', '1562764082', '0', '157818806', null, null, null, null);
INSERT INTO `vote_user` VALUES ('11', null, 'user44', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561874082', '1562764082', '1', '331828406', null, null, null, null);
INSERT INTO `vote_user` VALUES ('12', null, 'user66', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561525289', '1562415289', '0', '647357606', null, null, null, null);
INSERT INTO `vote_user` VALUES ('13', null, 'user65', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561525999', '1562830921', '1', '568046006', null, null, null, null);
INSERT INTO `vote_user` VALUES ('14', null, 'user777', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561526599', '1562416599', '0', '694276406', null, null, null, null);
INSERT INTO `vote_user` VALUES ('15', null, 'user88', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561874082', '1562416888', '1', '647357606', null, null, null, null);
INSERT INTO `vote_user` VALUES ('16', null, 'user999', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561874082', '1562764361', '0', '157818806', null, null, null, null);
INSERT INTO `vote_user` VALUES ('17', null, 'user99', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '1', '1561874082', '1562417244', '1', '994516406', null, null, null, null);
INSERT INTO `vote_user` VALUES ('18', 'Liii', 'user52', '96e79218965eb72c92a549dd5a330112', '33', '0', '0', '3', '1561874082', '1562417558', '0', '1562774400', '4', '2,5,8', null, '6');
INSERT INTO `vote_user` VALUES ('19', null, 'user123', '96e79218965eb72c92a549dd5a330112', '63', '0', '0', '3', '1561874082', '1562469421', '1', '836750006', null, null, null, null);
INSERT INTO `vote_user` VALUES ('20', 'Loo', 'user952', '96e79218965eb72c92a549dd5a330112', '35', '0', '1', '4', '1561874082', '1562835580', '0', '1562947200', '4', '2,3', null, '6');
INSERT INTO `vote_user` VALUES ('21', '这条gai最靓的崽', 'Li5270', '96e79218965eb72c92a549dd5a330112', '75', '0', '2', '6', '1561938281', '1562916119', '1', '1086883200', '1', '1,7,8', null, '5');
INSERT INTO `vote_user` VALUES ('22', null, 'user321', '96e79218965eb72c92a549dd5a330112', '54', '0', '0', '2', '1562912077', '1562914602', null, null, null, null, null, null);
INSERT INTO `vote_user` VALUES ('23', 'Lii', 'user966', '96e79218965eb72c92a549dd5a330112', '635', '0', '1', '6', '1562918974', '1562918974', '1', '1213977600', '2', '1,2,3', null, '2');
