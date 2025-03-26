package com.store.controller;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.model.ThongKeOrderItems;
import com.store.repository.OrderItemsRepository;
import com.store.repository.ProductRepository;
import com.store.utils.BuilderOrderToOrderResp;
import com.store.web.response.OrderItemsTKResponse;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/test")
public class Test {
	final OrderItemsRepository itemsRepository;
	final ProductRepository productRepository;
	final BuilderOrderToOrderResp builderOrderToOrderResp;
	
	@GetMapping
	public List<OrderItemsTKResponse> get(){
		return builderOrderToOrderResp
				.toOrderItemsTKResponses(
						itemsRepository.tkOrderItemDetail(998,6,2023));
	}
}
