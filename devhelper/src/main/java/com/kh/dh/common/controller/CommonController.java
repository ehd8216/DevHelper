package com.kh.dh.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController {

	@RequestMapping("openMonaco")
	public String openMonaco() {
		return "react-app/index";
	}
	
	@RequestMapping("toMain")
	public String toMain() {
		return "redirect:/";
	}
	
}
