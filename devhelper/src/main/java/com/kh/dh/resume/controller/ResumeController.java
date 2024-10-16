package com.kh.dh.resume.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.dh.resume.model.service.ResumeServiceImpl;

@Controller
public class ResumeController {
	@Autowired
	private ResumeServiceImpl rService;
	
	@RequestMapping("resume.re")
	public String toResume() {
		return "resume/resumeListView";
		
	}

}
