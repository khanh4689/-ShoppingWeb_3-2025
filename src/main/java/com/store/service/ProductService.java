package com.store.service;

import com.store.web.request.ReqCart;
import com.store.web.response.CartResponse;
import com.store.web.response.ProductResponse;

public interface ProductService {
	
	CartResponse addCart(ReqCart reqCart);
	
	CartResponse update(ReqCart reqCart);
}
