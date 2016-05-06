package org.gdpurjyfs.qiuming.entity;

import java.util.Date;

public class Favorite {
	private long id;
	private long userId;
	private long postId;
	private String favoriteName;
	private Date time;
	
	public Favorite() {
		this.favoriteName = "默认收藏夹";
	}
	
	public Favorite(long userId, long postId) {
		this(userId, postId, "默认收藏夹");
	}
	
	public Favorite(long userId, long postId, String favoriteName) {
		this.userId = userId;
		this.postId = postId;
		this.favoriteName = favoriteName;
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
	public String getFavoriteName() {
		return favoriteName;
	}
	public void setFavoriteName(String favoriteName) {
		this.favoriteName = favoriteName;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	
	@Override
	public String toString() {
		return "Favorite [id=" + id + ", userId=" + userId + ", postId="
				+ postId + ", favoriteName=" + favoriteName + ", time=" + time
				+ "]";
	}

}
