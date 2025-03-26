<%@page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<div class="container mt-4">
	<div class="row">
		<div class="col-md-3">
			<c:if test="${prices.size() > 0}">
				<div class="card p-3">
					<h5 class="card-title text-primary">Mức giá</h5>
					<div class="row g-2">
						<c:forEach var="list" items="${prices}">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" name="price"
									value="${list.value}" id="price-${list.value}"> <label
									class="form-check-label" for="price-${list.value}">
									${list.label} </label>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:if>
		</div>

		<div class="col-md-9">
			<c:choose>
				<c:when test="${searchByCategory.content.size() > 0}">
					<div class="row g-4" id="searchByCategory">
						<c:forEach var="list" items="${searchByCategory.content}">
							<div class="col-lg-4 col-md-6">
								<div class="card shadow-sm h-100">
									<a data-bs-toggle="offcanvas" data-bs-target="#detail"
										onclick="detail('${list.id}')"> <img class="card-img-top"
										src="/store/img/products/${list.img}" alt="${list.names}"
										style="height: 150px; object-fit: cover;">
									</a>
									<div class="card-body text-center">
										<h5 class="card-title">${list.names}</h5>
										<p class="card-text text-danger fw-bold">${list.price}VND</p>
										<div
											class="d-flex justify-content-center align-items-center addCart"
											data-id="${list.id}">
											<div class="btn-group btn-group-sm"
												style="display: ${list.quantityCart>0 ? 'block' : 'none'}">
												<button class="btn btn-outline-primary"
													onclick="updateCart(this,'-')">
													<i class="bi bi-dash-lg"></i>
												</button>
												<label class="mx-2">${list.quantityCart}</label>
												<button class="btn btn-outline-primary"
													onclick="updateCart(this,'+')">
													<i class="bi bi-plus-lg"></i>
												</button>
											</div>
											<div class="p-2"
												style="display: ${list.quantityCart>0 ? 'none' : 'block'}; cursor: pointer;">
												<i onclick="addProductCart(${list.id})"
													class="bi bi-cart-plus fs-4 text-primary"></i>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="row">
						<div class="col-12 text-center">
							<button id="view" class="btn btn-primary mt-3"
								onclick="xem(1, this, '/store/product/search/by/categoryPage', 'searchByCategory', 4)">
								Xem thêm</button>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="text-center">
						<h2 class="text-muted">Không có sản phẩm nào.</h2>
						<img src="/store/img/default/notfound.jfif" class="img-fluid mt-3"
							style="max-height: 300px;">
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<script>
    document.querySelectorAll('input[type="checkbox"][name="price"]').forEach(checkbox => {
        checkbox.addEventListener('click', select);
    });

    function select() {
        let selectedValues = Array.from(document.querySelectorAll('input[type="checkbox"][name="price"]:checked'))
            .map(checkbox => checkbox.value);

        console.log(selectedValues);

        fetch('/store/product/search/by/categoryValue', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ 'priceBetWeen': selectedValues })
        })
        .then(response => response.json())
        .then(datas => {
            // Nếu không có dữ liệu, hiển thị thông báo "Không có sản phẩm"
            if (!datas.content || datas.content.length === 0) {
                document.getElementById('searchByCategory').innerHTML = `
                    <div class="row" style="text-align: center;">
                        <h2>Không có sản phẩm nào.</h2>
                    </div>
                `;
                document.getElementById('view').style.display = 'none'; // Ẩn nút "Xem thêm"
                return;
            }

            // Tạo HTML cho danh sách sản phẩm
            let result = datas.content.map(data => `
                <div class="col-4 mb-4">
                    <a class="row" data-bs-toggle="offcanvas" data-bs-target="#detail" onclick="detail('${data.id}')">
                        <img alt="" class="row" style="height: 150px" src="/store/img/products/${data.img}">
                    </a>
                    <div>${data.names}</div>
                    <div>${data.price}</div>
                    <div class="d-flex justify-content-end addCart" data-id="${data.id}">
                        <div class="btn" style="display: ${data.quantityCart > 0 ? 'block' : 'none'}">
                            <button class="btn btn-primary" onclick="updateCart(this, '-')">
                                <i class="fa-solid fa-minus"></i>
                            </button>
                            <label>${data.quantityCart}</label>
                            <button class="btn btn-primary" onclick="updateCart(this, '+')">
                                <i class="fa-solid fa-plus"></i>
                            </button>
                        </div>
                        <div class="p-2" style="display: ${data.quantityCart > 0 ? 'none' : 'block'}; cursor: pointer;">
                            <i onclick="addProductCart('${data.id}')" class="fa-sharp fa-solid fa-cart-plus fs-4 text-primary"></i>
                        </div>
                    </div>
                </div>
            `).join('');

            // Cập nhật giao diện ngay lập tức
            document.getElementById('searchByCategory').innerHTML = result;

            // Hiển thị nút "Xem thêm" và cập nhật onclick để đồng bộ với giá đã lọc
            let btn = document.getElementById('view');
            btn.style.display = 'block';
            btn.setAttribute('onclick', `xem(1, this, '/store/product/search/by/categoryPage', 'searchByCategory', 4, ${JSON.stringify(selectedValues)})`);
        })
        .catch(error => console.error('Lỗi khi lọc giá:', error));
    }

    // Giả định hàm xem() có tham số bổ sung để xử lý giá đã lọc
    function xem(page, element, url, target, size, selectedValues) {
        fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ page: page, size: size, priceBetWeen: selectedValues || [] })
        })
        .then(response => response.json())
        .then(datas => {
            let result = datas.content.map(data => `
                <div class="col-4 mb-4">
                    <a class="row" data-bs-toggle="offcanvas" data-bs-target="#detail" onclick="detail('${data.id}')">
                        <img alt="" class="row" style="height: 150px" src="/store/img/products/${data.img}">
                    </a>
                    <div>${data.names}</div>
                    <div>${data.price}</div>
                    <div class="d-flex justify-content-end addCart" data-id="${data.id}">
                        <div class="btn" style="display: ${data.quantityCart > 0 ? 'block' : 'none'}">
                            <button class="btn btn-primary" onclick="updateCart(this, '-')">
                                <i class="fa-solid fa-minus"></i>
                            </button>
                            <label>${data.quantityCart}</label>
                            <button class="btn btn-primary" onclick="updateCart(this, '+')">
                                <i class="fa-solid fa-plus"></i>
                            </button>
                        </div>
                        <div class="p-2" style="display: ${data.quantityCart > 0 ? 'none' : 'block'}; cursor: pointer;">
                            <i onclick="addProductCart('${data.id}')" class="fa-sharp fa-solid fa-cart-plus fs-4 text-primary"></i>
                        </div>
                    </div>
                </div>
            `).join('');

            document.getElementById(target).innerHTML += result; // Thêm dữ liệu mới vào danh sách hiện tại
            if (datas.last) element.style.display = 'none'; // Ẩn nút nếu không còn trang tiếp theo
        })
        .catch(error => console.error('Lỗi khi tải thêm:', error));
    }
</script>