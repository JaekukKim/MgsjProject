package com.project.utils;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

@Controller
public class RequestMappingsList {

	// requestMapping 목록 불러오기

	@Autowired
	private RequestMappingHandlerMapping requestMappingHandlerMapping;
	
	@RequestMapping(value = "/admin/endPoints", method = RequestMethod.GET)
	public String getEndPointsInView(Model model) {
		
		Map<RequestMappingInfo, HandlerMethod> endPoint = requestMappingHandlerMapping.getHandlerMethods();
	
		model.addAttribute("endPoint", endPoint);
		
		return "/admin/endPointsRequestMapping";
	}

}