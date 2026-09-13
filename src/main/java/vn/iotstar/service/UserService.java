package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.User;

public interface UserService {
    User findById(int id);
    User login(String username, String password);
    User get(String username);
    User getByEmail(String email);
    void insert(User user);
    void update(User user);
    void delete(int id);
    List<User> findAll();
    List<User> searchPaginated(String keyword, int page, int pageSize);
    int countSearch(String keyword);
    int count();
    boolean register(String username, String password, String email, String fullname, String phone);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    boolean verifyOtp(String email, String code);
    boolean sendForgotPasswordOtp(String email);
    boolean resetPasswordWithOtp(String email, String code, String newPassword);
}
