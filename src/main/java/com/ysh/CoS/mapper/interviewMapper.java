package com.ysh.CoS.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ysh.CoS.dto.intCmtDTO;
import com.ysh.CoS.dto.interviewDTO;

@Mapper
public interface interviewMapper {

	List<interviewDTO> interviewList(Map<String, Object> resultMap);

	int interviewCnt();

	List<interviewDTO> interviewSearchList(Map<String, Object> resultMap);

	int interviewSearchCnt(Map<String, Object> resultMap);

	interviewDTO listDetail(String iSeq);

	int IntCmtCount(String iSeq);

	int writeCmt(intCmtDTO intCmt);

	List<intCmtDTO> listCmt(String iSeq);

	int delComment(String string);

	String nickName(String mSeq);

	int writeInterview(interviewDTO interview);

}
