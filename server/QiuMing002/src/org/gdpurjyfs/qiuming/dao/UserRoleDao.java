package org.gdpurjyfs.qiuming.dao;

import org.gdpurjyfs.qiuming.entity.UserRole;
import org.gdpurjyfs.qiuming.util.JDBCTools;
import org.junit.Test;


public class UserRoleDao implements CommonDao {
	
	public UserRoleDao() {
		
	}

	//----------------------------------------------------------------------------
	@Test
	public void testcreate() {
		UserRole postRole = new UserRole();
		postRole.setRoleName("新的角色名");
		System.out.println(create(postRole));
	}
	
	@Test
	public void testdelete() {
		System.out.println(delete(7));
	}
	//----------------------------------------------------------------------------
	
	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof UserRole) {
			
			UserRole userRole = (UserRole) entity;			
			String sql = "INSERT INTO user_role(roleName) VALUES(?)";
			Object[] args = { userRole.getRoleName()};
			
			return JDBCTools.create(JDBCTools.getConnect(), sql, args);
		} else {
			return ENTITY_FAIL;
		}
	}

	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "user_role", id);
		} else {
			return NONE;
		}
	}

	@Override
	public Object findById(long id) {
		return JDBCTools.findById(JDBCTools.getConnect(), "user_role", id, UserRole.class);
	}
	
	@Override
	public Object update(Object entity) {
		// TODO Auto-generated method stub
		return null;
	}
}
