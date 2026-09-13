<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dec" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><dec:title default="Hệ Thống Quản Trị Admin" /></title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f6f9;
            color: #333;
            overflow-x: hidden;
        }

        /* Top Navbar */
        .admin-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .admin-brand {
            font-weight: 700;
            font-size: 1.35rem;
            letter-spacing: 0.5px;
            color: #38bdf8 !important;
        }

        /* Sidebar */
        .sidebar {
            min-height: calc(100vh - 56px);
            background: #1e293b;
            box-shadow: 2px 0 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }
        .sidebar .nav-link {
            color: #94a3b8;
            font-weight: 500;
            padding: 12px 20px;
            border-radius: 8px;
            margin: 4px 12px;
            transition: all 0.25s ease;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .sidebar .nav-link i {
            font-size: 1.1rem;
            width: 24px;
            text-align: center;
        }
        .sidebar .nav-link:hover {
            color: #ffffff;
            background: rgba(255, 255, 255, 0.08);
            transform: translateX(4px);
        }
        .sidebar .nav-link.active {
            color: #ffffff;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        /* Main Content Container */
        .main-content {
            padding: 30px;
        }
        .card-custom {
            border: none;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            background: #ffffff;
        }
        .card-header-custom {
            background: #ffffff;
            border-bottom: 1px solid #f1f5f9;
            padding: 20px 25px;
            border-top-left-radius: 12px !important;
            border-top-right-radius: 12px !important;
        }

        /* Footer */
        footer {
            background: #ffffff;
            border-top: 1px solid #e2e8f0;
            color: #64748b;
            padding: 15px 0;
            font-size: 0.875rem;
        }
        
        .badge-status-active {
            background-color: #dcfce7;
            color: #166534;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 20px;
        }
        .badge-status-inactive {
            background-color: #fee2e2;
            color: #991b1b;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 20px;
        }
        .badge-role-admin {
            background-color: #dbeafe;
            color: #1e40af;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 20px;
        }
        .badge-role-user {
            background-color: #f1f5f9;
            color: #475569;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 20px;
        }
    </style>
    
    <dec:head />
</head>
<body>

    <!-- Header Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark admin-header sticky-top">
        <div class="container-fluid px-4">
            <a class="navbar-brand admin-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/admin/categories">
                <i class="fa-solid fa-shield-halved"></i> ADMIN PORTAL
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="adminNavbar">
                <ul class="navbar-header-nav navbar-nav ms-auto align-items-center gap-3">
                    <li class="nav-item">
                        <a class="nav-link text-light" href="${pageContext.request.contextPath}/home" target="_blank">
                            <i class="fa-solid fa-globe me-1"></i> Xem Website
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-light d-flex align-items-center gap-2" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                            <img src="${pageContext.request.contextPath}/assets/images/user.png" 
                                 onerror="this.src='https://cdn-icons-png.flaticon.com/512/3135/3135715.png'" 
                                 alt="Admin Avatar" class="rounded-circle" width="32" height="32">
                            <span>Administrator</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0" aria-labelledby="userDropdown">
                            <li><a class="dropdown-menu-item dropdown-item" href="${pageContext.request.contextPath}/myprofile"><i class="fa-solid fa-id-card me-2 text-primary"></i>Hồ sơ cá nhân</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-menu-item dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Container Layout -->
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar px-0">
                <div class="position-sticky pt-3">
                    <div class="px-3 mb-3 text-uppercase text-secondary fs-7 fw-bold" style="letter-spacing: 1px;">Menu Quản Trị</div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.requestURI.contains('/admin/categories') or pageContext.request.requestURI.contains('/admin/category') ? 'active' : ''}" 
                               href="${pageContext.request.contextPath}/admin/categories">
                                <i class="fa-solid fa-layer-group"></i> Quản Lý Danh Mục
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.requestURI.contains('/admin/users') or pageContext.request.requestURI.contains('/admin/user') ? 'active' : ''}" 
                               href="${pageContext.request.contextPath}/admin/users">
                                <i class="fa-solid fa-users-gear"></i> Quản Lý Người Dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.requestURI.contains('/admin/products') or pageContext.request.requestURI.contains('/admin/product') ? 'active' : ''}" 
                               href="${pageContext.request.contextPath}/admin/products">
                                <i class="fa-solid fa-box-archive"></i> Quản Lý Sản Phẩm
                            </a>
                        </li>
                    </ul>

                    <hr class="my-4 mx-3 text-secondary">

                    <div class="px-3 mb-2 text-uppercase text-secondary fs-7 fw-bold" style="letter-spacing: 1px;">Hệ Thống</div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">
                                <i class="fa-solid fa-house"></i> Trang Chủ Người Dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                                <i class="fa-solid fa-power-off"></i> Đăng Xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Dynamic Body -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                <dec:body />
            </main>
        </div>
    </div>

    <!-- Footer -->
    <footer class="mt-auto text-center">
        <div class="container">
            <p class="mb-0">&copy; 2026 Admin Portal System | Built with Spring Boot & SiteMesh Decorator</p>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
