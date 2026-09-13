package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Category;

public interface ICategoryDao {
    void insert(Category category);
    void update(Category category);
    void delete(int cateid) throws Exception;
    Category findById(int cateid);
    Category findByCategoryname(String name) throws Exception;
    List<Category> findAll();
    List<Category> searchByName(String catname);
    List<Category> findAll(int page, int pagesize);
    List<Category> searchPaginated(String keyword, int page, int pageSize);
    int countSearch(String keyword);
    int count();
}
