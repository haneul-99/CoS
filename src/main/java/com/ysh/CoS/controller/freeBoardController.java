package com.ysh.CoS.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public String list(Model model, String page, String search, String word) {
		
		String isSearch = service.getIsSearch(search, word); 
		
		int nowPage = 0;	//현재 페이지 번호(=page)
		int begin = 0;		//rnum
		int end = 0;		//rnum
		int pageSize = 10;	//한 페이지 당 출력할 게시물 수
		int totalCount = 0;	//총 게시물 수
		int totalPage = 0;	//총 페이지 수(총 게시물 수 / 한페이지 당 게시물 수)
		
		if (page == null || page == "") nowPage = 1;
		else nowPage = Integer.parseInt(page);
		
		begin = ((nowPage - 1) * pageSize) + 1;
		end = begin + pageSize - 1;
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("begin", begin + "");
		map.put("end", end + "");
		
		map.put("isSearch", isSearch);
		map.put("search", search);
		map.put("word", word);
		
		List<boardDTO> list = service.list(map);
		
		totalCount = service.getTotalCount(map);
		totalPage = (int)Math.ceil((double)totalCount / pageSize);
		
		String pagebar = service.getPagebar(map, nowPage, totalCount, totalPage, list);
		
		model.addAttribute("list", list);
		model.addAttribute("map", map);
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("nowPage", nowPage);
		
		return "freeBoard/list";
	}
	
	@GetMapping("/listDetail/{id}") 
	public String listDetail(Model model) {
		
		return "freeBoard/listDetail";
	}
	
}
