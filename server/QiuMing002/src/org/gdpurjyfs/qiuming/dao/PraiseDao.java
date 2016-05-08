package org.gdpurjyfs.qiuming.dao;

import java.util.List;

import org.gdpurjyfs.qiuming.entity.Praise;
import org.gdpurjyfs.qiuming.util.JDBCTools;
import org.junit.Test;


public class PraiseDao implements CommonDao {	
	
	public PraiseDao() {
		
	}
	
	//--------------------------------------------------------------------
	
	@Test
	public void testcreate() {
		Praise praise = new Praise();
		praise.setPostId(4);
		praise.setUserId(2);
		
		// 用户 2 点赞 帖子 4
		
		System.out.println(create(praise));
	}
	
	@Test
	public void testdelete() {
		System.out.println(delete(3));
	}
	
	
	@Test
	public void testexitsByIds() {
		System.out.println(JDBCTools.existByIds(JDBCTools.getConnect(), "praise", "userId", "postId", 1, 1));
		System.out.println(JDBCTools.existByIds(JDBCTools.getConnect(), "praise", "userId", "postId", 2, 1));
	}
	
	//--------------------------------------------------------------------
	
	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof Praise) {
			Praise praise = (Praise) entity;
			
			long userId = praise.getUserId();
			long postId = praise.getPostId();
			
			if(! JDBCTools.existByIds(JDBCTools.getConnect(), "praise", "userId", "postId",userId, postId)) {
				String sql = "INSERT INTO praise( userId, postId) "
						+ "VALUES(?, ?)";
				Object[] args = { userId, postId };
				
				return JDBCTools.create(JDBCTools.getConnect(), sql, args);
			} else {
				// 不可重复点赞
				return CommentDao.DUPLICATE;
			}
		} else {
			return CommentDao.ENTITY_FAIL;
		}
	}
	
	public String delete(long userId, long postId) {
		String sql = "delete from praise where userId = ? and postId = ? ;";
		Object[] args = { userId, postId };
		return JDBCTools.update(JDBCTools.getConnect(), sql, args);
	}

	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "praise", id);
		} else {
			return NONE;
		}
	}
	
	public Praise findById(long userId, long postId) {
		List<Praise> praises = JDBCTools.findByDoubleColumnName(JDBCTools.getConnect(), "praise", 
				"userId", userId, 
				"postId", postId, Praise.class);
		return praises != null && praises.size() != 0 ? praises.get(0) : null;
	}

	@Override
	public Object findById(long id) {
		return JDBCTools.findById(JDBCTools.getConnect(), "praise", id, Praise.class);
	}

	// 赞，只有点赞和取消赞
	@Override
	public Object update(Object entity) {
		return null;
	}
	
}
