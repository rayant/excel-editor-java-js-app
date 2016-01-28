package com.xml_tables_task.rest;

import com.google.gson.Gson;
import com.xml_tables_task.model.XlsTable;
import com.xml_tables_task.service.interfaces.XlsTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by RAYANT on 26.01.2016.
 */


@RestController
public class XlsTableRestController {

    @Autowired
    private XlsTableService xlsTableService;


    @RequestMapping(value = "/read/all", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<XlsTable>> listAll() {
        List<XlsTable> result = xlsTableService.listAll();
        if (result.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public void save(@RequestBody String tableJson) {
        Gson gson = new Gson();
        XlsTable xlsTable = gson.fromJson(tableJson, XlsTable.class);
        xlsTableService.save(xlsTable);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public void delete(@RequestBody String tableJson) {
        Gson gson = new Gson();
        XlsTable xlsTable = gson.fromJson(tableJson, XlsTable.class);
        xlsTableService.delete(xlsTable);
    }
}
