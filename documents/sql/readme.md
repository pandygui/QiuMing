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
INSERT INTO post(userId, title, content) VALUES(1, '本站第一个帖子', '# 本站第一个帖子\n番号 ibw-518z。');
```

#### 查看帖子

1. 输入 postId

2. 查询

```
SELECT content, title from post where postId = postId;
```

#### 修改帖子

```
UPDATE post SET title = '本站第一个帖子',
                content = '# 本站第一个帖子\n番号: ibw-518z, ibw-218。'
            WHERE id = 1;
```

#### 收藏帖子

1. userId, postId

2. 写入 favorite 。

3. 设置 post where postId = 1 的 favorite_number

```
INSERT INTO favorite(userId, postId) VALUES(1, 1);
UPDATE post SET favoriteNumber = favoriteNumber + 1
            WHERE id = 1;
```

#### 帖子贴标签

1. userId, postId, tagName

2. 写入 tag

```
INSERT INTO tag (userId, postId, tagName) VALUES(1, 1, '第一发'); -- 贴标签
```

#### 点赞帖子

1. userId, postId

2. 写入 praise

3. 修改 post where postId = 1 的 praise_number

```
INSERT INTO praise (userId, postId) VALUES(1, 1);
UPDATE post SET praise_number = praise_number + 1
            WHERE id = 1;
```

#### 删除帖子

1. postId

```
DELETE FROM post WHERE id=2;
```

#### 举报帖子

1. userId, postId, reason

2. 写入 complain

```
INSERT INTO complain (userId, postId, complain_reason) VALUES(5, 5, '非发车帖子有番号');
```

### 评论模块

#### 评论帖子

1. userId, postId, content

2. 写入 comment

3. 发送私信告知作者

4. 如果是自己评论自己则不发送私信

```
INSERT INTO `comment` (userId, postId, content) VALUES(1, 1, '自己评论自己的第一篇帖子');
INSERT INTO `comment` (userId, postId, content) VALUES(5, 1, '关荣的抢不到第一');
INSERT INTO `letter` (receiveUserId, senderUserId, content) 
              VALUES (1, 1, '系统私信：{userId} 在 {postId} 评论了');
```

#### 回复评论

1. userId, postId, content, reciverUserId

2. 写入 comment

3. 发送系统私信告诉介绍着

4. 如果是自己评论自己则不发送私信

```
INSERT INTO `comment` (userId, postId, reciverUserId, content) 
                VALUES(1, 1, 5, '我看了你的评论了');
INSERT INTO `letter` (receiveUserId, senderUserId, content) 
              VALUES (5, 1, '系统私信：{userId} 在 {postId}回复了您的评论了');
```

#### 查看评论

1. postId

2. LIMIT 10 分页方式查看评论

### 发车模块

#### 发车

1. 申请发车，获取到 postId

2. postId, userId, content, 手动帖子 车牌号

3. 发车，获取到 carId

```
INSERT INTO post(userId, title, content, post_roleId) VALUES(1, '本站第一个发车', '# 秋名山老司机第一发\n番号 ibw-518z。', 2);
INSERT INTO car_depart(postId, plate_number) VALUES(4, '秋 ibw-518z')
```

#### 上车

1. 搜索车牌号，选择 postId

2. userId, carId

3. 写入 carAboard 前检查是否已经上传， 检查 carAboard state 字段

> **注意**：只能上车一次，下车后才可上其他车

```
-- check
INSERT INTO carAboard (userId, carId) VALUES(5, 1);
```

#### 下车

1. 通过 userId 遍历 carAboard 

2. 设置 state 字段

```
UPDATE carAboard SET state = 2 
                  WHERE userId = 5;
```

#### 设置上车权限

> **注意**：此次开发阶段不开发此功能。

### 社交模块

#### 关注

1. userId, focusUserId

2. 写入 friend

3. 系统私信通知 focusUserId

```
INSERT INTO friend (userId, focusUserId) VALUES(5, 1);
INSERT INTO `letter` (receiveUserId, senderUserId, content) 
              VALUES (1, 1, '系统私信：{userId} 关注了你');
```

####  发送私信

1. userId, focusUserId, content

```
INSERT INTO `letter` (receiveUserId, senderUserId, content) 
              VALUES (5, 1, '谢谢关注我');
```

#### 搜索服务

TODO

### 管理模块/审核模块

> **注意**：本模块暂时不开发。

#### 审核发车

#### 审核评论

#### 审核帖子