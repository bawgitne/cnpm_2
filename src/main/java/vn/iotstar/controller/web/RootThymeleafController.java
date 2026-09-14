package vn.iotstar.controller.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;

@Controller
public class RootThymeleafController {

    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private IProductService productService;

    @GetMapping({"/", "/home"})
    public String index(Model model) {
        List<Category> categories = categoryService.findAll();
        List<Product> products = null;
        try {
            products = productService.findTop10Newest();
            if (products == null || products.isEmpty()) {
                products = productService.findAll();
            }
        } catch (Exception e) {
            products = productService.findAll();
        }

        model.addAttribute("categories", categories);
        model.addAttribute("products", products);

        return "web/index";
    }
}
