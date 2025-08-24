<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="adminnav.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Orders</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f9f9f9; font-family: Arial, sans-serif; }
        .container { margin: 40px auto; max-width: 1200px; }
        .order-box { background-color: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); margin-bottom: 25px; }
        .order-header { font-weight: 600; margin-bottom: 15px; color: #333; display: flex; justify-content: space-between; align-items: center; }
        .status { font-size: 14px; color: #666; }
        .update-btn { margin-left: 10px; }
        table th, table td { text-align: center; vertical-align: middle; }
        .empty-orders { text-align: center; padding: 40px; color: #666; }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Manage Orders 📦</h2>

    <%
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT o.*, s.user FROM orders o JOIN signup s ON o.user_id = s.id ORDER BY order_date DESC");

            boolean hasOrders = false;
            while(rs.next()) {
                hasOrders = true;
                int orderId = rs.getInt("order_id");
                String username = rs.getString("user");
                String status = rs.getString("status");
                Timestamp orderDate = rs.getTimestamp("order_date");
                double totalAmount = rs.getDouble("total_amount");
    %>

    <div class="order-box">
        <div class="order-header">
            <span>Order #<%= orderId %> by <strong><%= username %></strong> on <%= orderDate %></span>
            <span>
                Status: <strong><%= status %></strong>
                <% if(!"Completed".equals(status)) { %>
                    <a href="updateOrderStatus.jsp?id=<%= orderId %>&status=Completed" class="btn btn-success btn-sm update-btn">Mark Completed</a>
                <% } %>
            </span>
        </div>

        <table class="table table-bordered table-hover">
            <thead class="table-secondary">
                <tr>
                    <th>Product</th>
                    <th>Qty</th>
                    <th>Price (₹)</th>
                </tr>
            </thead>
            <tbody>
            <%
                PreparedStatement ps = con.prepareStatement(
                    "SELECT p.name, oi.quantity, oi.price " +
                    "FROM order_items oi JOIN products p ON oi.product_id = p.product_id " +
                    "WHERE oi.order_id=?"
                );
                ps.setInt(1, orderId);
                ResultSet rs2 = ps.executeQuery();
                while(rs2.next()) {
            %>
                <tr>
                    <td><%= rs2.getString("name") %></td>
                    <td><%= rs2.getInt("quantity") %></td>
                    <td>₹ <%= String.format("%.2f", rs2.getDouble("price")) %></td>
                </tr>
            <%
                }
                rs2.close();
                ps.close();
            %>
                <tr class="table-light">
                    <td colspan="2" class="text-end"><strong>Total Amount</strong></td>
                    <td><strong>₹ <%= String.format("%.2f", totalAmount) %></strong></td>
                </tr>
            </tbody>
        </table>
    </div>

    <%
            }
            if(!hasOrders) {
    %>
        <div class="empty-orders">
            <h4>No orders found 😔</h4>
        </div>
    <%
            }
            rs.close();
            st.close();
            con.close();
        } catch(Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        }
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
