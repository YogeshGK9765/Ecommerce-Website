<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String productName = request.getParameter("name");
    String price = request.getParameter("price");
    String quantity = request.getParameter("quantity");
%>


<html>
<head>
    <title>Buy Product</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 50px; }
        form { max-width: 400px; margin: auto; }
        input, select { width: 100%; padding: 10px; margin: 10px 0; }
        button { padding: 10px 20px; background-color: #28a745; color: white; border: none; }
    </style>
</head>
<body>

<h2>Buy Product</h2>

<form action="payment.jsp" method="post">
    <label>Product Name:</label>
    <input type="text" name="productName" value="<%= productName %>" readonly>

    <label>Price:</label>
    <input type="text" name="price" value="<%= price %>" readonly>

    <label>Quantity:</label>
    <input type="number" name="quantity" value="<%= quantity %>" min="1" required>

    <label>Your Name:</label>
    <input type="text" name="buyerName" required>

    <label>Address:</label>
    <input type="text" name="address" required>

    <label>Payment Method:</label>
    <select name="paymentMethod" required>
        <option value="Credit Card">Credit Card</option>
        <option value="Debit Card">Debit Card</option>
        <option value="UPI">UPI</option>
        <option value="Net Banking">Net Banking</option>
        <option value="Cash on Delivery">Cash on Delivery</option>
    </select>

    <button type="submit">Confirm Purchase</button>
</form>

</body>
</html>
