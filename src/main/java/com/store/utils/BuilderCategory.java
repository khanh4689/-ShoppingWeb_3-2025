package com.store.utils;

import java.util.List;

import org.springframework.stereotype.Component;

import com.store.model.Category;
import com.store.repository.projection.CategoryProjection;
import com.store.web.response.CategoryResponse;

@Component
public class BuilderCategory {
	
	public List<CategoryResponse> toCategoryResponses(List<CategoryProjection> categoryProjections) {
		return categoryProjections.stream().map(this::toCategoryResponse).toList();
	}
	
	public CategoryResponse toCategoryResponse(CategoryProjection categoryProjection) {
		return CategoryResponse
				.builder()
				.id(categoryProjection.getId())
				.name(categoryProjection.getNames())
				.quantity(categoryProjection.getProducts().size())
				.build();
	}
	
	public CategoryResponse toCategoryResponse(Category category) {
		return CategoryResponse
				.builder()
				.id((long)category.getId())
				.name(category.getNames())
				.quantity(category.getProducts() == null ? 0 : category.getProducts().size())
				.build();
	}
}
