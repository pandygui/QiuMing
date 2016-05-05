/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50629
Source Host           : localhost:3306
Source Database       : qiuming_test

Target Server Type    : MYSQL
Target Server Version : 50629
File Encoding         : 65001

Date: 2016-05-05 16:23:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `car_aboard`
-- ----------------------------
DROP TABLE IF EXISTS `car_aboard`;
CREATE TABLE `car_aboard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '用户 id',
  `carId` int(11) NOT NULL COMMENT '发车编号',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '上车状态,0 还未上车，1乘车，2下车',
  PRIMARY KEY (`id`),
  KEY `aboard_user_id` (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of car_aboard
-- ----------------------------
INSERT INTO `car_aboard` VALUES ('1', '5', '1', '0000-00-00 00:00:00', '2');

-- ----------------------------
-- Table structure for `car_depart`
-- ----------------------------
DROP TABLE IF EXISTS `car_depart`;
CREATE TABLE `car_depart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `postId` int(11) NOT NULL COMMENT '发车对应的帖子 id',
  `plateNumber` int(11) NOT NULL COMMENT '车牌号码',
  `carState` int(11) DEFAULT '1' COMMENT '发车状态。0 未发车，1 发车，2 发车完毕',
  PRIMARY KEY (`id`),
  KEY `car_post_id` (`postId`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of car_depart
-- ----------------------------
INSERT INTO `car_depart` VALUES ('1', '4', '0', '1');

-- ----------------------------
-- Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `postId` int(11) NOT NULL COMMENT '帖子 id',
  `content` varchar(200) NOT NULL DEFAULT '# 评论使用markdown' COMMENT '评论使用markdown @ 来处理用户提示的',
  `userId` int(11) NOT NULL COMMENT '用户 id',
  `replyCommentId` int(11) DEFAULT '-1' COMMENT '如果为空，则默认是对帖子的回复',
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`id`),
  KEY `posts_id_comments_id` (`postId`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', '1', '自己评论自己的第一篇帖子', '1', '0', null);
INSERT INTO `comment` VALUES ('9', '4', '回复某个评论', '2', '2', '2016-05-03 21:21:31');
INSERT INTO `comment` VALUES ('8', '4', '第一评论', '2', '0', '2016-05-03 21:21:31');
INSERT INTO `comment` VALUES ('10', '4', '第一评论', '2', '0', '2016-05-05 14:29:24');
INSERT INTO `comment` VALUES ('12', '4', '第一评论', '2', '0', '2016-05-05 14:29:40');
INSERT INTO `comment` VALUES ('13', '4', '回复某个评论', '2', '2', '2016-05-05 14:29:40');

-- ----------------------------
-- Table structure for `complain`
-- ----------------------------
DROP TABLE IF EXISTS `complain`;
CREATE TABLE `complain` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '举报编号',
  `postId` int(11) NOT NULL COMMENT '被举报帖子id',
  `complainTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '举报时间',
  `userId` int(11) NOT NULL COMMENT '举报用户',
  `reason` varchar(200) NOT NULL COMMENT '举报理由',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '0:受理 1:成功',
  PRIMARY KEY (`id`),
  KEY `complain_user_id` (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of complain
-- ----------------------------
INSERT INTO `complain` VALUES ('1', '5', '2016-04-23 20:00:12', '5', '非发车帖子有番号', '0');
INSERT INTO `complain` VALUES ('2', '4', '2016-05-03 21:06:32', '2', '用于测试的举报', '0');

-- ----------------------------
-- Table structure for `favorite`
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '用户 id',
  `postId` int(11) NOT NULL COMMENT '帖子 id',
  `favoriteName` varchar(20) NOT NULL DEFAULT '默认收藏夹' COMMENT '收藏夹名字',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `collection_user_id` (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of favorite
-- ----------------------------
INSERT INTO `favorite` VALUES ('1', '1', '1', '默认收藏夹', '2016-04-23 18:01:58');

-- ----------------------------
-- Table structure for `friend`
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户关系表 id',
  `userId` int(11) NOT NULL COMMENT '用户id',
  `focusUserId` int(11) NOT NULL COMMENT '用户关注的用户 id',
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '关注时间',
  PRIMARY KEY (`id`),
  KEY `friend_ship_user_id` (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friend
-- ----------------------------
INSERT INTO `friend` VALUES ('1', '5', '1', '2016-04-24 12:49:51');

-- ----------------------------
-- Table structure for `letter`
-- ----------------------------
DROP TABLE IF EXISTS `letter`;
CREATE TABLE `letter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiveUserId` int(11) NOT NULL COMMENT '本条私信的接受用户',
  `senderUserId` int(11) NOT NULL COMMENT '发送私信的用户',
  `content` varchar(200) NOT NULL COMMENT '私信内容',
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '私信时间',
  `read` int(11) NOT NULL DEFAULT '0' COMMENT '0 未读， 1 已读',
  PRIMARY KEY (`id`),
  KEY `letter_sender_user_id` (`senderUserId`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of letter
-- ----------------------------
INSERT INTO `letter` VALUES ('1', '1', '1', '系统私信：{user_id} 在 {post_id} 评论了', '2016-04-23 20:19:03', '0');
INSERT INTO `letter` VALUES ('2', '1', '1', '系统私信：{user_id} 关注了你', '2016-04-24 12:50:33', '0');
INSERT INTO `letter` VALUES ('3', '5', '1', '谢谢关注我', '2016-04-24 12:51:18', '0');
INSERT INTO `letter` VALUES ('4', '1', '2', '这封私信课室包含着我对你满满的爱意。', '2016-05-03 19:25:27', '0');
INSERT INTO `letter` VALUES ('6', '1', '2', '这封私信课室包含着我对你满满的爱意。', '2016-05-03 19:53:12', '0');

-- ----------------------------
-- Table structure for `post`
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '用户 id',
  `title` varchar(100) NOT NULL COMMENT '帖子标题',
  `content` varchar(5000) NOT NULL DEFAULT '# 帖子不能为空' COMMENT '保存 markdown 格式的帖子',
  `praiseNumber` int(11) DEFAULT '0' COMMENT '获赞数',
  `favoriteNumber` int(11) DEFAULT '0' COMMENT '被收藏数',
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发帖时间',
  `modifyTime` timestamp NULL DEFAULT NULL COMMENT '最近修改时间',
  `state` int(11) DEFAULT '1' COMMENT '帖子审核状态，0 ： 不通过，1 ： 通过',
  `postRoleId` int(11) NOT NULL DEFAULT '1' COMMENT '帖子元类型',
  PRIMARY KEY (`id`),
  KEY `articles_user_id` (`userId`),
  KEY `post_role_id` (`postRoleId`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES ('1', '1', '本站第一个帖子', '# 本站第一个帖子\n番号: ibw-518z, ibw-218。', '1', '1', '2016-04-23 17:52:57', null, '1', '1');
INSERT INTO `post` VALUES ('3', '1', '本站第三个帖子', '# 本站第三个帖子\n番号 ibw-518z。', '0', '0', '2016-04-23 19:56:16', null, '1', '1');
INSERT INTO `post` VALUES ('4', '1', '本站第一个发车', '# 秋名山老司机第一发\n番号 ibw-518z。', '0', '0', '2016-04-24 13:12:27', null, '1', '1');
INSERT INTO `post` VALUES ('5', '1', '本站第一个帖子', '# 本站第一个帖子\n番号 ibw-518z。', '0', '0', '2016-05-03 16:39:02', null, '1', '1');
INSERT INTO `post` VALUES ('6', '1', '跟别人家的标题冲突了', '# 本站第一个帖子\n番号 ibw-518z。', '0', '0', '2016-05-03 16:41:48', '2016-05-05 14:26:45', '1', '1');
INSERT INTO `post` VALUES ('7', '1', '本站第一个帖子', '# 本站第一个帖子\n番号 ibw-518z。\n randon:0.5092309859862587', '0', '0', '2016-05-05 14:26:20', '2016-05-05 14:26:20', '1', '1');
INSERT INTO `post` VALUES ('8', '5', 'title', 'WebSocket', '0', '0', '2016-05-05 14:36:19', '2016-05-05 14:36:19', '1', '1');
INSERT INTO `post` VALUES ('9', '5', 'title', '# 帖子\n\n\n----\n\n[AsmJit : C++ 封裝的 Just-In-Time Assembler](http://blog.linux.org.tw/~jserv/archives/002089.html)\n\n[开源项目asmjit——调用自定义方法demo以及windbg调试](http://www.cnblogs.com/hbccdf/p/asmjit_demo_with_windbg.html)\n\n[谈谈AsmJit](http://www.cnblogs.com/lanrenxinxin/p/5021641.html?utm_source=tuicool&utm_medium=referral)\n\n[[公告] 欢迎来到高级语言虚拟机圈子](http://hllvm.group.iteye.com/group/topic/17147)', '0', '0', '2016-05-05 14:37:01', '2016-05-05 14:37:01', '1', '1');

-- ----------------------------
-- Table structure for `post_role`
-- ----------------------------
DROP TABLE IF EXISTS `post_role`;
CREATE TABLE `post_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(30) DEFAULT NULL COMMENT '帖子元类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_role_name` (`roleName`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post_role
-- ----------------------------
INSERT INTO `post_role` VALUES ('1', '帖子');
INSERT INTO `post_role` VALUES ('2', '发车');

-- ----------------------------
-- Table structure for `praise`
-- ----------------------------
DROP TABLE IF EXISTS `praise`;
CREATE TABLE `praise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '用户 id',
  `postId` int(11) NOT NULL COMMENT '帖子 id',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`),
  KEY `praise_user_id` (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of praise
-- ----------------------------
INSERT INTO `praise` VALUES ('1', '1', '1', '2016-04-23 18:13:38');

-- ----------------------------
-- Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '创建标签的用户',
  `tagName` varchar(10) NOT NULL COMMENT '标签名字',
  `postId` int(11) NOT NULL COMMENT '被贴标签的帖子',
  `praiseNumber` int(11) NOT NULL DEFAULT '0' COMMENT '赞同次数',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '贴标签时间',
  PRIMARY KEY (`id`),
  KEY `tag_post_id` (`postId`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('1', '1', '第一发', '1', '0', '2016-04-23 18:06:10');
INSERT INTO `tag` VALUES ('2', '2', '第一帖', '4', '0', '2016-05-05 14:24:37');

-- ----------------------------
-- Table structure for `tag_praise`
-- ----------------------------
DROP TABLE IF EXISTS `tag_praise`;
CREATE TABLE `tag_praise` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录的id，插入前判断 tag_id 是否存在，然后在判断相同 tag_id 的情况下 parise_user_id 是否唯一，如果增加一条记录，就会去找到 tag_id 然后让其 support_number 加一',
  `tagId` int(11) NOT NULL COMMENT '哪个标签',
  `praiseUserId` int(11) NOT NULL COMMENT '点赞的用户',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞的时间',
  PRIMARY KEY (`id`),
  KEY `praise_tag_id` (`tagId`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag_praise
-- ----------------------------
INSERT INTO `tag_praise` VALUES ('2', '1', '4', '2016-05-03 21:55:20');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(18) NOT NULL,
  `pickname` varchar(20) DEFAULT NULL COMMENT '昵称',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `telephone` varchar(20) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `address` varchar(200) DEFAULT '秋名山',
  `experience` int(11) DEFAULT '0' COMMENT '用户经验值',
  `sex` varchar(6) DEFAULT '秀吉' COMMENT '用户性别',
  `roleId` int(11) DEFAULT NULL COMMENT '用户角色码',
  `introduction` varchar(200) DEFAULT '这个人太懒了，一句话也没有写' COMMENT '个人简介',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `user_role_id` (`roleId`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'admin', '女仆酱', 'qyvlik@qq.com', null, '16', '秋名山', '1', '女', '3', '这个人太懒了，一句话也没有写');
INSERT INTO `user` VALUES ('5', 'qyvlik', '1403085871', null, null, null, null, '秋名山', '64', '秀吉', null, '这个人太懒了，一句话也没有写');
INSERT INTO `user` VALUES ('2', 'test', 'password', 'pickname', 'email@qq.com', '123456', '1', '秋名山', '0', '秀吉', null, '这个是个人简介');
INSERT INTO `user` VALUES ('10', '老王', '123456789', '又是一个云老王', 'laowang@qiuming.moe', '0800092000', '20', '秋名山下水道~', '0', '男', '1', '谁家娇妻守空房，我住隔壁我姓王');

-- ----------------------------
-- Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色码',
  `roleName` varchar(20) NOT NULL DEFAULT '普通用户' COMMENT '用户角色名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '普通用户');
INSERT INTO `user_role` VALUES ('2', '管理员');
INSERT INTO `user_role` VALUES ('3', '超级管理员');
