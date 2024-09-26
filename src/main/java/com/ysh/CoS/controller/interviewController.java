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

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
	public String detail(@PathVariable("iSeq") String iSeq, Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		interviewDTO listDetail = interviewService.listDetail(iSeq);
		List<intCmtDTO> listCmt = interviewService.listCmt(iSeq);
		int IntCmtCount = interviewService.IntCmtCount(iSeq);
		
		Cookie[] cookies = request.getCookies();
		Cookie oldCookie = null;
		int iCount = 0;
		
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("interviewDetail")) { //interviewDetail이라는 값이 있을 경우 oldCookie에 넣어줌
					oldCookie = cookie;
				}
			}
		} 
		
		if(oldCookie != null) {
			if(!oldCookie.getValue().contains(iSeq)) {	//해당 게시판번호를 가지고 있다면 조회수 증가 X
				iCount = interviewService.viewCount(iSeq);
				oldCookie.setValue(oldCookie.getValue() + "[" + iSeq + "]"); //게시판번호 [10] [101] 정확하게 구분하기 위해 괄호 사용
				oldCookie.setMaxAge(60 * 60 * 2);
				response.addCookie(oldCookie);
				System.out.println("방문기록 아이디 " + oldCookie.getName());
			}
		} else {
			iCount = interviewService.viewCount(iSeq);
			Cookie newCookie = new Cookie("interviewDetail","[" + iSeq + "]");
	        newCookie.setMaxAge(60 * 60 * 24);
	        response.addCookie(newCookie);
		}
		
		session.getAttribute("id");
		model.addAttribute("listCmt", listCmt);
		model.addAttribute("listDetail", listDetail);
		model.addAttribute("IntCmtCount", IntCmtCount);

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
			return "/interview/interviewWrite";
		}
	}
	
	private String uploadFile(String filePath, String fileName) {
		
		int n = 1;  //인덱스 숫자
		int index = fileName.lastIndexOf("."); //확장자 위치
		
		String tempName = fileName.substring(0, index);  //"test"
		String tempExt = fileName.substring(index);		//".txt"
		
		while(true) {
			
			File file = new File(filePath + "\\" + fileName);
			
			if (file.exists()) {
				//있다. > 중복 > 파일명 변경
				fileName = String.format("%s(%d).%s", tempName, n, tempExt);
				n++;
			} else {
				//없다. > 사용 가능한 파일명
				return fileName;
			}
		}
	}
	
	/* 게시글 수정 */
	@GetMapping(value="/edit/{iSeq}")
	public String edit(@PathVariable("iSeq") String iSeq, Model model) {
		
		interviewDTO interview = interviewService.writeDetail(iSeq);
		
		model.addAttribute("interview", interview);
		
		return "/interview/interviewEdit";
	}
	
	@PostMapping(value="/editForm")
	public String editForm(interviewDTO interview, MultipartHttpServletRequest request, HttpSession session, String iSeq) {
		
		String iTitle = request.getParameter("iTitle");
		String iContent = request.getParameter("editorTxt");
		String fileName = "";
		MultipartFile file = request.getFile("file");
		
		//첨부파일 수정 코딩 작성
		if(file.getOriginalFilename().equals("")) {
			//새 파일이 없을 때
			interview.setIFile(interview.getIFile());
		} else if (file.getOriginalFilename() != null) {
			if(file.getOriginalFilename().equals(interview.getIFile())) {
				//새 파일이 있을 때
				File iFile = new File(interview.getIFile());
				
				if(iFile.exists()) {
					iFile.delete(); //파일 삭제 - File 객체에 .delete()메소드
				}
			}
		}
		
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
		
		int result = interviewService.editInterview(interview);
		
		if (result == 1) {
			return "redirect:/interview/interviewList";
		} else {
			return "/interview/interviewEdit/" + iSeq;
		}
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