package org.gdpurjyfs.qiuming.dao;

import org.gdpurjyfs.qiuming.entity.TagPraise;
import org.gdpurjyfs.qiuming.util.JDBCTools;
import org.junit.Test;

public class TagPraiseDao implements CommonDao {
	
	public TagPraiseDao() {

	}
	
	// ----------------------------------------------------------------------------
	
	@Test
	public void testcreate() {
		TagPraise tagPraise = new TagPraise();
		tagPraise.setPraiseUserId(4);
		tagPraise.setTagId(1);
		System.out.println(create(tagPraise));
	}
	
	@Test
	public void testdelete() {
		System.out.println(delete(1));
	}
	
	// ----------------------------------------------------------------------------
	
	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof TagPraise) {
			TagPraise tagPraise = (TagPraise) entity;
			long tagId = tagPraise.getTagId();
			long praiseUserId = tagPraise.getPraiseUserId();
			
			if(! JDBCTools.existByIds(JDBCTools.getConnect(), "tag_praise", "tagId", "praiseUserId",tagId, praiseUserId)) {
				String sql = "INSERT INTO tag_praise( tagId, praiseUserId) "
						+ "VALUES(?, ?)";
				Object[] args = { tagId, praiseUserId };
				
				return JDBCTools.create(JDBCTools.getConnect(), sql, args);
			} else {
				// 不可重复点赞
				return CommentDao.DUPLICATE;
			}
		} else {
			return CommentDao.ENTITY_FAIL;
		}
	}

	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "tag_praise", id);
		} else {
			return NONE;
		}
	}

	@Override
	public Object findById(long id) {
		return JDBCTools.findById(JDBCTools.getConnect(), "tag_praise", id, TagPraise.class);
	}
	
	@Override
	public Object update(Object entity) {
		// TODO Auto-generated method stub
		return null;
	}
}
