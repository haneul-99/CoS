package com.ysh.CoS.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ysh.CoS.dto.memberDTO;


@Mapper
public interface memberMapper {

	memberDTO loginCheck(@Param("id")String id, @Param("password")String password);

}
