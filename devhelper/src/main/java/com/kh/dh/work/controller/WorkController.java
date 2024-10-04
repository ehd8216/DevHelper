package com.kh.dh.work.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.dh.common.model.vo.PageInfo;
import com.kh.dh.common.template.Pagination;
import com.kh.dh.work.model.service.WorkServiceImpl;
import com.kh.dh.work.model.vo.Work;


@Controller
public class WorkController {
	
	@Autowired
	private WorkServiceImpl wService;
	
	// 페이징처리 쓸데있으면 쓰기
	@RequestMapping()
	private ModelAndView selectList(@RequestParam(value = "cpage",defaultValue = "1")int currentPage, ModelAndView mv) {
		int listCount = wService.selectListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		ArrayList<Work>list = wService.selectList(pi);
		
		mv.addObject("pi",pi).addObject("list",list);
		
		return mv;
		
	}
	
	// 채용공고목록 페이지로 이동
	@RequestMapping("list.wo")
	private String ToListView() {
		return "work/workListView";
	}
	
	// 상세채용공고로 이동
	@RequestMapping("detail.wo")
	private String TodetailView() {
		return "work/workDetailView";
	}
	
	
	
	

}
