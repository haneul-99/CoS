package com.ysh.CoS.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.ysh.CoS.dto.intCmtDTO;
import com.ysh.CoS.dto.interviewDTO;
import com.ysh.CoS.mapper.interviewMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class interviewService {
	
	private final interviewMapper interviewMapper;
	
	public Page<interviewDTO> interviewList(Map<String, Object> resultMap, Pageable page) {
		List<interviewDTO> list = interviewMapper.interviewList(resultMap);
		int count = interviewMapper.interviewCnt();
		return new PageImpl<>(list, page, count);
	}
	
	public Page<interviewDTO> interviewSearchList(Map<String, Object> resultMap,
			Pageable page) {
		List<interviewDTO> searchList = interviewMapper.interviewSearchList(resultMap);
		int count = interviewMapper.interviewSearchCnt(resultMap);
		return new PageImpl<>(searchList, page, count);
	}

	public interviewDTO listDetail(String iSeq) {
		return interviewMapper.listDetail(iSeq);
	}

	public int IntCmtCount(String iSeq) {
		return interviewMapper.IntCmtCount(iSeq);
	}

	public int writeCmt(intCmtDTO intCmt) {
		return interviewMapper.writeCmt(intCmt);
	}

	public List<intCmtDTO> listCmt(String iSeq) {
		return interviewMapper.listCmt(iSeq);
	}

	public int delComment(String string) {
		return interviewMapper.delComment(string);
	}

	public String nickName(String mSeq) {
		return interviewMapper.nickName(mSeq);
	}

	public int writeInterview(interviewDTO interview) {
		return interviewMapper.writeInterview(interview);
	}

	public interviewDTO writeDetail(String iSeq) {
		return interviewMapper.writeDetail(iSeq);
	}

	public int editInterview(interviewDTO interview) {
		return interviewMapper.editInterview(interview);
	}

	public int viewCount(String iSeq) {
		return interviewMapper.viewCount(iSeq);
	}
	
}
