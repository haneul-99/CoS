package com.ysh.CoS.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ysh.CoS.dto.interviewDTO;

@Mapper
public interface interviewMapper {

	List<interviewDTO> interviewList(Map<String, Object> resultMap);

	int interviewCnt();

	List<interviewDTO> interviewSearchList(Map<String, Object> resultMap);

	int interviewSearchCnt(Map<String, Object> resultMap);

	interviewDTO listDetail(String iSeq);


}
