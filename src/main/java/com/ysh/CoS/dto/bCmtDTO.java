package com.ysh.CoS.dto;

import lombok.Data;

@Data
public class bCmtDTO {
	private String bcSeq;		//댓글번호 
	private String mSeq;		//회원번호 
	private String bcDate;		//작성일 
	private String bSeq;		//자유게시판 번호 
	private String bcRef;		//글 묶음
	private String bcStep;		//순서
	private String bcLevel;		//들여쓰기
	private String bcDell;		//삭제여부
	private String bcContent;	//댓글내용 
	
	private String nickName;	//닉네임
	private String auth;		//권한
	private String img;			//이미지
}
