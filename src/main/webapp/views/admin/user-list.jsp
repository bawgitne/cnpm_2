<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Người Dùng - Admin</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-users-gear text-primary me-2"></i>Quản Lý Người Dùng</h3>
            <p class="text-muted mb-0">Quản lý danh sách tài khoản, phân quyền và trạng thái người dùng</p>
        </div>
        <a href="<c:url value='/admin/user/add'/>" class="btn btn-primary px-4 py-2 rounded-pill shadow-sm">
            <i class="fa-solid fa-user-plus me-2"></i>Thêm Người Dùng Mới
        </a>
    </div>

    <!-- Search Form Card -->
    <div class="card card-custom mb-4">
        <div class="card-body p-3">
            <form action="<c:url value='/admin/users'/>" method="get" class="row g-2 align-items-center">
                <div class="col-md-8 col-lg-6">
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <input type="text" name="keyword" class="form-control border-start-0 bg-light" placeholder="Nhập tên đăng nhập, họ tên hoặc email..." value="${keyword}">
                    </div>
                </div>
                <div class="col-auto d-flex gap-2">
                    <button type="submit" class="btn btn-dark px-4"><i class="fa-solid fa-search me-1"></i> Tìm kiếm</button>
                    <c:if test="${not empty keyword}">
                        <a href="<c:url value='/admin/users'/>" class="btn btn-outline-secondary"><i class="fa-solid fa-rotate-left me-1"></i> Đặt lại</a>
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
                            <th class="ps-4" style="width: 70px;">STT</th>
                            <th style="width: 80px;">Avatar</th>
                            <th>Tên Đăng Nhập</th>
                            <th>Họ & Tên</th>
                            <th>Email</th>
                            <th>Số Điện Thoại</th>
                            <th style="width: 120px;">Vai Trò</th>
                            <th style="width: 130px;">Trạng Thái</th>
                            <th class="text-end pe-4" style="width: 150px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listuser}" var="u" varStatus="STT">
                            <tr>
                                <td class="ps-4 fw-bold text-secondary">${(currentPage - 1) * pageSize + STT.index + 1}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.avatar != null && (u.avatar.startsWith('http://') || u.avatar.startsWith('https://'))}">
                                            <c:url value="${u.avatar}" var="avatarUrl"></c:url>
                                        </c:when>
                                        <c:when test="${not empty u.avatar}">
                                            <c:url value="/image?fname=${u.avatar}" var="avatarUrl"></c:url>
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" var="avatarUrl"></c:url>
                                        </c:otherwise>
                                    </c:choose>
                                    <img src="${avatarUrl}" alt="${u.userName}" class="rounded-circle shadow-sm border" style="width: 42px; height: 42px; object-fit: cover;">
                                </td>
                                <td class="fw-semibold text-dark">${u.userName}</td>
                                <td>${u.fullName}</td>
                                <td class="text-muted">${u.email}</td>
                                <td>${empty u.phone ? '-' : u.phone}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.roleid == 1 || u.roleid == 2}">
                                            <span class="badge badge-role-admin"><i class="fa-solid fa-user-shield me-1"></i>Admin</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-role-user"><i class="fa-solid fa-user me-1"></i>User</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.status == 1}">
                                            <span class="badge badge-status-active"><i class="fa-solid fa-circle-check me-1"></i>Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-status-inactive"><i class="fa-solid fa-circle-xmark me-1"></i>Khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="<c:url value='/admin/user/edit?id=${u.id}'/>" class="btn btn-sm btn-outline-primary me-1" title="Chỉnh sửa">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <a href="<c:url value='/admin/user/delete?id=${u.id}'/>" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?');" 
                                       class="btn btn-sm btn-outline-danger" title="Xóa">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listuser}">
                            <tr>
                                <td colspan="9" class="text-center py-5 text-muted">
                                    <i class="fa-solid fa-users-slash fs-1 mb-3 d-block text-secondary"></i>
                                    Không tìm thấy người dùng nào khớp với từ khóa.
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
                <span class="text-muted small">Hiển thị kết quả (Tổng cộng <strong>${totalItems}</strong> tài khoản)</span>
                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/users?page=${currentPage - 1}&keyword=${keyword}'/>">
                                <i class="fa-solid fa-chevron-left"></i>
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="<c:url value='/admin/users?page=${i}&keyword=${keyword}'/>">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/users?page=${currentPage + 1}&keyword=${keyword}'/>">
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
