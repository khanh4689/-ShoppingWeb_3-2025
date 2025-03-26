<%@page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<div class="container mt-4">
    <!-- Nút tạo loại sản phẩm -->
    <div class="d-flex justify-content-end mb-4">
        <button class="btn btn-primary d-flex align-items-center"
                type="button" 
                data-bs-toggle="collapse" 
                data-bs-target="#collapseForm"
                aria-expanded="false" 
                aria-controls="collapseForm">
            <i class="bi bi-plus-lg me-2"></i> Tạo loại sản phẩm
        </button>
    </div>

    <!-- Form nhập loại sản phẩm -->
    <div class="collapse collapse-horizontal mb-4" id="collapseForm">
        <div class="card card-body bg-primary text-white shadow-lg border-0" style="width: 350px;">
            <h5 class="card-title mb-3">Thêm loại sản phẩm mới</h5>
            <div class="mb-3">
                <label for="inputCategoryNames" class="form-label">Tên loại</label>
                <input type="text" 
                       class="form-control" 
                       id="inputCategoryNames" 
                       placeholder="Nhập tên loại sản phẩm">
            </div>
            <button class="btn btn-light text-primary fw-bold" 
                    onclick="create()">
                <i class="bi bi-check-lg me-2"></i> Tạo mới
            </button>
        </div>
    </div>

    <!-- Danh sách loại sản phẩm -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <div class="row fw-bold">
                <div class="col-1">ID</div>
                <div class="col-4">Tên loại sản phẩm</div>
                <div class="col-3 text-center">Số lượng</div>
                <div class="col-2 text-center">Hành động</div>
            </div>
        </div>
        <div class="card-body p-0" id="listCategoryManager">
            <c:forEach var="list" items="${managerCategory}">
                <div class="row align-items-center p-3 border-bottom hover-bg">
                    <div class="col-1">${list.id}</div>
                    <div class="col-4">
                        <input type="text" 
                               class="form-control" 
                               value="${list.name}" 
                               onblur="updateCategory('${list.id}', this)">
                    </div>
                    <div class="col-3 text-center fw-bold">${list.quantity}</div>
                    <c:if test="${list.quantity <= 0}">
                        <div class="col-2 text-center">
                            <button class="btn btn-danger btn-sm" 
                                    onclick="remove(${list.id}, this)">
                                <i class="bi bi-trash me-1"></i> Xóa
                            </button>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<style>
    .hover-bg:hover {
        background-color: #f8f9fa;
        transition: background-color 0.3s;
    }
</style>

<script>
    function updateCategory(idCategory, input) {
        var data = { 'id': idCategory, 'names': input.value };
        fetch('/store/manager/category/update', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(function(response) {
            if (response.ok) {
                return response.text();
            } else {
                return response.json();
            }
        })
        .then(function(data) {
            if (typeof data === 'string') {
                alert(data);
            } else {
                alert(data.errors[0].message);
            }
        })
        .catch(function(error) {});
    }
    
    function create() {
        let name = document.getElementById("inputCategoryNames");
        var data = { 'names': name.value };

        fetch('/store/manager/category/create', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(function(response) {
            if (response.ok) {
                return response.json();
            } else {
                return response.json();
            }
        })
        .then(function(data) {
            if(data.errors != null) {
                alert(data.errors[0].message);
            } else {
                var divElement = document.getElementById("listCategoryManager");
                var text = `
                    <div class="row align-items-center p-3 border-bottom hover-bg">
                        <div class="col-1">${data.id}</div>
                        <div class="col-4">
                            <input type="text" class="form-control" 
                                   value="${data.name}" 
                                   onblur="updateCategory(${data.id}, this)">
                        </div>
                        <div class="col-3 text-center fw-bold">${data.quantity}</div>
                        <div class="col-2 text-center">
                            <button class="btn btn-danger btn-sm" 
                                    onclick="remove(${data.id}, this)">
                                <i class="bi bi-trash me-1"></i> Xóa
                            </button>
                        </div>
                    </div>
                `;
                divElement.insertAdjacentHTML('afterbegin', text);
                name.value = ''; // Reset input sau khi tạo thành công
            }
        })
        .catch(function(error) {});
    }
    
    function remove(id, input) {
        var data = { 'id': id };
        fetch('/store/manager/category/delete', {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(function(response) {
            if (response.ok) {
                return response.text();
            } else {
                return response.json();
            }
        })
        .then(function(data) {
            if(data.errors != null) {
                alert(data.errors[0].message);
            } else {
                alert(data);
                input.closest('.row').remove();
            }
        })
        .catch(function(error) {});
    }
</script>