package com.ysh.CoS.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysh.CoS.dto.intCmtDTO;
import com.ysh.CoS.dto.interviewDTO;
import com.ysh.CoS.service.interviewService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value="/interview")
public class interviewController {
	
	private final interviewService interviewService;
	
	/* 면접후기게시판 페이지 */
	@GetMapping(value="/interviewPage")
	public String interviewPage(String search,String word, Model model,Pageable page) {

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
        
		return "interview/interviewPage";
       
	}
	
	/* 면접후기게시판 상세조회 */
	@GetMapping(value="/detail")
	public String detail(String iSeq, Model model, HttpSession session) {
		interviewDTO listDetail = interviewService.listDetail(iSeq);
		List<intCmtDTO> listCmt = interviewService.listCmt(iSeq);
		int IntCmtCount = interviewService.IntCmtCount(iSeq);
		session.getAttribute("id");
		model.addAttribute("listCmt", listCmt);
		model.addAttribute("listDetail", listDetail);
		model.addAttribute("IntCmtCount", IntCmtCount);
		System.out.println(listDetail);
		return "/interview/detail";
	}
	
	/* 게시판 댓글 작성 */
	@GetMapping(value="/writeCmt")
	public String writeCmt(intCmtDTO intCmt, HttpSession session, String iSeq) {
		
		LocalDateTime now = LocalDateTime.now();
	    String date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

	    intCmt.setIcSeq(intCmt.getIcSeq());
	    intCmt.setIcContent(intCmt.getIcContent());
	    intCmt.setIcDate(date);
	    intCmt.setMSeq((String)session.getAttribute("mSeq"));
	    intCmt.setISeq(iSeq);
		
		int result = interviewService.writeCmt(intCmt);
		
		return "redirect:/interview/detail?iSeq=" + iSeq;
	}
	
	/* 게시판 댓글 삭제 */
	@PostMapping(value="/delComment")
	public String delComment(intCmtDTO intCmt, String icSeq, String iSeq) {
		int result = interviewService.delComment(icSeq);
		System.out.println(result);
		return "redirect:/interview/detail?iSeq=" + iSeq;
	}
}