package com.kh.dh.member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.dh.common.model.service.GitService;
import com.kh.dh.member.model.service.MemberServiceImpl;
import com.kh.dh.member.model.vo.Firend;
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
	@RequestMapping("update.me")
	public String updatemember(HttpServletRequest request, HttpSession session)
	{
		Member m = new Member();
		Member loginmem = (Member)session.getAttribute("loginMember");
		m.setMemIntro(request.getParameter("memIntro"));
		m.setStackName(request.getParameter("stackName"));
		m.setMemNo(loginmem.getMemNo());
		int result = mService.updatemember(m);
		if(result > 0)
		{
			session.setAttribute("alertMsg", "성공적으로 회원정보가 수정되었습니다"); 
			return "redirect:mypage.me?memNo="+loginmem.getMemNo();
		}
		else
		{
			session.setAttribute("alertMsg", "회원정보 수정에 실패 했습니다"); 
			return "redirect:mypage.me?memNo="+loginmem.getMemNo();
		}
		
				
		
	}
	@RequestMapping("userlist.me")
	public ModelAndView userlist(ModelAndView mv)
	{
		ArrayList<Member> list = mService.userlist();
		mv.addObject("list", list)
		  .setViewName("member/userlist");
		return mv;
	}
	@ResponseBody
	@RequestMapping("friend.me")
	public int  friendlist( HttpSession session, int memNo)
	{
		Member loginmem = (Member)session.getAttribute("loginMember");
		int logmemNo = loginmem.getMemNo(); //로그인 회원 번호
		Firend f = new Firend();
		f.setBfGiver(logmemNo);
		f.setBfTaker(memNo);
		System.out.println(f);
		int count = mService.checkFriendExists(f);
		System.out.println(count);
		if(count > 0) //이미 친구관계
		{
			System.out.println(count);
			return 2;
		}
		else 
		{
			int result = mService.friendlist(f);
			return result;	
		}
	}
	@RequestMapping("request.me")
    public String requestFriend(@RequestParam("currentMemberId") int currentMemberId, Model model) {
        // 받은 친구 요청
        List<Map<String, Object>> receivedRequests = mService.getReceivedRequests(currentMemberId);
        System.out.println(receivedRequests);
        model.addAttribute("receivedRequests", receivedRequests);
        // 보낸 친구 요청
        List<Map<String, Object>> sentRequests = mService.getSentRequests(currentMemberId);
        model.addAttribute("sentRequests", sentRequests);
        return "member/friend"; 
    }
	@RequestMapping("receive.me")
    public String receiveFriend(@RequestParam("memNo") int memNo, @RequestParam("action") String action, HttpSession session, Model model) {
		Member loginmem = (Member)session.getAttribute("loginMember");
		int loginmemNo = loginmem.getMemNo();
       int result = mService.receivefriend(memNo, action,loginmemNo);
       if (result > 0) { 
           if (action.equals("Y")) {
               model.addAttribute("message", "친구 요청을 수락했습니다.");
           } else {
               model.addAttribute("message", "친구 요청을 거절했습니다.");
           }
       } else { 
           model.addAttribute("message", "처리에 실패했습니다.");
          
       }
       
       return "member/friend"; // 성공 후 표시할 페이지
    }
}
