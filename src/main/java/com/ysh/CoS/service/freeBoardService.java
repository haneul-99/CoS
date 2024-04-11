package com.ysh.CoS.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ysh.CoS.dto.boardDTO;
import com.ysh.CoS.mapper.freeBoardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class freeBoardService {
	
	private final freeBoardMapper freeBoardMapper;

	public List<boardDTO> selectList() {
		
		return freeBoardMapper.selectList();
	}

}
