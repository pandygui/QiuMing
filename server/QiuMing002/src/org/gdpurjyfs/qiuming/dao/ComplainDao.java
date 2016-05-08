package org.gdpurjyfs.qiuming.dao;

import org.gdpurjyfs.qiuming.entity.Complain;
import org.gdpurjyfs.qiuming.util.JDBCTools;
import org.junit.Test;

public class ComplainDao implements CommonDao {
	
	public ComplainDao() {
		
	}
	//--------------------------------------------------------------------
	@Test
	public void testcreate() {
		Complain complain = new Complain();
		complain.setPostId(4);
		complain.setUserId(2);
		complain.setReason("用于测试的举报");
		
		// 用户 2 举报 帖子 4
		
		System.out.println(create(complain));
	}
	
	@Test
	public void testdelete() {
		System.out.println(delete(2));
	}
	
	//--------------------------------------------------------------------
	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof Complain) {
			Complain complain = (Complain) entity;
			
			long userId = complain.getUserId();
			long postId = complain.getPostId();
			String reason = complain.getReason();
			
			if(! JDBCTools.existByIds(JDBCTools.getConnect(), "complain", "userId", "postId", userId, postId)) {
				String sql = "INSERT INTO complain( userId, postId, reason) "
						+ "VALUES(?, ?, ?)";
				Object[] args = { userId, postId, reason };
				
				return JDBCTools.create(JDBCTools.getConnect(), sql, args);
			} else {
				// 不可重复举报
				return CommentDao.DUPLICATE;
			}
		} else {
			return CommentDao.ENTITY_FAIL;
		}
	}

	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "praise", id);
		} else {
			return NONE;
		}
	}

	@Override
	public Object findById(long id) {
		return JDBCTools.findById(JDBCTools.getConnect(), "complain", id, Complain.class);
	}
	
	@Override
	public Object update(Object entity) {
		return null;
	}
	
}
