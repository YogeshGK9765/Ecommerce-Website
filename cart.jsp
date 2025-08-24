<%@ page import="java.util.*,java.sql.*" %>
<%@ include file="usernav.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f9f9f9;
        }
        .cart-container {
            max-width: 900px;
            margin: 40px auto;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
            color: #333;
        }
        .btn-checkout {
            width: 100%;
            padding: 12px;
            font-size: 18px;
            border-radius: 8px;
        }
        .empty-cart {
            text-align: center;
            padding: 40px;
            color: #666;
        }
    </style>
</head>
<body>

<div class="cart-container">
    <h2>Your Shopping Cart 🛒</h2>

    <%
        HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) session.getAttribute("cart");
        if (cart != null && !cart.isEmpty()) {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
            Statement st = con.createStatement();
            double grandTotal = 0;
    %>

    <table class="table table-hover text-center align-middle">
        <thead class="table-dark">
            <tr>
                <th>Product</th>
                <th>Qty</th>
                <th>Price (₹)</th>
                <th>Total (₹)</th>
            </tr>
        </thead>
        <tbody>
        <%
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                int pid = entry.getKey();
                int qty = entry.getValue();
                ResultSet rs = st.executeQuery("SELECT * FROM products WHERE product_id=" + pid);
                if (rs.next()) {
                    double price = rs.getDouble("price");
                    double total = price * qty;
                    grandTotal += total;
        %>
            <tr>
                <td><%= rs.getString("name") %></td>
                <td><%= qty %></td>
                <td><%= String.format("%.2f", price) %></td>
                <td><b><%= String.format("%.2f", total) %></b></td>
            </tr>
        <%
                }
            }
        %>
            <tr class="table-light">
                <td colspan="3" class="text-end"><strong>Grand Total</strong></td>
                <td><strong>₹ <%= String.format("%.2f", grandTotal) %></strong></td>
            </tr>
        </tbody>
    </table>

    <form action="checkout.jsp" method="post">
        <button type="submit" class="btn btn-success btn-checkout">Proceed to Checkout</button>
    </form>

    <%
        } else {
    %>
    <div class="empty-cart">
        <h4>Your cart is empty 😔</h4>
        <p><a href="product.jsp" class="btn btn-primary mt-3">Continue Shopping</a></p>
    </div>
    <%
        }
    %>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
