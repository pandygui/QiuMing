package org.gdpurjyfs.qiuming.dao;

import java.util.List;

public interface CommonDao {    
    public Object create(Object entity);
    public Object delete(long id);
    public Object update(Object entity);
    public Object findById(long id);
    public List<Object> findAll(Object ... args);
    
}