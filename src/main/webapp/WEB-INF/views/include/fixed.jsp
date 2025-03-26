<%@page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<div class="below row">
	<nav class="navbar navbar-expand-lg bg-primary">
    <div class="container-fluid">
        <!-- Dropdown danh mục -->
        <div class="dropdown">
            <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                <i class="bi bi-list"></i>
            </button>
            <ul class="dropdown-menu">
                <c:forEach var="list" items="${category}">
                    <li><a class="dropdown-item" href="/store/product/search/by/category/${list.id}">${list.name}</a></li>
                </c:forEach>
            </ul>
        </div>

        <!-- Logo -->
        <a class="navbar-brand text-white" href="/store">
            <i class="bi bi-bag"></i> ESHOPPEE
        </a>

        <!-- Thanh tìm kiếm -->
        <form class="d-flex flex-grow-1 mx-3">
            <input id="searchByName" class="form-control" type="text" placeholder="Tìm kiếm..." name="search" value="${param.search}">
            <button class="btn btn-light" type="submit">
                <i class="bi bi-search"></i>
            </button>
        </form>

        <!-- Giỏ hàng -->
        <a href="/store/cart" class="btn btn-light position-relative">
            <i class="bi bi-cart"></i>
            <span class="position-absolute top-0 start-100 translate-middle badge bg-danger" id="myCart">
                <c:if test="${myCart != 0}">${myCart}</c:if>
            </span>
        </a>

        <!-- Dropdown Quản lý -->
        <c:if test="${account!=null && account.admins}">
            <div class="dropdown ms-2">
                <button class="btn btn-light dropdown-toggle" data-bs-toggle="dropdown">Quản lý</button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="/store/manager/category/view">Loại sản phẩm</a></li>
                    <li><a class="dropdown-item" href="/store/manager/product/view">Sản phẩm</a></li>
                    <li><a class="dropdown-item" href="/store/manager/history/order">Lịch sử đặt hàng</a></li>
                </ul>
            </div>
        </c:if>

        <!-- Đăng nhập / Tài khoản -->
        <c:if test="${account==null}">
            <a href="/store/account/login" class="btn btn-outline-light ms-3">
                <i class="bi bi-person"></i> Đăng nhập
            </a>
        </c:if>

        <c:if test="${account!=null}">
            <div class="dropdown ms-2">
                <button class="btn btn-light dropdown-toggle" data-bs-toggle="dropdown">Tài khoản</button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="/store/account/changepass">Đổi mật khẩu</a></li>
                    <li><a class="dropdown-item" href="/store/account/update/infor">Cập nhật thông tin</a></li>
                    <li><a class="dropdown-item" href="/store/account/logout">Đăng xuất</a></li>
                    <li><a class="dropdown-item" href="/store/history/order">Lịch sử mua hàng</a></li>
                </ul>
            </div>
        </c:if>
    </div>
</nav>

</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var input = document.getElementById("searchByName");

    if (input) {
        var formSearch = input.closest("form"); // Lấy form chứa input tìm kiếm

        if (formSearch) {
            // Ngăn chặn hành động submit mặc định và xử lý tìm kiếm
            formSearch.addEventListener("submit", function(event) {
                event.preventDefault(); 
                searchProductByName();
            });

            // Hàm tìm kiếm sản phẩm theo tên
            function searchProductByName() {
                var searchValue = input.value.trim(); // Lấy giá trị nhập vào và loại bỏ khoảng trắng thừa
                
                if (searchValue) {
                    // Chuyển hướng đến trang tìm kiếm
                    window.location.href = "/store/product/search?search=" + encodeURIComponent(searchValue);
                }
            }

            // Gán sự kiện khi nhấn phím Enter
            input.addEventListener("keyup", function(event) {
                if (event.key === "Enter") {
                    searchProductByName();
                }
            });
        } else {
            console.error("Không tìm thấy form chứa ô tìm kiếm.");
        }
    } else {
        console.error("Không tìm thấy input có ID 'searchByName'");
    }
});


</script>