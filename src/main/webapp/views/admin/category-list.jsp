<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Danh Mục - Admin</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-layer-group text-primary me-2"></i>Quản Lý Danh Mục</h3>
            <p class="text-muted mb-0">Quản lý các danh mục sản phẩm trong hệ thống</p>
        </div>
        <a href="<c:url value='/admin/category/add'/>" class="btn btn-primary px-4 py-2 rounded-pill shadow-sm">
            <i class="fa-solid fa-plus me-2"></i>Thêm Danh Mục Mới
        </a>
    </div>

    <!-- Search Form Card -->
    <div class="card card-custom mb-4">
        <div class="card-body p-3">
            <form action="<c:url value='/admin/categories'/>" method="get" class="row g-2 align-items-center">
                <div class="col-md-8 col-lg-6">
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <input type="text" name="keyword" class="form-control border-start-0 bg-light" placeholder="Nhập tên danh mục cần tìm..." value="${keyword}">
                    </div>
                </div>
                <div class="col-auto d-flex gap-2">
                    <button type="submit" class="btn btn-dark px-4"><i class="fa-solid fa-search me-1"></i> Tìm kiếm</button>
                    <c:if test="${not empty keyword}">
                        <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary"><i class="fa-solid fa-rotate-left me-1"></i> Đặt lại</a>
                    </c:if>
                </div>
            </form>
        </div>
    </div>

    <!-- Data Table Card -->
    <div class="card card-custom">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4" style="width: 80px;">STT</th>
                            <th style="width: 120px;">Hình Ảnh</th>
                            <th>Tên Danh Mục</th>
                            <th style="width: 150px;">Trạng Thái</th>
                            <th class="text-end pe-4" style="width: 180px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listcate}" var="cate" varStatus="STT">
                            <tr>
                                <td class="ps-4 fw-bold text-secondary">${(currentPage - 1) * pageSize + STT.index + 1}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${cate.images != null && (cate.images.startsWith('http://') || cate.images.startsWith('https://'))}">
                                            <c:url value="${cate.images}" var="imgUrl"></c:url>
                                        </c:when>
                                        <c:when test="${not empty cate.images}">
                                            <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="https://via.placeholder.com/80x60?text=No+Image" var="imgUrl"></c:url>
                                        </c:otherwise>
                                    </c:choose>
                                    <img src="${imgUrl}" alt="${cate.categoryname}" class="rounded shadow-sm border" style="width: 70px; height: 50px; object-fit: cover;">
                                </td>
                                <td class="fw-semibold text-dark">${cate.categoryname}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${cate.status == 1}">
                                            <span class="badge badge-status-active"><i class="fa-solid fa-circle-check me-1"></i>Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-status-inactive"><i class="fa-solid fa-circle-xmark me-1"></i>Đã khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="btn btn-sm btn-outline-primary me-1" title="Chỉnh sửa">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');" 
                                       class="btn btn-sm btn-outline-danger" title="Xóa">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listcate}">
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class="fa-solid fa-folder-open fs-1 mb-3 d-block text-secondary"></i>
                                    Không tìm thấy danh mục nào khớp với yêu cầu.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination Bar -->
        <c:if test="${totalPages > 0}">
            <div class="card-footer bg-white py-3 border-top-0 d-flex justify-content-between align-items-center">
                <span class="text-muted small">Hiển thị kết quả (Tổng cộng <strong>${totalItems}</strong> danh mục)</span>
                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/categories?page=${currentPage - 1}&keyword=${keyword}'/>">
                                <i class="fa-solid fa-chevron-left"></i>
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="<c:url value='/admin/categories?page=${i}&keyword=${keyword}'/>">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/categories?page=${currentPage + 1}&keyword=${keyword}'/>">
                                <i class="fa-solid fa-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>
</body>
</html>
