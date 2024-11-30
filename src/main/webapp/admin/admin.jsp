<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.ecommerce_app.entity.User" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Role" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Category" %>
<%@ page import="uz.pdp.ecommerce_app.DB.DB" %>
<%@ page import="uz.pdp.ecommerce_app.entity.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Admin Panel</title>
    <style>
        .sidebar {
            background: #f8f9fa;
            padding: 20px;
            height: 100vh;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }

        .content {
            padding: 20px;
        }

        .btn-remove {
            background: #ff4d4d;
            color: white;
            border: none;
        }
    </style>
</head>
<body>
<%
    //admin page
    User currentUser = (User) request.getSession().getAttribute("user");

    if (currentUser != null && currentUser.getRole().equals(Role.USER)) {
        response.sendRedirect("/home.jsp");
        return;
    }
%>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->


        <div class="col-3 sidebar">
            <h4>Bo'limlar</h4>
            <form action="/admin/admin.jsp" method="post">
                <button type="submit" name="view" value="category" class="btn btn-primary w-100 mb-3">Category</button>
                <button type="submit" name="view" value="product" class="btn btn-primary w-100">Product</button>
            </form>
            <form action="/main" method="post">
                <%
                    request.getSession().invalidate();
                %>
                <button type="submit" class="btn btn-primary w-100 mb-3">BOSH MENU</button>
            </form>

        </div>

        <!-- Main Content -->
        <div class="col-9 content">
            <%
                String view = request.getParameter("view");
                if ("category".equals(view)) {
            %>
            <h4>Kategoriyalar</h4>
            <ul class="list-group">
                <% for (Category category : DB.CATEGORIES) { %>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <%= category.getName() %>
                    <form action="/deleteCategory" method="post" class="d-inline">
                        <input type="hidden" name="categoryId" value="<%= category.getId() %>">
                        <button type="submit" class="btn btn-remove btn-sm">O'chirish</button>
                    </form>
                </li>
                <% } %>
            </ul>
            <form action="/admin/addCategory.jsp" method="get">
                <button type="submit" class="btn btn-success mt-3">Kategoriya Qo'shish</button>
            </form>
            <%
            } else if ("product".equals(view)) {
            %>
            <h4>Mahsulotlar</h4>
            <div class="row">
                <% for (Product product : DB.PRODUCTS) { %>
                <div class="col-md-4">
                    <div class="card mb-3">
                        <img src="/file/<%= product.getId() %>" class="card-img-top" alt="<%= product.getName() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= product.getName() %>
                            </h5>
                            <p class="card-text">Narxi: <%= product.getPrice() %> so'm</p>
                            <form action="/deleteProduct" method="post">
                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                <button type="submit" class="btn btn-remove">O'chirish</button>
                            </form>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <form action="/admin/addProduct.jsp" method="get">
                <button type="submit" class="btn btn-primary mt-3">Mahsulot Qo'shish</button>
            </form>
            <%
                }
            %>
        </div>
    </div>
</div>
</body>
</html>
