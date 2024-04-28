package com.ysh.CoS.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
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
	public String interviewPage(String search, String word, Model model, @PageableDefault(page = 0, size = 10) Pageable page) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Page<interviewDTO> list = null;
		
		resultMap.put("offset", page.getOffset());
		resultMap.put("pageSize",page.getPageSize());
		resultMap.put("search", search);
		resultMap.put("word", word);
		
		
		if(search == null) {
			list = interviewService.interviewList(resultMap,page);
		} else {
			list = interviewService.interviewSearchList(resultMap, page);
		}
		
		int nowPage = list.getPageable().getPageNumber() + 1;
	    int startPage = Math.max(nowPage - 4, 1); //Math.max를 이용해서 start 페이지가 0이하로 되는 것을 방지
	    int endPage = Math.min(nowPage + 5, list.getTotalPages()); //endPage가 총 페이지의 개수를 넘는 것을 방지

	    model.addAttribute("list", list);
	    model.addAttribute("nowPage", nowPage);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    
	    //System.out.println("PAGE SIZE : " + list.getSize());
        //System.out.println("TOTAL PAGES : " + list.getTotalPages());
        //System.out.println("TOTAL COUNT : " + list.getTotalElements());
        //System.out.println("endPage : " + list.getTotalPages());
        //System.out.println("nowPage : " + list.getPageable().getPageNumber());
        
		return "/interview/interviewPage";
       
	}
	
}
