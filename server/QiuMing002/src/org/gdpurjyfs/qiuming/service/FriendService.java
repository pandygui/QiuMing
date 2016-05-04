package org.gdpurjyfs.qiuming.service;

import org.gdpurjyfs.qiuming.dao.FriendDao;
import org.gdpurjyfs.qiuming.dao.UserDao;
import org.gdpurjyfs.qiuming.entity.Friend;
import org.gdpurjyfs.qiuming.entity.User;

public class FriendService {
	/*
	 * 加关注 
	 */
	
	private User user;
	private User focusUser;

	// TODO
	public String focus() {
		// 1. 查找被关注用户是否存在
		// 2. 是否已经关注了
		// 3. 写入 Friend 记录
		
		UserDao userDao = new UserDao();
		User findUser = (User)userDao.findById(this.getUser().getId());
		if(findUser != null ) {
			FriendDao friendDao = new FriendDao();
			Friend friend = new Friend();
			friend.setFocusUserId(this.getFocusUser().getId());
			friend.setUserId(this.getUser().getId());
			
			friendDao.create(friend);
		}
		
		
		return "";
	}	
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public User getFocusUser() {
		return focusUser;
	}

	public void setFocusUser(User focusUser) {
		this.focusUser = focusUser;
	}
}
