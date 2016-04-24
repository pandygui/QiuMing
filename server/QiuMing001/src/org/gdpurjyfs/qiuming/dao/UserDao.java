package org.gdpurjyfs.qiuming.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.gdpurjyfs.qiuming.entity.User;
import org.gdpurjyfs.qiuming.util.*;
import org.apache.commons.dbutils.QueryRunner;

public class UserDao implements CommonDao {
	private String newPassword;

	public UserDao() {

	}

	// TODO
	public User findByName(String username) {
		return null;
	}

	@Override
	public Object create(Object entity) {
		// TODO Auto-generated method stub
		if (entity instanceof User) {
			User user = (User) entity;
			Connection conn = JDBCTools.getConnect();
			QueryRunner qr = new QueryRunner();
			try {
				qr.update(conn,
						"INSERT INTO user() VALUES(?,?,?,?,?,?,?,?,?,?)",
						user.getUsername(), user.getAddress());

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
		} else {
			return null;
		}

	}

	@Override
	public Object delete(long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object update(Object entity) {
		// TODO Auto-generated method stub

		/*
		 * long id; String username; String password; String pickname; String
		 * email; String telephone; int age; String address; long experience;
		 * String sex; long roleId; String introduction;
		 */
		
		// 1. 验证 entity 的字段是否为空
		return null;
	}

	@Override
	public Object findById(long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> findAll(Object... args) {
		// TODO Auto-generated method stub
		return null;
	}
	
	//---------------------------------------------------------

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

}
