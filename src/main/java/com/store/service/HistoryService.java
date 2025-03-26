package com.store.service;

import org.springframework.ui.Model;

import com.store.model.OrdersItems;

public interface HistoryService {
	void getOrderResponses(Model model,int status);
	
	
	OrdersItems hoan(int id);
	String updateOrder(OrdersItems item);
	
	String saveCancelOrder(Integer id);
}
