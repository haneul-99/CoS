package com.ysh.CoS.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ysh.CoS.dto.boardDTO;

@Mapper
public interface freeBoardMapper {

	List<boardDTO> list(Map<String, String> map);

	int getTotalCount();

	

}
