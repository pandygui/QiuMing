package org.gdpurjyfs.qiuming.dao;

import org.gdpurjyfs.qiuming.entity.Tag;
import org.gdpurjyfs.qiuming.util.JDBCTools;
import org.junit.Test;

public class TagDao implements CommonDao {

	public TagDao() {

	}

	// ----------------------------------------------------------------------------

	@Test
	public void testcreate() {
		Tag tag = new Tag();
		tag.setUserId(2);
		tag.setPostId(4);
		tag.setTagName("第一帖");
		
		// 用户 2 给帖子 4 贴上 第一帖的标签
		System.out.println(create(tag));
	}
	
	@Test
	public void testdelete() {
		System.out.println(delete(2));
	}

	// ----------------------------------------------------------------------------

	@Override
	public Object create(Object entity) {

		if (entity != null && entity instanceof Tag) {

			Tag tag = (Tag) entity;

			long userId = tag.getUserId();
			long postId = tag.getPostId();
			String tagName = tag.getTagName();
			// 判断是否重复插入相同的 tag
			if (!JDBCTools.isUnique(JDBCTools.getConnect(), "tag",
					"postId", "tagName", postId, tagName)) {
				String sql = "INSERT INTO tag(userId, postId, tagName) VALUES(?, ?, ?)";
				Object[] args = { userId, postId, tagName };
				return JDBCTools.create(JDBCTools.getConnect(), sql, args);
			} else {
				return CommonDao.DUPLICATE;
			}
		} else {
			return ENTITY_FAIL;
		}
	}

	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "tag", id);
		} else {
			return NONE;
		}
	}

	@Override
	public Object findById(long id) {
		return JDBCTools.findById(JDBCTools.getConnect(), "tag", id, Tag.class);
	}

	@Override
	public Object update(Object entity) {
		return null;
	}
}
