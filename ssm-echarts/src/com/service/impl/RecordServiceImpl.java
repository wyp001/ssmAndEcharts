package com.service.impl;


import com.mapper.RecordMapper;
import com.po.Record;
import com.service.RecordService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("recordService")
public class RecordServiceImpl implements RecordService {
    @Autowired
    private RecordMapper mapper;

	@Override
	public List<Record> selecMore() {
		return mapper.selecMore();
	}
  
}
