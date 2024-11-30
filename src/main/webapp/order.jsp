<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="uz.pdp.ecommerce_app.entity.*" %>
<%@ page import="uz.pdp.ecommerce_app.DB.DB" %>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Order</title>0
    <style>
        body {
            background-image: url('https://avatars.mds.yandex.net/i?id=af3337ae94a5038b5b1c2b43f788001fc0d57c44-12144750-images-thumbs&n=13');
            background-size: cover;
            background-attachment: fixed;
            height: 100vh;
            color: #fff;
        }

        .container {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            padding: 40px;
            margin-top: 50px;
        }

        h1 {
            color: #007bff;
            font-weight: bold;
        }

        h4 {
            color: #333;
        }

        .product-list .product-item {
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-price {
            font-size: 1.5rem;
            margin-top: 20px;
            font-weight: bold;
            color: #007bff;
        }

        .btn {
            font-size: 1.2rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .footer {
            margin-top: 30px;
            text-align: center;
            font-size: 0.9rem;
            color: #aaa;
        }
    </style>
</head>
<body>
<div class="container text-center">
    <h1>Buyurtmangiz</h1>
    <div class="product-list text-start">
        <%
            User user = (User) request.getSession().getAttribute("user");

            if (user == null) {
                response.sendRedirect("/loginPage.jsp");
                return;
            }

            Order order = new Order();
            order.setStatus(Status.NEW);
            order.setUserId(user.getId());
            order.setLocalDateTime(LocalDateTime.now());

            Basket basket = (Basket) request.getSession().getAttribute("basket");
            int totalPrice = basket.getMap().entrySet().stream()
                    .mapToInt(item -> item.getKey().getPrice() * item.getValue())
                    .sum();

            for (Map.Entry<Product, Integer> entry : basket.getMap().entrySet()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(order.getId());
                orderItem.setAmount(entry.getValue());
                orderItem.setProductId(entry.getKey().getId());
                DB.ORDER_ITEMS.add(orderItem);
        %>
        <div class="product-item">
            <span style="color: black"><%= entry.getKey().getName() %> (<%= entry.getKey().getPrice() %> so'm)</span>
            <span style="color: black"><%= entry.getValue() %> x = <%= entry.getValue() * entry.getKey().getPrice() %> so'm</span>
        </div>
        <% }
            DB.ORDERS.add(order);
        %>
    </div>

    <div class="total-price">
        Umumiy summa: <%= totalPrice %> so'm<br>
        Buyurtma vaqti: <%= order.getLocalDateTime().format(DateTimeFormatter.ofPattern("dd MMMM yyyy HH:mm")) %><br>
        Holati: <span class="badge bg-success">NEW</span>
    </div>

    <form action="/basketClear" method="post">
        <button type="submit" class="btn mt-4">Bosh Menyu</button>
    </form>
</div>

<div class="footer">
    &copy; 2024 G46 groups. Barcha huquqlar himoyalangan.
</div>
</body>
</html>
