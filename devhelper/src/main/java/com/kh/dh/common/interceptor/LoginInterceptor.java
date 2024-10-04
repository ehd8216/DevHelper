package com.kh.dh.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object Handler) throws Exception {
		// true 리턴시 => 기존 요청 흐름대로 Controller 제대로 실행
		// false 리턴시 => Controller 실행되지 않음
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginUser") != null) {
			// 현재 요청을 보낸 사람이 로그인이 되어있을 경우 => Controller 실행
			return true;
		}else {
			// 로그인이 되어있지 않을 경우 => Controller 실행 x
			session.setAttribute("alertMsg", "로그인 후 이용가능한 서비스입니다.");
			response.sendRedirect(request.getContextPath());
			return false;
		}
		
	}

}
