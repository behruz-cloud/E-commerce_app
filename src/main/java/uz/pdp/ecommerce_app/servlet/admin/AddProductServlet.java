package uz.pdp.ecommerce_app.servlet.admin;


import uz.pdp.ecommerce_app.DB.DB;
import uz.pdp.ecommerce_app.entity.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.UUID;

@WebServlet(value = "/addProduct")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    String absolutePath = "C:\\Users\\user\\IdeaProjects\\PDP Academy\\Java Backend\\6 - MODUL\\E-commerce_app\\files\\";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part part = req.getPart("productImage");
        byte[] bytes = part.getInputStream().readAllBytes();
        Path path = Files.write(Path.of(absolutePath + UUID.randomUUID() + ".jpg"), bytes);
        String photoUrl = path.toString();
        System.out.println(photoUrl);
        String productName = req.getParameter("productName");
        Integer price = Integer.valueOf(req.getParameter("productPrice"));
        Integer categoryId = Integer.valueOf(req.getParameter("categoryId"));
        Product product = new Product(
                productName,
                price,
                categoryId,
                photoUrl
        );
        DB.PRODUCTS.add(product);
        resp.sendRedirect("/admin/deleteProductOrCategorySucses.jsp");
    }
}
