package com.ysh.CoS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysh.CoS.service.freeBoardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/freeBoard")
public class freeBoardController {
	
	//private final freeBoardService service;
	
	@GetMapping("/list")
	public String list() {
		return "freeBoard/list";
	}
	
}
