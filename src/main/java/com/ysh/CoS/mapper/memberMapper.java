package com.ysh.CoS.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ysh.CoS.model.member.Member;

@Mapper

public interface memberMapper {

	Member loginCheck(String id, String password);



}
