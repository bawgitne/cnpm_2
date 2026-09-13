<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Người Dùng Mới - Admin</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-user-plus text-primary me-2"></i>Thêm Người Dùng Mới</h3>
            <p class="text-muted mb-0">Tạo tài khoản người dùng mới cho hệ thống</p>
        </div>
        <a href="<c:url value='/admin/users'/>" class="btn btn-outline-secondary rounded-pill px-4">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
        </a>
    </div>

    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="card card-custom">
                <div class="card-header-custom d-flex align-items-center justify-content-between">
                    <h5 class="card-title fw-bold mb-0">Thông Tin Tài Khoản</h5>
                    <span class="badge bg-primary-subtle text-primary fw-semibold px-3 py-2 rounded-pill">User Form</span>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/user/insert'/>" method="post" enctype="multipart/form-data">
                        
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="userName" class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="userName" name="userName" placeholder="Nhập tên đăng nhập..." required>
                            </div>
                            <div class="col-md-6">
                                <label for="passWord" class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="passWord" name="passWord" placeholder="Nhập mật khẩu..." required>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="fullName" class="form-label fw-semibold">Họ & Tên <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Nhập họ và tên..." required>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="example@email.com" required>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                                <input type="text" class="form-control" id="phone" name="phone" placeholder="0901234567">
                            </div>
                            <div class="col-md-6">
                                <label for="roleid" class="form-label fw-semibold">Vai trò hệ thống</label>
                                <select class="form-select" id="roleid" name="roleid">
                                    <option value="5" selected>User (Người dùng)</option>
                                    <option value="1">Admin (Quản trị viên)</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="avatarUrl" class="form-label fw-semibold">Link Ảnh Đại Diện (URL ngoài)</label>
                            <input type="url" class="form-control" id="avatarUrl" name="avatarUrl" placeholder="https://example.com/avatar.jpg">
                        </div>

                        <div class="mb-4">
                            <label for="avatarFile" class="form-label fw-semibold">Hoặc Tải Lên Tệp Avatar</label>
                            <input type="file" class="form-control" id="avatarFile" name="avatarFile" accept="image/*">
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold d-block">Trạng thái tài khoản</label>
                            <div class="form-check form-check-inline me-4">
                                <input class="form-check-input" type="radio" name="status" id="userActive" value="1" checked>
                                <label class="form-check-label text-success fw-semibold" for="userActive">
                                    <i class="fa-solid fa-circle-check me-1"></i> Hoạt động
                                </label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="userInactive" value="0">
                                <label class="form-check-label text-danger fw-semibold" for="userInactive">
                                    <i class="fa-solid fa-circle-xmark me-1"></i> Khóa
                                </label>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="d-flex justify-content-end gap-2">
                            <a href="<c:url value='/admin/users'/>" class="btn btn-light px-4">Hủy bỏ</a>
                            <button type="submit" class="btn btn-primary px-4"><i class="fa-solid fa-floppy-disk me-2"></i>Lưu Người Dùng</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
