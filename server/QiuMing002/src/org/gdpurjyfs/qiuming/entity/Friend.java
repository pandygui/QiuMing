package org.gdpurjyfs.qiuming.entity;

import java.util.Date;

public class Friend {
	private long id;
	private long userId;
	private long focusUserId;
	private Date time;

	public Friend() {

	}

	public Friend(long userId, long focusUserId) {
		this.userId = userId;
		this.focusUserId = focusUserId;
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
	public String toString() {
		return "Friend [id=" + id + ", userId=" + userId + ", focusUserId="
				+ focusUserId + ", time=" + time + "]";
	}

}
