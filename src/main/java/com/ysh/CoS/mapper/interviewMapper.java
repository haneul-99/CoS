package com.ysh.CoS.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ysh.CoS.dto.interviewDTO;

@Mapper
public interface interviewMapper {

	List<interviewDTO> interviewList();

	

}
