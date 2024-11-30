<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="uz.pdp.ecommerce_app.entity.User" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Order" %>
<%@ page import="uz.pdp.ecommerce_app.DB.DB" %>
<%@ page import="uz.pdp.ecommerce_app.entity.OrderItem" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <title>Order Items Show</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #f3f4f7, #eaeaea);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 50px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }

        h1 {
            text-align: center;
            background: #007bff;
            color: #fff;
            margin: 0;
            padding: 20px 0;
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        ul {
            list-style-type: none;
            padding: 20px;
            margin: 0;
        }

        li {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 15px;
            border-bottom: 1px solid #ddd;
            font-size: 16px;
        }

        li:last-child {
            border-bottom: none;
        }

        li:hover {
            background-color: #f9f9f9;
        }

        .order-info {
            padding: 15px 20px;
            font-size: 16px;
            background: #f8f9fa;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
        }

        .order-info p {
            margin: 10px 0;
            color: #333;
        }

        .total {
            font-size: 20px;
            font-weight: bold;
            text-align: right;
            padding: 15px 20px;
            background: #f1f1f1;
            color: #007bff;
        }

        .back-button {
            text-align: center;
            padding: 20px;
            background: #007bff;
        }

        .back-button button {
            color: #fff;
            background: #0069d9;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
        }

        .back-button button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Buyurtma tafsilotlari</h1>
    <ul>
        <%
            User user = (User) request.getSession().getAttribute("user");
            Integer orderId = Integer.valueOf(request.getParameter("orderId"));

            Order order = DB.ORDERS.stream().
                    filter(item -> item.getId().equals(orderId)).
                    filter(item -> item.getUserId().equals(user.getId())).
                    findFirst().
                    get();

            List<OrderItem> orderItems = DB.ORDER_ITEMS.stream().
                    filter(item -> item.getOrderId().equals(orderId)).
                    toList();

            int totalPrice = 0;

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");

            for (OrderItem orderItem : orderItems) {
                Product product = DB.PRODUCTS.stream().filter(item -> item.getId().equals(orderItem.getProductId())).findFirst().get();
                totalPrice += product.getPrice() * orderItem.getAmount();
        %>
        <li>
            <span><%= product.getName() %> (<%= orderItem.getAmount() %> ta)</span>
            <span><%= product.getPrice() * orderItem.getAmount() %> so'm</span>
        </li>
        <%
            }
        %>
    </ul>
    <div class="order-info">
        <p>Vaqt: <%= order.getLocalDateTime().format(formatter) %></p>
        <p>Holat: <%= order.getStatus() %></p>
    </div>
    <div class="total">
        Jami: <%= totalPrice %> so'm
    </div>
    <div class="back-button">
        <form action="/home.jsp" method="post">
            <button type="submit">Bosh menyu</button>
        </form>
    </div>
</div>
</body>
</html>
