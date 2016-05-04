package org.gdpurjyfs.qiuming.action;

public class CommentAction {
	
	private String username;
	private String reciverUsername;
	private String content;
	private long replyCommentId;

	// TODO 评论帖子
	public String commentPost() {
		return "";
	}
	
	// TODO 删除评论
	public String deleteComment() {
		return "";
	}
	
	// TODO 回复评论
	public String replyComment() {
		return "";
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getReciverUsername() {
		return reciverUsername;
	}

	public void setReciverUsername(String reciverUsername) {
		this.reciverUsername = reciverUsername;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public long getReplyCommentId() {
		return replyCommentId;
	}

	public void setReplyCommentId(long replyCommentId) {
		this.replyCommentId = replyCommentId;
	}
}
