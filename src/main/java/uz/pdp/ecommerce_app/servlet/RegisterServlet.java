package uz.pdp.ecommerce_app.servlet;

import uz.pdp.ecommerce_app.DB.DB;
import uz.pdp.ecommerce_app.entity.User;
import uz.pdp.ecommerce_app.entity.Role;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String phoneNumber = req.getParameter("phoneNumber");
        String password = req.getParameter("password");
        User user = new User(
                firstName,
                lastName,
                phoneNumber,
                password,
                Role.USER
        );
        DB.USERS.add(user);
        resp.sendRedirect("/succes.jsp");
    }
}
