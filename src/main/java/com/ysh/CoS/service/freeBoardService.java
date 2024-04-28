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
		
		if (map.get("isSearch").equals("n")) {
		
			return freeBoardMapper.list(map);
		} else if (!map.get("search").equals("all")) {
			
			return freeBoardMapper.listSingleSearch(map);
		} else {		
			
			return freeBoardMapper.listAllSearch(map);
		}
		
	}

	public int getTotalCount(Map<String, String> map) {
		
		if (map.get("isSearch").equals("n")) {
			
			return freeBoardMapper.getTotalCount(map);
		} else if (!map.get("search").equals("all")) {
			
			return freeBoardMapper.getSingleSearchCount(map);
		} else {		
			
			return freeBoardMapper.getAllSearchCount(map);
		}
		
	}


}
