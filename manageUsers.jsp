<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="adminnav.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f9f9f9; font-family: Arial, sans-serif; }
        .container { max-width: 1200px; margin: 40px auto; }
        .user-table { background-color: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
        .user-table th, .user-table td { text-align: center; vertical-align: middle; }
        .user-actions a { margin: 0 5px; }
        .empty-users { text-align: center; padding: 40px; color: #666; }
        .search-bar { background: #fff; padding: 12px; border-radius: 10px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); margin-bottom: 20px; display: flex; gap: 10px; align-items: center; }
        .search-bar input { flex: 1; padding: 8px; border-radius: 5px; border: 1px solid #ccc; }
        .search-bar button { padding: 8px 15px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; }
        .search-bar button:hover { background-color: #0056b3; }
        .add-btn { margin-bottom: 20px; }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Manage Users 👥</h2>


    <!-- Search Bar -->
    <form method="get" class="search-bar">
        <input type="text" name="query" placeholder="Search by ID or Name" value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
        <button type="submit">Search</button>
        <a href="manageUsers.jsp" class="btn btn-secondary">Reset</a>
    </form>

    <!-- Add New User Button -->
    <a href="addUser.jsp" class="btn btn-success add-btn">+ Add New User</a>

    <%
        String searchQuery = request.getParameter("query");
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
            PreparedStatement ps;
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                ps = con.prepareStatement("SELECT * FROM signup WHERE id LIKE ? OR name LIKE ? ORDER BY id DESC");
                ps.setString(1, "%" + searchQuery + "%");
                ps.setString(2, "%" + searchQuery + "%");
            } else {
                ps = con.prepareStatement("SELECT * FROM signup ORDER BY id DESC");
            }
            ResultSet rs = ps.executeQuery();

            boolean hasUsers = rs.isBeforeFirst(); // Check if result set has rows
            if(hasUsers) {
    %>

    <div class="user-table">
        <table class="table table-bordered table-hover">
            <thead class="table-secondary">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Username</th>
                    <th>Role</th>
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
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("mobile") %></td>
                    <td><%= rs.getString("user") %></td>
                    <td><%= rs.getString("role") %></td>
                    <td class="user-actions">
                        <a href="editUser.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-primary">Edit</a>
                        <a href="deleteUser.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?');">Delete</a>
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
        <div class="empty-users">
            <h4>No users found 😔</h4>
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
