package uz.pdp.ecommerce_app.servlet;


import uz.pdp.ecommerce_app.DB.DB;
import uz.pdp.ecommerce_app.entity.Basket;
import uz.pdp.ecommerce_app.entity.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Objects;

@WebServlet("/add")
public class AddProductToBasket extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        int productId = Integer.parseInt(req.getParameter("productId"));
        HttpSession session = req.getSession();
        Product product = DB.PRODUCTS.stream().filter(item -> item.getId().equals(productId)).findFirst().orElseThrow();
        Basket basket = (Basket) Objects.requireNonNullElse(session.getAttribute("basket"), new Basket());
        basket.getMap().put(product, 1);
        session.setAttribute("basket", basket);
        resp.sendRedirect("/home.jsp?categoryId=" + categoryId);
    }
}
