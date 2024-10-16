package com.kh.dh.member.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.dh.common.model.service.GitService;
import com.kh.dh.member.model.service.MemberServiceImpl;
import com.kh.dh.member.model.vo.Member;
import com.kh.dh.repository.model.service.RepoServiceImpl;
import com.kh.dh.repository.model.vo.Repositorys;

@Controller
public class MemberController 
{
	@Autowired
	private MemberServiceImpl mService;
	
	@Autowired
	private RepoServiceImpl rService;
	
	@Autowired
	private GitService gService;
	
	
	private String token = "";
	
	@RequestMapping(value = "login.me")
	public String loginPage()
	{
		return "member/loginPage";
	}
	
	@RequestMapping(value = "callback")
	public String gitLogin(@RequestParam String code, HttpSession session) throws IOException {
		//토큰 가져오기
		String token = gService.getToken(code);
		
		//토큰으로 정보가져오기
		Member gitMember = gService.getUserInfo(token);
		
		// 이미 가입되어있는지 확인
        Member loginMember = mService.selectMember(gitMember);
        // 안되있으면 db에 추가
        if(loginMember == null) {
	    	int result = mService.insertMember(gitMember);
	    	if(result  > 0) {
	    		loginMember = mService.selectMember(gitMember);
	    		
	    		// 가입시 db에 레파지토리 입력
	    		System.out.println(loginMember.getMemNo());
	    		System.out.println(token);
	    		rService.insertRepo(loginMember.getMemNo(), token);
	    	}
        }
        else {
        	loginMember = mService.selectMember(gitMember);
        }
        session.setAttribute("loginMember", loginMember);
        session.setAttribute("token", token);
        return "redirect:/";
	}
	
	@RequestMapping("logout.me")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	@RequestMapping("mypage.me")
	public ModelAndView mypage(int memNo, ModelAndView mv) {
		Member m = mService.selectMemberDetail(memNo);
		mv.addObject("m", m)
		  .setViewName("member/myPage");
		return mv;
	}
	
}
