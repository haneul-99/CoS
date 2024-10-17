package com.ysh.CoS.dto;

import lombok.Data;

@Data
public class intCmtDTO {
	private String icSeq;			//댓글번호 
	private String mSeq;			//회원번호 
	private String iSeq;			//면접 후기 번호 
	private String icDate;			//작성일
	//private String step;			//순서
	//private String deps;			//대댓글
	private String parentIdx;		//부모 댓글
	private String icContent;		//댓글내용
	
	private String name;			//회원이름
	private String iNum;			//번호(순위함수)
	private String img;				//회원 프로필
	private String nickName;		//닉네임
	private String auth;			//권한 1-주니어 개발자, 2-시니어 개발자
	private String id;				//회원아이디
	private String regDate; 		//몇분전, 몇시간전, 몇일전
}
