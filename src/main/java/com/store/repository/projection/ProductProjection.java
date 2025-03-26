package com.store.repository.projection;

import com.store.repository.interfaces.CategoryInterface;
import com.store.repository.interfaces.ProductInterface;

public interface ProductProjection extends ProductInterface{
	CategoryInterface getCategory();
}
