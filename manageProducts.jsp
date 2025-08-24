<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="adminnav.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Products</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f9f9f9; font-family: Arial, sans-serif; }
        .container { margin: 40px auto; max-width: 1200px; }
        .table th, .table td { vertical-align: middle; text-align: center; }
        .action-btn { margin: 0 3px; }
        .add-btn { margin-bottom: 20px; }
        .search-bar { background: #fff; padding: 12px; border-radius: 10px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); margin-bottom: 20px; display: flex; gap: 10px; align-items: center; }
        .search-bar input { flex: 1; padding: 8px; border-radius: 5px; border: 1px solid #ccc; }
        .search-bar button { padding: 8px 15px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; }
        .search-bar button:hover { background-color: #0056b3; }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Manage Products 🛒</h2>


    <!-- Search Bar -->
    <form method="get" class="search-bar">
        <input type="text" name="query" placeholder="Search by ID or Name" value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
        <button type="submit">Search</button>
        <a href="manageProducts.jsp" class="btn btn-secondary">Reset</a>
    </form>

    <!-- Add Product Button -->
    <a href="addProduct.jsp" class="btn btn-success add-btn">+ Add New Product</a>

    <!-- Products Table -->
    <table class="table table-bordered table-hover bg-white">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Category</th>
                <th>Price (₹)</th>
                <th>Quantity</th>
                <th>Discount (%)</th>
                <th>Image</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            String searchQuery = request.getParameter("query");
            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
                PreparedStatement ps;
                if(searchQuery != null && !searchQuery.trim().isEmpty()) {
                    ps = con.prepareStatement("SELECT * FROM products WHERE product_id LIKE ? OR name LIKE ? ORDER BY product_id DESC");
                    ps.setString(1, "%" + searchQuery + "%");
                    ps.setString(2, "%" + searchQuery + "%");
                } else {
                    ps = con.prepareStatement("SELECT * FROM products ORDER BY product_id DESC");
                }

                ResultSet rs = ps.executeQuery();
                boolean hasProducts = rs.isBeforeFirst();
                if(hasProducts) {
                    while(rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("product_id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= rs.getString("category") %></td>
                <td>₹ <%= String.format("%.2f", rs.getDouble("price")) %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td><%= rs.getInt("discount") %></td>
                <td>
                    <img src="<%= rs.getString("image_url") %>" alt="Product" style="width:50px; height:50px; object-fit:cover;">
                </td>
                <td>
                    <a href="updateProduct.jsp?id=<%= rs.getInt("product_id") %>" class="btn btn-primary btn-sm action-btn">Edit</a>
                    <a href="deleteProduct.jsp?id=<%= rs.getInt("product_id") %>" class="btn btn-danger btn-sm action-btn" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
        <%
                    }
                } else {
        %>
            <tr>
                <td colspan="9" class="text-center text-muted">No products found 😔</td>
            </tr>
        <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch(Exception e) {
        %>
            <tr>
                <td colspan="9" class="text-danger">Error: <%= e.getMessage() %></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
