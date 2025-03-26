package com.store.web.response;

import com.store.web.resp.RespOrder;

import lombok.Getter;
import lombok.experimental.SuperBuilder;
@SuperBuilder
@Getter
public class OrderResponse extends RespOrder {
	public String email;
}
