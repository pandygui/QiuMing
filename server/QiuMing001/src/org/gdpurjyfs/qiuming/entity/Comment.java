package org.gdpurjyfs.qiuming.entity;

import java.util.Date;

public class Comment {
	
	
	private long id;
	private long postId;
	private String content;
	private long userId;
	private long reciverUserId;
	private Date time;
	
	public Comment() {
		
	}
	
	public Comment(long postId) {
		this.setPostId(postId);
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getPostId() {
		return postId;
	}
	public void setPostId(long postId) {
		this.postId = postId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public long getReciverUserId() {
		return reciverUserId;
	}
	public void setReciverUserId(long reciverUserId) {
		this.reciverUserId = reciverUserId;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}

	
}
