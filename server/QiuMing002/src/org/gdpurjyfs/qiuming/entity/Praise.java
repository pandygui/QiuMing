package org.gdpurjyfs.qiuming.entity;

import java.util.Date;

public class Praise {
	private long id;
	private long userId;
	private long postId;
	private Date time;
	
	public Praise() {
	}
	
	public Praise(long userId, long postId) {
		this.userId = userId;
		this.postId = postId;
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
	public long getPostId() {
		return postId;
	}
	public void setPostId(long postId) {
		this.postId = postId;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	
	@Override
	public String toString() {
		return "Praise [id=" + id + ", userId=" + userId + ", postId=" + postId
				+ ", time=" + time + "]";
	}

}
