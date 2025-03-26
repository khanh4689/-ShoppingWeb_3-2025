package com.store.service;

import java.util.List;
import org.springframework.data.domain.Page;

import com.store.repository.interfaces.PriceBetweenInterface;
import com.store.web.request.ProductSearchRequest;
import com.store.web.response.PriceBetweenResponse;
import com.store.web.response.ProductResponse;

public interface SearchByCategoryService {
	Page<ProductResponse> getProductResponses(int page);
	
	void setSpec(ProductSearchRequest productSearchRequest);
	
	void setCategory(int category);
	
	List<PriceBetweenResponse> getPriceBetweenResponses();
	
	
	PriceBetweenResponse toPriceBetweenResponse(PriceBetweenInterface priceBetweenInterface);
}
