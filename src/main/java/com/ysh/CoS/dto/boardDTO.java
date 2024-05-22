package com.ysh.CoS.dto;

import lombok.Data;

@Data
public class boardDTO {
	private String bSeq;		//자유게시판 번호 
	private String mSeq;		//회원번호 
	private String bTitle;		//제목 
	private String bContent;	//내용 
	private String bDate;		//작성일 
	private String bCount;		//조회수 
	private String bFile;		//첨부파일 
	
	private String nickName;	//작성자
	private String bNo;			//글 번호
}
