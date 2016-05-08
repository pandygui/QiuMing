package org.gdpurjyfs.qiuming.entity;

import java.util.Date;

public class Post {
	
	private long id;
	private long userId;
	private String title;
	private String content;
	private long praiseNumber;
	private long favoriteNumber;
	private Date time;
	private Date modifyTime;
	private int state;				// 帖子审核状态，0 ： 不通过，1 ： 通过
	private long roleId;			// 1 帖子 2 发车
	
	public Post(long userId, long postId, String title, String content) {
		this.userId = userId;
		this.id = postId;
		this.title = title;
		this.content = content;
	}
	
	public Post(long userId, String title, String content) {
		this.userId = userId;
		this.title = title;
		this.content = content;
	}	
	
	public Post() {
		this.title = "";
		this.content = "";
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public long getPraiseNumber() {
		return praiseNumber;
	}
	public void setPraiseNumber(long praiseNumber) {
		this.praiseNumber = praiseNumber;
	}
	public long getFavoriteNumber() {
		return favoriteNumber;
	}
	public void setFavoriteNumber(long favoriteNumber) {
		this.favoriteNumber = favoriteNumber;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public long getRoleId() {
		return roleId;
	}
	public void setRoleId(long roleId) {
		this.roleId = roleId;
	}
	
	@Override
	public String toString() {
		return "Post [id=" + id + ", userId=" + userId + ", title=" + title
				+ ", content=" + content + ", praiseNumber=" + praiseNumber
				+ ", favoriteNumber=" + favoriteNumber + ", time=" + time
				+ ", modifyTime=" + modifyTime + ", state=" + state
				+ ", roleId=" + roleId + "]";
	}
}
