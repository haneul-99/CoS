package com.ysh.CoS.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

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

}
