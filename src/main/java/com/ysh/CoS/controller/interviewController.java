package com.ysh.CoS.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysh.CoS.dto.interviewDTO;
import com.ysh.CoS.service.interviewService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value="/interview")
public class interviewController {
	
	private final interviewService interviewService;
	
	/* 면접후기게시판 페이지 */
	@GetMapping(value="/interviewPage")
	public String interviewPage(Model model) {
		
		List<interviewDTO> interview = interviewService.interviewList();
		
		model.addAttribute("interviewList", interview);
		
		return "/interview/interviewPage";
	}
	 
	/*
	@GetMapping(value="/interviewPage")
	public Map<String, Object> interviewPage(@RequestParam Map<String, Object> search, Model model, @PageableDefault(value = 10) Pageable page) {
		Map<String,Object> resultMap =new HashMap<String, Object>();
		Page<Map<String, Object>> result = interviewService.interviewList(search, page);
		resultMap.put("pages", result);
		resultMap.put("size", page.getPageSize());
		return resultMap;
	}
	*/
}
