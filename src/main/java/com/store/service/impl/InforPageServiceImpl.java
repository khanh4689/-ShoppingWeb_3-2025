package com.store.service.impl;

import org.springframework.stereotype.Service;

import com.store.service.InforPageService;
import com.store.service.Param;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InforPageServiceImpl implements InforPageService {
	final Param param;
	String name = "";
	int page = 1;

	@Override
	public void setSearch(String name) {
		this.name = param.getString(name, "");
	}

	@Override
	public String getSearch() {
		return this.name;
	}

	@Override
	public void setPage() {
		this.page = param.getInt("page", 1);
	}

	@Override
	public int getPage() {
		return this.page;
	}

}
