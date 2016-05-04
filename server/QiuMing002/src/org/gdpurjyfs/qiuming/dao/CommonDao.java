package org.gdpurjyfs.qiuming.dao;

import java.util.List;

public interface CommonDao {
	public Object create(Object entity);

	public Object delete(long id);

	public Object update(Object entity);

	public Object findById(long id);

	/*
	 * 获取列表
	 * index 请求开始的位置
	 * size 请求的大小
	 * count 总共的大小
	 * */
	public List<Object> findAll(Object... args);

	public static final String ENTITY_FAIL = "ENTITY_FAIL",
			SUCCESS = "SUCCESS", NONE = "NONE", DUPLICATE = "DUPLICATE",
			UNKNOWN = "UNKNOWN", CONNECTION_FAIL = "CONNECTION_FAIL";
}