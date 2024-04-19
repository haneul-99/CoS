package com.ysh.CoS.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ysh.CoS.dto.interviewDTO;

@Mapper
public interface interviewMapper {

	List<interviewDTO> interviewList();
	
	/*
	List<Map<String, Object>> interviewList(Map<String, Object> search);

	int interviewCnt(Map<String, Object> search);
	*/
	

}
