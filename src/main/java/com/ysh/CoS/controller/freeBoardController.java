package com.ysh.CoS.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ysh.CoS.dto.boardDTO;
import com.ysh.CoS.dto.memberDTO;
import com.ysh.CoS.service.freeBoardService;

import jakarta.servlet.http.HttpServletRequest;
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
	public String write(HttpSession session, Model model) {
		
		String mSeq = (String)session.getAttribute("mSeq");
		String nickName = service.getNickName(mSeq);
		
		model.addAttribute("nickName", nickName);
		return "freeBoard/write";
	}
	
	@PostMapping("/writeOk")
	public String writeOk(HttpSession session, HttpServletRequest req) {

		boardDTO dto = new boardDTO();
		
		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) req;
		
		String mSeq = (String) session.getAttribute("mSeq");
		String bTitle = multi.getParameter("bTitle");
		String bContent = multi.getParameter("editorTxt");
		String fileName = null;
		MultipartFile file = multi.getFile("file");
		
		if (!file.isEmpty()) {
			
			//파일 업로드 완료 > 파일이 어디 있는지? > 임시 폴더에 저장 > 우리가 원하는 폴더로 이동 
			fileName = file.getOriginalFilename();
			String path = "C:\\Users\\snow9\\OneDrive\\문서\\GitHub\\CoS\\src\\main\\resources\\static\\freeBoardImg";
		
			System.out.println(path);
		
			//파일명 중복 방지
			fileName = getFileName(path, fileName);
		
			//파일 이동 
			File file2 = new File(path + "\\" + fileName);
		
			try {	//이걸 안하면 임시 폴더에 저장됨 
			
				file.transferTo(file2); //이동할 파일 넣어주면 임시폴더에 저장된 파일이 원하는 폴더의 이름으로 이동 
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		dto.setMSeq(mSeq);
		dto.setBTitle(bTitle);
		dto.setBContent(bContent);
		dto.setBFile(fileName);
			
		int result = service.addFreeBoard(dto);

		if (result == 1) {
			return "redirect:/freeBoard/list";
		} else {
			return "freeBoard/write";
		}
	
	}

	private String getFileName(String path, String fileName) {
		
		//저장할 폴더내의 파일명을 중복되지 않게 만들기
		//path = "resource/static/fileImg"
		//fileName = "test.txt"
		
		//test.txt > test(1).txt > test(2).txt
		int n = 1; //인덱스 숫자
		int index = fileName.lastIndexOf("."); //확장자 위치
		
		String tempName = fileName.substring(0, index);	//"test"
		String tempExt = fileName.substring(index);		//".txt"
		
		while (true) { //이름과 똑같은애가 몇개인지 몰라서(몇번의 작업을 할지 몰라서) 무한루프돔 
			
			File file = new File(path + "\\" + fileName);
			
			if (file.exists()) { //경로에 파일이 존재하는지 확인
				//있다. > 중복 > 파일명 변경
				fileName = String.format("%s(%d)%s", tempName, n, tempExt);
				n++;
			} else {
				//없다. > 사용 가능한 파일명
				return fileName;
			}
		}
	}
	
	@GetMapping("/edit/{bSeq}") 
	public String edit(HttpSession session, Model model, @PathVariable String bSeq) {
		
		boardDTO dto = service.getEditInfo(bSeq);
		
		model.addAttribute("dto", dto);
		
		System.out.println(dto);
			
		return "freeBoard/edit";
			
	}
	
	@PostMapping("/editOk")
	public String editOk(HttpSession session, HttpServletRequest req) {

		boardDTO dto = new boardDTO();
		
		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) req;
		
		String mSeq = (String) session.getAttribute("mSeq");
		String bTitle = multi.getParameter("bTitle");
		String bContent = multi.getParameter("editorTxt");
		String bFile1 = multi.getParameter("bFile1");
		String bSeq = multi.getParameter("bSeq");
		String fileName = null;
		
		Boolean flag = false;	//파일 그대로 유지 여부
		
		MultipartFile file = multi.getFile("file");
		
		if (!file.isEmpty()) {
			
			//파일 업로드 완료 > 파일이 어디 있는지? > 임시 폴더에 저장 > 우리가 원하는 폴더로 이동 
			fileName = file.getOriginalFilename();
			String path = "C:\\Users\\snow9\\OneDrive\\문서\\GitHub\\CoS\\src\\main\\resources\\static\\freeBoardImg";
		
			System.out.println(path);
		
			//파일명 중복 방지
			fileName = getFileName(path, fileName);
		
			//파일 이동 
			File file2 = new File(path + "\\" + fileName);
		
			try {	//이걸 안하면 임시 폴더에 저장됨 
			
				file.transferTo(file2); //이동할 파일 넣어주면 임시폴더에 저장된 파일이 원하는 폴더의 이름으로 이동 
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		
		dto.setBSeq(bSeq);
		dto.setMSeq(mSeq);
		dto.setBTitle(bTitle);
		dto.setBContent(bContent);
		dto.setBFile(fileName);
		
		if (bFile1 != null && file.isEmpty()) { //파일 수정X > 원본 유지 
			flag = true;
		} 
			
		int result = service.editFreeBoard(dto, flag);

		if (result == 1) {
			return "redirect:/freeBoard/listDetail/" + bSeq ;
		} else {
			return "redirect:/freeBoard/edit/" + bSeq;
		}
	
	}
	
}
