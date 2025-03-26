package com.store.service.impl;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.store.model.Product;
import com.store.repository.PriceBetweenRepository;
import com.store.repository.ProductRepository;
import com.store.repository.interfaces.PriceBetweenInterface;
import com.store.service.SearchByCategoryService;
import com.store.spec.SearchByCategorySpec;
import com.store.utils.BuilderProduct;
import com.store.web.request.ProductSearchRequest;
import com.store.web.response.PriceBetweenResponse;
import com.store.web.response.ProductResponse;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SearchByCategoryServiceImpl implements SearchByCategoryService {
	final PriceBetweenRepository betweenRepository;
	final ProductRepository productRepository;
	final SearchByCategorySpec searchByCategoryFilter;
	final BuilderProduct builderProduct;
	
	private List<PriceBetweenInterface> priceBetween;
	private Specification<Product> spec;
	
	
	private int category = 1;
	
	
	public Page<ProductResponse> getProductResponses(int page){
		Page<Product> products = productRepository.findAll(this.spec, PageRequest.of(page, 9));
		return builderProduct.toProductResponsess(products);
	}
	
	
	public void setSpec(ProductSearchRequest productSearchRequest) {
		this.spec = searchByCategoryFilter.getSearchSpecification(productSearchRequest, category);
	}
	
	public void setCategory(int category) {
		this.category = category;
	}
	
	public List<PriceBetweenResponse> getPriceBetweenResponses(){
		return priceBetween.stream()
				.filter(price -> price.getCategory() == category)
				.map(this::toPriceBetweenResponse).toList();
	}
	
	@PostConstruct
	private void addPriceBetween() {
		priceBetween = betweenRepository.findBy(PriceBetweenInterface.class);
	}
	
	public PriceBetweenResponse toPriceBetweenResponse(PriceBetweenInterface priceBetweenInterface) {
		return PriceBetweenResponse
				.builder()
				.label(priceBetweenInterface.getName())
				.value(priceBetweenInterface.getPrice())
				.build();
	}
}
