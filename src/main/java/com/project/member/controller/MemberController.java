package com.project.member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.member.domain.MemberAddressDTO;
import com.project.member.domain.MemberDTO;
import com.project.member.service.MemberService;
import com.project.product.domain.CategoryDTO;
import com.project.product.domain.ProductDTO;
import com.project.product.service.CategoryService;
import com.project.product.service.ProductService;

@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private CategoryService categoryService;

	// 메인페이지 접속
	@RequestMapping(value = "/mainPage/mainPage", method = RequestMethod.GET)
	public void connectBoardMain(Model model) throws Exception {

		logger.info("MGSJ 접속");

		
		  List<CategoryDTO> categoryList1 = categoryService.categoryDetailProduct1();
		  
		  List<CategoryDTO> categoryList2 = categoryService.categoryDetailProduct2();
		  
		  model.addAttribute("categoryList1", categoryList1);
		  
		  model.addAttribute("categoryList2", categoryList2);
		 
		
		List<ProductDTO> productList = productService.productList();
		
		model.addAttribute("mainPageProductList", productList);

	}

	// 회원가입 접속 페이지
	@RequestMapping(value = "/member/memberSignUp", method = RequestMethod.GET)
	public void signUpMemberPage() throws Exception {

		logger.info("회원가입 페이지 접속 joinMember - (controller)");
	}

	// 회원가입 로직
	@RequestMapping(value = "/member/memberSignUp", method = RequestMethod.POST)
	public String signUpMember(MemberDTO memberDTO, MemberAddressDTO memberAddressDTO) throws Exception {

		logger.info("회원가입 실행 signUpMember - (controller)");

		memberService.signUpMember(memberDTO, memberAddressDTO);

		logger.info("회원가입 정보 : {}", memberDTO);

		return "redirect:/member/memberLoginPage";
	}

	// 로그인 페이지 접속
	@RequestMapping(value = "/member/memberLoginPage", method = RequestMethod.GET)
	public void memberLoginPage() throws Exception {

		logger.info("로그인 페이지 접속 memberLoginPage - (controller)");
	}

	// 로그인 기능 구현
	@RequestMapping(value = "/member/memberLogin", method = RequestMethod.POST)
	public String memberLogin(MemberDTO memberDTO, HttpServletRequest req, RedirectAttributes reat) throws Exception {

		logger.info("로그인 진행 memberLoginPage - (controller)");

		MemberDTO memberInfo = memberService.memberLogin(memberDTO);

		HttpSession session = req.getSession();

		if (memberInfo == null) {
			session.setAttribute("isLogon", null);
			reat.addFlashAttribute("loginMessage", false);
			logger.info("로그인 실패");

			return "redirect:/member/memberLoginPage";

		} else {
			session.setAttribute("memberInfo", memberInfo);
			
			if (memberInfo.getUserVerify() == 5) {
				logger.info("판매 인증 회원 로그인 : {}", session.getAttribute("memberInfo"));
				
			} else if(memberInfo.getUserVerify() == 128){
				logger.info("관리자 로그인 : {}", session.getAttribute("memberInfo"));
				
			} else {
				logger.info("일반 회원 로그인 : {}", session.getAttribute("memberInfo"));
			}

		}

		return "redirect:/mainPage/mainPage";
	}

	// 로그아웃 로직
	@RequestMapping(value = "/member/memberLogout", method = RequestMethod.GET)
	public String memberLogout(HttpSession session) throws Exception {

		logger.info("유저 로그아웃, 로그아웃 계정 : {}", session.getAttribute("memberInfo").toString());

		session.invalidate();

		return "redirect:/mainPage/mainPage";
	}

	// 회원정보수정 페이지 접속
	@RequestMapping(value = "/member/memberModifyPage", method = RequestMethod.GET)
	public void connectMemberModifyPage() throws Exception {

		logger.info("회원정보 수정 페이지 접속 connectMemberModifyPage - controller");
	}

	// 회원정보 수정 기능 로직
	@RequestMapping(value = "/member/memberModify", method = RequestMethod.POST)
	public String memberModify(MemberDTO memberDTO, HttpSession session) throws Exception {

		logger.info("회원정보 수정, 수정회원 정보 : {}", memberDTO);

		memberService.memberModify(memberDTO);

		// 회원정보 수정이 완료되면 세션아이디를 초기화 시켜야 한다.
		// 왜? 수정된 정보의 데이터는 이전 세션에 저장되지 않기 때문이다.

		memberLogout(session);

		return "redirect:/mainPage/mainPage";
	}

	// 아이디 중복검사 로직
	@ResponseBody
	@RequestMapping(value = "/member/checkDuplicateId", method = RequestMethod.POST)
	public boolean checkDuplicateId(@RequestParam("userId") String userId) throws Exception {

		logger.info("아이디 중복검사 실행 checkDuplicateId - controller : {}", userId);

		int inputUserId = memberService.checkDuplicateId(userId);

		if (inputUserId == 1) {

			logger.info("아이디 중복입니다.");

			return false;

		} else {
			logger.info("회원가입 가능한 아이디입니다.");

			return true;

		}
	}

	// 아이디 패스워드 찾기 - 진입 페이지
	@RequestMapping(value = "/member/memberFindIdpwdPage", method = RequestMethod.GET)
	public void memberFindIdpwdPage() throws Exception {

		logger.info("회원 아이디, 비밀번호 찾기 페이지 진입 memberFindIdpwdPage - controller");

	}

	// 아이디 찾기 - 로직
	@ResponseBody
	@RequestMapping(value = "/member/memberFindId", method = RequestMethod.POST)
	public void memberFindId(MemberDTO memberDTO) throws Exception {

		logger.info("회원 아이디 찾기 시작 memberFindIdpwdPage - controller");

		memberService.memberFindId(memberDTO);

	}

	// 비밀번호 찾기 - 로직
	@ResponseBody
	@RequestMapping(value = "/member/memberFindpwd", method = RequestMethod.POST)
	public void memberFindPwd(MemberDTO memberDTO) throws Exception {

		logger.info("회원 비밀번호 찾기 시작 memberFindIdpwdPage - controller");

		memberService.memberFindPwd(memberDTO);

	}
	
	// 회원 탈퇴 로직
	@ResponseBody
	@RequestMapping(value = "/member/removeMember", method = RequestMethod.POST)
	public boolean removeMember(MemberDTO memberDTO) throws Exception {
		
		String inputPwd = memberDTO.getUserPwd();
		System.out.println("들어온 비밀번호 : " + inputPwd);
		
		String userPwd = memberService.getUserPwd(memberDTO.getUserId());
		System.out.println("db 비밀번호 : " + userPwd);
		
		if(inputPwd.equals(userPwd)) {
			
			logger.info("비밀번호 일치, 회원탈퇴 시작 : {}", memberDTO.getUserId());
			
			memberService.removeMember(memberDTO);
			
			return true;
			
		} else {
			
			logger.info("비밀번호 불일치, 회원탈퇴 실패");
			
			return false;
		}
	}

}
