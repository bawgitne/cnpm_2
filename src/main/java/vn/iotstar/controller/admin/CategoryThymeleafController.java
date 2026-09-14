package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.util.Constant;

@Controller
@RequestMapping({"/admin/categories", "/admin/category"})
public class CategoryThymeleafController {

    @Autowired
    private ICategoryService cateService;

    @GetMapping({"", "/list", "/searchpaginated"})
    public String searchAndPaginate(
            @RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "size", required = false, defaultValue = "5") int size,
            Model model) {

        if (page < 1) page = 1;
        if (size < 1) size = 5;

        int totalItems = cateService.countSearch(keyword);
        int totalPages = (int) Math.ceil((double) totalItems / size);
        if (totalPages < 1) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<Category> list = cateService.searchPaginated(keyword, page, size);

        List<Integer> pageNumbers = new ArrayList<>();
        for (int i = 1; i <= totalPages; i++) {
            pageNumbers.add(i);
        }

        model.addAttribute("categories", list);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalItems", totalItems);
        model.addAttribute("pageSize", size);
        model.addAttribute("pageNumbers", pageNumbers);

        return "admin/category-list";
    }

    @GetMapping("/add")
    public String addCategoryForm(Model model) {
        Category category = new Category();
        category.setStatus(1);
        model.addAttribute("category", category);
        model.addAttribute("isEdit", false);
        return "admin/category-form";
    }

    @GetMapping("/edit/{id}")
    public String editCategoryForm(@PathVariable("id") int id, Model model, RedirectAttributes redirectAttributes) {
        Category category = cateService.findById(id);
        if (category == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy danh mục ID: " + id);
            return "redirect:/admin/categories";
        }
        model.addAttribute("category", category);
        model.addAttribute("isEdit", true);
        return "admin/category-form";
    }

    @PostMapping("/save")
    public String saveOrUpdate(
            @ModelAttribute("category") Category category,
            @RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
            RedirectAttributes redirectAttributes) {

        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                String originalFilename = imageFile.getOriginalFilename();
                String ext = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    ext = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                String fname = System.currentTimeMillis() + ext;
                Path destination = Paths.get(uploadPath, fname);
                Files.copy(imageFile.getInputStream(), destination);
                category.setImages(fname);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            if (category.getCategoryid() > 0) {
                Category oldCate = cateService.findById(category.getCategoryid());
                if (oldCate != null && oldCate.getImages() != null) {
                    category.setImages(oldCate.getImages());
                }
            } else {
                if (category.getImages() == null || category.getImages().trim().isEmpty()) {
                    category.setImages("avatar.png");
                }
            }
        }

        if (category.getCategoryid() > 0) {
            cateService.update(category);
            redirectAttributes.addFlashAttribute("message", "Cập nhật danh mục thành công!");
        } else {
            cateService.insert(category);
            redirectAttributes.addFlashAttribute("message", "Thêm mới danh mục thành công!");
        }

        return "redirect:/admin/categories";
    }

    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        try {
            cateService.delete(id);
            redirectAttributes.addFlashAttribute("message", "Xóa danh mục thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa danh mục này!");
            e.printStackTrace();
        }
        return "redirect:/admin/categories";
    }
}
