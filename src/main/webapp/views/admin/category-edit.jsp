<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Danh Mục - Admin</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-pen-to-square text-primary me-2"></i>Chỉnh Sửa Danh Mục</h3>
            <p class="text-muted mb-0">Cập nhật thông tin danh mục #${cate.categoryid}</p>
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
                    <span class="badge bg-warning-subtle text-warning-emphasis fw-semibold px-3 py-2 rounded-pill">ID: ${cate.categoryid}</span>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="categoryid" value="${cate.categoryid}">

                        <div class="mb-3">
                            <label for="categoryname" class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-lg" id="categoryname" name="categoryname" value="${cate.categoryname}" required>
                        </div>

                        <!-- Current Image Preview -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold d-block">Hình ảnh hiện tại</label>
                            <c:choose>
                                <c:when test="${cate.images != null && (cate.images.startsWith('http://') || cate.images.startsWith('https://'))}">
                                    <c:url value="${cate.images}" var="imgUrl"></c:url>
                                </c:when>
                                <c:when test="${not empty cate.images}">
                                    <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="https://via.placeholder.com/150x100?text=No+Image" var="imgUrl"></c:url>
                                </c:otherwise>
                            </c:choose>
                            <img src="${imgUrl}" alt="${cate.categoryname}" class="rounded border p-1 shadow-sm mb-2" style="max-height: 140px; object-fit: cover;">
                        </div>

                        <div class="mb-3">
                            <label for="images" class="form-label fw-semibold">Link Hình Ảnh (URL mới)</label>
                            <input type="text" class="form-control" id="images" name="images" value="${cate.images}" placeholder="https://example.com/image.jpg">
                        </div>

                        <div class="mb-4">
                            <label for="images1" class="form-label fw-semibold">Thay đổi tệp ảnh (Tải lên tệp mới)</label>
                            <input type="file" class="form-control" id="images1" name="images1" accept="image/*">
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold d-block">Trạng thái danh mục</label>
                            <div class="form-check form-check-inline me-4">
                                <input class="form-check-input" type="radio" name="status" id="statusActive" value="1" ${cate.status == 1 ? 'checked' : ''}>
                                <label class="form-check-label text-success fw-semibold" for="statusActive">
                                    <i class="fa-solid fa-circle-check me-1"></i> Hoạt động
                                </label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="statusInactive" value="0" ${cate.status != 1 ? 'checked' : ''}>
                                <label class="form-check-label text-danger fw-semibold" for="statusInactive">
                                    <i class="fa-solid fa-circle-xmark me-1"></i> Khóa
                                </label>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="d-flex justify-content-end gap-2">
                            <a href="<c:url value='/admin/categories'/>" class="btn btn-light px-4">Hủy bỏ</a>
                            <button type="submit" class="btn btn-warning px-4"><i class="fa-solid fa-square-check me-2"></i>Cập Nhật Danh Mục</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
