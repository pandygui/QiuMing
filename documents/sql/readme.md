# 使用说明

先建表，然后初始化数据库。

1. [秋明数据库初始化](秋明数据库初始化.sql)

2. [初始化角色表](初始化角色表.sql)

## 功能与数据库操作映射

|  | 用户模块 | 帖子模块 | 评论模块 | 发车模块 | 社交模块 | 管理模块/审核模块 |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| 用户注册 | √ |  |  |  |  |  |
| 修改用户信息 | √ |  |  |  |  |  |
| 修改密码 | √ |  |  |  |  |  |
| 登陆 | √ |  |  |  |  |  |
| 创建帖子 |  | √ |  |  |  |  |
| 查看帖子 |  | √ |  |  |  |  |
| 修改帖子 |  | √ |  |  |  |  |
| 收藏帖子 |  | √ |  |  |  |  |
| 评论帖子 |  |  | √ |  |  |  |
| 帖子贴标签 |  | √ |  |  |  |  |
| 赞同帖子的标签 |  | √ |  |  |  |  |
| 查看帖子评论 |  |  | √ |  |  |  |
| 点赞帖子 |  | √ |  |  |  |  |
| 删除帖子 |  | √ |  |  |  |  |
| 举报帖子 |  | √ |  |  |  |  |
| 加关注 |  |  |  |  | √ |  |
| 发送私信 |  |  |  |  | √ |  |
| 搜索私信 |  |  |  |  | √ |  |
| 搜索用户 |  |  |  |  | √ |  |
| 搜索车牌号 |  |  |  |  | √ |  |
| 举报发车 |  |  |  | √ |  |  |
| 上车 |  |  |  | √ |  |  |
| 发车 |  |  |  | √ |  |  |
| 设置上车权限 |  |  |  | √ |  |  |
| 审核发车 |  |  |  |  |  | √ |
| 审核帖子 |  |  |  |  |  | √ |
| 审核评论 |  |  |  |  |  | √ |

### 用户模块

#### 登陆

1. 输入用户名和密码。

2. 数据库匹配。SUCCESS, PASSWORD_FAIL, USER_NONE

3. 执行登陆后相关用户操作，例如登陆一次经验加一，获取未读私信。

```
SELECT username, pickname, experience FROM user where username = 'admin' and password = 'admin';

UPDATE user SET experience = experience + 1 where username = 'admin';
```

#### 用户注册

1. 输入用户名和密码。

2. 数据库匹配。SUCCESS, PASSWORD_FAIL, USER_NONE

3. 执行相关注册操作

```
INSERT INTO user(username, password) VALUES('qyvlik', '1403085871');
```

#### 修改用户信息

1. 输入用户名和密码。

2. 数据库匹配。SUCCESS, PASSWORD_FAIL, USER_NONE

3. 先取出所有用户信息，然后一一匹配赋值，再写回数据库。

```
UPDATE user SET pickname = 'pickname' ,
                email = 'email@qq.com' ,
                telephone = '123456',
                age = 1,
                address = '秋名山',
                sex = '秀吉',
                introduction = '这个是个人简介'
             where username = 'test';
```

#### 修改密码

1. 输入用户名和密码。

2. 数据库匹配。SUCCESS, PASSWORD_FAIL, USER_NONE

3. oldPassword 和 newPassword

```
UPDATE `user` SET `password` = 'password' WHERE username = 'test';
```

### 帖子模块

#### 创建帖子

1. 输入用户 id（登陆后必须要拿到的）

2. 输入标题，内容

3. 发布

~~4. 是否要审核（不要了）~~

```
INSERT INTO post(user_id, title, content) VALUES(1, '本站第一个帖子', '# 本站第一个帖子\n番号 ibw-518z。');
```

#### 查看帖子

1. 输入 post_id

2. 查询

```
SELECT content, title from post where post_id = post_id;
```

#### 修改帖子

```
UPDATE post SET title = '本站第一个帖子',
                content = '# 本站第一个帖子\n番号: ibw-518z, ibw-218。'
            WHERE id = 1;
```

#### 收藏帖子

1. user_id, post_id

2. 写入 favorite 。

3. 设置 post where post_id = 1 的 favorite_number

```
INSERT INTO favorite(user_id, post_id) VALUES(1, 1);
UPDATE post SET favorite_number = favorite_number + 1
            WHERE id = 1;
```

#### 帖子贴标签

1. user_id, post_id, tagName

2. 写入 tag

```
INSERT INTO tag (user_id, post_id, tag_name) VALUES(1, 1, '第一发'); -- 贴标签
```

#### 点赞帖子

1. user_id, post_id

2. 写入 praise

3. 修改 post where post_id = 1 的 praise_number

```
INSERT INTO praise (user_id, post_id) VALUES(1, 1);
UPDATE post SET praise_number = praise_number + 1
            WHERE id = 1;
```

#### 删除帖子

1. post_id

```
DELETE FROM post WHERE id=2;
```

#### 举报帖子

1. user_id, post_id, reason

2. 写入 complain

```
INSERT INTO complain (user_id, post_id, complain_reason) VALUES(5, 5, '非发车帖子有番号');
```

### 评论模块

#### 评论帖子

1. user_id, post_id, content

2. 写入 comment

3. 发送私信告知作者

4. 如果是自己评论自己则不发送私信

```
INSERT INTO `comment` (user_id, post_id, content) VALUES(1, 1, '自己评论自己的第一篇帖子');
INSERT INTO `comment` (user_id, post_id, content) VALUES(5, 1, '关荣的抢不到第一');
INSERT INTO `letter` (receive_user_id, sender_user_id, content) 
              VALUES (1, 1, '系统私信：{user_id} 在 {post_id} 评论了');
```

#### 回复评论

1. user_id, post_id, content, reciver_user_id

2. 写入 comment

3. 发送系统私信告诉介绍着

4. 如果是自己评论自己则不发送私信

```
INSERT INTO `comment` (user_id, post_id, reciver_user_id, content) 
                VALUES(1, 1, 5, '我看了你的评论了');
INSERT INTO `letter` (receive_user_id, sender_user_id, content) 
              VALUES (5, 1, '系统私信：{user_id} 在 {post_id}回复了您的评论了');
```

#### 查看评论

1. post_id

2. LIMIT 10 分页方式查看评论

### 发车模块

#### 发车

1. 申请发车，获取到 post_id

2. post_id, user_id, content, 手动帖子 车牌号

3. 发车，获取到 car_id

```
INSERT INTO post(user_id, title, content, post_role_id) VALUES(1, '本站第一个发车', '# 秋名山老司机第一发\n番号 ibw-518z。', 2);
INSERT INTO car_depart(post_id, plate_number) VALUES(4, '秋 ibw-518z')
```

#### 上车

1. 搜索车牌号，选择 post_id

2. user_id, car_id

3. 写入 car_aboard 前检查是否已经上传， 检查 car_aboard state 字段

> **注意**：只能上车一次，下车后才可上其他车

```
-- check
INSERT INTO car_aboard (user_id, car_id) VALUES(5, 1);
```

#### 下车

1. 通过 user_id 遍历 car_aboard 

2. 设置 state 字段

```
UPDATE car_aboard SET state = 2 
                  WHERE user_id = 5;
```

#### 设置上车权限

> **注意**：此次开发阶段不开发此功能。

### 社交模块

#### 关注

1. user_id, focus_user_id

2. 写入 friend

3. 系统私信通知 focus_user_id

```
INSERT INTO friend (user_id, focus_user_id) VALUES(5, 1);
INSERT INTO `letter` (receive_user_id, sender_user_id, content) 
              VALUES (1, 1, '系统私信：{user_id} 关注了你');
```

####  发送私信

1. user_id, focus_user_id, content

```
INSERT INTO `letter` (receive_user_id, sender_user_id, content) 
              VALUES (5, 1, '谢谢关注我');
```

#### 搜索服务

TODO

### 管理模块/审核模块

> **注意**：本模块暂时不开发。

#### 审核发车

#### 审核评论

#### 审核帖子