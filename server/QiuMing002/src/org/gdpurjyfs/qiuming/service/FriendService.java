package org.gdpurjyfs.qiuming.service;

import java.util.ArrayList;
import java.util.List;

import org.gdpurjyfs.qiuming.dao.FriendDao;
import org.gdpurjyfs.qiuming.dao.UserDao;
import org.gdpurjyfs.qiuming.entity.Friend;
import org.gdpurjyfs.qiuming.entity.User;

public class FriendService {
	/* 加关注 取消关注 获取用户关注列表 */
	
	private FriendDao friendDao = new FriendDao();
	private UserDao userDao = new UserDao();
	
	/**
	 * 获取用户关注列表
	 * 注意返回的用户中的 password 一定是空的！
	 ***/
	public List<User> getFriendList(long userId) {
		List<Friend> friends = friendDao.getFriendList(userId);
		List<User> users = new ArrayList<User>();
		for(Friend f : friends) {
			User user = (User)userDao.findById(f.getFocusUserId());
			if(user != null) {
				users.add(user);
			}
		}
		return users;
	}
	
	/**
	 * 关注某个用户
	 ***/
	public String focusUser(long userId, long focusUserId) {
		return (String) friendDao.create(new Friend(userId, focusUserId));
	}
	
	/**
	 * 取消关注某个用户
	 ***/
	public String unfocusUser(long userId, long focusUserId) {
		return friendDao.delete(userId, focusUserId);
	}

}
