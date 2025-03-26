package com.store.repository;

import java.util.List;
import org.springframework.stereotype.Repository;

import com.store.model.Category;

@Repository
public interface CategoryRepository extends CommonRepository<Category, Integer> {
	<T> List<T> findBy(Class<T> classType);
	
	
	
}
