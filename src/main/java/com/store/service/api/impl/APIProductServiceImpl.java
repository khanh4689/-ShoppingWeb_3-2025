package com.store.service.api.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.store.model.Product;
import com.store.repository.CategoryRepository;
import com.store.repository.OrderItemsRepository;
import com.store.repository.ProductRepository;
import com.store.repository.UpdateStatusRepository;
import com.store.repository.interfaces.UpdateStatusInterface;
import com.store.repository.projection.CategoryProjection;
import com.store.repository.projection.ProductProjection;
import com.store.service.InforPageService;
import com.store.service.Param;
import com.store.service.api.APIProductService;
import com.store.utils.BuilderCategory;
import com.store.utils.BuilderOrderStatus;
import com.store.utils.BuilderOrderToOrderResp;
import com.store.utils.BuilderProduct;
import com.store.utils.SortProduct;
import com.store.web.resp.RespUpdateStatus;
import com.store.web.response.CategoryResponse;
import com.store.web.response.OrderItemsDetailResponse;
import com.store.web.response.ProductResponse;

import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Service
public class APIProductServiceImpl implements APIProductService {
	final Param param;
	final ProductRepository productRepository;
	final CategoryRepository categoryRepository;
	final OrderItemsRepository orderItemsRepository;
	final BuilderProduct builderProduct;
	final BuilderCategory builderCategory;
	final BuilderOrderToOrderResp builderOrderToOrderResp;
	final InforPageService inforPageService;
	final BuilderOrderStatus builderOrderStatus;
	final UpdateStatusRepository updateStatusRepository;
	
	@Cacheable(cacheNames = "product", key = "#id")
	@Override
	public ProductResponse toProductResponse(Integer id) {
		return getProductResponse(id);
	}
	
	
	@Cacheable(cacheNames = "productDate", key = "#page")
	@Override
	public Page<ProductResponse> getProductDate(Integer page) {
		return getProductPage(page, SortProduct.sortDate());
	}
	
	@Cacheable(cacheNames = "productPrice", key = "#page")
	@Override
	public Page<ProductResponse> getProductPrice(Integer page) {
		return getProductPage(page, SortProduct.sortPrice());
	}
	
	@Cacheable(cacheNames = "productSearch",  key = "#search + #page")
	@Override
	public Page<ProductResponse> getProductSearch(String search,Integer page) {
		return getProductPage(search,page, SortProduct.sortDate());
	}
	
	@Cacheable(cacheNames = "categories")
	@Override
	public List<CategoryResponse> getAllCategory() {
		return builderCategory
				.toCategoryResponses(categoryRepository.findBy(CategoryProjection.class));
	}
	
	
	public Page<ProductResponse> getProductPage(Integer page, Sort sort) {
		Pageable pageable = PageRequest.of(page, 8, sort);
		Page<ProductProjection> data = productRepository
				.findBy(ProductProjection.class, pageable);
		return builderProduct.toProductResponses(data);
	}

	public Page<ProductResponse> getProductPage(String search,Integer page, Sort sort){
		Pageable pageable = PageRequest.of(page, 8, sort);
		Page<ProductProjection> data = productRepository
				.findBy("%"+search+"%",pageable,ProductProjection.class);
		return builderProduct.toProductResponses(data);
	}
	
	
	ProductResponse getProductResponse(Integer id) {
		Optional<Product> product = productRepository.findById(id);
		if(product.isPresent()) {
			return builderProduct.toProductResponse(product.get());
		}
		return null;
	}


	@Cacheable(cacheNames = "orderDetail",  key = "#id")
	@Override
	public List<OrderItemsDetailResponse> getOrderDetail(int id) {
		return builderOrderToOrderResp.toRespOrderItems(orderItemsRepository.findBy(id));
	}


	@Cacheable(cacheNames = "orderStatus",  key = "#id")
	@Override
	public List<RespUpdateStatus> getOrderStatus(int id) {
		List<UpdateStatusInterface> data = 
				updateStatusRepository.findBy(id, UpdateStatusInterface.class);
		return builderOrderStatus.respUpdateStatus(data);
	}
}
