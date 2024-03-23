package com.ysh.CoS.service;

import org.springframework.stereotype.Service;

import com.ysh.CoS.dto.memberDTO;
import com.ysh.CoS.mapper.memberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class memberService {

	private final memberMapper memberMapper;

	public memberDTO loginCheck(String id, String password) {
		return memberMapper.loginCheck(id,password);
	}
	
}
