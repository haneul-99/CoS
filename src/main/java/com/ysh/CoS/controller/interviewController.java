package com.ysh.CoS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysh.CoS.service.interviewService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value="/interview")
public class interviewController {
	
	private final interviewService interviewService;

}
