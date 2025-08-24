<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="adminnav.jsp" %>

<%
    String message = "";
    int productId = 0;
    String name = "", description = "", category = "", imageUrl = "";
    double price = 0.0;
    int quantity = 0, discount = 0;

    if(request.getParameter("id") != null) {
        productId = Integer.parseInt(request.getParameter("id"));
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM products WHERE product_id=?");
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                name = rs.getString("name");
                description = rs.getString("description");
                category = rs.getString("category");
                price = rs.getDouble("price");
                quantity = rs.getInt("quantity");
                discount = rs.getInt("discount");
                imageUrl = rs.getString("image_url");
            }
            rs.close();
            ps.close();
            con.close();
        } catch(Exception e) {
            message = "<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>";
        }
    }

    if(request.getParameter("update") != null) {
        String newName = request.getParameter("name");
        String newDescription = request.getParameter("description");
        String newCategory = request.getParameter("category");
        double newPrice = Double.parseDouble(request.getParameter("price"));
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));
        int newDiscount = Integer.parseInt(request.getParameter("discount"));
        String newImageUrl = request.getParameter("image_url");

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
            PreparedStatement ps = con.prepareStatement(
                "UPDATE products SET name=?, description=?, category=?, price=?, quantity=?, discount=?, image_url=? WHERE product_id=?"
            );
            ps.setString(1, newName);
            ps.setString(2, newDescription);
            ps.setString(3, newCategory);
            ps.setDouble(4, newPrice);
            ps.setInt(5, newQuantity);
            ps.setInt(6, newDiscount);
            ps.setString(7, newImageUrl);
            ps.setInt(8, productId);

            int result = ps.executeUpdate();
            if(result > 0) {
                message = "<div class='alert alert-success'>Product updated successfully!</div>";
                name = newName;
                description = newDescription;
                category = newCategory;
                price = newPrice;
                quantity = newQuantity;
                discount = newDiscount;
                imageUrl = newImageUrl;
            } else {
                message = "<div class='alert alert-danger'>Failed to update product.</div>";
            }

            ps.close();
            con.close();
        } catch(Exception e) {
            message = "<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f9f9f9; font-family: Arial, sans-serif; }
        .container { max-width: 600px; margin: 50px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
        h2 { text-align: center; margin-bottom: 30px; }
        .form-label { font-weight: 500; }
        .btn-submit { margin-top: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Edit Product 🛒</h2>

    <%= message %>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">Product Name</label>
            <input type="text" name="name" class="form-control" value="<%= name %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="3" required><%= description %></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Category</label>
            <input type="text" name="category" class="form-control" value="<%= category %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Price (₹)</label>
            <input type="number" step="0.01" name="price" class="form-control" value="<%= price %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Quantity</label>
            <input type="number" name="quantity" class="form-control" value="<%= quantity %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Discount (%)</label>
            <input type="number" name="discount" class="form-control" value="<%= discount %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Image URL</label>
            <input type="text" name="image_url" class="form-control" value="<%= imageUrl %>" required>
        </div>
        <button type="submit" name="update" class="btn btn-primary btn-submit w-100">Update Product</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
