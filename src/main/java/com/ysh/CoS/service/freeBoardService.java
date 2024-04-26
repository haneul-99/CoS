package com.ysh.CoS.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ysh.CoS.dto.boardDTO;
import com.ysh.CoS.mapper.freeBoardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class freeBoardService {
	
	private final freeBoardMapper freeBoardMapper;

	public List<boardDTO> list(Map<String, String> map) {
		
		return freeBoardMapper.list(map);
	}

	public int getTotalCount() {
		
		return freeBoardMapper.getTotalCount();
	}


}
