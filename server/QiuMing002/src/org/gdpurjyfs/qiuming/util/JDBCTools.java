package org.gdpurjyfs.qiuming.util;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.gdpurjyfs.qiuming.dao.CommentDao;

public final class JDBCTools {

	private static String driveClassName = "com.mysql.jdbc.Driver";
	private static String url = "jdbc:mysql://localhost:3306/qiuming_test?userUnicode=true&characterEncoding=UTF8";

	private static String user = "root";
	private static String password = "root";

	public static boolean existByIds(Connection conn, String tableName,
			String id1Name, String id2Name, long id1, long id2) {
		return isUnique(conn, tableName, id1Name, id2Name, id1, id2);
	}

	public static boolean isUnique(Connection conn, String tableName,
			String arg1Name, String arg2Name, Object arg1, Object arg2) {
		if (conn == null) {
			return false;
		}

		QueryRunner qr = new QueryRunner();
		String sql = "select * from " + tableName + " where " + arg1Name
				+ " = ? and " + arg2Name + "=? ;";
		Object[] args = { arg1, arg2 };

		try {
			return qr.query(conn, sql, new BeanHandler<Object>(Object.class),
					args) != null;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCTools.close(conn);
		}
	}

	public static String modifyColumnById(Connection conn, String tableName,
			String columnName, Object columnValue, long id) {
		if (conn == null) {
			return CommentDao.CONNECTION_FAIL;
		}

		QueryRunner qr = new QueryRunner();
		try {
			// update tablename set columnName = columnValue where id = id
			String sql = "update " + tableName + " set " + columnName
					+ " = ? where id = ?";
			Object[] args = { columnValue, id };
			qr.update(conn, sql, args);
		} catch (SQLException e) {
			e.printStackTrace();
			return CommentDao.UNKNOWN;
		} finally {
			JDBCTools.close(conn);
		}
		return CommentDao.SUCCESS;
	}

	public static String deleteById(Connection conn, String tableName, long id) {
		if (conn == null) {
			return CommentDao.CONNECTION_FAIL;
		}

		QueryRunner qr = new QueryRunner();
		try {
			String sql = "delete from " + tableName + " where id = ?;";
			qr.update(conn, sql, id);

		} catch (SQLException e) {
			e.printStackTrace();
			return CommentDao.UNKNOWN;
		} finally {
			JDBCTools.close(conn);
		}
		return CommentDao.SUCCESS;
	}
	
	public static <T> List<T> findByDoubleColumnName(Connection conn, String tableName,
			String column1Name, Object column1Value, 
			String column2Name, Object column2Value, 
			Class<T> clazz) {
		if (conn == null) {
			// System.out.println("get Connect fail");
			return null;
		}
		QueryRunner qr = new QueryRunner();
		String sql = "select * from " + tableName + " where " + column1Name
				+ " = ? and " + column2Name + " = ? ;";
		Object[] params = { column1Value, column2Value };

		try {
			return qr.query(conn, sql, new BeanListHandler<T>(clazz), params);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			JDBCTools.close(conn);
		}
	}

	public static <T> List<T> findByColumnName(Connection conn, String tableName,
			String columnName, Object columnValue, Class<T> clazz) {
		if (conn == null) {
			// System.out.println("get Connect fail");
			return null;
		}
		QueryRunner qr = new QueryRunner();
		String sql = "select * from " + tableName + " where " + columnName
				+ " = ?;";
		Object[] params = { columnValue };

		try {
			return qr.query(conn, sql, new BeanListHandler<T>(clazz), params);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			JDBCTools.close(conn);
		}
	}
	
	

	public static <T> T findById(Connection conn, String tableName, long id,
			Class<T> clazz) {
		List<T> l =  findByColumnName(conn, tableName, "id", id, clazz);
		return l != null && l.size() != 0 ? l.get(0) : null;
	}

	public static String update(Connection conn, String sqlString, Object[] args) {
		if (conn == null) {
			return CommentDao.CONNECTION_FAIL;
		}
		QueryRunner qr = new QueryRunner();
		try {
			qr.update(conn, sqlString, args);
		} catch (SQLException e) {
			e.printStackTrace();
			return CommentDao.UNKNOWN;
		} finally {
			JDBCTools.close(conn);
		}
		return CommentDao.SUCCESS;
	}

	public static String create(Connection conn, String sql, Object[] args) {
		if (conn == null) {
			return CommentDao.CONNECTION_FAIL;
		}
		QueryRunner qr = new QueryRunner();
		try {
			qr.update(conn, sql, args);
		} catch (SQLException e) {
			e.printStackTrace();

			// 重复插入
			if (e.getErrorCode() == 1062) {
				return CommentDao.DUPLICATE;
			} else {
				return CommentDao.UNKNOWN;
			}
		} finally {
			JDBCTools.close(conn);
		}
		return CommentDao.SUCCESS;
	}

	// TODO 设置排序
	public static <T> List<T> getRecodeListById(Connection conn, String tableName,
			String idName, long id, long index, long size, Class<T> clazz) {

		QueryRunner qr = new QueryRunner();

		// select * from post where userId = userid limit index, size;

		String sql = "select * from " + tableName + " where " + idName
				+ " = ? LIMIT ?, ? ;";
		Object[] params = { id, index, size };

		try {
			return qr.query(conn, sql, new BeanListHandler<T>(clazz), params);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			JDBCTools.close(conn);
		}
	}
	
	// 获取指定表，index , size 
	// TODO 设置排序
	public static <T> List<T> getRecodeList(Connection conn, String tableName, long index, long size, Class<T> clazz) {
		QueryRunner qr = new QueryRunner();

		// select * from post where userId = userid limit index, size;

		String sql = "select * from " + tableName +" LIMIT ?, ? ;";
		Object[] params = { index, size };
		try {
			return qr.query(conn, sql, new BeanListHandler<T>(clazz), params);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			JDBCTools.close(conn);
		}
	}
	
	public static Connection getConnect() {
		Connection conn = null;

		// load driver
		try {
			Class.forName(driveClassName);
		} catch (ClassNotFoundException e) {
			System.out.println("load driver failed!");
			e.printStackTrace();
		}

		// connect db
		try {
			conn = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			System.out.println("connect failed!");
			e.printStackTrace();
		}

		return conn;
	}

	public static void close(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
