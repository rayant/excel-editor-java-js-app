package com.xml_tables_task.service;

import com.xml_tables_task.dao.interfaces.XlsTableDao;
import com.xml_tables_task.model.XlsTable;
import com.xml_tables_task.service.interfaces.XlsTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by RAYANT on 26.01.2016.
 */


@Service("userService")
@Transactional
public class XlsTableServiceImpl implements XlsTableService {

    @Autowired
    private XlsTableDao dao;

    @Override
    public XlsTable findById(Integer id) {
        return dao.findById(id);
    }

    @Override
    public void save(XlsTable entity) {
        dao.save(entity);
    }

    @Override
    public void delete(XlsTable entity) {
        dao.delete(entity);
    }

    @Override
    public List<XlsTable> listAll() {
        return dao.listAll();
    }
}
