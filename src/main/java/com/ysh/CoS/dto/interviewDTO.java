package com.ysh.CoS.dto;

import lombok.Data;

@Data
public class interviewDTO {
	private String iSeq;		//면접후기 번호
	private String mSeq;		//회원번호 
	private String iTitle;		//제목 
	private String iContent;	//내용 
	private String iDate;		//작성일 
	private String iCount;		//조회수
	private String iFile;		//첨부파일
	
	private String name;		//회원이름
	private String iNum;		//번호(순위함수)
	private String img;			//회원 프로필
	private String nickName;	//닉네임
	private String auth;		//권한 1-주니어 개발자, 2-시니어 개발자
	private String id;			//회원아이디
	private String regDate;		//몇분전, 몇시간전, 몇일전
	private String iGood;
}
