package com.store.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.store.model.Customer;
import com.store.service.Session;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Service
public class ManagerInterceptor implements HandlerInterceptor {
	Session session;
	
	public ManagerInterceptor(Session session) {
		super();
		this.session = session;
	}



	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String uri = request.getRequestURI();
		Customer customer = session.get("account");
		String error = "";
		if (customer == null) {
			error = "Please has to login.";
			response.sendRedirect("/store/account/login?error="+error);
		}else {
			if(!customer.getAdmins()) {
				error = "You cann't enough authorize.";
				response.sendRedirect("/store");
			}
		}
		
		if (error.length() > 0) { // có lỗi
			return false;
		}
		return true;

	}
}
