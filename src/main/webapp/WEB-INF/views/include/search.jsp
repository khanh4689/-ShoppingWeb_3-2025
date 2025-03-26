<%@page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<c:choose>
    <c:when test="${searchProducts.content.size()>0}">
        <h1 class="text-center my-4">Kết quả tìm kiếm cho: <span class="text-primary">${param.search}</span></h1>
        
        <div class="row row-cols-1 row-cols-md-4 g-4" id="pageSearch">
            <c:forEach var="list" items="${searchProducts.content}">
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <a class="text-decoration-none" data-bs-toggle="offcanvas" data-bs-target="#detail" onclick="detail('${list.id}')">
                            <img src="/store/img/products/${list.img}" class="card-img-top" style="height: 180px; object-fit: cover;" alt="${list.names}">
                        </a>
                        <div class="card-body text-center">
                            <h5 class="card-title">${list.names}</h5>
                            <p class="card-text text-danger fw-bold">${list.price} VND</p>
                        </div>
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
            </c:forEach>
        </div>

        <div class="row mt-4">
            <div class="col text-center">
                <c:if test="${searchProducts.totalPages > 1}">
                    <button class="btn btn-outline-primary btn-lg px-4"
                        onclick="xem(1, this, '/store/api/product/search', 'pageSearch', 3)">
                        <i class="bi bi-arrow-down-circle"></i> Xem thêm
                    </button>
                </c:if>
            </div>
        </div>

    </c:when>

    <c:otherwise>
        <div class="text-center my-5">
            <h2 class="text-danger">Không tìm thấy sản phẩm</h2>
            <img src="/store/img/default/notfound.jfif" class="img-fluid mt-3" style="height: 300px;">
        </div>
    </c:otherwise>
</c:choose>


