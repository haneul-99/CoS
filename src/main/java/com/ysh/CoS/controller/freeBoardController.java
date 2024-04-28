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
		
		String isSearch = "n";
		
		if (search == null || word == null || word.equals("")) {
			isSearch = "n";
		} else {
			isSearch = "y";
			word = word.trim();
		}
		
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
		
		String pagebar = "";	//페이지바 태그
		int blockSize = 10;		//한번에 보여지는 페이지 수
		int n = 0; 				//출력될 페이지 번호
		int loop = 0;			//루프 변수
		
		loop = 1;
		n = ((nowPage - 1) / blockSize) * blockSize + 1;
		
		if (map.get("isSearch") == "n") {
			
			if (n == 1) {			//nowPage가 1~10인 즉 이전페이지 해당X
				pagebar += String.format(" <a href='#!' class='page dis'>&lt;&lt;</a> ");
			} else {
				pagebar += String.format(" <a href='/freeBoard/list?page=%d' class='page'>&lt;&lt;</a> ", n - 1);
			}
			
			while (!(loop > blockSize || n > totalPage)) {
				
				if (nowPage == n) {
					pagebar += String.format(" <a href='#!' id='now' class='page dis'>%d</a> ", n);
				} else {
					pagebar += String.format(" <a href='/freeBoard/list?page=%d' class='page'>%d</a> ", n, n);
				}
				
				loop++;
				n++;
				
			}
			
			if (n > totalPage) {
				pagebar += String.format(" <a href='#!' class='page dis'>&gt;&gt;</a> ");
			} else {
				pagebar += String.format(" <a href='/freeBoard/list?page=%d' class='page'>gt;&gt;</a> ", n);
			}
			
		} else {
			
			if (n == 1) {			//nowPage가 1~10인 즉 이전페이지 해당X
				pagebar += String.format(" <a href='#!' class='page dis'>&lt;&lt;</a> ");
			} else {
				pagebar += String.format(" <a href='/freeBoard/list?search=%s&word=%s&page=%d' class='page'>&lt;&lt;</a> ", map.get("search"), map.get("word"), n - 1);
			}
			
			while (!(loop > blockSize || n > totalPage)) {
				
				if (nowPage == n) {
					pagebar += String.format(" <a href='#!' id='now' class='page dis'>%d</a> ", n);
				} else {
					pagebar += String.format(" <a href='/freeBoard/list?search=%s&word=%s&page=%d' class='page'>%d</a> ", map.get("search"), map.get("word"), n, n);
				}
				
				loop++;
				n++;
				
			}
			
			if (n > totalPage) {
				pagebar += String.format(" <a href='#!' class='page dis'>&gt;&gt;</a> ");
			} else {
				pagebar += String.format(" <a href='/freeBoard/list?search=%s&word=%s&page=%d' class='page'>gt;&gt;</a> ", map.get("search"), map.get("word"), n);
			}
			
			if (search.equals("bTitle")) {
				for (boardDTO dto : list) {
					String title = dto.getBTitle();
					
					title = title.replace(word, "<span style=\"background-color: gold; color: tomato;\">" + word + "</span>");
					dto.setBTitle(title);
				}
			} else if (search.equals("name")) {
				for (boardDTO dto : list) {
					String name = dto.getName();
					
					name = name.replace(word, "<span style=\"background-color: gold; color: tomato;\">" + word + "</span>");
					dto.setName(name);
				}
			} else if (search.equals("bContent")) {
				for (boardDTO dto : list) {
					String content = dto.getBContent();
					
					content = content.replace(word, "<span style=\"background-color: gold; color: tomato;\">" + word + "</span>");
					dto.setBContent(content);
				}
			} else {
				for (boardDTO dto : list) {
					String title = dto.getBTitle();
					String name = dto.getName();
					String content = dto.getBContent();
					
					title = title.replace(word, "<span style=\"background-color: gold; color: tomato;\">" + word + "</span>");
					name = name.replace(word, "<span style=\"background-color: gold; color: tomato;\">" + word + "</span>");
					content = content.replace(word, "<span style=\"background-color: gold; color: tomato;\">" + word + "</span>");
				
					dto.setBTitle(title);
					dto.setName(name);
					dto.setBContent(content);
				}
			}
			
		}
		
		
		model.addAttribute("list", list);
		model.addAttribute("map", map);
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("nowPage", nowPage);
		
		return "freeBoard/list";
	}
	
}
