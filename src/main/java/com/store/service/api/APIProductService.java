package com.store.service.api;

import java.util.List;

import org.springframework.data.domain.Page;

import com.store.web.resp.RespUpdateStatus;
import com.store.web.response.CategoryResponse;
import com.store.web.response.OrderItemsDetailResponse;
import com.store.web.response.ProductResponse;

public interface APIProductService {
	ProductResponse toProductResponse(Integer id);
	
	Page<ProductResponse> getProductDate(Integer page);
	Page<ProductResponse> getProductPrice(Integer page);
	Page<ProductResponse> getProductSearch(String search,Integer page);
	
	List<CategoryResponse> getAllCategory();
	
	
	List<OrderItemsDetailResponse> getOrderDetail(int id);
	
	List<RespUpdateStatus> getOrderStatus(int id);
}
