package org.gdpurjyfs.qiuming.dao;

import org.gdpurjyfs.qiuming.entity.Comment;
import org.gdpurjyfs.qiuming.util.JDBCTools;
import org.junit.Test;

public class CommentDao implements CommonDao {

	public CommentDao() {

	}
	
	//--------------------------------------------------------------------
	
	@Test
	public void testcreate() {
		Comment comment = new Comment();
		comment.setPostId(4);
		comment.setUserId(2);
		comment.setContent("第一评论");
		comment.setReplyCommentId(0);
		
		// 用户 2  评论 帖子 4
		System.out.println(create(comment));
		

		comment = new Comment();
		comment.setPostId(4);
		comment.setUserId(2);
		comment.setContent("回复某个评论");
		comment.setReplyCommentId(2);
		
		// 用户 2  回复 帖子 4 中的评论 2
		System.out.println(create(comment));
	}
	
	@Test
	public void testdelete() {
		System.out.println(delete(2));
	}
	
	//--------------------------------------------------------------------
	
	// TODO
	// 用来回复，暂时不做
	// groundId, content, replyCommentId
	public String replyComment(Comment comment) {
		return null;
	}
	
	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof Comment) {
			Comment comment = (Comment) entity;

			long userId = comment.getUserId();
			long postId = comment.getPostId();
			long replyCommentId = comment.getReplyCommentId();		// 默认为零，直接评论帖子
			String content = comment.getContent();

			String sql = "INSERT INTO comment( userId, postId, replyCommentId, content) "
					+ "VALUES(?, ?, ?, ?)";
			Object[] args = { userId, postId, replyCommentId, content };

			// 可以重复
			return JDBCTools.create(JDBCTools.getConnect(), sql, args);

		} else {
			return CommentDao.ENTITY_FAIL;
		}
	}

	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "comment", id);
		} else {
			return NONE;
		}
	}

	@Override
	public Object findById(long id) {
		return JDBCTools.findById(JDBCTools.getConnect(), "comment", id,
				Comment.class);
	}

	@Override
	public Object update(Object entity) {
		return null;
	}

}
