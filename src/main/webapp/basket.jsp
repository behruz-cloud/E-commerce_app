<%@ page import="java.util.Objects" %>
<%@ page import="java.util.Map" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Basket" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <title>Basket</title>
    <style>
        body {
            background-image: url(https://avatars.mds.yandex.net/i?id=af3337ae94a5038b5b1c2b43f788001fc0d57c44-12144750-images-thumbs&n=13);
            background-size: cover;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 60%;
        }

        h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .product-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }

        .product-info {
            display: flex;
            flex-direction: column;
        }

        .product-info span {
            font-size: 1rem;
            color: #555;
        }

        .quantity-buttons {
            display: flex;
            gap: 10px;
        }


        .btn {
            padding: 10px 15px;
            background-color: green;
            border-radius: 5px;
        }

        .order-btn {
            width: 100%;
            padding: 15px;
            background-color: green;
            color: white;
            border: none;
            font-size: 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }

    </style>

</head>
<body>
<%
    Basket basket = (Basket) Objects.requireNonNullElse(request.getSession().getAttribute("basket"), new Basket());

    Map<Product, Integer> basketMap = basket.getMap();%>

<div class="container">

    <h2>Mahsulotlaringiz : </h2>

    <% for (Map.Entry<Product, Integer> entry : basketMap.entrySet()) {%>


    <form action="/basketServlet" method="post">
        <div class="product-item d-flex align-items-center mb-3">
            <div class="product-info flex-grow-1">

                <h3 class="mb-0"><%= entry.getKey().getName() %> - <%= entry.getKey().getPrice() * entry.getValue() %> so'm</h3>

            </div>
            <div class="quantity-buttons d-flex align-items-center">
                <button type="submit" name="action" value="add" class="btn btn-success px-3">+</button>
                <span class="quantity mx-3 text-center border rounded px-3 py-1 bg-light"><%= entry.getValue() %></span>
                <button type="submit" name="action" value="remove" class="btn btn-danger px-3">-</button>
            </div>
            <input type="hidden" name="productId" value="<%= entry.getKey().getId() %>">
        </div>
    </form>

    <%
        }
    %>
    <form action="/order.jsp" method="post">
        <button type="submit" name="order" value="order" class="order-btn">BUYURTMA BERISH</button>
    </form>
</div>

</body>
</html>