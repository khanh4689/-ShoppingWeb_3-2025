package com.store.controller.api;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.store.repository.interfaces.UpdateStatusInterface;
import com.store.service.InforPageService;
import com.store.service.Param;
import com.store.service.api.APIProductService;
import com.store.web.resp.RespUpdateStatus;
import com.store.web.response.OrderItemsDetailResponse;
import com.store.web.response.ProductResponse;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/product")
public class APIProductController {
	/*
	 * Là lớp dùng chung cho tìm kiếm, phân trang, chọn selected.
	 */
	final InforPageService inforPageService;
	final APIProductService apiProductService;
	final Param param;

	// Xem chi tiết sản phẩm khi nhấp vào cái ảnh sản phẩm.
	@PostMapping("/detail")
	public ProductResponse detail() {
		Integer id = param.getInt("id", 0);
		return apiProductService.toProductResponse(id);
	}

	@PostMapping("/view/date")
	public Page<ProductResponse> viewDate() {
		int page = param.getInt("page", 1);
		return apiProductService.getProductDate(page);
	}

	@PostMapping("/view/price")
	public Page<ProductResponse> viewPrice() {
		int page = param.getInt("page", 1);
		return apiProductService.getProductPrice(page);
	}

	/*
	 * Trước khi sử dụng cái này phải đi qua đường dẫn Url :
	 * http://localhost:8080/store/product/search?search=?. Method get Ký tự ? cuối
	 * cùng là tên sản phẩm bạn muốn search. Nếu không đi qua thì mặc định nó rỗng
	 * Hoặc nó sẽ lấy ký tự search của các method khác trong InforPageService
	 */
	@PostMapping("/search")
	public Page<ProductResponse> searchViewPage() {
		int page = param.getInt("page", 1);
		return apiProductService.getProductSearch(inforPageService.getSearch(), page);
	}

	
	// xem hóa đơn chi tiết.
	@PostMapping("/order/detail")
	public List<OrderItemsDetailResponse> getOrderItemsDetailResponses() {
		int id = param.getInt("id", 1);
		return apiProductService.getOrderDetail(id);
	}
	
	
	//xem tình trạng đơn hàng
		@PostMapping("/order/status")
		public List<RespUpdateStatus> status() {
			int id = param.getInt("id", 1);
			return apiProductService.getOrderStatus(id);
		}

}
