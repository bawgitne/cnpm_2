<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Danh Mục Mới - Admin</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-folder-plus text-primary me-2"></i>Thêm Danh Mục Mới</h3>
            <p class="text-muted mb-0">Tạo danh mục mới cho sản phẩm trong hệ thống</p>
        </div>
        <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary rounded-pill px-4">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
        </a>
    </div>

    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="card card-custom">
                <div class="card-header-custom d-flex align-items-center justify-content-between">
                    <h5 class="card-title fw-bold mb-0">Thông Tin Danh Mục</h5>
                    <span class="badge bg-primary-subtle text-primary fw-semibold px-3 py-2 rounded-pill">Category Form</span>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
                        
                        <div class="mb-3">
                            <label for="categoryname" class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-lg" id="categoryname" name="categoryname" placeholder="Nhập tên danh mục..." required>
                        </div>

                        <div class="mb-3">
                            <label for="images" class="form-label fw-semibold">Link Hình Ảnh (URL ngoài)</label>
                            <input type="url" class="form-control" id="images" name="images" placeholder="https://example.com/image.jpg">
                            <div class="form-text">Nhập URL trực tiếp của hình ảnh (nếu không upload tệp bên dưới).</div>
                        </div>

                        <div class="mb-4">
                            <label for="images1" class="form-label fw-semibold">Tải lên tệp ảnh từ máy tính</label>
                            <input type="file" class="form-control" id="images1" name="images1" accept="image/*">
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold d-block">Trạng thái danh mục</label>
                            <div class="form-check form-check-inline me-4">
                                <input class="form-check-input" type="radio" name="status" id="statusActive" value="1" checked>
                                <label class="form-check-label text-success fw-semibold" for="statusActive">
                                    <i class="fa-solid fa-circle-check me-1"></i> Hoạt động
                                </label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="statusInactive" value="0">
                                <label class="form-check-label text-danger fw-semibold" for="statusInactive">
                                    <i class="fa-solid fa-circle-xmark me-1"></i> Khóa
                                </label>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="d-flex justify-content-end gap-2">
                            <a href="<c:url value='/admin/categories'/>" class="btn btn-light px-4">Hủy bỏ</a>
                            <button type="submit" class="btn btn-primary px-4"><i class="fa-solid fa-floppy-disk me-2"></i>Lưu Danh Mục</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
