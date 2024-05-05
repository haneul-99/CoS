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
	private String rnum;		//rownum 정수설정
	private String img;			//회원 프로필
}
