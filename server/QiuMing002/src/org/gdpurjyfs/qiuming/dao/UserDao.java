package org.gdpurjyfs.qiuming.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.gdpurjyfs.qiuming.entity.User;
import org.gdpurjyfs.qiuming.util.*;
import org.junit.Test;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;


@SuppressWarnings("unused")
public class UserDao implements CommonDao {
	public static final String PASSWORD_FAIL = "PASSWORD_FAIL";

	public UserDao() {

	}

	// ------------------------------------------------------
	@Test
	public void testCreate() {
		User user = new User();
		user.setUsername("老王");
		user.setPassword("123456");
		user.setPickname("云老王");
		System.out.println(create(user));
	}

	@Test
	public void testfindById() {
		Object user = findById(10);
		if (user != null && user instanceof User) {
			System.out.println(user.toString());
		} else {
			System.out.println("Null Object");
		}
	}

	@Test
	public void testfindByName() {
		Object user = findByName("老王");
		if (user != null && user instanceof User) {
			System.out.println(user.toString());

		} else {
			System.out.println("Null Object");
		}
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

	@Test
	public void testupdate() {
		User user = (User) findByName("老王");
		System.out.println(user.toString());

		/* update info */

		user.setPickname("又是一个云老王");
		user.setAge(20);
		user.setAddress("秋名山下水道~");
		user.setEmail("laowang@qiuming.moe");
		user.setIntroduction("谁家娇妻守空房，我住隔壁我姓王");
		user.setTelephone("0800092000");
		user.setSex("男");
		user.setRoleId(1);

		/* update password */
		user.setPassword("123456789");

		String result = (String) update(user);

		if (result != null) {
			System.out.println(result.toString());
			user = (User) findByName("老王");
			System.out.println("修改后： " + user.toString());
		} else {
			System.out.println("update Fail");
		}
	}

	// ------------------------------------------------------
	
	public String experienceUp(User user) {
		return JDBCTools.modifyColumnById(JDBCTools.getConnect(), 
				"user", "experience", user.getExperience() + 1, user.getId());
	}
	
	public String updatePassword(User user) {
		return JDBCTools.modifyColumnById(JDBCTools.getConnect(), 
				"user", "password", user.getPassword(), user.getId());
	}

	public User findByName(String username) {
		List<User> us = JDBCTools.findByColumnName(JDBCTools.getConnect(), 
				"user", "username", username,
				User.class);
		return us != null && us.size() != 0 ? us.get(0) : null;
	}

	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof User) {
			User user = (User) entity;
			/*
			 * `username` `password` `pickname` `email` `telephone` `age`
			 * `address` `experience` `sex` `roleId` `introduction`
			 */
			String sql = "INSERT INTO user( username,password,pickname,email,telephone,"
					+ "age,address,sex,roleId, introduction) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?)";
			Object[] args = { user.getUsername(), user.getPassword(),
					user.getPickname(), user.getEmail(), user.getTelephone(),
					user.getAge(), user.getAddress(),
					// user.Experience(),
					user.getSex(), user.getRoleId(), user.getIntroduction() };
			
			return JDBCTools.create(JDBCTools.getConnect(), sql, args);
		} else {
			return CommentDao.ENTITY_FAIL;
		}

	}

	/*
	 * ENTITY_FAIL = "ENTITY_FAIL", SUCCESS = "SUCCESS", PASSWORD_FAIL =
	 * "PASSWORD_FAIL", USER_NONE = "USER_NONE", USER_DUPLICATE =
	 * "USER_DUPLICATE", UNKNOWN = "UNKNOWN", CONNECTION_FAIL =
	 * "CONNECTION_FAIL";
	 */
	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "user", id);
		} else {
			return CommentDao.NONE;
		}
	}

	@Override
	public Object update(Object entity) {
		/*
		 * long id; String username; String password; String pickname; String
		 * email; String telephone; int age; String address; long experience;
		 * String sex; long roleId; String introduction;
		 */
		if (entity != null && entity instanceof User) {
			User user = (User) entity;
			User oldUserInfo = (User) findById(user.getId());
			if (oldUserInfo == null) {
				return CommentDao.NONE;
			} else {
				String sql = "UPDATE user set pickname=?, email=?, "
						+ " telephone=?, age=?, address=?, sex=?, roleId=?, introduction=? "
						+ " where id=? ;";
				Object[] args = {  user.getPickname(), user.getEmail(), user.getTelephone(),
						user.getAge(), user.getAddress(), user.getSex(),
						user.getRoleId(), user.getIntroduction(), user.getId() };

				return JDBCTools.update(JDBCTools.getConnect(), sql, args);
			}
		} else {
			return CommentDao.ENTITY_FAIL;
		}
	}

	@Override
	public Object findById(long id) {
		User user = JDBCTools.findById(JDBCTools.getConnect(), "user", id, User.class);
		
		if(user != null) {
			// TODO 移除重要的字段
			user.setPassword("");
		}
		return user;
	}

}
