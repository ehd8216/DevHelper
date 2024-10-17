package com.kh.dh.work.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.dh.common.model.vo.PageInfo;
import com.kh.dh.common.template.Pagination;
import com.kh.dh.employmentAPI.model.vo.Scrap;
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
	
	// 상세채용공고 페이지로 이동
	@RequestMapping("detail.wo")
	private ModelAndView TodetailView(@RequestParam("sn")int sn, ModelAndView mv) {
		
		mv.addObject("sn",sn)
		  .setViewName("work/workDetailView");
		
		return mv;
	}
	
	// 자기소개서 페이지로 이동
	@RequestMapping("cover.wo")
	private String ToCover() {
		return "coverletter/coverletter";
	}
	// 스크랩 리스트페이지로 이동
	@RequestMapping("scraplist.wo")
	private ModelAndView scraplist(int memNo, ModelAndView mv)
	{
		ArrayList<Scrap> sc = wService.scraplist(memNo);
		mv.addObject("sc", sc)
		  .setViewName("work/scraplist");
		return mv;
	}
	@ResponseBody
	@RequestMapping("scrapcheck.wo")
	public List<Integer> scrapcheck(int memNo) {
	    ArrayList<Scrap> scrap = wService.scraplist(memNo);
	    List<Integer> SnList = new ArrayList<>();
	    for (Scrap sc : scrap) {
	        SnList.add(sc.getRecrutPblntSn()); // scrap 객체에서 recrutPblntSn을 추출
	    }
	    System.out.println(SnList); // 콘솔에 출력하여 확인
	    return SnList; // SnList를 JSON 형태로 반환
	}
	
	

}
