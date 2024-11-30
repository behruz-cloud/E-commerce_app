<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Order" %>
<%@ page import="uz.pdp.ecommerce_app.DB.DB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <title>Buyurtmalar ro'yxati</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #dae2f8, #d6a4a4);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 50px auto;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            padding: 30px;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h1 {
            text-align: center;
            color: #343a40;
            margin-bottom: 30px;
            font-size: 2.5rem;
            font-weight: bold;
        }

        .order-list {
            list-style: none;
            padding: 0;
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: #f8f9fa;
            transition: all 0.3s ease;
        }

        .order-item:hover {
            background: #e8ebf0;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .order-info {
            font-size: 1.1rem;
            color: #495057;
        }

        .status {
            padding: 8px 12px;
            border-radius: 20px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
        }

        .status.COMPLETED {
            background-color: #28a745;
            color: #fff;
        }

        .status.PENDING {
            background-color: #ffc107;
            color: #212529;
        }

        .status.CANCELED {
            background-color: #dc3545;
            color: #fff;
        }

        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

        .order-number {
            font-weight: bold;
            color: #495057;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Buyurtmalar ro'yxati</h1>
    <ul class="order-list">
        <%
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
            int orderNumber = 1;

            for (Order order : DB.ORDERS) {

                String formattedDate = order.getLocalDateTime().format(formatter);
        %>
        <li class="order-item">
            <div class="order-info">
                <span class="order-number"><%= orderNumber++ %>.</span>
                <span>Vaqt: <%= formattedDate %></span>
                <span class="status <%= order.getStatus() %>"><%= order.getStatus() %></span>
            </div>
            <form action="/orderItemShow.jsp" method="post">
                <input type="hidden" name="orderId" value="<%= order.getId() %>">
                <button type="submit">Mahsulotlarni ko'rish</button>
            </form>
        </li>
        <%
            }
        %>
    </ul>
</div>
</body>
</html>
