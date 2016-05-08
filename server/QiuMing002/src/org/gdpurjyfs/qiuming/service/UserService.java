package org.gdpurjyfs.qiuming.service;

import org.gdpurjyfs.qiuming.dao.CommonDao;
import org.gdpurjyfs.qiuming.dao.UserDao;
import org.gdpurjyfs.qiuming.entity.User;

public class UserService {

	/*
	 * 用户注册 修改用户信息 修改密码 登陆 修改用户角色
	 */

	private UserDao dao = new UserDao();

	public UserService() {

	}
	
	/**
	 * 修改信息
	 ***/
	public String modifyInfo(User user) {
		return (String) this.dao.update(user);
	}

	/**
	 * 修改密码
	 ***/
	public String modifyPassword(User user, String newPassword) {
		return dao.updatePassword(user);
	}

	/**
	 * 用户注册
	 ***/
	public String register(User user) {
		return (String) dao.create(user);
	}

	/**
	 * 用户登录
	 ***/
	public String login(User user) {
		User userObject = this.dao.findByName(user.getUsername());
		if (userObject != null) {
			// 1.添加经验
			// 2..
			if (user.getPassword().equals(userObject.getPassword())) {
				dao.experienceUp(userObject);
				return CommonDao.SUCCESS;
			} else {
				return UserDao.PASSWORD_FAIL;
			}
		} else {
			return CommonDao.NONE;
		}
	}

	/**
	 * 获取用户
	 ***/
	public User getUserByName(String username) {
		User user = dao.findByName(username);
		if (user != null) {
			user.setPassword("");
		}
		return user;
	}
	
	/**
	 * 查询是否有此用户
	 ***/
	public User getUserById(long userId) {
		return (User)dao.findById(userId);
	}

}
