package com.ysh.CoS.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	@GetMapping(value="/interviewList")
	public String interviewPage(String search,String word, Model model, @PageableDefault(value = 10) Pageable page) {

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
        
		return "/interview/interviewList";
       
	}
	
	/* 면접후기게시판 상세조회 */
	@GetMapping(value="/detail/{iSeq}")
	public String detail(@PathVariable("iSeq") String iSeq, Model model, HttpSession session) {
		interviewDTO listDetail = interviewService.listDetail(iSeq);
		List<intCmtDTO> listCmt = interviewService.listCmt(iSeq);
		int IntCmtCount = interviewService.IntCmtCount(iSeq);
		session.getAttribute("id");
		model.addAttribute("listCmt", listCmt);
		model.addAttribute("listDetail", listDetail);
		model.addAttribute("IntCmtCount", IntCmtCount);
		//System.out.println("listDetail: "+ listDetail);
		//System.out.println("listCmt: " + listCmt);
		return "/interview/interviewDetail";
	}
	
	/* 게시글 작성 */
	@GetMapping(value="/write")
	public String write(HttpSession session, Model model) {
		String mSeq = (String) session.getAttribute("mSeq");
		String nickName = interviewService.nickName(mSeq);
		model.addAttribute("nickName", nickName);
		return "/interview/interviewWrite";
		
	}
	
	@PostMapping(value="/writeForm")
	public String writeForm(interviewDTO interview, MultipartHttpServletRequest request, HttpSession session) {
		
		String iTitle = request.getParameter("iTitle");
		String iContent = request.getParameter("editorTxt");
		String fileName = "";
		MultipartFile file = request.getFile("file");
		
		if(!file.isEmpty()) {
			fileName = file.getOriginalFilename();
			String filePath = "/Users/kimhaneul/Documents/GitHub/CoS/bin/main/static/interviewImg/";
			
			fileName = uploadFile(filePath, fileName);
			
			File save = new File(filePath + "//" + fileName);
			
			try {
				file.transferTo(save);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		interview.setMSeq((String)session.getAttribute("mSeq"));
		interview.setITitle(iTitle);
		interview.setIContent(iContent);
		interview.setIFile(fileName);
		
		//mybatis insert는 int로 return 해야함
		int result = interviewService.writeInterview(interview);
		
		if (result == 1) {
			return "redirect:/interview/interviewList";
		} else {
			return "/interview/writeForm";
		}
	}
	
	private String uploadFile(String filePath, String fileName) {
		
		return null;
	}

	/* 게시판 댓글 작성 */
	@GetMapping(value="/writeCmt")
	public String writeCmt(intCmtDTO intCmt, HttpSession session, String iSeq) {
		
	    intCmt.setIcSeq(intCmt.getIcSeq());
	    intCmt.setIcContent(intCmt.getIcContent());
	    intCmt.setMSeq((String)session.getAttribute("mSeq"));
	    intCmt.setISeq(iSeq);
		
		interviewService.writeCmt(intCmt);

		return "redirect:/interview/interviewList";
	}
	
	/* 게시판 댓글 삭제 */
	@PostMapping(value="/delComment/{icSeq}")
	public String delComment(intCmtDTO intCmt, @PathVariable("icSeq") String icSeq, String iSeq) {
		int result = interviewService.delComment(icSeq);
		System.out.println(result);
		return "redirect:/interview/interviewList";
	}
}