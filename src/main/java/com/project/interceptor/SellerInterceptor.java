package com.project.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.project.member.domain.MemberDTO;

public class SellerInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		// printWriter 글자 깨짐 방지용 인코딩 -> 서블릿에서 주로 쓰이는 개념
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession loginSession = request.getSession();

		MemberDTO memberLogin = (MemberDTO) loginSession.getAttribute("memberInfo");

		if (memberLogin == null || memberLogin.getUserVerify() != 5) {

			PrintWriter out = response.getWriter();

			out.print("<script> alert('판매자 인증 받은 사용자만 사용이 가능합니다'); location.href='/mainPage/mainPage';</script>");

			out.flush();

			out.close();

			return false;

		}

		return true;
	}
}
