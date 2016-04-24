package org.gdpurjyfs.qiuming.service;

import org.gdpurjyfs.qiuming.dao.CommentDao;
import org.gdpurjyfs.qiuming.entity.Comment;
import org.gdpurjyfs.qiuming.entity.User;

public class CommentService {
	/* 
	 * 评论帖子 查看帖子评论
	 */
	private User user;
	private Comment comment;
	
	// TODO
	public String commentPost() {
		// 1. 用户是否登陆
		// 2. post id
		// 3. Comment 写入记录
		CommentDao commentDao = new CommentDao();
		commentDao.create(this.getComment());
		
		return "";
	}
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Comment getComment() {
		return comment;
	}
	public void setComment(Comment comment) {
		this.comment = comment;
	}
	
}
