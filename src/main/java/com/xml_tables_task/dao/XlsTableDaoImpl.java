package com.xml_tables_task.dao;

import com.xml_tables_task.dao.interfaces.XlsTableDao;
import com.xml_tables_task.model.XlsTable;
import org.springframework.stereotype.Repository;

/**
 * Created by RAYANT on 26.01.2016.
 */
@Repository("xlsTableDao")
public class XlsTableDaoImpl extends AbstractDao<Integer,XlsTable> implements XlsTableDao {
}
