<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="adminnav.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add New Product</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f9f9f9; font-family: Arial, sans-serif; }
        .container { max-width: 700px; margin: 50px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
        h2 { text-align: center; margin-bottom: 30px; }
        .form-label { font-weight: 500; }
        .btn-submit { margin-top: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Add New Product 🛒</h2>

    <%
        String message = "";
        if(request.getParameter("submit") != null){
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String priceStr = request.getParameter("price");
            String quantityStr = request.getParameter("quantity");
            String discountStr = request.getParameter("discount");
            String imageUrl = request.getParameter("image_url");

            try {
                double price = Double.parseDouble(priceStr);
                int quantity = Integer.parseInt(quantityStr);
                int discount = Integer.parseInt(discountStr);

                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO products (name, description, category, price, quantity, discount, image_url) VALUES (?, ?, ?, ?, ?, ?, ?)"
                );
                ps.setString(1, name);
                ps.setString(2, description);
                ps.setString(3, category);
                ps.setDouble(4, price);
                ps.setInt(5, quantity);
                ps.setInt(6, discount);
                ps.setString(7, imageUrl);

                int result = ps.executeUpdate();
                if(result > 0){
                    message = "<div class='alert alert-success'>Product added successfully!</div>";
                } else {
                    message = "<div class='alert alert-danger'>Failed to add product.</div>";
                }
                ps.close();
                con.close();
            } catch(Exception e){
                message = "<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>";
            }
        }
        out.println(message);
    %>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">Product Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="3" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Category</label>
            <select name="category" class="form-control" required>
                <option value="">Select Category</option>
                <%
                    // Fetch categories from DB
                    try {
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery("SELECT * FROM categories ORDER BY name ASC");
                        while(rs.next()){
                %>
                <option value="<%= rs.getString("name") %>"><%= rs.getString("name") %></option>
                <%
                        }
                        rs.close();
                        st.close();
                        con.close();
                    } catch(Exception e) {
                        out.println("<option value=''>Error loading categories</option>");
                    }
                %>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Price (₹)</label>
            <input type="number" step="0.01" name="price" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Quantity</label>
            <input type="number" name="quantity" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Discount (%)</label>
            <input type="number" name="discount" class="form-control" value="0">
        </div>
        <div class="mb-3">
            <label class="form-label">Image URL</label>
            <input type="text" name="image_url" class="form-control" required>
        </div>
        <button type="submit" name="submit" class="btn btn-success btn-submit w-100">Add Product</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
