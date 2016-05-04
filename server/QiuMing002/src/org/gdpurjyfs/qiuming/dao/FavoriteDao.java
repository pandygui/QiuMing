package org.gdpurjyfs.qiuming.dao;

import java.util.List;

import org.gdpurjyfs.qiuming.entity.Favorite;
import org.gdpurjyfs.qiuming.util.JDBCTools;
import org.junit.Test;

public class FavoriteDao implements CommonDao {

	public FavoriteDao() {
		
	}
	
	//--------------------------------------------------------------------
	
	@Test
	public void testcreate() {
		Favorite favorite = new Favorite();
		favorite.setPostId(4);
		favorite.setUserId(2);
		
		// 用户 2 收藏 帖子 4
		
		System.out.println(create(favorite));
	}
	
	@Test
	public void testdelete() {
		System.out.println(delete(2));
	}
	
	//--------------------------------------------------------------------
	
	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof Favorite) {
			Favorite favorite = (Favorite) entity;
			
			long userId = favorite.getUserId();
			long postId = favorite.getPostId();
			String favoriteName = favorite.getFavoriteName();
			
			if(! JDBCTools.existByIds(JDBCTools.getConnect(), "favorite", "userId", "postId",userId, postId)) {
				String sql = "INSERT INTO favorite( userId, postId, favoriteName) "
						+ "VALUES(?, ?, ?)";
				Object[] args = { userId, postId, favoriteName };
				
				return JDBCTools.create(JDBCTools.getConnect(), sql, args);
			} else {
				// 不可重复收藏
				return CommentDao.DUPLICATE;
			}
		} else {
			return CommentDao.ENTITY_FAIL;
		}
	}

	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "favorite", id);
		} else {
			return NONE;
		}
	}

	@Override
	public Object findById(long id) {
		return JDBCTools.findById(JDBCTools.getConnect(), "favorite", id, Favorite.class);
	}


	//TODO 收藏夹暂时不提供其他业务
	@Override
	public Object update(Object entity) {
		return null;
	}
	
	//TODO 获取用户所有的收藏
	@Override
	public List<Object> findAll(Object... args) {
		return null;
	}
}
