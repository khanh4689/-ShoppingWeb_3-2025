package com.store.service;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.store.web.request.ReqCategory;
import com.store.web.response.CategoryResponse;

public interface CategoryService {
	ResponseEntity<String> update(ReqCategory request);
	
	ResponseEntity<String> delete(ReqCategory request);
	
	ResponseEntity<CategoryResponse> create(ReqCategory request);
	
	public List<CategoryResponse> getAll();
}
