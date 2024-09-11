package com.ysh.CoS.service;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ysh.CoS.dto.boardDTO;
import com.ysh.CoS.mapper.freeBoardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class freeBoardService {
	
	private final freeBoardMapper freeBoardMapper;

	public String getIsSearch(String search, String word) {

		String isSearch = "n";
		
		if (search == null || word == null || word.equals("")) {
			isSearch = "n";
		} else {
			isSearch = "y";
		}
		
		return isSearch;
	}
	
	public List<boardDTO> list(Map<String, String> map) {
		
		if (map.get("isSearch").equals("n")) {
		
			return freeBoardMapper.list(map);
		} else if (!map.get("search").equals("all")) {
			
			return freeBoardMapper.listSingleSearch(map);
		} else {		
			
			return freeBoardMapper.listAllSearch(map);
		}
		
	}

	public int getTotalCount(Map<String, String> map) {
		
		if (map.get("isSearch").equals("n")) {
			
			return freeBoardMapper.getTotalCount(map);
		} else if (!map.get("search").equals("all")) {
			
			return freeBoardMapper.getSingleSearchCount(map);
		} else {		
			
			return freeBoardMapper.getAllSearchCount(map);
		}
		
	}

	public String getPagebar(Map<String, String> map, int nowPage, int totalCount, int totalPage, List<boardDTO> list) {
		
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
			
		} else {	//isSearch가 "y"인 경우(=검색어가 있는 경우)
			
			String word = map.get("word").trim();	//단어 앞뒤 공백제거 처리
			map.put("word", word);
			
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
			
			if (map.get("search").equals("bTitle")) {
				for (boardDTO dto : list) {
					String title = dto.getBTitle();
					
					title = title.replace(map.get("word"), "<span style=\"background-color: gold; color: tomato;\">" + map.get("word") + "</span>");
					dto.setBTitle(title);
				}
			} else if (map.get("search").equals("nickName")) {
				for (boardDTO dto : list) {
					String name = dto.getNickName();
					
					name = name.replace(map.get("word"), "<span style=\"background-color: gold; color: tomato;\">" + map.get("word") + "</span>");
					dto.setNickName(name);
				}
			} else if (map.get("search").equals("bContent")) {
				for (boardDTO dto : list) {
					String content = dto.getBContent();
					
					content = content.replace(map.get("word"), "<span style=\"background-color: gold; color: tomato;\">" + map.get("word") + "</span>");
					dto.setBContent(content);
				}
			} else {
				for (boardDTO dto : list) {
					String title = dto.getBTitle();
					String name = dto.getNickName();
					String content = dto.getBContent();
					
					title = title.replace(map.get("word"), "<span style=\"background-color: gold; color: tomato;\">" + map.get("word") + "</span>");
					name = name.replace(map.get("word"), "<span style=\"background-color: gold; color: tomato;\">" + map.get("word") + "</span>");
					content = content.replace(map.get("word"), "<span style=\"background-color: gold; color: tomato;\">" + map.get("word") + "</span>");
				
					dto.setBTitle(title);
					dto.setNickName(name);
					dto.setBContent(content);
				}
			}
			
		}
		
		return pagebar;
	}

	public boardDTO getBoardInfo(String bSeq) {
		
		return freeBoardMapper.getBoardInfo(bSeq);
	}

	public boardDTO dtoProcess(boardDTO dto) {
	
		if (dto.getAuth() == "1") dto.setAuth("주니어 개발자");
		else dto.setAuth("시니어 개발자");
		
		String date = dto.getBDate();
		int year = Integer.parseInt(date.substring(0, 4));
		int month = Integer.parseInt(date.substring(5, 7)) - 1;	//month는 0~11
		int day = Integer.parseInt(date.substring(8, 10));
		
		int hour =  Integer.parseInt(date.substring(11, 13));
		int min =  Integer.parseInt(date.substring(14, 16));
		int sec =  Integer.parseInt(date.substring(17));
		
		
		Calendar nowDate = Calendar.getInstance();
		Calendar bDate = Calendar.getInstance();
		bDate.set(year, month, day, hour, min, sec);
		
		long time = nowDate.getTimeInMillis() - bDate.getTimeInMillis();
		
		int weekDay = (int)(time / 1000 / 60 / 60 / 24); 
		int weekMin = (int)(time / 1000 / 60); 
		
		if (weekDay < 1) {
			
			if (weekMin < 1) {
				dto.setBDate("방금 전");
			} else if (weekMin < 60) {
				dto.setBDate(weekMin + "분 전");
			} else {
				dto.setBDate("1일 전");
			}
			
		} else if (weekDay <= 14) {
			dto.setBDate(weekDay + "일 전");
		} else {
			dto.setBDate(date.substring(0, 10));
		}
		
		return dto;
	}

	public int increaseCount(String bSeq, String count) {
		
		return freeBoardMapper.increaseCount(bSeq, count);
	}

	public int flagLike(String bSeq, String mSeq) {
		
		return freeBoardMapper.flagLike(bSeq, mSeq);
	}

	public int addLike(String mSeq, String bSeq) {
		
		return freeBoardMapper.addLike(mSeq, bSeq);
	}

	public int removeLike(String mSeq, String bSeq) {
		
		return freeBoardMapper.removeLike(mSeq, bSeq);
	}

	public int addFreeBoard(boardDTO dto) {
		
		return freeBoardMapper.addFreeBoard(dto);
	}

	public String getNickName(String mSeq) {
		
		return freeBoardMapper.getNickName(mSeq);
	}

	public boardDTO getEditInfo(String bSeq) {
		
		return freeBoardMapper.getEditInfo(bSeq);
	}

	public int editFreeBoard(boardDTO dto, Boolean flag) {
		
		if (flag) {
			return freeBoardMapper.editNFreeBoard(dto);
		} else {
			return freeBoardMapper.editFreeBoard(dto);
		}
	}

	public String getFileNamed(String bSeq) {

		return freeBoardMapper.getFileNamed(bSeq);
	}

	
}
