package org.gdpurjyfs.qiuming.dao;

import java.util.List;

import org.gdpurjyfs.qiuming.entity.Favorite;
// import org.gdpurjyfs.qiuming.entity.Post;
import org.gdpurjyfs.qiuming.util.JDBCTools;
import org.junit.Test;

public class FavoriteDao implements CommonDao {

	public FavoriteDao() {

	}

	// --------------------------------------------------------------------

	@Test
	public void testcreate() {
		Favorite favorite = new Favorite();
		favorite.setPostId(10);
		favorite.setUserId(5);

		// 用户 5 收藏 帖子 4

		System.out.println(create(favorite));
	}

	@Test
	public void testdelete() {
		System.out.println(delete(2));
	}

	@Test
	public void testdelete2() {
		System.out.println(delete(5, 1, "默认收藏夹"));
		System.out.println(delete(5, 4, "默认收藏夹"));
	}

	@Test
	public void testgetUserFavoriteList() {
		List<Favorite> favorites = getUserFavoriteList(5, 0, 10);
		if (favorites != null) {
			System.out.println("favorites.size()" + favorites.size());
		} else {
			System.out.println("很口怕，这个用户没有收藏任何东西");

		}
	}

	// --------------------------------------------------------------------

	public String delete(long userId, long postId, String favoriteName) {
		List<Favorite> favorites = JDBCTools.findByDoubleColumnName(
				JDBCTools.getConnect(), "favorite", "userId", userId, "postId",
				postId, Favorite.class);
		// System.out.println("favorites size:"+favorites.size());
		if (favorites != null) {
			for (Favorite f : favorites) {
				if (f.getFavoriteName().equals(favoriteName)) {
					return (String) delete(f.getId());
				}
			}
		}
		return CommonDao.NONE;
	}

	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof Favorite) {
			Favorite favorite = (Favorite) entity;

			long userId = favorite.getUserId();
			long postId = favorite.getPostId();
			String favoriteName = favorite.getFavoriteName();

			if (!JDBCTools.existByIds(JDBCTools.getConnect(), "favorite",
					"userId", "postId", userId, postId)) {
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
		return JDBCTools.findById(JDBCTools.getConnect(), "favorite", id,
				Favorite.class);
	}

	public Favorite find(long userId, long postId, String favoriteName) {
		List<Favorite> favorites = JDBCTools.findByDoubleColumnName(
				JDBCTools.getConnect(), "favorite", "userId", userId, "postId",
				postId, Favorite.class);
		if (favorites != null) {
			for (Favorite f : favorites) {
				if (f.getFavoriteName().equals(favoriteName)) {
					return f;
				}
			}
		}
		return null;
	}

	/**
	 * 获取用户指定收藏夹的所有帖子列表
	 ***/
	public List<Favorite> getUserFavoriteList(long userId, String favoriteName) {
		return JDBCTools.findByDoubleColumnName(JDBCTools.getConnect(),
				"favorite", "userId", userId, "favoriteName", favoriteName,
				Favorite.class);
	}

	/**
	 * 分段获取用户所收藏的帖子列表
	 ***/
	public List<Favorite> getUserFavoriteList(long userId, long index, long size) {
		return JDBCTools.getRecodeListById(JDBCTools.getConnect(), "favorite",
				"userId", userId, index, size, Favorite.class);
	}

	// TODO 收藏夹暂时不提供其他业务
	@Override
	public Object update(Object entity) {
		return null;
	}
}
