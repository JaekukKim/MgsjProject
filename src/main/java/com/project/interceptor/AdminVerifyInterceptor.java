package com.project.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.project.member.domain.MemberDTO;

public class AdminVerifyInterceptor extends HandlerInterceptorAdapter{
	
	// url 입력으로 관리자페이지 무단접속 방지용 인터셉터
	@Override
	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object object) throws Exception {
		
		// printWriter 글자 깨짐 방지용 인코딩
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		// 매직넘버 방지
		int adminVerifyNum = 128;

		HttpSession loginUserSession = request.getSession();
		
		MemberDTO memberSession = (MemberDTO) loginUserSession.getAttribute("memberInfo");
		
		// 로그인한 회원의 인증번호가 관리자 번호가 아닐 시
		if (memberSession == null || memberSession.getUserVerify() != adminVerifyNum) {
			
			PrintWriter out  = response.getWriter();
			
			// 스크립트 문으로 메인 페이지로 보내줌.
			out.print("<script>"
					+ "alert('관리자만 로그인이 가능합니다');"
					+ "location.href='/mainPage/mainPage';"
					+ "</script>");
			
			out.flush();
			out.close();
	
			return false;
		}
		
		return true;
	}

}
