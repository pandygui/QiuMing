package org.gdpurjyfs.qiuming.dao;

import java.util.Date;
import java.util.List;

public class FriendDao implements CommonDao {
	private long id;
	private long userId;
	private long focusUserId;
	private Date time;
	
	public FriendDao() {
		
	}
	
	public String focus(long focusUserId) {
		return "";
	}
	
	// 加关注
	public static String focus(long userId, long focusUserId) {
		return "";
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public long getFocusUserId() {
		return focusUserId;
	}
	public void setFocusUserId(long focusUserId) {
		this.focusUserId = focusUserId;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}

	@Override
	public Object create(Object entity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object delete(long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object update(Object entity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object findById(long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> findAll(Object... args) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
}
