package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.User;

public interface UserDao {
    User findById(int id);
    User get(String username);
    User getByEmail(String email);
    void insert(User user);
    void update(User user);
    void delete(int id);
    List<User> findAll();
    List<User> searchPaginated(String keyword, int page, int pageSize);
    int countSearch(String keyword);
    int count();
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    void updateStatus(String email, int status);
    void updateCode(String email, String code);
    void updatePassword(String email, String newPassword);
}
