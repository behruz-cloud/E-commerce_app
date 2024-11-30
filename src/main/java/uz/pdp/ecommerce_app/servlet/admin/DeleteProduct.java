package uz.pdp.ecommerce_app.servlet.admin;


import uz.pdp.ecommerce_app.DB.DB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteProduct")
public class DeleteProduct extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        DB.PRODUCTS.removeIf(product -> product.getId() == productId);
        resp.sendRedirect("/admin/deleteProductOrCategorySucses.jsp");
    }
}
