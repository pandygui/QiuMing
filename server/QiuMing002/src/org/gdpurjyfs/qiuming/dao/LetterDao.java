package org.gdpurjyfs.qiuming.dao;

import org.gdpurjyfs.qiuming.entity.Letter;
import org.gdpurjyfs.qiuming.util.JDBCTools;
import org.junit.Test;

public class LetterDao implements CommonDao {

	public LetterDao() {

	}
	
	//--------------------------------------------------------------------
	
	@Test
	public void testcreate() {
		Letter letter = new Letter();
		letter.setContent("这封私信课室包含着我对你满满的爱意。");
		// 2 发送给 1
		letter.setReceiveUserId(1);
		letter.setSenderUserId(2);
		System.out.println(create(letter));
	}
	
	@Test
	public void testdelete() {
		String result = (String) delete(7);
		if (result != null) {
			System.out.println(result.toString());
		} else {
			System.out.println("Delete Fail");
		}
	}	
	
	//--------------------------------------------------------------------
	
	
	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof Letter) {
			Letter letter = (Letter) entity;
			/*
			 * `username` `password` `pickname` `email` `telephone` `age`
			 * `address` `experience` `sex` `roleId` `introduction`
			 */			
			String sql = "INSERT INTO letter(receiveUserId, senderUserId, content) "
					+ " VALUES(?,?,?);";
			Object[] args = { 
					letter.getReceiveUserId(),
					letter.getSenderUserId(),
					letter.getContent() };
			
			return JDBCTools.create(JDBCTools.getConnect(), sql, args);
		} else {
			return CommentDao.ENTITY_FAIL;
		}
	}

	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "letter", id);
		} else {
			return NONE;
		}
	}

	// 私信不能修改
	@Override
	public Object update(Object entity) {
		return null;
	}

	@Override
	public Object findById(long id) {
		return JDBCTools.findById(JDBCTools.getConnect(), "letter", id, Letter.class);
	}

}
