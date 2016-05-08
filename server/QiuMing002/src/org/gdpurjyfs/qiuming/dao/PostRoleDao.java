package org.gdpurjyfs.qiuming.dao;

import org.gdpurjyfs.qiuming.entity.PostRole;
import org.gdpurjyfs.qiuming.util.JDBCTools;
import org.junit.Test;

public class PostRoleDao implements CommonDao {
	
	public PostRoleDao() {
		
	}
	
	//----------------------------------------------------------------------------
	@Test
	public void testcreate() {
		PostRole postRole = new PostRole();
		postRole.setRoleName("新的角色名");
		System.out.println(create(postRole));
	}
	
	@Test
	public void testdelete() {
		System.out.println(delete(4));
	}
	//----------------------------------------------------------------------------
	
	@Override
	public Object create(Object entity) {
		if (entity != null && entity instanceof PostRole) {
			
			PostRole postRole = (PostRole) entity;			
			String sql = "INSERT INTO post_role(roleName) VALUES(?)";
			Object[] args = { postRole.getRoleName()};
			
			return JDBCTools.create(JDBCTools.getConnect(), sql, args);
		} else {
			return ENTITY_FAIL;
		}
	}

	@Override
	public Object delete(long id) {
		if (findById(id) != null) {
			return JDBCTools.deleteById(JDBCTools.getConnect(), "post_role", id);
		} else {
			return NONE;
		}
	}

	@Override
	public Object findById(long id) {
		return JDBCTools.findById(JDBCTools.getConnect(), "post_role", id, PostRole.class);
	}
	
	@Override
	public Object update(Object entity) {
		// TODO Auto-generated method stub
		return null;
	}

}
