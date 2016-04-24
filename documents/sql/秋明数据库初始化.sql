CREATE TABLE `user` (
`id` integer NOT NULL AUTO_INCREMENT,
`username` varchar(20) CHARACTER SET utf8 NOT NULL,
`password` varchar(18) CHARACTER SET utf8 NOT NULL,
`pickname` varchar(20) CHARACTER SET utf8 NULL COMMENT '昵称',
`email` varchar(50) CHARACTER SET utf8 NULL DEFAULT '' COMMENT '邮箱',
`telephone` varchar(20) CHARACTER SET utf8 NULL DEFAULT '0',
`age` int NULL DEFAULT 0,
`address` varchar(200) CHARACTER SET utf8 NULL DEFAULT '秋名山',
`experience` integer NULL DEFAULT 0 COMMENT '用户经验值',
`sex` varchar(6) CHARACTER SET utf8 NULL DEFAULT '秀吉' COMMENT '用户性别',
`role_id` integer NULL DEFAULT 0 COMMENT '用户角色码',
`introduction` varchar(200) CHARACTER SET utf8 NULL DEFAULT '这个人太懒了，一句话也没有写' COMMENT '个人简介',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `user_role` (
`id` integer NOT NULL AUTO_INCREMENT COMMENT '角色码',
`role_name` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '普通用户' COMMENT '用户角色名称',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `post` (
`id` integer NOT NULL AUTO_INCREMENT,
`user_id` integer NOT NULL COMMENT '用户 id',
`title` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '帖子标题',
`content` varchar(5000) CHARACTER SET utf8 NOT NULL DEFAULT '# 帖子不能为空' COMMENT '保存 markdown 格式的帖子',
`praise_number` integer NULL DEFAULT 0 COMMENT '获赞数',
`favorite_number` integer NULL DEFAULT 0 COMMENT '被收藏数',
`time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发帖时间',
`modify_time` datetime NULL COMMENT '最近修改时间',
`state` int NULL COMMENT '帖子审核状态，0 ： 不通过，1 ： 通过',
`post_role_id` integer NOT NULL DEFAULT 1 COMMENT '帖子元类型, 1 帖子 2 发车',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `comment` (
`id` integer NOT NULL AUTO_INCREMENT,
`post_id` integer NOT NULL COMMENT '帖子 id',
`content` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '# 评论使用markdown' COMMENT '评论使用markdown @ 来处理用户提示的',
`user_id` integer NOT NULL COMMENT '用户 id',
`reciver_user_id` integer NULL COMMENT '如果为空，则默认是对帖子的回复',
`time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `friend` (
`id` integer NOT NULL AUTO_INCREMENT COMMENT '用户关系表 id',
`user_id` integer NOT NULL COMMENT '用户id',
`focus_user_id` integer NOT NULL COMMENT '用户关注的用户 id',
`time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '关注时间',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `favorite` (
`id` integer NOT NULL AUTO_INCREMENT,
`user_id` integer NOT NULL COMMENT '用户 id',
`post_id` integer NOT NULL COMMENT '帖子 id',
`favorite_name` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '默认收藏夹' COMMENT '收藏夹名字',
`time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `letter` (
`id` integer NOT NULL AUTO_INCREMENT,
`receive_user_id` integer NOT NULL COMMENT '本条私信的接受用户',
`sender_user_id` integer NOT NULL COMMENT '发送私信的用户',
`content` varchar(200) CHARACTER SET utf8 NOT NULL COMMENT '私信内容',
`time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '私信时间',
`read` int NULL DEFAULT 0 COMMENT '本私信是否已读， 0 未读， 1 已读',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `post_role` (
`id` integer NOT NULL AUTO_INCREMENT,
`post_role_name` varchar(30) CHARACTER SET utf8 NULL COMMENT '帖子元类型',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `praise` (
`id` integer NOT NULL AUTO_INCREMENT,
`user_id` integer NOT NULL COMMENT '用户 id',
`post_id` integer NOT NULL COMMENT '帖子 id',
`time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `car_depart` (
`id` integer NOT NULL AUTO_INCREMENT,
`post_id` integer NOT NULL COMMENT '发车对应的帖子 id',
`plate_number` integer NOT NULL COMMENT '车牌号码',
`car_state` int NULL DEFAULT 1 COMMENT '发车状态。0 未发车，1 发车，2 发车完毕',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `car_aboard` (
`id` integer NOT NULL AUTO_INCREMENT,
`user_id` integer NOT NULL COMMENT '用户 id',
`car_id` integer NOT NULL COMMENT '发车编号',
`time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`state` int NOT NULL DEFAULT 1 COMMENT '上车状态,0 还未上车，1乘车，2下车',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `tag` (
`id` integer NOT NULL AUTO_INCREMENT,
`user_id` integer NOT NULL COMMENT '创建标签的用户',
`tag_name` varchar(10) CHARACTER SET utf8 NOT NULL COMMENT '标签名字',
`post_id` integer NOT NULL COMMENT '被贴标签的帖子',
`praise_number` integer NOT NULL COMMENT '赞同次数',
`time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '贴标签时间',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `complain` (
`id` integer NOT NULL AUTO_INCREMENT COMMENT '举报编号',
`post_id` integer NOT NULL COMMENT '被举报帖子id',
`complain_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '举报时间',
`user_id` integer NOT NULL COMMENT '举报用户',
`complain_reason` varchar(200) CHARACTER SET utf8 NOT NULL COMMENT '举报理由',
`state` int NOT NULL DEFAULT 0 COMMENT '0:成功 1:失败',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `tag_praise` (
`id` integer NOT NULL AUTO_INCREMENT COMMENT '记录的id，插入前判断 tag_id 是否存在，然后在判断相同 tag_id 的情况下 parise_user_id 是否唯一，如果增加一条记录，就会去找到 tag_id 然后让其 support_number 加一',
`tag_id` integer NOT NULL COMMENT '哪个标签',
`praise_user_id` integer NOT NULL COMMENT '点赞的用户',
`time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞的时间',
PRIMARY KEY (`id`) 
)
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;


ALTER TABLE `post` ADD CONSTRAINT `articles_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
ALTER TABLE `comment` ADD CONSTRAINT `posts_id_comments_id` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`);
ALTER TABLE `friend` ADD CONSTRAINT `friend_ship_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
ALTER TABLE `favorite` ADD CONSTRAINT `collection_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
ALTER TABLE `letter` ADD CONSTRAINT `letter_sender_user_id` FOREIGN KEY (`sender_user_id`) REFERENCES `user` (`id`);
ALTER TABLE `praise` ADD CONSTRAINT `praise_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
ALTER TABLE `car_depart` ADD CONSTRAINT `car_post_id` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`);
ALTER TABLE `car_aboard` ADD CONSTRAINT `aboard_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
ALTER TABLE `tag` ADD CONSTRAINT `tag_post_id` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`);
ALTER TABLE `complain` ADD CONSTRAINT `complain_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
ALTER TABLE `tag_praise` ADD CONSTRAINT `praise_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`);
ALTER TABLE `post` ADD CONSTRAINT `post_role_id` FOREIGN KEY (`post_role_id`) REFERENCES `post_role` (`id`);
ALTER TABLE `user` ADD CONSTRAINT `user_role_id` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`id`);
alter table user add unique key (`username`);
