<%@ page import="uz.pdp.ecommerce_app.entity.User" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Role" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Category</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 500px;
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

        input[type="text"],
        button {
            padding: 12px;
            margin: 10px 0;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 16px;
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
    <h1>Add Category</h1>
    <form action="/addCategory" method="post">
        <input type="text" placeholder="Category name" name="categoryName" required>
        <button type="submit">SEND</button>
    </form>
</div>

</body>
</html>
