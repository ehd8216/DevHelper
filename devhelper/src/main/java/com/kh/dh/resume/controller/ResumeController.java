package com.kh.dh.resume.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ResumeController {
	
	@RequestMapping("resume.re")
	public String toResume() {
		return "resume/resumeListView";
	}
	

}
