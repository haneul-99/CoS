package com.ysh.CoS.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ysh.CoS.dto.interviewDTO;
import com.ysh.CoS.mapper.interviewMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class interviewService {
	
	private final interviewMapper interviewMapper;
	
	
	public List<interviewDTO> interviewList() {
		return interviewMapper.interviewList();
	}
	
	
	/*
	public Page<Map<String, Object>> interviewList(Map<String, Object> search, Pageable page) {
		search.put("offset", page.getOffset());
		search.put("pageSize", page.getPageSize());

		List<Map<String, Object>> contents = interviewMapper.interviewList(search);
		int count = interviewMapper.interviewCnt(search);
		return new PageImpl<>(contents, page, count);
	}
	*/
	

}
