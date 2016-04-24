-- 初始化用户角色

INSERT INTO user_role(role_name) VALUES( '普通用户' );
INSERT INTO user_role(role_name) VALUES( '管理员' );
INSERT INTO user_role(role_name) VALUES( '超级管理员' );

-- 初始化帖子类型

INSERT INTO post_role(post_role_name) VALUES('帖子');
INSERT INTO post_role(post_role_name) VALUES('发车');