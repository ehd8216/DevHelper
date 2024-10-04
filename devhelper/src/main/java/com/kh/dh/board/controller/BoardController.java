package com.kh.dh.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.GsonFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.kh.dh.board.model.service.BoardServiceImpl;
import com.kh.dh.board.model.vo.Board;
import com.kh.dh.common.model.vo.PageInfo;
import com.kh.dh.common.template.Pagination;


@Controller
public class BoardController {
	
	@Autowired
	private BoardServiceImpl bs;

	@RequestMapping("list.bo")
	public ModelAndView selectList(@RequestParam(value="cPage", defaultValue="1") int currentPage, ModelAndView mv, Integer memNo) {
		int listCount = bs.selectListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 6);
		
		ArrayList<Board> list = bs.selectList(pi, memNo);
		
		/*
		mv.addObject("pi", pi);
		mv.addObject("list", list);
		mv.setViewName("board/boardListView");
		*/
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("board/boardListView");
		
		return mv;
		
	}
	
	@RequestMapping("enrollForm.bo")
	public String enrollForm(HttpSession session) {
		session.setAttribute("alertMsg", "게시글을 작성해보세요");
		return "board/BoardEnrollForm";
	}
	
	@ResponseBody
	@RequestMapping(value="insert.bo", produces="application/json; charset=utf-8")
	public String boardInsert(Board b, HttpSession session) {
		
	    int result = bs.insertBoard(b);
	    boolean response;

	    if (result > 0) {
	    	response = true;
	        session.setAttribute("alertMsg", "게시글이 등록되었습니다");
	    } else {
	    	response = false;
	    	session.setAttribute("errorMsg", "게시글 등록 실패");
	    }
	    
	    return new Gson().toJson(response);
	    
	}
	
	
	
	
	
	
	
	
	
}
