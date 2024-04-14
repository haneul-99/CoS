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

	

}
