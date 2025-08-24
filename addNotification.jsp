<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="adminnav.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Notification</title>
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
    <h2>Add New Notification 📢</h2>

    <%
        String message = "";
        if(request.getParameter("submit") != null) {
            String title = request.getParameter("title");
            String msg = request.getParameter("message");

            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO notifications (title, message) VALUES (?, ?)"
                );
                ps.setString(1, title);
                ps.setString(2, msg);

                int result = ps.executeUpdate();
                if(result > 0){
                    message = "<div class='alert alert-success'>Notification added successfully!</div>";
                } else {
                    message = "<div class='alert alert-danger'>Failed to add notification.</div>";
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
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Message</label>
            <textarea name="message" class="form-control" rows="5" required></textarea>
        </div>
        <button type="submit" name="submit" class="btn btn-success btn-submit w-100">Add Notification</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
