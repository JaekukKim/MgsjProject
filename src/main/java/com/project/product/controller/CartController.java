package com.project.product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.project.member.domain.MemberDTO;
import com.project.order.domain.OrderDetailDTO;
import com.project.product.domain.CartDTO;
import com.project.product.service.CartService;
import com.project.product.service.ProductService;

@Controller
public class CartController {

	private static final Logger logger = LoggerFactory.getLogger(CartController.class);

	@Autowired
	private CartService cartService;

	@Autowired
	private ProductService productService;

	// 장바구니 등록
	@ResponseBody
	@RequestMapping(value = "/cart/cartWrite", method = RequestMethod.POST)
	public boolean cartWrite(CartDTO cartDTO,
					@RequestParam ("pno") int pno,
					@RequestParam ("userId") String userId,
					HttpServletRequest req,
					HttpServletResponse resp) throws Exception {

		logger.info("장바구니 등록 cartWrite - Controller");
		
		HttpSession session = req.getSession();
		
		MemberDTO memberLoginSession = (MemberDTO)session.getAttribute("memberInfo");
		
		if (memberLoginSession == null || !memberLoginSession.getUserId().equals(userId)) {
			// 세션값이 없을때, 세션아이디값과 db에 있는 아이디값이 다를경우
			
			return false;
			
		} else {
			
			cartService.cartWrite(cartDTO);
			
			resp.sendRedirect("/product/productView?pno=" + pno);
			
			return true;
		}
		
	}
	// 장바구니 목록 주문목록으로 넘기기
	@RequestMapping(value = "/cart/cartOrder", method = RequestMethod.POST)
	public String cartOrder(
			HttpServletRequest req,
			OrderDetailDTO orderdetailDTO,
			String userId
			) throws Exception {
		
		logger.info("장바구니 주문목록으로 넘기기 cartOrder - Controller");

		HttpSession session = req.getSession();
		
		MemberDTO memberLoginSession = (MemberDTO)session.getAttribute("memberInfo");
		
		orderdetailDTO.setUserId(memberLoginSession.getUserId());
		
		cartService.cartOrder(orderdetailDTO);

		return "redirect:/order/orderPage";
	}
	
	
	
	// 장바구니 수정(비동기)
	// 앞단에서 장바구니 번호 받아오자
	// pno에 빗대서 업데이트
	@RequestMapping(value = "/cart/cartUpdate", method = RequestMethod.POST)
	public String cartUpdate(@RequestParam("pno") int pno, CartDTO cartDTO) throws Exception {

		logger.info("장바구니 수정 cartUpdate - Controller");

		cartService.cartUpdate(cartDTO);

		return "redirect:";
	}

	// 장바구니 삭제
	// 장바구니 안의 항목 삭제
	@ResponseBody
	@RequestMapping(value = "/cart/cartDelete", method = RequestMethod.POST)
	public int cartDelete(
			@RequestParam(value="cartProductNum[]") List<String> cartProductNum, 
			CartDTO cartDTO, HttpSession session) throws Exception {

		logger.info("장바구니 삭제 cartDelete - Controller");

		MemberDTO cartSession = (MemberDTO)session.getAttribute("memberInfo");
		String cartUserId = cartSession.getUserId();
		
		int result = 0;
		int cartProductNumber = 0;
		
		if (cartSession != null) {
			cartDTO.setUserId(cartUserId);
			
			for (String i : cartProductNum) {
				
				cartProductNumber = Integer.parseInt(i);
				cartDTO.setPno(cartProductNumber);
				cartService.cartDelete(cartDTO);
			}
			
			result = 1;
		}
		
		return result;

	}

	// 장바구니 목록
	@RequestMapping(value = "/cart/cartList", method = RequestMethod.GET)
	public void cartList(HttpServletRequest req, CartDTO cartDTO, Model model) throws Exception {

		logger.info("장바구니 목록 cartList - Controller");

		HttpSession session = req.getSession();

		MemberDTO memberLoginSession = (MemberDTO) session.getAttribute("memberInfo");

		cartDTO.setUserId(memberLoginSession.getUserId());
		
		List<CartDTO> cartList = cartService.cartList(cartDTO);

		model.addAttribute("cartList", cartList);

	}
}
