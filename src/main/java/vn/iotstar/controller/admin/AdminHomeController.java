package vn.iotstar.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;

@Controller
public class AdminHomeController {

    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private IProductService productService;

    @GetMapping("/admin/home")
    public String adminHome(Model model) {
        int totalCategories = categoryService.count();
        int totalProducts = 0;
        try {
            if (productService.findAll() != null) {
                totalProducts = productService.findAll().size();
            }
        } catch (Exception e) {
            totalProducts = 0;
        }

        model.addAttribute("totalCategories", totalCategories);
        model.addAttribute("totalProducts", totalProducts);

        return "admin/home";
    }
}
