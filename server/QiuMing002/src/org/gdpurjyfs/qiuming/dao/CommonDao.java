package org.gdpurjyfs.qiuming.dao;

public interface CommonDao {
	public Object create(Object entity);

	public Object delete(long id);

	public Object update(Object entity);

	public Object findById(long id);

	public static final String ENTITY_FAIL = "ENTITY_FAIL",
			SUCCESS = "SUCCESS", NONE = "NONE", DUPLICATE = "DUPLICATE",
			UNKNOWN = "UNKNOWN", CONNECTION_FAIL = "CONNECTION_FAIL";
}