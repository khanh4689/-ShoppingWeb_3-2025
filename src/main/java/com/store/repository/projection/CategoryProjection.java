package com.store.repository.projection;

import java.util.List;

import com.store.repository.interfaces.CategoryInterface;
import com.store.repository.interfaces.ProductInterface;

public interface CategoryProjection extends CategoryInterface {	
	List<ProductInterface> getProducts();
}
