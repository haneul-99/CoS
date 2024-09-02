package com.ysh.CoS.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ysh.CoS.dto.boardDTO;
import com.ysh.CoS.dto.memberDTO;
import com.ysh.CoS.service.freeBoardService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
		
		for (boardDTO dto : list) {
			dto = service.dtoProcess(dto);
		}
		totalCount = service.getTotalCount(map);
		totalPage = (int)Math.ceil((double)totalCount / pageSize);
		
		String pagebar = service.getPagebar(map, nowPage, totalCount, totalPage, list);
		
		model.addAttribute("list", list);
		model.addAttribute("map", map);
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("nowPage", nowPage);
		
		return "freeBoard/list";
	}
	
	@GetMapping("/listDetail/{bSeq}") 
	public String listDetail(HttpSession session, Model model, @PathVariable String bSeq) {
		
		String mSeq = (String) session.getAttribute("mSeq");
		int flike = 0; 
		
		boardDTO dto = service.getBoardInfo(bSeq);
			
		dto = service.dtoProcess(dto);
		
		if (mSeq != null) {
			
			flike = service.flagLike(bSeq, mSeq);
			
			if (!mSeq.equals(dto.getMSeq())) {
				
				String scount = dto.getBCount();
				String count = Integer.parseInt(scount) + 1 + "";
				
				int result = service.increaseCount(bSeq, count);
				
				dto.setBCount(count);
				
			}
			
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("flike", flike);
			
		return "freeBoard/listDetail";
			
	}
	
	@ResponseBody
	@PostMapping("/addLike") 
	public int addLike(Model model, String mSeq, String bSeq) {
		
		int result = service.addLike(mSeq, bSeq);
		
		boardDTO dto = service.getBoardInfo(bSeq);
		dto = service.dtoProcess(dto);
		
		result = Integer.parseInt(dto.getCount());
		
		return result; 
		
	}
	
	@ResponseBody
	@PostMapping("/removeLike") 
	public int removeLike(Model model, String mSeq, String bSeq) {
		
		int result = service.removeLike(mSeq, bSeq);
		
		boardDTO dto = service.getBoardInfo(bSeq);
		dto = service.dtoProcess(dto);
		
		result = Integer.parseInt(dto.getCount());
		
		return result; 
		
	}
	
	@GetMapping("/write") 
	public String write(Model model) {
		
		return "freeBoard/write";
	}
	
	@PostMapping("/writeOk")
	public String writeOk(String nickName, String bTitle, String editorTxt, String file, HttpSession session, Model model) {
		System.out.println(nickName + " :nickName " + bTitle + " : bTitle " + editorTxt + " :editorTxt " + file + " : file");
		
		if (bTitle != "" && editorTxt != "") {
			String mSeq = (String) session.getAttribute("mSeq");
			int result = service.addBoard(mSeq, bTitle, editorTxt, file);
		} else {
			model.addAttribute("msg", "emptyCategory");
		}
		return "freeBoard/write";
	}
	
}
