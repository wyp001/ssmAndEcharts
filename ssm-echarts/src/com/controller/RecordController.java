package com.controller;


import com.po.Record;
import com.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
@RequestMapping(value = "/echarts")
public class RecordController {
    @Autowired
    private RecordService recordService;

    @RequestMapping(value = "/record")
    public @ResponseBody  Object getRecord(){
        List<Record> list=recordService.selecMore();
            return list;
    }
    @RequestMapping(value ="/test")
    public String into(){
        return "echarts/showInfoIndex";
    }
}