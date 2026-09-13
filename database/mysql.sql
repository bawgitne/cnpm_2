CREATE DATABASE IF NOT EXISTS ServletCRUDMVC
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE ServletCRUDMVC;

-- 1. Bảng User
CREATE TABLE IF NOT EXISTS `User` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL UNIQUE,
    fullname VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(500) NULL,
    roleid INT NOT NULL DEFAULT 5,
    phone VARCHAR(30) NULL UNIQUE,
    createdDate DATE NULL,
    status INT NOT NULL DEFAULT 1,
    code VARCHAR(50) NULL
);

-- 2. Bảng categories
CREATE TABLE IF NOT EXISTS categories (
    CategoryId INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL,
    Images VARCHAR(500) NULL,
    Status INT NOT NULL DEFAULT 1
);

-- 3. Bảng products
CREATE TABLE IF NOT EXISTS products (
    ProductId INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Price DOUBLE NOT NULL DEFAULT 0,
    Description VARCHAR(1000) NULL,
    Images VARCHAR(500) NULL,
    Quantity INT NOT NULL DEFAULT 0,
    Status INT NOT NULL DEFAULT 1,
    CreatedDate DATE NULL,
    CategoryId INT NULL,
    FOREIGN KEY (CategoryId) REFERENCES categories(CategoryId) ON DELETE SET NULL
);

-- Demodata Users
INSERT INTO `User` (email, username, fullname, password, avatar, roleid, phone, createdDate, status)
SELECT 'admin@example.com', 'admin', 'Quản Trị Viên High-Tech', '123456', 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', 1, '0900000001', CURRENT_DATE, 1
WHERE NOT EXISTS (SELECT 1 FROM `User` WHERE username='admin');

INSERT INTO `User` (email, username, fullname, password, avatar, roleid, phone, createdDate, status)
SELECT 'manager@example.com', 'manager', 'Quản Lý Hệ Thống', '123456', 'https://cdn-icons-png.flaticon.com/512/4140/4140048.png', 2, '0900000002', CURRENT_DATE, 1
WHERE NOT EXISTS (SELECT 1 FROM `User` WHERE username='manager');

INSERT INTO `User` (email, username, fullname, password, avatar, roleid, phone, createdDate, status)
SELECT 'nguyenvana@gmail.com', 'nguyenvana', 'Nguyễn Văn A', '123456', 'https://cdn-icons-png.flaticon.com/512/4140/4140047.png', 5, '0912345678', CURRENT_DATE, 1
WHERE NOT EXISTS (SELECT 1 FROM `User` WHERE username='nguyenvana');

INSERT INTO `User` (email, username, fullname, password, avatar, roleid, phone, createdDate, status)
SELECT 'tranthib@gmail.com', 'tranthib', 'Trần Thị B', '123456', 'https://cdn-icons-png.flaticon.com/512/4140/4140040.png', 5, '0987654321', CURRENT_DATE, 1
WHERE NOT EXISTS (SELECT 1 FROM `User` WHERE username='tranthib');

INSERT INTO `User` (email, username, fullname, password, avatar, roleid, phone, createdDate, status)
SELECT 'levanc@gmail.com', 'levanc', 'Lê Văn C', '123456', 'https://cdn-icons-png.flaticon.com/512/4140/4140037.png', 5, '0933445566', CURRENT_DATE, 1
WHERE NOT EXISTS (SELECT 1 FROM `User` WHERE username='levanc');

-- Demodata Categories
INSERT INTO categories (CategoryName, Images, Status)
SELECT 'Điện thoại & Smartphone', 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500', 1
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE CategoryName='Điện thoại & Smartphone');

INSERT INTO categories (CategoryName, Images, Status)
SELECT 'Laptop & Máy tính xách tay', 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500', 1
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE CategoryName='Laptop & Máy tính xách tay');

INSERT INTO categories (CategoryName, Images, Status)
SELECT 'Đồng hồ thông minh', 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500', 1
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE CategoryName='Đồng hồ thông minh');

INSERT INTO categories (CategoryName, Images, Status)
SELECT 'Tai nghe & Âm thanh', 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500', 1
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE CategoryName='Tai nghe & Âm thanh');

INSERT INTO categories (CategoryName, Images, Status)
SELECT 'Máy tính bảng iPad', 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500', 1
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE CategoryName='Máy tính bảng iPad');

INSERT INTO categories (CategoryName, Images, Status)
SELECT 'Phụ kiện & Gaming', 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?w=500', 0
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE CategoryName='Phụ kiện & Gaming');

-- Demodata Products (Dynamically query CategoryId to guarantee FK validity)
INSERT INTO products (ProductName, Price, Description, Images, Quantity, Status, CreatedDate, CategoryId)
SELECT 'iPhone 15 Pro Max 256GB Titanium', 1299.0, 'Điện thoại iPhone 15 Pro Max mới nhất với chip A17 Pro', 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500', 50, 1, CURRENT_DATE, (SELECT CategoryId FROM categories WHERE CategoryName LIKE '%Điện thoại%' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM products WHERE ProductName='iPhone 15 Pro Max 256GB Titanium');

INSERT INTO products (ProductName, Price, Description, Images, Quantity, Status, CreatedDate, CategoryId)
SELECT 'Samsung Galaxy S24 Ultra 512GB', 1199.0, 'Siêu phẩm AI Phone với camera 200MP và S-Pen', 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=500', 35, 1, CURRENT_DATE, (SELECT CategoryId FROM categories WHERE CategoryName LIKE '%Điện thoại%' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM products WHERE ProductName='Samsung Galaxy S24 Ultra 512GB');

INSERT INTO products (ProductName, Price, Description, Images, Quantity, Status, CreatedDate, CategoryId)
SELECT 'MacBook Pro M3 Max 16-inch', 2499.0, 'Laptop chuyên nghiệp cho đồ họa và lập trình', 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500', 20, 1, CURRENT_DATE, (SELECT CategoryId FROM categories WHERE CategoryName LIKE '%Laptop%' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM products WHERE ProductName='MacBook Pro M3 Max 16-inch');

INSERT INTO products (ProductName, Price, Description, Images, Quantity, Status, CreatedDate, CategoryId)
SELECT 'Dell XPS 15 OLED Touch', 1899.0, 'Laptop mỏng nhẹ cao cấp với màn hình OLED 3.5K', 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500', 15, 1, CURRENT_DATE, (SELECT CategoryId FROM categories WHERE CategoryName LIKE '%Laptop%' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM products WHERE ProductName='Dell XPS 15 OLED Touch');

INSERT INTO products (ProductName, Price, Description, Images, Quantity, Status, CreatedDate, CategoryId)
SELECT 'Apple Watch Series 9 GPS 45mm', 399.0, 'Đồng hồ thông minh hỗ trợ Double Tap và đo SpO2', 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500', 40, 1, CURRENT_DATE, (SELECT CategoryId FROM categories WHERE CategoryName LIKE '%Đồng hồ%' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM products WHERE ProductName='Apple Watch Series 9 GPS 45mm');

INSERT INTO products (ProductName, Price, Description, Images, Quantity, Status, CreatedDate, CategoryId)
SELECT 'Sony WH-1000XM5 Wireless Headphones', 349.0, 'Tai nghe chống ồn chủ động đỉnh cao thế giới', 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500', 60, 1, CURRENT_DATE, (SELECT CategoryId FROM categories WHERE CategoryName LIKE '%Tai nghe%' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM products WHERE ProductName='Sony WH-1000XM5 Wireless Headphones');

INSERT INTO products (ProductName, Price, Description, Images, Quantity, Status, CreatedDate, CategoryId)
SELECT 'iPad Air M2 11-inch Wi-Fi 128GB', 599.0, 'Máy tính bảng iPad Air thế hệ mới chip M2 siêu mạnh', 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500', 25, 1, CURRENT_DATE, (SELECT CategoryId FROM categories WHERE CategoryName LIKE '%iPad%' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM products WHERE ProductName='iPad Air M2 11-inch Wi-Fi 128GB');
