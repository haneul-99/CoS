package com.ysh.CoS.service;

import org.springframework.stereotype.Service;

import com.ysh.CoS.mapper.memberMapper;

import com.ysh.CoS.model.member.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class memberService {

	private final memberMapper memberMapper;
	
	public Member loginCheck(String id, String password) {
		
		return memberMapper.loginCheck(id,password);
	}

}
