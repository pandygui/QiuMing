/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50629
Source Host           : localhost:3306
Source Database       : qiuming_test

Target Server Type    : MYSQL
Target Server Version : 50629
File Encoding         : 65001

Date: 2016-05-05 23:37:20
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
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES ('1', '1', '本站第一个帖子', '# 本站第一个帖子\n番号: ibw-518z, ibw-218。', '2', '1', '2016-04-23 17:52:57', '2016-05-05 14:26:45', '1', '1');
INSERT INTO `post` VALUES ('3', '1', '本站第三个帖子', '# 本站第三个帖子\n番号 ibw-518z。', '1', '0', '2016-04-23 19:56:16', '2016-05-05 14:26:45', '1', '1');
INSERT INTO `post` VALUES ('4', '1', '本站第一个发车', '# 秋名山老司机第一发\n番号 ibw-518z。', '0', '0', '2016-04-24 13:12:27', '2016-05-05 14:26:45', '1', '1');
INSERT INTO `post` VALUES ('5', '1', '本站第一个帖子', '# 本站第一个帖子\n番号 ibw-518z。', '0', '0', '2016-05-03 16:39:02', '2016-05-05 14:26:45', '1', '1');
INSERT INTO `post` VALUES ('6', '1', '跟别人家的标题冲突了', '# 本站第一个帖子\n番号 ibw-518z。', '0', '0', '2016-05-03 16:41:48', '2016-05-05 14:26:45', '1', '1');
INSERT INTO `post` VALUES ('7', '1', '本站第一个帖子', '# 本站第一个帖子\n番号 ibw-518z。\n randon:0.5092309859862587', '0', '0', '2016-05-05 14:26:20', '2016-05-05 14:26:20', '1', '1');
INSERT INTO `post` VALUES ('8', '5', 'title', 'WebSocket', '0', '0', '2016-05-05 14:36:19', '2016-05-05 14:36:19', '1', '1');
INSERT INTO `post` VALUES ('9', '5', 'title', '# 帖子\n\n\n----\n\n[AsmJit : C++ 封裝的 Just-In-Time Assembler](http://blog.linux.org.tw/~jserv/archives/002089.html)\n\n[开源项目asmjit——调用自定义方法demo以及windbg调试](http://www.cnblogs.com/hbccdf/p/asmjit_demo_with_windbg.html)\n\n[谈谈AsmJit](http://www.cnblogs.com/lanrenxinxin/p/5021641.html?utm_source=tuicool&utm_medium=referral)\n\n[[公告] 欢迎来到高级语言虚拟机圈子](http://hllvm.group.iteye.com/group/topic/17147)', '1', '0', '2016-05-05 14:37:01', '2016-05-05 14:37:01', '1', '1');
INSERT INTO `post` VALUES ('10', '5', '# MySQL 使用笔记', '# MySQL 使用笔记\n\n> 垃圾 MySQL，毁我青春。\n\n在 Window7 下我重新安装了 MySQL 5.7，尝试连接数据库时报如下错误：\n\n> Error 2003(HY000) Can\'t connect to MySQL server (10060) \n\n发现是本地 MySQL 服务无法启动。\n\n使用了 [MySQL 5.6](http://cdn.mysql.com/archives/mysql-5.6/mysql-5.6.29-winx64.zip)，这个是解压版。\n\n解压后，找到 **mysqld.exe** 然后在终端运行如下命令注册 MySQL 服务：\n\n```\nmysqld.exe -install\nnet start mysql\n```\n\n注册服务后，启动，一般会成功的，如果不成功，就再换个低版本的试试。\n\n然后这个解压版是没有设置密码的，用户名为 root，所以如果使用如下命令在终端进入 MySQL：\n\n```\nmysql -u root -p\n```\n\n但是输入 `root` 这个密码的话，是会报错：\n\n> ERROR 1045 (28000): Access denied for user \'root\'@\'localhost\' (using password: NO)\n\n所以控制台下直接输入 `mysql` 就可以进入。\n\n重设密码的时候出现：\n\n> ERROR 1044 (42000): Access denied for user \'\'@\'localhost\' to database \'mysql\'\n\n妈个鸡，用个解压版的 mysql 这么多麻烦。\n\n问题解决，参考这篇文章 [ERROR 1044 (42000): Access denied for user \'\'@\'localhost\' to database \'mysql\'](http://blog.sina.com.cn/s/blog_7d31bbee01012pkz.html)。\n\n先新建一个 `my.ini` 在 MySQL 的根目录下。\n\n```\n[mysqld]\n\nskip-external-locking\nskip-name-resolve\nskip-grant-tables\n\nsql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES \n```\n\n写入上诉内容。\n\n然后在控制台键入 `mysql` 默认用户进入 `mysql`，然后在 `mysql` 中输入 `UPDATE user SET Password=PASSWORD(\'root\') where USER=\'root\';` 即可修改密码为 root。\n\n至此，我终于可以说，垃圾 MySQL，毁我青春。', '0', '0', '2016-05-05 18:05:18', '2016-05-05 18:05:19', '1', '1');
INSERT INTO `post` VALUES ('11', '5', '软件工程学习笔记', '# 软件工程学习笔记\n\n## UML\n\n软件工程中，学会使用 UML 进行需求分析很重要。\n\nUML 统一建模语言，是由基本构造块，规则以及公共机制组成。UML 的基构造块既用于 UML 建模的词汇有三个：事务（things），关系（relationships）和图（diagrams）。\n\n1. 事务\n\n    1. 结构事务（structural thing），名词\n\n        1. 类（class）\n\n        2. 接口（interface）\n\n        3. 协作（collaboration）\n\n        4. 用例（use case）\n\n        5. 构件（component）\n\n        6. 结点（node）\n\n    2. 行为事务（behavioral thing），动词\n\n        1. 交互（interactive）\n\n        2. 状态机（state machine）\n\n    3. 分组事务（grouping thing），组织\n\n        1. 包（package）\n\n    4. 注释事务（annotational thing），解释\n\n        1. 注解（note）\n\n2. 关系\n\n    1. 关联\n\n    2. 依赖\n\n    3. 泛化\n\n    4. 实现\n\n3. 图\n\n    1. 结构视图\n\n        1. 类图\n\n        2. 对象图\n\n        3. 包图\n\n        4. 构件图\n\n        5. 实施图\n\n    2. 行为视图（用于定义需求）\n\n        1. 用例图\n\n        2. 顺序图\n\n        3. 协作图\n\n        4. 状态图\n\n        5. 活动图\n\n### 需求分析之用例图\n\n用例图是面向用户的，具体是挖掘用户需求，或者期望这个系统能够提供什么功能。用例想是一个黑盒，他没有包括任何实现有关的信息。通过不断打开黑盒，分析黑盒，再打开新的黑盒，知道整个系统可以被清晰的了解为止。\n\n\n\n', '1', '0', '2016-05-05 20:10:20', '2016-05-05 20:10:20', '1', '1');
INSERT INTO `post` VALUES ('12', '5', '安装 V-Play 笔记', '# 安装 V-Play 笔记\n\n> author: qyvlik\n\n> V-Play 2.7.1\n\n> Qt 5.5.1\n\n> QtCreator 3.5.1\n\nV-Play 是三年前开始开发的一个商业用 2D 游戏引擎。发展到现在，在游戏开发和应用开发有所建树，尤其是应用开发中，是现阶段 QML 开发应用唯一一个最优的方案，当然反驳的人是拿不出第二款如此成熟的 QML 应用开发框架。（如果有的话，请务必安利给我。）\n\n## 遇到问题\n\n直接使用安装包安装可能会出现如下问题：\n\n![](images/001.jpg)\n\n放弃这种安装方式。\n\n另一方面，v-play 的官方客服立刻在邮件上问我，是否在安装过程遇到了问题。安装后会定时发送一些 V-Play 的精品教材，虽然是英语的，但是没有使用过多高深的词汇。\n\n---\n\n如果以及安装了 Qt (Qt 5)，可以直接使用 `MaintenanceTool` 进行组件更新。\n\n[add-v-play-to-existing-qt-installation](http://v-play.net/doc/vplay-installation/#add-v-play-to-existing-qt-installation)\n\nClick the Settings button and in the Settings window, click on the Repositories tab. Click on the bottom section User defined repositories and then click the  Add Repository button.\n\nNow enter the URL for your development platform in the text box. It is either:\n\n- https://sdk.v-play.net/2/windows\n\n- https://sdk.v-play.net/2/macx\n\n- https://sdk.v-play.net/2/linux\n\nNext, confirm the V-Play installation repository with OK and proceed with the Package Manager option by pressing the Next button.\n\nYou can then proceed with the steps of Download & Install V-Play like described above.\n\n现在卡在 61 %:\n\n![](images/002.jpg)\n\n---\n\n重新安装 Qt 5.5.1，然后在使用 `MaintenanceTool` 安装 V-Play 成功。\n\n每次启动时，都会提示如下图：\n\n![](images/005.png)\n\n一般直接升级 `QtCreator` 为 3.6。覆盖安装。\n\n[V-Play 官网](http://v-play.net/)，下载前记得注册账号哦。\n', '0', '0', '2016-05-05 20:12:10', '2016-05-05 20:12:11', '1', '1');
INSERT INTO `post` VALUES ('18', '1', '管理员发校车啦', '# 管理员发校车啦\n\n怎么办，被另一个用户刷帖了。', '0', '0', '2016-05-05 21:44:43', '2016-05-05 21:44:43', '1', '1');
INSERT INTO `post` VALUES ('13', '5', 'V-Play 使用粗体验', '# V-Play 使用粗体验\n\n## 在 window 7 上\n\n其实 Window 7 是作为生产和开发的环境。\n\n所以一般可以用来调试其他手机的界面适配的问题。\n\n如果没有申请 `liencen key`，启动后会显示如下的 `SplashScreen`\n\n![](images/003.jpg)\n\n 启动后如下：\n\n![](images/004.jpg)\n\n可以更换主题和尺寸。 \n\n## 安卓\n\n在安卓上，使用页面导航 + 页面栈的方法管理页面。\n\n非常好的处理了回退按钮与页面导航。\n\n但是在处理类似聊天界面时，仍然有些许问题。\n\n详细 bug 描述参见 [Android device can\'t friendly fix the application scene when virtual keyboard was display.](https://bugreports.qt.io/browse/QTBUG-49656) 以及 [[Android]: When the window resizes then there it will cause flicker](https://bugreports.qt.io/browse/QTBUG-41170)。\n\n## 手机风格主题切换\n\n不是安卓手机只能使用安卓的风格主题，是可以切换到 ios 的主题的。各个系统的主题风格各有差异，可以自行进行配置。\n', '1', '0', '2016-05-05 20:26:08', '2016-05-05 20:26:09', '1', '1');
INSERT INTO `post` VALUES ('14', '5', '反射实现 ', '# 反射实现 \n\n1. 实现 `Variant`。\n\n2. 实现字符串到对象方法的绑定。\n\n3. 实现字符串到对象属性的绑定。', '0', '0', '2016-05-05 20:29:03', '2016-05-05 20:29:03', '1', '1');
INSERT INTO `post` VALUES ('15', '5', 'QML 数据库小探', '# QML 数据库小探\n\n首先 QML 中的数据库文件是存放在某个路径中的，具体就是通过 `QmlEngine::offlineStoragePath` 属性得知。接着，在这个路径下，可能有多个数据库文件。\n\n在 QML 中 `QtQuick.LocalStorage` 中的 `openDatabaseSync` 方法如下：\n\n`object openDatabaseSync(string name, string version, string description, int estimated_size, jsobject callback(db))`\n\n其中 `name`，`version`，`description`，`estimated_size` 这四个参数，根据这四个参数在 `QmlEngine::offlineStoragePath`  路径下所有的 `ini` 文件进行匹配（ini文件是对应数据库文件的配置文件，一般与对应数据库同名，保存了数据库的名字，版本号，描述和大小，数据库驱动类型，一般是 `QSQLITE`）。如果数据库文件不存在，就根据这四个文件进行数据库文件的构建。\n\n好，现在有两个问题，一个是如何在 ·`C++` 中处理 `QML` 生成的数据库（都是 `sqlite` 数据库），其次如何在 `QML` 中打开指定的数据库文件。\n\n首先说说如何在 `QML` 中打开指定的数据库文件。\n\n在看看 `openDatabaseSync` 这个函数：\n\n`object openDatabaseSync(string name, string version, string description, int estimated_size, jsobject callback(db))`\n\n它是根据`QmlEngine::offlineStoragePath` 路径下的 `ini` 文件，进行数据库的打开或者创建操作。\n\n所以，如果你现在有一个现成的数据库文件，可以尝试依葫芦画瓢，写一个对应的 `ini` 文件，再将数据库文件和 `ini` 文件放到应用的 `QmlEngine::offlineStoragePath` 路径下。\n\n> 注意，`ini` 文件名要和数据库文件名相同，例如： `123.sqlite` 和 `123.ini`。\n\n第二个是如何在 C++ 中打开在 QML 中的创建的数据库？或者说，C++ 如何通过数据库与 QML 进行数据交互。\n\n## c++ 操作 qml 数据库\n\nC++ 打开 SQLITE 的数据库不难，难得是怎么打开 QML 生成的数据库文件。\n\n如果是一个 QtQuick 应用，而不是 QtQuick UI 项目，那么其 `QmlEngine::offlineStoragePath` 就会对应到每个应用的临时路径。\n\n其次 `openDatabaseSync` 函数中的 `name` 参数与 `void QSqlDatabase::setDatabaseName(const QString & name)` 是否是有相同的意思呢？\n\n> `object openDatabaseSync(string name, string version, string description, int estimated_size, jsobject callback(db))` \n\n这里有一个折中的解决办法。\n\n首先使用 `QmlEngine::offlineStoragePath` 获取这个路径下的数据库文件，一般是 `*.sqlite`。\n\n然后将路径下的 `*.sqlite` 直接通过 `QSqlDatabase::setDatabaseName` 设置给 `QSqlDatabase` 实例。应该就能打开了（推测，或许还需要读取 ini 文件）。\n\n例如在 `QML` 文件中打开（创建）一个数据库。\n\n```\nvar db = LocalStorage.openDatabaseSync(\"CPP_AND_QML\", \"1.0\", \"for cpp and qml\", 1000000);\n// do something for db\n```\n\n在 `cpp` 文件的操作\n\n```\nQString path = engine->offlineStoragePath();       // 获取数据库路径\nQSqlDatabase db = QSqlDatabase::addDatabase(\"QSQLITE\");       // 设置打开的数据库类型\nQString sqliteFile = findSqliteFile(path);                                    // 用于查找对应路径下的数据库文件\n\ndb.setDatabaseName(path + \"/\" + sqliteFile );\n\ndb.open();\n// other operation for db\n```\n\n**当然上述代码未经过测试。**\n', '1', '0', '2016-05-05 20:32:23', '2016-05-05 20:32:23', '1', '1');
INSERT INTO `post` VALUES ('16', '5', '碰撞', '# 碰撞\n\n2D 游戏中，或者弹幕游戏中，最为重要的是碰撞。\n\n知识准备，动量守恒，二维矢量运算，四叉树，多边形的对角线和边的条数\n\n## 碰撞检测列表的获取\n\n首先说一说什么是碰撞检测列表吧。\n\n就一般而言，游戏场景中有许多物体，这些物体一般都由一个列表进行管理。通过这里列表可以获取物体的坐标和大小，也可以通过这里列表检索某个物体，修改物体的属性。\n\n一般地，获取的碰撞列表最直接的方式就是获取所有物体对象列表。但是如果两个物品一个在东一个在西，很明显不用进行碰撞检测。但是直接获取所有物体列表就会十分的低效。\n\n## 碰撞检测的方式\n\n## 碰撞检测函数\n\n## 碰撞反应函数\n\n## 碰撞修复函数\n\n# end\n\n> [弹幕游戏的碰撞检测一般是怎么实现的？](http://www.zhihu.com/question/28123324)\n', '0', '0', '2016-05-05 20:40:45', '2016-05-05 20:40:45', '1', '1');
INSERT INTO `post` VALUES ('17', '5', 'QML Text 同时显示不同大小的字', '# QML Text 同时显示不同大小的字\n\n直接上代码。\n\n```\nText {\n    text: \'<font size=\"-1\">-7</font>\n            <font size=\"5\">10</font>\'\n    textFormat: Text.RichText\n    font.pixelSize: 30\n    font.family: \"微软雅黑\"\n}\n```\n\n直接查看 `HTML font` 便签的文档。\n\n主要有 `color`，`face`，`size` 三个属性。\n\n~~主要先看 `size` 属性，由于在 QML 中 直接设置两个 `font` 元素的size 同时为正，不能直接显示不同的大小。（bug？）~~\n\n~~例如下列的 `html` 字符串在 `Text` 中就无法直接显示出不同的大小~~\n\n```html\n<font size=\"5\">5</font>\n<font size=\"10\">10</font>\n```\n\n要使上诉代码在 `Text` 正确生效，必须设置 `textFormat: Text.RichText`。其他属性可以忽略。如果想要他们的绘制大小有所变化，可以直接设置 `Text.font.pointSize`，这个属性相当于一个比例系数。\n\n显示效果如下\n\n<font size=\"5\">5</font>\n<font size=\"10\">10</font>\n', '0', '0', '2016-05-05 20:53:47', '2016-05-05 20:53:47', '1', '1');

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
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of praise
-- ----------------------------
INSERT INTO `praise` VALUES ('1', '1', '1', '2016-04-23 18:13:38');
INSERT INTO `praise` VALUES ('71', '5', '1', '2016-05-05 22:48:37');
INSERT INTO `praise` VALUES ('65', '5', '15', '2016-05-05 22:33:46');
INSERT INTO `praise` VALUES ('62', '5', '13', '2016-05-05 22:14:38');
INSERT INTO `praise` VALUES ('60', '5', '3', '2016-05-05 20:12:39');
INSERT INTO `praise` VALUES ('64', '5', '9', '2016-05-05 22:20:38');
INSERT INTO `praise` VALUES ('63', '5', '11', '2016-05-05 22:14:44');

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
INSERT INTO `user` VALUES ('1', 'admin', 'admin', '女仆酱', 'qyvlik@qq.com', null, '16', '秋名山', '3', '女', '3', '这个人太懒了，一句话也没有写');
INSERT INTO `user` VALUES ('5', 'qyvlik', '1403085871', null, null, null, null, '秋名山', '164', '秀吉', null, '这个人太懒了，一句话也没有写');
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
