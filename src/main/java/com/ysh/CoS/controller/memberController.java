package com.ysh.CoS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

import com.ysh.CoS.dto.memberDTO;
import com.ysh.CoS.service.memberService;

import lombok.RequiredArgsConstructor;

@Controller 
@RequiredArgsConstructor
public class memberController {

	private final memberService service;
	
	@RequestMapping(value = "/index")
	public String index() {
		return "index";
	}
	
	@GetMapping("/member/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/member/loginOk")
	public String loginOk(String id, String password, HttpSession session, memberDTO member) {
		
		member = service.loginCheck(id,password);
		
		if (member != null) {
			String mSeq = member.getMSeq();
			session.setAttribute("mSeq",mSeq);
			session.setAttribute("id", id);
			
			return "redirect:/index";
			
		} else { 
			return "redirect:/member/login"; 
		}
	}
}
