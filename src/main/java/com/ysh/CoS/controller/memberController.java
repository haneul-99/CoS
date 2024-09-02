package com.ysh.CoS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpSession;

import com.ysh.CoS.dto.memberDTO;
import com.ysh.CoS.service.memberService;

import lombok.RequiredArgsConstructor;

@Controller 
@RequiredArgsConstructor
public class memberController {

	private final memberService service;
	
	@GetMapping("/index")
	public String index() {
		return "index";
	}
	
	@GetMapping("/member/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/member/loginOk")
	public String loginOk(String id, String password, HttpSession session, Model model) {
		
		memberDTO dto = service.loginCheck(id,password);
		
		if (dto != null) {
			String mSeq = dto.getMSeq();
			session.setAttribute("mSeq",mSeq);
			session.setAttribute("id", id);
			
			return "redirect:/index";
			
		} else { 
			return "redirect:/member/login"; 
		}
	}
	
	@GetMapping("/member/logout")
	public String logout(HttpSession session) {
		
		session.removeAttribute("mSeq");		
		session.removeAttribute("id");
		
		return "redirect:/index";
	}
}
