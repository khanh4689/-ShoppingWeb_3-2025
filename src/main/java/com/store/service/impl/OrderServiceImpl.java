package com.store.service.impl;

import org.springframework.stereotype.Service;

import com.store.model.Customer;
import com.store.model.Orders;
import com.store.repository.OrderRepository;
import com.store.service.Mail;
import com.store.service.OrderService;
import com.store.service.Session;
import com.store.service.ShoppingCartService;
import com.store.utils.BuilderCartToOrder;
import com.store.utils.MailOrder;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class OrderServiceImpl implements OrderService {
	final ShoppingCartService cartService;
	final OrderRepository orderRepository;
	final BuilderCartToOrder builderOrder;
	final MailOrder mailOrder;
	final Mail mail;
	final Session session;

	String from = "doanhuynhduycuong16011601@gmail.com";
	@Override
	public String buy() {
		if (cartService.getCart().size() <= 0) {
			return "Bạn không có sản phẩm trong giỏ hàng để mua.";
		}

		Customer customer = session.get("account");

		try {
			Orders order = orderRepository.save(builderOrder.getOrders());
			mail.queue(customer.getEmail(), "Hóa đơn mua hàng tại ...",mailOrder.order(order));
			
			mail.queue(from, "Khách hàng đặt hàng ...",mailOrder.orderAdmin(order));
			cartService.clear();
			return "Buy thành công hóa đơn đã gửi đến gmail của bạn.";
		} catch (Exception e) {
		}
		return "Mua hàng thất bại vì có sản phẩm không đủ số lượng.";
	}

}
