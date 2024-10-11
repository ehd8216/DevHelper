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
import com.kh.dh.board.model.vo.CodeChunk;
import com.kh.dh.common.model.vo.PageInfo;
import com.kh.dh.common.template.Pagination;


@Controller
public class BoardController {
	
	@Autowired
	private BoardServiceImpl bs;

	@RequestMapping("list.bo")
	public ModelAndView selectList(@RequestParam(value="cPage", defaultValue="1") int currentPage, ModelAndView mv, Integer memNo, @RequestParam(value="boardLang", required=false) String boardLang, 
	        @RequestParam(value="boardAnswered", required=false) String boardAnswered) {
		
		Map<String, Object> conditions = new HashMap<String, Object>();
		conditions.put("lang", boardLang);
		conditions.put("answer", boardAnswered);
		
		int listCount = bs.selectListCount(conditions);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 6);
		
		conditions.put("memNo", memNo);
		ArrayList<Board> list = bs.selectList(pi, conditions);
		
		Map<Integer, ArrayList<CodeChunk>> codeChunksMap = new HashMap<>();

		for (Board board : list) {
		     ArrayList<CodeChunk> codeChunks = bs.selectCodeChunks(board.getBoardNo());
		     codeChunksMap.put(board.getBoardNo(), codeChunks);
		}
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("codeChunksMap", codeChunksMap)
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
		
		String code = b.getCode();
		int chunkSize = 4000;
		int chunkCount = (int)Math.ceil((double)code.length() / chunkSize);
		
	    int result = bs.insertBoard(b);
	    
	    boolean response;

	    if (result > 0) {
	    	
	    	for (int i = 0; i < chunkCount; i++) {
	    		
	    		int startIndex = i * chunkSize;
	    		int endIndex = Math.min(startIndex + chunkSize, code.length());
	    		String chunk = code.substring(startIndex, endIndex);
	    		
	    		bs.insertCodeChunk(chunk, i+1);
	    		
	    	}
	    	
	    	response = true;
	        session.setAttribute("alertMsg", "게시글이 등록되었습니다");
	        
	    } else {
	    	
	    	response = false;
	    	session.setAttribute("errorMsg", "게시글 등록 실패");
	    	
	    }
	    
	    return new Gson().toJson(response);
	    
	}
	
	@RequestMapping(value="detail.bo")
	public String boardDetailView(int bNo, Model model) {
		
		int result = bs.increaseBoardCount(bNo);
		
		if (result > 0) {
			Board b = bs.selectBoard(bNo);
			ArrayList<CodeChunk> list = bs.selectCodeChunks(bNo);
			model.addAttribute("b", b);
			model.addAttribute("list", list);
			model.addAttribute("alertMsg", bNo+"번 게시글을 조회합니다.");
			return "board/boardDetailView";
		} else {
			model.addAttribute("errorMsg", "게시글 조회 실패");
			return "community/community";
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value="viewCount.bo", produces="application/json; charset=utf-8")
	public String selectBoardByCount(HttpSession session) {
		
		ArrayList<Board> list = bs.selectBoardByCount();
		
		Map<Integer, ArrayList<CodeChunk>> codeChunksMap = new HashMap<>();

		for (Board board : list) {
		     ArrayList<CodeChunk> codeChunks = bs.selectCodeChunks(board.getBoardNo());
		     codeChunksMap.put(board.getBoardNo(), codeChunks);
		}
		
		session.setAttribute("list", list);
		session.setAttribute("codeMap", codeChunksMap);
		
		return new Gson().toJson("0");
		
	}
	
	@ResponseBody
	@RequestMapping(value="viewRandom.bo", produces="application/json; charset=utf-8")
	public String selectBoardByRandom(HttpSession session) {
		
		ArrayList<Board> list = bs.selectBoardByRandom();
		
		Map<Integer, ArrayList<CodeChunk>> codeChunksMap = new HashMap<>();
		
		for (Board board : list) {
			ArrayList<CodeChunk> codeChunks = bs.selectCodeChunks(board.getBoardNo());
			codeChunksMap.put(board.getBoardNo(), codeChunks);
		}
		
		session.setAttribute("list2", list);
		session.setAttribute("codeMap2", codeChunksMap);
		
		return new Gson().toJson("0");
		
	}
	
	
	
	
	
	
}
