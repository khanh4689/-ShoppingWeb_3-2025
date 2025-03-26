<%@page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<div class="container mt-4">
    <c:if test="${msg!=null}">
        <div class="alert alert-info text-center" role="alert">
            <h2 class="mb-0">${msg}</h2>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${cart.size()>0}">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th scope="col" style="width: 15%">Ảnh</th>
                            <th scope="col" style="width: 25%">Tên</th>
                            <th scope="col" style="width: 15%">Số lượng mua</th>
                            <th scope="col" style="width: 15%">Giá tiền</th>
                            <th scope="col" style="width: 15%; text-align: center">Số lượng tồn</th>
                            <th scope="col" style="width: 15%">Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="list" items="${cart}">
                            <tr>
                                <td>
                                    <a data-bs-toggle="offcanvas" 
                                       data-bs-target="#detail" 
                                       onclick="detail('${list.id}')">
                                        <img src="/store/img/products/${list.img}" 
                                             alt="${list.names}" 
                                             class="img-fluid rounded" 
                                             style="max-height: 100px; object-fit: cover;">
                                    </a>
                                </td>
                                <td>${list.names}</td>
                                <td>
                                    <form action="/store/cart/update/${list.id}" method="post">
                                        <input name="qty" 
                                               value="${list.quantityCart}" 
                                               type="number" 
                                               onblur="this.form.submit()" 
                                               class="form-control w-75" 
                                               min="0" 
                                               max="5">
                                    </form>
                                </td>
                                <td>${list.priceFormat()}</td>
                                <td style="text-align: center">${list.quantity}</td>
                                <td>
                                    <a href="/store/cart/remove/${list.id}" 
                                       class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-between align-items-center mt-4">
                <div>
                    <p class="mb-1">Tổng số lượng mua: <strong>${count}</strong></p>
                    <p class="mb-0">Tổng hóa đơn: <strong>${amount}</strong></p>
                </div>
                <div>
                    <a href="/store/cart/buy" class="btn btn-success me-2">
                        <i class="bi bi-cart-check"></i> Mua
                    </a>
                    <a href="/store/cart/clear" class="btn btn-warning">
                        <i class="bi bi-cart-x"></i> Làm sạch giỏ hàng
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5">
                <h2 class="mb-4">Không có sản phẩm nào trong giỏ hàng</h2>
                <img src="/store/img/default/cart.png" 
                     alt="Empty Cart" 
                     class="img-fluid" 
                     style="max-height: 400px">
            </div>
        </c:otherwise>
    </c:choose>
</div>