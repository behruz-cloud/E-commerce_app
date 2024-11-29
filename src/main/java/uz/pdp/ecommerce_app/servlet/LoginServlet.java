package uz.pdp.ecommerce_app.servlet;

import uz.pdp.ecommerce_app.DB.DB;
import uz.pdp.ecommerce_app.entity.Role;
import uz.pdp.ecommerce_app.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        Optional<User> userOptional = DB.USERS.stream().filter(user -> user.getPassword().equals(password) && user.getPhoneNumber().equals(phone)).findFirst();
        if (userOptional.isPresent()) {
            if (userOptional.get().getRole().equals(Role.ADMIN)) {
                req.getSession().setAttribute("admin", userOptional.get());
                resp.sendRedirect("/admin/admin.jsp");
            } else {
                req.getSession().setAttribute("user", userOptional.get());
                resp.sendRedirect("/home.jsp");
            }
        } else {
            resp.sendRedirect("/loginPage.jsp");
        }
    }
}
