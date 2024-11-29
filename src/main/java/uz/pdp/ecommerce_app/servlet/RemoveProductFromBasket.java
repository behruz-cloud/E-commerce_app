package uz.pdp.ecommerce_app.servlet;


import uz.pdp.ecommerce_app.DB.DB;
import uz.pdp.ecommerce_app.entity.Basket;
import uz.pdp.ecommerce_app.entity.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

@WebServlet("/remove")
public class RemoveProductFromBasket extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        Basket basket = (Basket) Objects.requireNonNullElse(req.getSession().getAttribute("basket"), new Basket());
        Product product = DB.PRODUCTS.stream().filter(item -> item.getId().equals(productId)).findFirst().orElseThrow();
        basket.getMap().remove(product);
        req.getSession().setAttribute("basket", basket);
        resp.sendRedirect("/home.jsp");
    }
}
