package uz.pdp.ecommerce_app.servlet.admin;


import uz.pdp.ecommerce_app.DB.DB;
import uz.pdp.ecommerce_app.entity.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addCategory")
public class AddCategory extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String string = req.getParameter("categoryName");
        if (string == null) {
            System.out.println(
                    string
            );
        }
        DB.CATEGORIES.add(new Category(string));
        resp.sendRedirect("/admin/deleteProductOrCategorySucses.jsp");
    }
}
