package com.store.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.store.service.Session;
import com.store.service.ShoppingCartService;
import com.store.service.api.APIProductService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("*")
@RequiredArgsConstructor
public class AllController {
	final ShoppingCartService shoppingCartService;
	final APIProductService apiProductService;
	final Session session;
	
	@GetMapping
	private String test(Model model) {
		int page = 0;
		
		model.addAttribute("newProducts", apiProductService.getProductDate(page));
		model.addAttribute("priceProducts", apiProductService.getProductPrice(page));
		model.addAttribute("myCart", shoppingCartService.getCount());
		session.set("category", apiProductService.getAllCategory());
		model.addAttribute("page", "include/home.jsp");
		return "index";
	}	
}
