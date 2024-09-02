package com.ysh.CoS.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ysh.CoS.dto.boardDTO;

@Mapper
public interface freeBoardMapper {

	List<boardDTO> list(Map<String, String> map);

	List<boardDTO> listSingleSearch(Map<String, String> map);

	List<boardDTO> listAllSearch(Map<String, String> map);

	int getTotalCount(Map<String, String> map);

	int getSingleSearchCount(Map<String, String> map);

	int getAllSearchCount(Map<String, String> map);

	boardDTO getBoardInfo(String bSeq);
	
	int increaseCount(@Param("bSeq")String bSeq, @Param("count")String count);

	int flagLike(@Param("bSeq")String bSeq, @Param("mSeq")String mSeq);

	int addLike(@Param("mSeq")String mSeq, @Param("bSeq")String bSeq);

	int removeLike(@Param("mSeq")String mSeq, @Param("bSeq")String bSeq);
}
