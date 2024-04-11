package com.ysh.CoS.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysh.CoS.dto.boardDTO;
import com.ysh.CoS.service.freeBoardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/freeBoard")
public class freeBoardController {
	
	private final freeBoardService service;
	
	@GetMapping("/list")
	public String list(Model model) {
		
		List<boardDTO> list = service.selectList();
		
		model.addAttribute("list", list);
		
		return "freeBoard/list";
	}
	
}
