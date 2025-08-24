<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<jsp:include page="adminnav.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f9f9f9;
            font-family: Arial, sans-serif;
        }
        .dashboard-container {
            max-width: 1200px;
            margin: 40px auto;
        }
        .dashboard-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .dashboard-header h1 {
            font-weight: bold;
            color: #333;
        }
        .stats-row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .stat-card {
            flex: 1 1 220px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            padding: 25px;
            text-align: center;
            transition: transform 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-card h2 {
            font-size: 32px;
            font-weight: bold;
            color: #007bff;
        }
        .stat-card p {
            font-size: 16px;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <div class="dashboard-header">
        <h1>Welcome to Admin Dashboard</h1>
        <p>Manage your website effectively from here.</p>
    </div>

    <div class="stats-row">
        <%
            Connection con = null;
            int totalUsers = 0, totalOrders = 0, totalProducts = 0;
            double totalRevenue = 0.0;
            try {
                con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce", "root", "966566");

                // Total users
                Statement st1 = con.createStatement();
                ResultSet rs1 = st1.executeQuery("SELECT COUNT(*) FROM signup");
                if(rs1.next()) totalUsers = rs1.getInt(1);
                rs1.close(); st1.close();

                // Total orders
                Statement st2 = con.createStatement();
                ResultSet rs2 = st2.executeQuery("SELECT COUNT(*) FROM orders");
                if(rs2.next()) totalOrders = rs2.getInt(1);
                rs2.close(); st2.close();

                // Total products
                Statement st3 = con.createStatement();
                ResultSet rs3 = st3.executeQuery("SELECT COUNT(*) FROM products");
                if(rs3.next()) totalProducts = rs3.getInt(1);
                rs3.close(); st3.close();

                // Total revenue
                Statement st4 = con.createStatement();
                ResultSet rs4 = st4.executeQuery("SELECT SUM(total_amount) FROM orders WHERE status='Completed'");
                if(rs4.next()) totalRevenue = rs4.getDouble(1);
                rs4.close(); st4.close();

                con.close();
            } catch(Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        %>

        <div class="stat-card">
            <h2><%= totalUsers %></h2>
            <p>Total Users</p>
        </div>
        <div class="stat-card">
            <h2><%= totalProducts %></h2>
            <p>Total Products</p>
        </div>
        <div class="stat-card">
            <h2><%= totalOrders %></h2>
            <p>Total Orders</p>
        </div>
        <div class="stat-card">
            <h2>₹ <%= String.format("%.2f", totalRevenue) %></h2>
            <p>Total Revenue</p>
        </div>
    </div>
</div>

<jsp:include page="footer.html" />

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
