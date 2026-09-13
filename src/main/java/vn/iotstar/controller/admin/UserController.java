package vn.iotstar.controller.admin;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

@MultipartConfig()
@WebServlet(urlPatterns = { "/admin/users", "/admin/user/add", "/admin/user/insert",
        "/admin/user/edit", "/admin/user/update", "/admin/user/delete" })
public class UserController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/users")) {
            String keyword = req.getParameter("keyword");
            if (keyword == null) keyword = "";

            String pageStr = req.getParameter("page");
            int page = 1;
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr.trim());
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            int pageSize = 5;

            int totalItems = userService.countSearch(keyword);
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);
            if (totalPages < 1) totalPages = 1;
            if (page > totalPages) page = totalPages;

            List<User> list = userService.searchPaginated(keyword, page, pageSize);

            req.setAttribute("listuser", list);
            req.setAttribute("keyword", keyword);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalItems", totalItems);
            req.setAttribute("pageSize", pageSize);

            req.getRequestDispatcher("/views/admin/user-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/user/add")) {
            req.getRequestDispatcher("/views/admin/user-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/user/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            User user = userService.findById(id);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/admin/user-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/user/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                userService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/admin/user/insert")) {
            String username = req.getParameter("userName");
            String email = req.getParameter("email");
            String fullName = req.getParameter("fullName");
            String passWord = req.getParameter("passWord");
            String phone = req.getParameter("phone");
            int roleid = Integer.parseInt(req.getParameter("roleid"));
            int status = Integer.parseInt(req.getParameter("status"));
            String avatarUrl = req.getParameter("avatarUrl");

            User user = new User();
            user.setUserName(username);
            user.setEmail(email);
            user.setFullName(fullName);
            user.setPassWord(passWord);
            user.setPhone(phone);
            user.setRoleid(roleid);
            user.setStatus(status);
            user.setCreatedDate(new Date(System.currentTimeMillis()));

            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            try {
                Part part = req.getPart("avatarFile");
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + File.separator + fname);
                    user.setAvatar(fname);
                } else if (avatarUrl != null && !avatarUrl.isEmpty()) {
                    user.setAvatar(avatarUrl);
                } else {
                    user.setAvatar("avatar.png");
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }

            userService.insert(user);
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        } else if (url.contains("/admin/user/update")) {
            int id = Integer.parseInt(req.getParameter("id"));
            String username = req.getParameter("userName");
            String email = req.getParameter("email");
            String fullName = req.getParameter("fullName");
            String passWord = req.getParameter("passWord");
            String phone = req.getParameter("phone");
            int roleid = Integer.parseInt(req.getParameter("roleid"));
            int status = Integer.parseInt(req.getParameter("status"));
            String avatarUrl = req.getParameter("avatarUrl");

            User user = userService.findById(id);
            String fileold = user != null ? user.getAvatar() : "";
            if (user == null) {
                user = new User();
                user.setId(id);
            }
            user.setUserName(username);
            user.setEmail(email);
            user.setFullName(fullName);
            if (passWord != null && !passWord.isEmpty()) {
                user.setPassWord(passWord);
            }
            user.setPhone(phone);
            user.setRoleid(roleid);
            user.setStatus(status);

            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            try {
                Part part = req.getPart("avatarFile");
                if (part != null && part.getSize() > 0) {
                    if (fileold != null && !fileold.isEmpty() && !fileold.startsWith("http")) {
                        deleteFile(uploadPath + File.separator + fileold);
                    }
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + File.separator + fname);
                    user.setAvatar(fname);
                } else if (avatarUrl != null && !avatarUrl.isEmpty()) {
                    user.setAvatar(avatarUrl);
                } else {
                    user.setAvatar(fileold);
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }

            userService.update(user);
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        }
    }

    private static void deleteFile(String filePath) {
        try {
            Path path = Paths.get(filePath);
            Files.deleteIfExists(path);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
