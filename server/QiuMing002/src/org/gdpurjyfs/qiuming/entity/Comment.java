package org.gdpurjyfs.qiuming.entity;

import java.util.Date;

public class Comment {

	private long id;
	private long groundId;
	private long postId;
	private String content;
	private long userId;
	private long replyCommentId;
	private Date time;
	
	public Comment() {
		this.content = "";
	}
	
	public Comment(long postId) {
		this.setPostId(postId);
	}
	public long getGroundId() {
		return groundId;
	}

	public void setGroundId(long groundId) {
		this.groundId = groundId;
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
	public long getReplyCommentId() {
		return replyCommentId;
	}

	public void setReplyCommentId(long replyCommentId) {
		this.replyCommentId = replyCommentId;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	
	@Override
	public String toString() {
		return "Comment [id=" + id + ", postId=" + postId + ", content="
				+ content + ", userId=" + userId + ", reciverUserId="
				+ replyCommentId + ", time=" + time + "]";
	}

	
}
