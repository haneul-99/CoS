package com.ysh.CoS.dto;

import lombok.Data;

@Data
public class QnADTO {
	private String qSeq;		//QnA 번호 
	private String mSeq;		//회원번호 
	private String qTitle;		//제목 
	private String qContent;	//내용 
	private String qDate;		//작성일 
	private String qCount;		//조회수 
	private String qFile;		//첨부파일 
}
