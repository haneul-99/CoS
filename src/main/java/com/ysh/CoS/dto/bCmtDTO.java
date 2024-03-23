package com.ysh.CoS.dto;

import lombok.Data;

@Data
public class bCmtDTO {
	private String bcSeq;		//댓글번호 
	private String mSeq;		//회원번호 
	private String bSeq;		//자유게시판 번호 
	private String bcDate;		//작성일 
	private String step;		//스텝 
	private String deps;		//뎁스
	private String bcContent;	//댓글내용 
}
