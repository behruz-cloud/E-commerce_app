package uz.pdp.ecommerce_app.servlet;

import uz.pdp.ecommerce_app.entity.Basket;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/basketClear")
public class BasketClear extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().removeAttribute("basket");
        req.getSession().setAttribute("basket", new Basket());
        resp.sendRedirect("/home.jsp");
    }
}
