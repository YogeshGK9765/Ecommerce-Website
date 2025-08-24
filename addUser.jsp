<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="adminnav.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add New User</title>
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
    <h2>Add New User 👤</h2>

    <%
        String message = "";
        if(request.getParameter("submit") != null){
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String username = request.getParameter("user");
            String password = request.getParameter("password");
            String userRole = request.getParameter("role"); // renamed variable

            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO signup (name, email, mobile, user, password, role) VALUES (?, ?, ?, ?, ?, ?)"
                );
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, mobile);
                ps.setString(4, username);
                ps.setString(5, password);
                ps.setString(6, userRole); // updated here

                int result = ps.executeUpdate();
                if(result > 0){
                    message = "<div class='alert alert-success'>User added successfully!</div>";
                } else {
                    message = "<div class='alert alert-danger'>Failed to add user.</div>";
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
            <label class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Mobile</label>
            <input type="text" name="mobile" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="user" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Role</label>
            <select name="role" class="form-control" required>
                <option value="">Select Role</option>
                <option value="user">User</option>
                <option value="admin">Admin</option>
            </select>
        </div>
        <button type="submit" name="submit" class="btn btn-success btn-submit w-100">Add User</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
