package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.entity.User;

import java.sql.Date;
import java.util.List;

@Component
public class DataInitializer implements CommandLineRunner {

    @Override
    public void run(String... args) throws Exception {
        System.out.println(">>> CHECKING AND INITIALIZING DEMO DATA <<<");
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();

            // 1. Seed Categories if empty
            Long cateCount = enma.createQuery("SELECT count(c) FROM Category c", Long.class).getSingleResult();
            if (cateCount == 0) {
                System.out.println("--> Seeding demo Categories...");
                createCategory(enma, "Điện thoại & Smartphone", "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500", 1);
                createCategory(enma, "Laptop & Máy tính xách tay", "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500", 1);
                createCategory(enma, "Đồng hồ thông minh", "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500", 1);
                createCategory(enma, "Tai nghe & Âm thanh", "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500", 1);
                createCategory(enma, "Máy tính bảng iPad", "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500", 1);
                createCategory(enma, "Phụ kiện & Gaming", "https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?w=500", 0);
                enma.flush();
            }

            // 2. Fetch active categories
            List<Category> categories = enma.createQuery("SELECT c FROM Category c", Category.class).getResultList();

            // 3. Seed Products if count < 5
            Long prodCount = enma.createQuery("SELECT count(p) FROM Product p", Long.class).getSingleResult();
            if (prodCount < 5 && !categories.isEmpty()) {
                System.out.println("--> Seeding demo Products...");
                Category cPhone = getCategoryByKeyword(categories, "Điện thoại");
                Category cLaptop = getCategoryByKeyword(categories, "Laptop");
                Category cWatch = getCategoryByKeyword(categories, "Đồng hồ");
                Category cAudio = getCategoryByKeyword(categories, "Tai nghe");
                Category cTablet = getCategoryByKeyword(categories, "Máy tính bảng");

                createProductIfNotExist(enma, "iPhone 15 Pro Max 256GB Titanium", 1299.0, 50, "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500", "Điện thoại iPhone 15 Pro Max mới nhất với chip A17 Pro", cPhone);
                createProductIfNotExist(enma, "Samsung Galaxy S24 Ultra 512GB", 1199.0, 35, "https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=500", "Siêu phẩm AI Phone với camera 200MP và S-Pen", cPhone);
                createProductIfNotExist(enma, "MacBook Pro M3 Max 16-inch", 2499.0, 20, "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500", "Laptop chuyên nghiệp cho đồ họa và lập trình", cLaptop);
                createProductIfNotExist(enma, "Dell XPS 15 OLED Touch", 1899.0, 15, "https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500", "Laptop mỏng nhẹ cao cấp với màn hình OLED 3.5K", cLaptop);
                createProductIfNotExist(enma, "Apple Watch Series 9 GPS 45mm", 399.0, 40, "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500", "Đồng hồ thông minh hỗ trợ Double Tap và đo SpO2", cWatch);
                createProductIfNotExist(enma, "Sony WH-1000XM5 Wireless Headphones", 349.0, 60, "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500", "Tai nghe chống ồn chủ động đỉnh cao thế giới", cAudio);
                createProductIfNotExist(enma, "iPad Air M2 11-inch Wi-Fi 128GB", 599.0, 25, "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500", "Máy tính bảng iPad Air thế hệ mới chip M2 siêu mạnh", cTablet);
            }

            // 4. Seed Users if count < 3
            Long userCount = enma.createQuery("SELECT count(u) FROM User u", Long.class).getSingleResult();
            if (userCount < 3) {
                System.out.println("--> Seeding demo Users...");
                createUserIfNotExist(enma, "admin@example.com", "admin", "Quản Trị Viên High-Tech", "123456", "https://cdn-icons-png.flaticon.com/512/3135/3135715.png", 1, "0900000001");
                createUserIfNotExist(enma, "manager@example.com", "manager", "Quản Lý Hệ Thống", "123456", "https://cdn-icons-png.flaticon.com/512/4140/4140048.png", 2, "0900000002");
                createUserIfNotExist(enma, "nguyenvana@gmail.com", "nguyenvana", "Nguyễn Văn A", "123456", "https://cdn-icons-png.flaticon.com/512/4140/4140047.png", 5, "0912345678");
                createUserIfNotExist(enma, "tranthib@gmail.com", "tranthib", "Trần Thị B", "123456", "https://cdn-icons-png.flaticon.com/512/4140/4140040.png", 5, "0987654321");
                createUserIfNotExist(enma, "levanc@gmail.com", "levanc", "Lê Văn C", "123456", "https://cdn-icons-png.flaticon.com/512/4140/4140037.png", 5, "0933445566");
            }

            trans.commit();
            System.out.println(">>> DEMO DATA INITIALIZATION COMPLETED SUCCESSFULLY <<<");
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            System.err.println("Notice on DataInitializer: " + e.getMessage());
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    private Category getCategoryByKeyword(List<Category> list, String kw) {
        for (Category c : list) {
            if (c.getCategoryname() != null && c.getCategoryname().toLowerCase().contains(kw.toLowerCase())) {
                return c;
            }
        }
        return list.isEmpty() ? null : list.get(0);
    }

    private Category createCategory(EntityManager enma, String name, String image, int status) {
        Category c = new Category();
        c.setCategoryname(name);
        c.setImages(image);
        c.setStatus(status);
        enma.persist(c);
        return c;
    }

    private void createProductIfNotExist(EntityManager enma, String name, double price, int qty, String image, String desc, Category category) {
        List<Product> list = enma.createQuery("SELECT p FROM Product p WHERE p.productName = :name", Product.class)
                .setParameter("name", name)
                .getResultList();
        if (list.isEmpty()) {
            Product p = new Product();
            p.setProductName(name);
            p.setPrice(price);
            p.setQuantity(qty);
            p.setImages(image);
            p.setDescription(desc);
            p.setStatus(1);
            p.setCategory(category);
            enma.persist(p);
        }
    }

    private void createUserIfNotExist(EntityManager enma, String email, String username, String fullname, String pass, String avatar, int role, String phone) {
        List<User> list = enma.createQuery("SELECT u FROM User u WHERE u.userName = :un", User.class)
                .setParameter("un", username)
                .getResultList();
        if (list.isEmpty()) {
            User u = new User();
            u.setEmail(email);
            u.setUserName(username);
            u.setFullName(fullname);
            u.setPassWord(pass);
            u.setAvatar(avatar);
            u.setRoleid(role);
            u.setPhone(phone);
            u.setStatus(1);
            u.setCreatedDate(new Date(System.currentTimeMillis()));
            enma.persist(u);
        }
    }
}
