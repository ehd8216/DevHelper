package com.kh.dh.repository.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RepoController {
	
	@RequestMapping("myRepo.re")
	public String myRepo() {
		return "repository/repository";
	}
	
	@RequestMapping("repoDetail.re")
	public String repoDetail() {
		return "repository/repoDetail";
	}

}
