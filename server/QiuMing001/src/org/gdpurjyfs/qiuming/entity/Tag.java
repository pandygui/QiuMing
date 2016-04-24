package org.gdpurjyfs.qiuming.entity;

import java.util.Date;

public class Tag {
	
	private long id;
	private long userId;
	private long postId;
	private String tagName;
	private long praiseNumber;
	private Date time;
	
	public Tag() {
		
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
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public long getPraiseNumber() {
		return praiseNumber;
	}
	public void setPraiseNumber(long praiseNumber) {
		this.praiseNumber = praiseNumber;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	
	
}
