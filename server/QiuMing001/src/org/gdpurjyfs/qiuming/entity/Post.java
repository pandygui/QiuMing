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
	private int state;				// TODO
	private long roleId;
	
	public Post() {
		
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
	
}
