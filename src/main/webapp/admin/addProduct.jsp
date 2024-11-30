<%@ page import="uz.pdp.ecommerce_app.entity.Category" %>
<%@ page import="uz.pdp.ecommerce_app.DB.DB" %>
<%@ page import="uz.pdp.ecommerce_app.entity.User" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Role" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADD PRODUCT</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            color: #333;
            font-size: 24px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        input[type="file"],
        input[type="text"],
        select,
        button {
            padding: 12px;
            margin: 10px 0;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        input[type="file"] {
            border: 1px solid #ddd;
            color: #555;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        select {
            background-color: #f9f9f9;
        }

        .form-select {
            background-color: #f1f1f1;
        }

        /* Responsive styles */
        @media (max-width: 600px) {
            .container {
                margin: 20px;
                padding: 15px;
            }

            h1 {
                font-size: 20px;
            }

            button {
                padding: 14px;
            }
        }
    </style>
</head>
<body>
<%
    User currentUser = (User) request.getSession().getAttribute("user");
    if (currentUser==null) {
        response.sendRedirect("/home.jsp");
        return;
    }
    if (currentUser.getRole().equals(Role.USER)) {
        response.sendRedirect("/home.jsp");
        return;
    }
%>
<div class="container">
    <h1>ADD PRODUCT</h1>
    <form action="/addProduct" method="post" enctype="multipart/form-data">
        <input type="file" placeholder="Select file" name="productImage" required>
        <input type="text" placeholder="Product name" name="productName" required>
        <input type="text" placeholder="Product price" name="productPrice" required>
        <select name="categoryId" class="form-select" required>
            <option value="" disabled selected>Select Category</option>
            <% for (Category category : DB.CATEGORIES) { %>
            <option value="<%= category.getId() %>"><%= category.getName() %></option>
            <% } %>
        </select>
        <button type="submit">SEND</button>
    </form>
</div>

</body>
</html>
