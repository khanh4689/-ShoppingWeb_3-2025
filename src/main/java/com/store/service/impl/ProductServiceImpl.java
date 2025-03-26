package com.store.service.impl;

import org.springframework.stereotype.Service;

import com.store.repository.ProductRepository;
import com.store.service.Param;
import com.store.service.ProductService;
import com.store.service.ShoppingCartService;
import com.store.utils.BuilderProduct;
import com.store.web.request.ReqCart;
import com.store.web.response.CartResponse;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
	final ProductRepository productRepository;
	
	final ShoppingCartService shoppingCartService;
	final BuilderProduct builderProduct;
	final Param param;

	
	@Override
	public CartResponse addCart(ReqCart reqCart) {
		shoppingCartService.update(reqCart.getId(), 1);
		return toCartResponse(shoppingCartService.getQuantity(reqCart.getId()), shoppingCartService.getCount());
	}
	@Override
	public CartResponse update(ReqCart reqCart) {
		shoppingCartService.update(reqCart.getId(), reqCart.getQuantity());
		int quantity = shoppingCartService.getQuantity(reqCart.getId());
		if(quantity <= 0) {
			shoppingCartService.remove(reqCart.getId());
		}
		
		return toCartResponse(quantity, shoppingCartService.getCount());
	}
	
	
	public CartResponse toCartResponse(Integer quantity, Integer count) {
		return CartResponse
				.builder()
				.quantity(quantity)
				.getCount(count)
				.build();
	}
	
	

}
