package com.project.order.controller;

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

import com.project.member.domain.MemberDTO;
import com.project.order.domain.OrderDTO;
import com.project.order.domain.OrderDetailDTO;
import com.project.order.domain.PaymentDTO;
import com.project.order.service.OrderService;
import com.project.order.service.PaymentService;

@Controller
public class PaymentController {

	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired(required = false)
	private OrderService orderService;
	
	
	//결제 - 주문정보(주문품목테이블), 주문세부정보(주소)
	@RequestMapping(value = "/payment/paymentWrite", method = RequestMethod.POST)
	public String paymentWrite(PaymentDTO paymentDTO, 
								OrderDTO orderDTO,
								OrderDetailDTO orderDetailDTO,
								HttpServletRequest req, 
								String userId) throws Exception {
		
		logger.info("결제 등록 paymentWrite - Controller");
		
		HttpSession session = req.getSession();

		MemberDTO memberLoginSession = (MemberDTO) session.getAttribute("memberInfo");

		paymentDTO.setUserId(memberLoginSession.getUserId());
		
		paymentService.paymentWrite(userId, paymentDTO, orderDTO, orderDetailDTO);
		
		System.out.println("값 넘어왔니?" + orderDetailDTO);
		
		return "redirect:/order/orderList";
	}
	
	
	//결제 내역 목록
	@RequestMapping(value = "/payment/paymentList", method = RequestMethod.GET)
	public void paymentList(HttpServletRequest req, PaymentDTO paymentDTO, Model model) throws Exception {
		
		logger.info("결제 내역 목록 paymentList - Controller");
		
		HttpSession session = req.getSession();

		MemberDTO memberLoginSession = (MemberDTO) session.getAttribute("memberInfo");

		paymentDTO.setUserId(memberLoginSession.getUserId());

		List<PaymentDTO> paymentList = paymentService.paymentList(paymentDTO);
		
		model.addAttribute("paymentList", paymentList);

	}
	
	
	
}
