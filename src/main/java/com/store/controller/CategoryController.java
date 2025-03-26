package com.store.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.store.repository.CategoryRepository;
import com.store.repository.projection.CategoryProjection;
import com.store.service.CategoryService;
import com.store.utils.BuilderCategory;
import com.store.web.request.ReqCategory;
import com.store.web.response.CategoryResponse;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("manager/category")
public class CategoryController {
	final CategoryRepository categoryRepository;
	final CategoryService categoryService;
	final BuilderCategory builderCategory;
	
	@GetMapping("/view")
	public String view(Model model) {
		model.addAttribute("managerCategory", builderCategory
				.toCategoryResponses(categoryRepository.findBy(CategoryProjection.class)));
		model.addAttribute("page", "include/category.jsp");
		return "index";
	}
	
	
	@ResponseBody
	@PostMapping("/create")
	public ResponseEntity<CategoryResponse> create(@RequestBody ReqCategory request) {
		return categoryService.create(request);
	}
//	
	@ResponseBody
	@PutMapping("/update")
	public ResponseEntity<String> update(@RequestBody ReqCategory request) {
		return categoryService.update(request);
	}
	
	@ResponseBody
	@DeleteMapping("/delete")
	public ResponseEntity<String> delete(@RequestBody ReqCategory request) {
		return categoryService.delete(request);
	}
}
