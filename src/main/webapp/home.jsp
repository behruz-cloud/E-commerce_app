<%@ page import="uz.pdp.ecommerce_app.entity.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.ecommerce_app.DB.DB" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Basket" %>
<%@ page import="uz.pdp.ecommerce_app.entity.User" %>
<%@ page import="java.util.Objects" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <title>HOME PAGE</title>
    <style>
        body {
            background-color: #f7f7f7;
        }

        .head {
            margin-top: 20px;
            background: whitesmoke;
            height: 80px;
            position: relative;
        }

        .login-button {
            position: absolute;
            top: 10px;
            left: 10px;
            font-size: 14px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .action-buttons {
            position: absolute;
            top: 10px;
            right: 10px;
            display: flex;
            gap: 10px;
        }

        .box {
            margin-top: 20px;
            padding: 20px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            background: #ffffff;
        }

        .product-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .product-details {
            padding: 15px;
        }

        .product-actions {
            margin-top: 15px;
            display: flex;
            justify-content: space-between;
        }

        .button-add, .button-remove {
            font-size: 14px;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        .button-add {
            background-color: #28a745;
            color: white;
        }

        .button-remove {
            background-color: #ff4d4d;
            color: white;
        }

        .savatcha_button {
            background-color: green;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        .savatcha_button:hover {
            background-color: #218838;
        }

        .login-actions {
            position: absolute;
            top: 10px;
            left: 10px;
            display: flex;
            gap: 10px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-info img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
        }

        .user-info span {
            font-size: 16px;
            font-weight: bold;
        }

        .user-info .login-icon {
            font-size: 18px;
            color: #007bff;
        }
    </style>

</head>
<body>
<%
    User currentUser = (User) request.getSession().getAttribute("user");
    Basket basket = (Basket) Objects.requireNonNullElse(request.getSession().getAttribute("basket"), new Basket());
    Integer categoryId;
    String categoryIdStr = request.getParameter("categoryId");
    int size = basket.getMap().size();

    if (categoryIdStr != null) {
        categoryId = Integer.valueOf(categoryIdStr);
    } else {
        categoryId = 1;
    }

    List<Product> products = DB.PRODUCTS.stream().filter(item -> item.getCategoryId().equals(categoryId)).toList();
%>

<div class="row">
    <div class="col">
        <div class="head">
            <h1 class="text-center">MARKET</h1>
            <div class="login-actions">
                <%
                    if (currentUser == null) {
                %>
                <form action="/loginPage.jsp" method="post">
                    <button type="submit" class="login-button">LOGIN</button>
                </form>
                <%
                } else {
                %>
                <form action="/logout" method="post">
                    <input type="hidden" name="userId" value="<%=currentUser.getId()%>">
                    <button type="submit" class="btn btn-danger">LOG OUT</button>
                </form>
                <%
                    }
                %>
            </div>
            <div class="action-buttons">
                <form action="/basket.jsp" method="post">
                    <button type="submit" class="savatcha_button">Savatcha (<%= size %>)</button>
                </form>
                <form action="/orderItem.jsp" method="post">
                    <button type="submit" class="savatcha_button">BUYURTMALARIM</button>
                </form>
                <div class="user-info">
                    <%
                        if (currentUser == null) {
                    %>
                    <span class="user-info"><i class="login-icon">👤</i> user</span>
                    <%
                    } else {
                        String fullName = currentUser.getFirstName() + " " + currentUser.getLastName();
                    %>
                    <span class="user-info">

                        <img src="https://avatars.mds.yandex.net/i?id=ae539a6d4a7590ff2d0a985e0a032f64e4fa3009-4120868-images-thumbs&n=13"
                             alt="img.png">
                        <span><%= fullName %></span>
                    </span>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-3">
        <div class="box">
            <form action="/home.jsp" method="post">
                <%
                    for (Category category : DB.CATEGORIES) {
                        String activeClass;
                        if (category.getId().equals(categoryId)) {
                            activeClass = "btn-primary";
                        } else {
                            activeClass = "btn-secondary";
                        } %>
                <button class="btn <%= activeClass %> w-100 mb-2" type="submit" name="categoryId"
                        value="<%= category.getId() %>">
                    <%= category.getName() %>
                </button>
                <%
                    }
                %>
            </form>

        </div>
    </div>
    <div class="col-9">
        <div class="box">
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <% for (Product product : products) { %>
                <div class="col">
                    <div class="product-card">

                        <img src="/file/<%= product.getId() %>" alt="<%= product.getName() %>">
                        <div class="product-details">
                            <h5 class="product-name"><%= product.getName() %>
                            </h5>
                            <p class="product-price">Narxi: <b><%= product.getPrice() %> so'm</b></p>
                            <div class="product-actions">

                                <% if (basket.getMap().containsKey(product)) { %>
                                <form action="/remove" method="post">
                                    <input type="hidden" name="categoryId" value="<%= categoryId %>">
                                    <button type="submit" name="productId" value="<%= product.getId() %>"
                                            class="button-remove">Savatchadan o'chirish
                                    </button>
                                </form>
                                <% } else { %>
                                <form action="/add" method="post">
                                    <input type="hidden" name="categoryId" value="<%= categoryId %>">
                                    <button type="submit" name="productId" value="<%= product.getId() %>"
                                            class="button-add">Savatchaga qo'shish
                                    </button>
                                </form>
                                <% } %>

                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>
</body>
</html>