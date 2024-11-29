package uz.pdp.ecommerce_app.servlet;

import uz.pdp.ecommerce_app.DB.DB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DB.ORDERS.clear();
        DB.ORDER_ITEMS.clear();
        req.getSession().invalidate();
        resp.sendRedirect("/home.jsp");
    }
}
