package com.store.utils;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.stereotype.Component;

import com.store.model.Customer;
import com.store.model.Orders;
import com.store.model.OrdersItems;
import com.store.model.Product;
import com.store.pojo.Cart;
import com.store.service.Session;
import com.store.service.ShoppingCartService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class BuilderCartToOrder {
	final ShoppingCartService cartService;
	final Session session;

	public Orders getOrders() {
		Customer customer = session.get("account");
		if (customer == null) {
			return null;
		}
		Orders order = new Orders();
		order.setTotalAmount(cartService.getAmount());
		order.setCustomerID(customer);
		order.setOrderItems(getOrdersItems(order));
		order.setAddresss(customer.getAddresss());
		order.setStatuss(1);
		order.setPhone(customer.getPhone());
		return order;
	}
	

	public List<OrdersItems> getOrdersItems(Orders order) {
		Map<Integer, Cart> map = cartService.getCart();
		return map.entrySet().stream()
				.filter(entry -> entry.getValue().getQuantityCart() > 0)
				.map(entry -> toOrdersItems(entry.getValue(), order))
				.collect(Collectors.toList());
	}

	public OrdersItems toOrdersItems(Cart cart, Orders order) {
		return OrdersItems.builder()
				.quantity(cart.getQuantityCart())
				.price(cart.getPrice())
				.product(new Product(cart.getId()))
				.iTemReturn(1)
				.order(order).build();
	}
}
