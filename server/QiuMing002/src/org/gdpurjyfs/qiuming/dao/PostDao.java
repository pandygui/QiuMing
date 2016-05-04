package org.gdpurjyfs.qiuming.dao;

import java.util.List;
import java.sql.Connection;
import java.util.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import org.gdpurjyfs.qiuming.entity.*;
import org.gdpurjyfs.qiuming.util.*;
import org.junit.Test;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

@SuppressWarnings("unused")
public class PostDao implements CommonDao {
	private static final String ENTITY_FAIL = "ENTITY_FAIL",
			SUCCESS = "SUCCESS", NONE = "NONE", UNKNOWN = "UNKNOWN",
			CONNECTION_FAIL = "CONNECTION_FAIL";

	public PostDao() {
		
	}
	
	//----------------------------------------------------------------------------
	
	@Test
	public void testcreate() {
		
		Post post = new Post();
		UserDao userDao = new UserDao();
		User userAdmin = (User) userDao.findById(1);
		// INSERT INTO post(userId, title, content) VALUES(1, '本站第一个帖子',
		// '# 本站第一个帖子\n番号 ibw-518z。');
		
		post.setUserId(userAdmin.getId());
		post.setTitle("本站第一个帖子");
		post.setContent("# 本站第一个帖子\n番号 ibw-518z。\n randon:" + Math.random());

		System.out.println(create(post));
	}
	
	@Test
	public void testfindById() {
		Object post = findById(5);
		if (post != null && post instanceof Post) {
			System.out.println(post.toString());
		} else {
			System.out.println("Null Object");
		}
	}
	
	@Test
	public void testupdate() {
		Post post = (Post)findById(6);
		post.setTitle("跟别人家的标题冲突了");
		post.setContent("# 本站第一个帖子\n番号 ibw-518z。");
		System.out.println(update(post));
		post = (Post)findById(6);
		System.out.println(post.toString());
	}
	
	
	//----------------------------------------------------------------------------

	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof Post) {
			
			Post post = (Post) entity;			
			String sql = "INSERT INTO post(userId, title, content) VALUES(?, ?, ?)";
			Object[] args = { post.getUserId(), post.getTitle(), post.getContent() };
			
			return JDBCTools.create(JDBCTools.getConnect(), sql, args);
		} else {
			return ENTITY_FAIL;
		}
	}

	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "post", id);
		} else {
			return NONE;
		}
	}

	@Override
	public Object update(Object entity) {
		if (entity != null && entity instanceof Post) {
			Post post = (Post) entity;
			Post oldUserInfo = (Post) findById(post.getId());
			if (oldUserInfo == null) {
				return NONE;
			} else {
				String sql = "UPDATE post set title=?, content=? , modifyTime =? where id=? ;";
				Object[] args = { post.getTitle(), 
						post.getContent(),
						new Timestamp(new Date().getTime()),
						post.getId() };

				return JDBCTools.update(JDBCTools.getConnect(), sql, args);
			}
		} else {
			return ENTITY_FAIL;
		}
	}

	@Override
	public Object findById(long id) {		
		return JDBCTools.findById(JDBCTools.getConnect(), "post", id, Post.class);
	}

	@Override
	public List<Object> findAll(Object... args) {
		// TODO Auto-generated method stub
		return null;
	}

}
