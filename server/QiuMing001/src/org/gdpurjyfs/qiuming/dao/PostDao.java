package org.gdpurjyfs.qiuming.dao;

import java.util.List;

public class PostDao implements CommonDao {
	
	public PostDao() {
		
	}

	@Override
	public Object create(Object entity) {
		// TODO Auto-generated method stub
		// 判断是否为 Post 
		// 除了 id, time, modifytime 之外都要处理
		return null;
	}

	@Override
	public Object delete(long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object update(Object entity) {
		// TODO Auto-generated method stub
		// 1. 检查 entity 是否为 Post
		// 2. 除了 state ，user_id ， time 都要修改
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
	
}
