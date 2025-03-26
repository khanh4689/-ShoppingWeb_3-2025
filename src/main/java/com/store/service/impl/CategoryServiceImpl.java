package com.store.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.store.exception.StringException;
import com.store.model.Category;
import com.store.repository.CategoryRepository;
import com.store.repository.projection.CategoryProjection;
import com.store.service.CategoryService;
import com.store.utils.BuilderCategory;
import com.store.web.request.ReqCategory;
import com.store.web.response.CategoryResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CategoryServiceImpl implements CategoryService {
	final CategoryRepository categoryRepository;
	final BuilderCategory builderCategory;
	@Override
	public ResponseEntity<String> update(ReqCategory request) {
		if(request.getNames()==null || request.getNames().equals("")) {
			throw new StringException("Name không được để trống : " + request.getNames());
		}
		
		Optional<Category> optional = categoryRepository.findById(request.getId());
		if(optional.isEmpty()) {
			throw new StringException("Dont' find id category : " + request.getId());
		}
		
		Category category = optional.get();
		category.setNames(request.getNames());
		
		categoryRepository.save(category);
		
		return ResponseEntity.ok("Update successfully");
	}
	@Override
	public ResponseEntity<CategoryResponse> create(ReqCategory request) {
		if(request.getNames()==null || request.getNames().equals("")) {
			throw new StringException("Name không được để trống : " + request.getNames());
		}
		
		Category category = categoryRepository.save(new Category(request.getNames()));
		return ResponseEntity.ok(builderCategory.toCategoryResponse(category));
	}
	@Override
	public ResponseEntity<String> delete(ReqCategory request) {
		Category category = categoryRepository.findById(request.getId()).get();
		if(category.getProducts().size() > 0) {
//			throw new ExistsException("You cann't delete this category. Because it have "+category.getProducts().size()+" products");
		}
		categoryRepository.deleteById(request.getId());
		return ResponseEntity.ok("Delete successfully");
	}
	
	
	public List<CategoryResponse> getAll(){
		return builderCategory
				.toCategoryResponses(categoryRepository.findBy(CategoryProjection.class));
	}
	

}
