<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="usernav.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f9f9f9;
            font-family: Arial, sans-serif;
        }
        .orders-container {
            max-width: 900px;
            margin: 30px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        }
        .orders-container h2 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: 600;
            color: #333;
        }
        .order-box {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 25px;
            background: #fefefe;
        }
        .order-header {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 10px;
            color: #444;
        }
        .status {
            font-size: 14px;
            font-weight: normal;
            margin-left: 8px;
            color: #777;
        }
        .empty-orders {
            text-align: center;
            padding: 30px;
            color: #666;
        }
        table th, table td {
            font-size: 14px;
            padding: 8px;
        }
    </style>

</head>
<body>

<div class="orders-container">
    <h2>My Orders 📦</h2>

    <%
        String username = (String) session.getAttribute("username"); // get username from session
        if (username != null) {
            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
                
                // get userId from signup table
                PreparedStatement psUser = con.prepareStatement("SELECT id FROM signup WHERE user=?");
                psUser.setString(1, username);
                ResultSet rsUser = psUser.executeQuery();
                int userId = 0;
                if(rsUser.next()) {
                    userId = rsUser.getInt("id");
                }
                rsUser.close();
                psUser.close();
                
                // fetch orders
                PreparedStatement ps = con.prepareStatement("SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC");
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();

                boolean hasOrders = false;
                while(rs.next()) {
                    hasOrders = true;
                    int oid = rs.getInt("order_id");
                    double totalAmount = rs.getDouble("total_amount");
    %>
        <div class="order-box">
            <div class="order-header">
                Order #<%= oid %> 
                <span class="status">(Status: <%= rs.getString("status") %>)</span>
            </div>
            <table class="table table-bordered text-center align-middle">
                <thead class="table-secondary">
                    <tr>
                        <th>Product</th>
                        <th>Qty</th>
                        <th>Price (₹)</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    PreparedStatement ps2 = con.prepareStatement(
                        "SELECT p.name, oi.quantity, oi.price " +
                        "FROM order_items oi JOIN products p ON oi.product_id=p.product_id " +
                        "WHERE oi.order_id=?"
                    );
                    ps2.setInt(1, oid);
                    ResultSet rs2 = ps2.executeQuery();
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
                    ps2.close();
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
            <h4>You don’t have any orders yet 😔</h4>
            <p><a href="product.jsp" class="btn btn-primary mt-3">Start Shopping</a></p>
        </div>
    <%
                }

                rs.close();
                ps.close();
                con.close();
            } catch(Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        } else {
    %>
        <p class="text-danger text-center">Please login to view your orders.</p>
    <%
        }
    %>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
