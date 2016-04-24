package org.gdpurjyfs.qiuming.service;

import org.gdpurjyfs.qiuming.dao.UserDao;
import org.gdpurjyfs.qiuming.entity.User;
import org.gdpurjyfs.qiuming.entity.UserRole;

public class AdminService {
	private User user;
	private UserRole userRole;
	
	// TODO 更新用户角色
	public String upDateUserRole() {
		// 1. 使用 UserDao 检查用户是否存在
		// 2. 使用 UserRoleDao 修改用户角色
		// 3. 如果出错，提示
		UserDao userDao = new UserDao();
		User findUser = userDao.findByName(this.getUser().getUsername());
		String result = "";
		if(findUser != null) {
			findUser.setRoleId(this.getUserRole().getId());
			userDao.update(findUser);
		}
		return result;
	}
	
	// TODO 设置上车权限
	public String setAboardPermiss() {
		
		
		
		return "";
	}

	public UserRole getUserRole() {
		return userRole;
	}

	public void setUserRole(UserRole userRole) {
		this.userRole = userRole;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}
