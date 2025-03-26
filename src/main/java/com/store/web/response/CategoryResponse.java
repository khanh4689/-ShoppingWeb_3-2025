package com.store.web.response;

import com.store.web.resp.RespCategory;

import lombok.Getter;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@Getter
public class CategoryResponse extends RespCategory {
	
	Integer quantity;
}
