package com.xml_tables_task.controller;

import com.xml_tables_task.service.interfaces.XlsTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by RAYANT on 12.01.2016.
 */

@Controller
public class Main {

    @Autowired
    private XlsTableService xlsService;

    @RequestMapping(value = {"/","/index"})
       public String main(ModelMap model) {
        return "main";
    }
}
