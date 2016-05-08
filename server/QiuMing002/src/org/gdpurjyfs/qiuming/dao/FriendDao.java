package org.gdpurjyfs.qiuming.dao;

import java.util.List;

import org.gdpurjyfs.qiuming.entity.Friend;
import org.gdpurjyfs.qiuming.util.JDBCTools;
import org.junit.Test;

public class FriendDao implements CommonDao {

	public FriendDao() {

	}

	// ----------------------------------------------------------------------
	@Test
	public void testcreate() {
		Friend friend = new Friend();

		// 用户 1 关注用户 2
		friend.setFocusUserId(1);
		friend.setUserId(2);
		System.out.println(create(friend));
	}

	@Test
	public void testdelete() {
		System.out.println(delete(2));
	}

	// ----------------------------------------------------------------------

	// 关注
	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof Friend) {

			Friend friend = (Friend) entity;

			long userId = friend.getUserId();
			long focusUserId = friend.getFocusUserId();

			if (!JDBCTools.existByIds(JDBCTools.getConnect(), "friend",
					"userId", "focusUserId", userId, focusUserId)) {

				String sql = "INSERT INTO friend (userId, focusUserId) VALUES(?, ?)";
				Object[] args = { userId, focusUserId };

				return JDBCTools.create(JDBCTools.getConnect(), sql, args);
			} else {
				// 不可重复关注
				return CommentDao.DUPLICATE;
			}
		} else {
			return ENTITY_FAIL;
		}
	}

	/**
	 * 取消关注
	 ***/
	public String delete(long userId, long focusUserId) {
		List<Friend> friends = JDBCTools.findByDoubleColumnName(
				JDBCTools.getConnect(), "friend", "userId", userId,
				"focusUserId", focusUserId, Friend.class);
		if (friends != null && friends.size() != 0) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "friend",
					friends.get(0).getId());
		} else {
			return NONE;
		}
	}

	/**
	 * 取消关注
	 ***/
	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "friend", id);
		} else {
			return NONE;
		}
	}

	@Override
	public Object findById(long id) {
		return JDBCTools.findById(JDBCTools.getConnect(), "friend", id,
				Friend.class);
	}

	@Override
	public Object update(Object entity) {
		return null;
	}

	/**
	 * 罗列用户所有的关注用户
	 ***/
	public List<Friend> getFriendList(long userId) {
		return JDBCTools.findByColumnName(JDBCTools.getConnect(), "friend",
				"userId", userId, Friend.class);
	}
}
