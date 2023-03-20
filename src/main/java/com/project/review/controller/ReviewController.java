package com.project.review.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.review.domain.ReviewBoardDTO;
import com.project.review.service.ReviewService;

@Controller
public class ReviewController {

	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	 
	@Autowired
	private ReviewService reviewService;
	
	// 리뷰 등록 페이지
	@RequestMapping(value = "/review/reviewWritePage", method = RequestMethod.GET)
	public String reviewPage(@RequestParam("pno") int pno, Model model) throws Exception {
		
		logger.info("리뷰 등록 페이지 reviewWritePage - Controller");
		
		model.addAttribute("productNumber", pno);
		
		return "/review/reviewWritePage";
	}
	// 리뷰 등록
	@ResponseBody
	@RequestMapping(value = "/review/reviewWrite", method = RequestMethod.POST)
	public void reviewWrite(ReviewBoardDTO reviewBoardDTO) throws Exception {
		
		logger.info("리뷰 등록 reviewWrite - Controller");
		
		reviewService.reviewWrite(reviewBoardDTO);
		
	}
	
	//리뷰 조회
	@RequestMapping(value = "/review/reviewView", method = RequestMethod.GET)
	public void reviewView(Model model, ReviewBoardDTO reviewBoardDTO, int rvno) throws Exception {
		
		logger.info("리뷰 조회 reviewView - Controller");
		
		reviewBoardDTO = reviewService.reviewView(rvno);
		
		model.addAttribute("reviewBoardDTO", reviewBoardDTO);
		
	}
	//리뷰 수정
	@RequestMapping(value = "/review/reviewUpdate", method = RequestMethod.POST)
	public String reviewUpdate(ReviewBoardDTO reviewBoardDTO) throws Exception {
		
		logger.info("리뷰 수정 reviewUpdate - Controller");
		
		reviewService.reviewUpdate(reviewBoardDTO);
		
		return "redirect:/review/main";
	}
	
	//리뷰 삭제
	@ResponseBody
	@RequestMapping(value = "/review/reviewDelete", method = RequestMethod.POST)
	public void reviewDelete(int rvno) throws Exception {
		
		logger.info("리뷰 삭제 reviewDelete - Controller");
		
		reviewService.reviewDelete(rvno);
	}
	

}
