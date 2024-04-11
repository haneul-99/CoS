package com.ysh.CoS.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ysh.CoS.dto.boardDTO;

@Mapper
public interface freeBoardMapper {

	List<boardDTO> selectList();

}
