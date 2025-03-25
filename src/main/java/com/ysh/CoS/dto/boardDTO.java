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
	
	private String nickName;	//닉네임
	private String bNo;			//글 번호
	private String bCmt;		//댓글 수
	
	private String img;			//이미지
	private String auth;		//개발자 종류
	private String count;		//좋아요 수

}
