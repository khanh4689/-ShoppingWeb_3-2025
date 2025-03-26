package com.store.service.impl;

import java.util.List;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.store.model.Customer;
import com.store.model.Orders;
import com.store.model.OrdersItems;
import com.store.model.UpdateStatus;
import com.store.repository.OrderItemsRepository;
import com.store.repository.OrderRepository;
import com.store.repository.UpdateStatusRepository;
import com.store.service.HistoryService;
import com.store.service.Param;
import com.store.service.Session;
import com.store.utils.BuilderOrderToOrderResp;
import com.store.utils.ExecutorUtils;
import com.store.web.response.OrderResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HistoryServiceImpl implements HistoryService {
	final OrderRepository orderRepository;
	final BuilderOrderToOrderResp builderOrderToOrderResp;
	final OrderItemsRepository orderItemsRepository;
	final UpdateStatusRepository updateStatusRepository;
	final Session session;
	final Param param;

	@Override
	public void getOrderResponses(Model model, int status) {
		Customer customer = session.get("account");
		model.addAttribute("history", orderResponses(customer.getId(), status));
	}

	@Override
	public OrdersItems hoan(int id) {
		OrdersItems item = orderItemsRepository.findById(id).get();
		item.setITemReturn(2);
		return orderItemsRepository.save(item);
	}

	List<OrderResponse> orderResponses(int customer, int status) {
		List<Orders> orders = orderRepository.findByStatus(status, customer);
		return builderOrderToOrderResp.toRespOrders(orders);
	}

	@CacheEvict(cacheNames = {"orderDetail","orderStatus"}, key = "#item.getOrder().getOrderID()")
	
	public String updateOrder(OrdersItems item) {
		Runnable task = () -> {
			String reason = param.getString("reason", "");
			String msg = String.format("Khách hàng yêu cầu hoàn trả sản phẩm %s. Lý do : %s",
					item.getProduct().getNames(), reason);
			Orders orders = orderRepository.findById(item.getOrder().getOrderID()).get();
			orders.getUpdateStatus().add(updateStatus(orders, msg));
			orderRepository.save(orders);
		};

		ExecutorUtils.executor.execute(task);
		return "redirect:/history/order/success";

	}

	@CacheEvict(cacheNames = "orderStatus", key = "#id")
	@Override
	public String saveCancelOrder(Integer id) {
		Orders orders = orderRepository.findById(id).get();
		orders.setStatuss(0);
		orders.getUpdateStatus().add(updateStatus(orders));
		orderRepository.save(orders);
		return "redirect:/history/order";

	}

	UpdateStatus updateStatus(Orders orders, String msg) {
		Customer customer = session.get("account");
		UpdateStatus updateStatus = new UpdateStatus();
		updateStatus.setOrders(orders);
		updateStatus.setDescriptions(msg);
		updateStatus.setGmail(customer.getEmail());
		return updateStatus;
	}

	UpdateStatus updateStatus(Orders orders) {
		Customer customer = session.get("account");
		UpdateStatus updateStatus = new UpdateStatus();
		updateStatus.setOrders(orders);
		updateStatus.setGmail(customer.getEmail());
		return updateStatus;
	}

}
