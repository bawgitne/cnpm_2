package vn.iotstar.service.impl;

import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.util.EmailUtil;

import java.util.List;
import java.util.Random;

public class UserServiceImpl implements UserService {
    private final UserDao userDao = new UserDaoImpl();

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public void delete(int id) {
        userDao.delete(id);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public List<User> searchPaginated(String keyword, int page, int pageSize) {
        return userDao.searchPaginated(keyword, page, pageSize);
    }

    @Override
    public int countSearch(String keyword) {
        return userDao.countSearch(keyword);
    }

    @Override
    public int count() {
        return userDao.count();
    }

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user == null) {
            // Thử đăng nhập bằng Email nếu truyền email vào ô username
            user = this.getByEmail(username);
        }
        if (user != null && password != null && password.equals(user.getPassWord())) {
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    @Override
    public User getByEmail(String email) {
        return userDao.getByEmail(email);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (checkExistUsername(username) || checkExistEmail(email) || checkExistPhone(phone)) {
            return false;
        }
        long millis = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(millis);
        
        // Sinh mã OTP 6 chữ số
        String otp = generateOtp();
        
        // Tạo tài khoản mặc định status = 0 (chưa kích hoạt) và code = otp
        User newUser = new User(email, username, fullname, password, null, 5, phone, date, 0, otp);
        userDao.insert(newUser);

        // Gửi email OTP kích hoạt
        String subject = "Mã OTP kích hoạt tài khoản";
        String content = "<h3>Xin chào " + fullname + ",</h3>"
                + "<p>Cảm ơn bạn đã đăng ký tài khoản. Mã OTP để kích hoạt tài khoản của bạn là:</p>"
                + "<h2 style='color: #4CAF50; font-size: 28px; letter-spacing: 4px;'>" + otp + "</h2>"
                + "<p>Mã này có hiệu lực để xác minh tài khoản của bạn.</p>";
        EmailUtil.sendEmail(email, subject, content);

        return true;
    }

    @Override
    public boolean verifyOtp(String email, String code) {
        if (email == null || code == null) return false;
        User user = userDao.getByEmail(email);
        if (user != null && code.trim().equals(user.getCode())) {
            userDao.updateStatus(email, 1);
            userDao.updateCode(email, null);
            return true;
        }
        return false;
    }

    @Override
    public boolean sendForgotPasswordOtp(String email) {
        if (email == null) return false;
        User user = userDao.getByEmail(email);
        if (user == null) return false;

        String otp = generateOtp();
        userDao.updateCode(email, otp);

        String subject = "Mã OTP đặt lại mật khẩu";
        String content = "<h3>Xin chào " + user.getFullName() + ",</h3>"
                + "<p>Bạn đã yêu cầu đặt lại mật khẩu. Mã OTP của bạn là:</p>"
                + "<h2 style='color: #FF5722; font-size: 28px; letter-spacing: 4px;'>" + otp + "</h2>"
                + "<p>Vui lòng không chia sẻ mã này cho người khác.</p>";
        EmailUtil.sendEmail(email, subject, content);
        return true;
    }

    @Override
    public boolean resetPasswordWithOtp(String email, String code, String newPassword) {
        if (email == null || code == null || newPassword == null || newPassword.isEmpty()) return false;
        User user = userDao.getByEmail(email);
        if (user != null && code.trim().equals(user.getCode())) {
            userDao.updatePassword(email, newPassword);
            return true;
        }
        return false;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }

    private String generateOtp() {
        Random random = new Random();
        int number = 100000 + random.nextInt(900000);
        return String.valueOf(number);
    }
}
