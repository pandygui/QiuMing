package org.gdpurjyfs.qiuming.action;

import java.util.Date;

public class PostAction {
	/*
	 * 创建帖子 
	 * 查看帖子 
	 * 修改帖子 
	 * 收藏帖子 
	 * 点赞帖子 
	 * 删除帖子 
	 * 举报帖子
	 * 帖子贴标签 
	 * 赞同帖子的标签 
	 */
	
	private long userId;
	private long postId;


	private String title;
	private String content;
	private int state; // TODO
	private Date time;
	
	private long viewUserId;
	private String tag;
	private String favoriteName;			// 收藏夹名称

	// TODO 创建帖子 
	public String createPost() {

		return "";
	}

	// TODO 查看帖子 
	public String viewPost() {
		return "";
	}
	
	// TODO 修改帖子 
	public String modifyPost() {
		return "";
	}
	
	// TODO 收藏帖子 
	public String favoritePost() {
		return "";
	}
	
	// TODO 点赞帖子 
	//! NOTE: 点赞或者取消赞	
	public String parisePost() {
		return "";
	}
	
	// TODO 删除帖子 
	public String deletePost() {
		return "";
	}
	
	// TODO 举报帖子
	public String complainPost() {
		return "";
	}
	
	// TODO 帖子贴标签
	public String tagPost() {
		return "";
	}
	
	// TODO 赞同帖子的标签 
	public String parisePostTag() {
		return "";
	}

	//--------------------------------------------------------------
	
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

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}
	
	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}
	public long getViewUserId() {
		return viewUserId;
	}

	public void setViewUserId(long viewUserId) {
		this.viewUserId = viewUserId;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
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
}
