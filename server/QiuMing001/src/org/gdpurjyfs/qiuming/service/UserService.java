package org.gdpurjyfs.qiuming.service;

import org.gdpurjyfs.qiuming.dao.UserDao;
import org.gdpurjyfs.qiuming.entity.User;

public class UserService {
	
	/*
	 * 用户注册 
	 * 修改用户信息 
	 * 修改密码 
	 * 登陆
	 * 修改用户角色
	 */
	
	private User user;
	private String newPassword;

	public UserService() {
		
	}
	
	// TODO 修改用户信息
	public String modifyInfo() {
		UserDao userDao = new UserDao();
		// remove password
		user.setPassword("");
	 	String result = (String) userDao.update(user);
		return result;
	}

	// TODO 修改密码
	public String modifyPassword() {
		UserDao userDao = new UserDao();
		userDao.setNewPassword(this.newPassword);
	 	String result = (String) userDao.update(user);
		return result;
	}

	// TODO 用户注册
	public String register() {
		// 1. check exist
		// 2. 
		UserDao userDao = new UserDao();
	 	String result = (String) userDao.create(user);
	 	//1. OK
	 	//2. Exitis
	 	//3. Fail
		return result;
	}

	// TODO 用户登录
	public String login() {
		UserDao userDao = new UserDao();
	    Object userObject = userDao.findByName(user.getUsername());
	    if(userObject != null) {
	    	
	    	// 登录操作
	    	// 加经验值
	    	// 设置 Attribute 等
	    }
		
		return "";
	}

	//-----------------------------------------
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
}
