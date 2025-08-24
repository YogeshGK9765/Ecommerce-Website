<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="adminnav.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Categories</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f9f9f9; font-family: Arial, sans-serif; }
        .container { max-width: 1200px; margin: 40px auto; }
        .category-table { background-color: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
        .category-table th, .category-table td { text-align: center; vertical-align: middle; }
        .category-actions a { margin: 0 5px; }
        .empty-categories { text-align: center; padding: 40px; color: #666; }
        .search-bar, .add-category-form { background: #fff; padding: 12px; border-radius: 10px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); margin-bottom: 20px; display: flex; gap: 10px; align-items: center; }
        .search-bar input, .add-category-form input { flex: 1; padding: 8px; border-radius: 5px; border: 1px solid #ccc; }
        .search-bar button, .add-category-form button { padding: 8px 15px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; }
        .search-bar button:hover, .add-category-form button:hover { background-color: #0056b3; }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Manage Categories 🗂️</h2>

    <!-- Search Bar -->
    <form method="get" class="search-bar">
        <input type="text" name="query" placeholder="Search by ID or Name" value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
        <button type="submit">Search</button>
        <a href="manageCategories.jsp" class="btn btn-secondary">Reset</a>
    </form>

    <!-- Add Category Form -->
    <form method="post" action="manageCategories.jsp" class="add-category-form">
        <input type="text" name="name" placeholder="Category Name" required>
        <input type="text" name="description" placeholder="Description" required>
        <button type="submit" name="addCategory">Add Category</button>
    </form>

<%
    // Handle Add Category POST
    if("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("addCategory") != null) {
        String newName = request.getParameter("name");
        String newDesc = request.getParameter("description");

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
            PreparedStatement psAdd = con.prepareStatement("INSERT INTO categories(name, description) VALUES(?, ?)");
            psAdd.setString(1, newName);
            psAdd.setString(2, newDesc);
            int i = psAdd.executeUpdate();
            psAdd.close();
            con.close();
            if(i > 0) {
                out.println("<p style='color:green;'>Category added successfully!</p>");
            } else {
                out.println("<p style='color:red;'>Failed to add category.</p>");
            }
        } catch(Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        }
    }

    String searchQuery = request.getParameter("query");
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
        PreparedStatement ps;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            ps = con.prepareStatement("SELECT * FROM categories WHERE id LIKE ? OR name LIKE ? ORDER BY id DESC");
            ps.setString(1, "%" + searchQuery + "%");
            ps.setString(2, "%" + searchQuery + "%");
        } else {
            ps = con.prepareStatement("SELECT * FROM categories ORDER BY id DESC");
        }
        ResultSet rs = ps.executeQuery();

        boolean hasCategories = rs.isBeforeFirst(); // Check if result set has rows
        if(hasCategories) {
%>
    <div class="category-table">
        <table class="table table-bordered table-hover">
            <thead class="table-secondary">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
<%
            while(rs.next()) {
%>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td class="category-actions">
                        <a href="editCategory.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-primary">Edit</a>
                        <a href="deleteCategory.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?');">Delete</a>
                    </td>
                </tr>
<%
            }
%>
            </tbody>
        </table>
    </div>
<%
        } else {
%>
    <div class="empty-categories">
        <h4>No categories found 😔</h4>
    </div>
<%
        }
        rs.close();
        ps.close();
        con.close();
    } catch(Exception e) {
        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
    }
%>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
