package uz.pdp.ecommerce_app.servlet;

import uz.pdp.ecommerce_app.entity.Basket;
import uz.pdp.ecommerce_app.entity.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import java.util.Optional;

@WebServlet("/basketServlet")
public class BasketServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        String action = req.getParameter("action");

        HttpSession session = req.getSession();
        Basket basket = (Basket) session.getAttribute("basket");
        if (basket == null) {
            basket = new Basket();
            session.setAttribute("basket", basket);
        }

        Map<Product, Integer> map = basket.getMap();
        Optional<Map.Entry<Product, Integer>> optionalEntry = map.entrySet().stream().filter(item -> item.getKey().getId().equals(productId)).findFirst();
        if (optionalEntry.isPresent()) {
            Map.Entry<Product, Integer> entry = optionalEntry.get();
            if ("add".equals(action)) {
                entry.setValue(entry.getValue() + 1);
            } else if ("remove".equals(action) && entry.getValue() > 1) {
                entry.setValue(entry.getValue() - 1);
            }
        }
        session.setAttribute("basket", basket);
        resp.sendRedirect("/basket.jsp");
    }
}

