package com.ysh.CoS.dto;

import lombok.Data;

@Data
public class memberDTO {
	private String mSeq;		//회원번호
	private String id;			//아이디 
	private String pw;			//비밀번호 
	private String nickName;	//닉네임
	private String name;		//이름 
	private String birth;		//생년월일 
	private String tel;			//전화번호 
	private String email;		//이메일 
	private String address; 	//주소 
	private String auth;		//권한
	private String img;			//프로필이미지
}
