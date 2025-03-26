package com.store.web.response;

import com.store.web.resp.RespOrderItems;

import lombok.Getter;
import lombok.experimental.SuperBuilder;
@SuperBuilder
@Getter
public class OrderItemsTKResponse extends RespOrderItems {
	
	OrderResponse order;
}
