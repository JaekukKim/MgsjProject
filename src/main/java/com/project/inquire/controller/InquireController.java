package com.project.inquire.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.inquire.domain.InquireDTO;
import com.project.inquire.service.InquireService;

@Controller
public class InquireController {

	private static final Logger logger = LoggerFactory.getLogger(InquireController.class);

	@Autowired
	private InquireService inquireService;
	
	
	// 제품 문의 페이지
	@RequestMapping(value = "/inquire/inquireWritePage", method = RequestMethod.GET)
	public String inquirePage(@RequestParam("pno") int pno, Model model) throws Exception {
		
		logger.info("제품 문의 페이지 inquirePage - Controller");
		
		model.addAttribute("productNumber", pno);
		
		return "/inquire/inquireWritePage";
	}

	// 제품 문의 등록
	@ResponseBody
	@RequestMapping(value = "/inquire/inquireWrite", method = RequestMethod.POST)
	public void inquireWrite(InquireDTO inquireDTO) throws Exception {

		logger.info("제품 문의 등록 inquireWrite - Controller");
		
		inquireService.inquireWrite(inquireDTO);

	}

	// 제품 문의 조회
	@RequestMapping(value = "/inquire/inquireView", method = RequestMethod.GET)
	public void inquireView(Model model, InquireDTO inquireDTO, int askNum) throws Exception {
		
		logger.info("제품 문의 조회 inquireView - Controller");
		
		inquireDTO = inquireService.inquireView(askNum);
		// inquireService.inquireView(askNum) <= askNum을 매개변수로 db에 접근하는 메소드
		
		model.addAttribute("inquireDTO", inquireDTO);
	}

	// 제품 문의 수정
	@RequestMapping(value = "/inquire/inquireUpdate", method = RequestMethod.POST)
	public String inquireUpdate(InquireDTO inquireDTO) throws Exception {
		
		logger.info("제품 문의 수정 inquireUpdate - Controller");
		
		inquireService.inquireUpdate(inquireDTO);
		
		
		return "redirect:/inquire/main";
	}

	// 제품 문의 삭제
	@ResponseBody
	@RequestMapping(value = "/inquire/inquireDelete", method = RequestMethod.POST)
	public void inquireDelete(int askNum) throws Exception {
		
		logger.info("제품 문의 삭제 inquireDelete - Controller");

		inquireService.inquireDelete(askNum);
		
	}
	
}
