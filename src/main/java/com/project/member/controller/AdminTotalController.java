package com.project.member.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.board.domain.PageIngredient;
import com.project.member.domain.MemberDTO;
import com.project.member.service.MemberService;
import com.project.product.domain.ProductDTO;
import com.project.product.service.ProductService;

@Controller
public class AdminTotalController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private ProductService productService;

	// 회원 목록 출력
	@RequestMapping(value = "/admin/memberManagement", method = RequestMethod.GET)
	public void getMemberList(@RequestParam("pageNum") int pageNum,
			@RequestParam(value = "searchType", required = false, defaultValue = "userId") String searchType,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword, 
			PageIngredient page, 
			Model model) throws Exception {

		logger.info("관리자 페이지 - 회원 목록 출력 getMemberList - controller");

		logger.info("관리자 페이지 - 회원 목록 출력\n검색어 : {}\n검색타입: ", keyword, searchType);

		// 파라미터 순서 int contentNum , int maxPageNum, int selectContent
		page = new PageIngredient(10, 10);

		page.setPageNum(pageNum);
		page.setSearchType(searchType);
		page.setKeyword(keyword);
		page.setSearchTypeAndKeyword(searchType, keyword);

		// 게시글 총 갯수를 구한다. 단 검색타입과 키워드에 맞춘 결과에 대한 총 갯수를 출력해야한다.
		page.setTotalContent(memberService.totalSearchMember(searchType, keyword));

		List<MemberDTO> memberList = null;
		memberList = memberService.getMemberList(
				page.getStartContentNum(), 
				page.getContentNum(), 
				searchType, keyword);
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("page", page);

		// 현재 페이지가 몇페이지인지 쉽게 구분하기위한 구분자를 넘겨주자
		model.addAttribute("selectedPageNum", pageNum);

	}

	// 관리자 상품 목록 출력
	@RequestMapping(value = "/admin/productManagement", method = RequestMethod.GET)
	public void getProductList(@RequestParam("pageNum") int pageNum,
			@RequestParam(value = "searchType", required = false, defaultValue = "productName") String searchType,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword, PageIngredient page, Model model) throws Exception {

		logger.info("관리자 페이지 - 상품 목록 출력 getProductList - controller");

		logger.info("관리자 페이지 - 상품 목록 출력\n검색어 : {}\n검색타입: ", keyword, searchType);

		// 파라미터 순서 int contentNum , int maxPageNum, int selectContent
		page = new PageIngredient(5, 5);

		page.setPageNum(pageNum);
		page.setSearchType(searchType);
		page.setKeyword(keyword);
		page.setSearchTypeAndKeyword(searchType, keyword);

		// 게시글 총 갯수를 구한다. 단 검색타입과 키워드에 맞춘 결과에 대한 총 갯수를 출력해야한다.
		page.setTotalContent(productService.totalSearchProduct(searchType, keyword));

		List<ProductDTO> productList = null;
		productList = productService.getProductList(page.getStartContentNum(), page.getContentNum(), searchType, keyword);
		model.addAttribute("productList", productList);
		model.addAttribute("page", page);

		// 현재 페이지가 몇페이지인지 쉽게 구분하기위한 구분자
		model.addAttribute("selectedPageNum", pageNum);

	}
	
	// 관리자 상품 게시글 삭제
	@ResponseBody
	@RequestMapping(value = "/admin/productDelete", method = RequestMethod.POST)
	public void adminProductDelete(@RequestParam("pno") int pno) throws Exception {
		
		logger.info("관리자 상품 삭제. 인증 불필요.");
		
		productService.adminProductDelete(pno);
	}
}
