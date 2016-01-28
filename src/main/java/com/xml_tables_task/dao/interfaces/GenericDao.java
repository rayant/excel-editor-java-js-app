package com.xml_tables_task.dao.interfaces;

import java.io.Serializable;
import java.util.List;

/**
 * Created by RAYANT on 16.01.2016.
 */
public interface GenericDao<PK extends Serializable, T> {

    T findById(PK id);

    void save(T entity);

    void  delete(T entity);

    List<T> listAll();

}
