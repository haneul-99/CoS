package com.ysh.CoS.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ysh.CoS.dto.bCmtDTO;
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
	
	String getLogImg(String mSeq);

	int flagLike(@Param("bSeq")String bSeq, @Param("mSeq")String mSeq);

	int addLike(@Param("mSeq")String mSeq, @Param("bSeq")String bSeq);

	int removeLike(@Param("mSeq")String mSeq, @Param("bSeq")String bSeq);

	int addFreeBoard(boardDTO dto);

	String getNickName(String mSeq);

	boardDTO getEditInfo(String bSeq);

	int editNFreeBoard(boardDTO dto);

	int editFreeBoard(boardDTO dto);

	String getFileNamed(String bSeq);

	int delBgood(String bSeq);
	
	int delBcmt(String bSeq);
	
	int delBoard(String bSeq);

	Object selectBcRef(String bSeq);

	int addFirstComment(bCmtDTO dto);

	List<bCmtDTO> getCommentList(String bSeq);

	int getMaxStep(bCmtDTO dto);

	String getRank(bCmtDTO dto);
	
	Object getNextbcSeq(@Param("bSeq") String bSeq, @Param("rank") String rank, @Param("bcRef") String bcRef);
	
	Object getNextBcLevel(Object bcSeq);

	int updateIncBcStep(bCmtDTO nextdto);

	int addSubComment(bCmtDTO dto);

	bCmtDTO getBcmtInfo(bCmtDTO nextdto);

	bCmtDTO getNextRankBcmtInfo(bCmtDTO nextdto);

	int updateDell(String bcSeq);

}
