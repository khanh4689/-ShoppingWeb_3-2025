<%@page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<!-- Mới đăng -->
<h1 class="text-center text-primary my-4">Mới đăng</h1>

<div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4" id="homeSortDate">
    <c:forEach var="list" items="${newProducts.content}">
        <div class="col">
            <div class="card shadow-sm">
                <a class="text-decoration-none" data-bs-toggle="offcanvas" data-bs-target="#detail" onclick="detail('${list.id}')">
                    <img alt="" class="card-img-top" style="height: 200px; object-fit: cover;" src="/store/img/products/${list.img}">
                </a>
                <div class="card-body text-center">
                    <h5 class="card-title">${list.names}</h5>
                    <p class="card-text text-danger fw-bold">${list.price} VND</p>
                    <div class="d-flex justify-content-center align-items-center addCart" data-id="${list.id}">
                        <div class="btn-group"
                            style="display: ${list.quantityCart>0 ? 'block' : 'none'}">
                            <button class="btn btn-outline-primary" onclick="updateCart(this,'-')">
                                <i class="fa-solid fa-minus"></i>
                            </button>
                            <label class="mx-2">${list.quantityCart}</label>
                            <button class="btn btn-outline-primary" onclick="updateCart(this,'+')">
                                <i class="fa-solid fa-plus"></i>
                            </button>
                        </div>
                        <div class="p-2"
                            style="display: ${list.quantityCart>0 ? 'none' : 'block'}; cursor: pointer;">
                            <i onclick="addProductCart(${list.id})" class="fa-sharp fa-solid fa-cart-plus fs-4 text-primary"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<div class="row mt-4">
    <div class="col text-center">
        <button class="btn btn-primary px-4 py-2" onclick="xem(1,this,'/store/api/product/view/date','homeSortDate',3)">Xem thêm</button>
    </div>
</div>

<!-- Sắp xếp theo giá -->
<h1 class="text-center text-primary my-4">Price</h1>

<div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4" id="homeSortPrice">
    <c:forEach var="list" items="${priceProducts.content}">
        <div class="col">
            <div class="card shadow-sm">
                <a class="text-decoration-none" data-bs-toggle="offcanvas" data-bs-target="#detail" onclick="detail('${list.id}')">
                    <img alt="" class="card-img-top" style="height: 200px; object-fit: cover;" src="/store/img/products/${list.img}">
                </a>
                <div class="card-body text-center">
                    <h5 class="card-title">${list.names}</h5>
                    <p class="card-text text-danger fw-bold">${list.price} VND</p>
                    <div class="d-flex justify-content-center align-items-center addCart" data-id="${list.id}">
                        <div class="btn-group"
                            style="display: ${list.quantityCart>0 ? 'block' : 'none'}">
                            <button class="btn btn-outline-primary" onclick="updateCart(this,'-')">
                                <i class="fa-solid fa-minus"></i>
                            </button>
                            <label class="mx-2">${list.quantityCart}</label>
                            <button class="btn btn-outline-primary" onclick="updateCart(this,'+')">
                                <i class="fa-solid fa-plus"></i>
                            </button>
                        </div>
                        <div class="p-2"
                            style="display: ${list.quantityCart>0 ? 'none' : 'block'}; cursor: pointer;">
                            <i onclick="addProductCart(${list.id})" class="fa-sharp fa-solid fa-cart-plus fs-4 text-primary"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<div class="row mt-4">
    <div class="col text-center">
        <button class="btn btn-primary px-4 py-2" onclick="xem(1,this,'/store/api/product/view/price','homeSortPrice',3)">Xem thêm</button>
    </div>
</div>

<c:forEach var="category" items="${categoryList}">
    <!-- Tiêu đề danh mục -->
    <h1 class="text-center text-primary my-4">${category.name}</h1>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
        <c:forEach var="list" items="${productsByCategory[category.id]}">
            <div class="col">
                <div class="card shadow-sm">
                    <a class="text-decoration-none" data-bs-toggle="offcanvas" data-bs-target="#detail" onclick="detail('${list.id}')">
                        <img alt="" class="card-img-top" style="height: 200px; object-fit: cover;" src="/store/img/products/${list.img}">
                    </a>
                    <div class="card-body text-center">
                        <h5 class="card-title">${list.names}</h5>
                        <p class="card-text text-danger fw-bold">${list.price} VND</p>
                        <div class="d-flex justify-content-center align-items-center addCart" data-id="${list.id}">
                            <div class="btn-group" style="display: ${list.quantityCart>0 ? 'block' : 'none'}">
                                <button class="btn btn-outline-primary" onclick="updateCart(this,'-')">
                                    <i class="bi bi-dash-lg"></i>
                                </button>
                                <label class="mx-2">${list.quantityCart}</label>
                                <button class="btn btn-outline-primary" onclick="updateCart(this,'+')">
                                    <i class="bi bi-plus-lg"></i>
                                </button>
                            </div>
                            <div class="p-2" style="display: ${list.quantityCart>0 ? 'none' : 'block'}; cursor: pointer;">
                                <i onclick="addProductCart(${list.id})" class="bi bi-cart-plus fs-4 text-primary"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</c:forEach>
