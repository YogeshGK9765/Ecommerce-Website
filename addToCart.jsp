<%@ page import="java.util.*, java.net.*" %>
<%
    String name = request.getParameter("name");
    String priceStr = request.getParameter("price");
    String quantityStr = request.getParameter("quantity");

    if (name == null || priceStr == null || quantityStr == null || name.isEmpty() || priceStr.isEmpty() || quantityStr.isEmpty()) {
%>
        <h2>Error: Missing product data!</h2>
        <p>Please make sure you're adding a valid product to the cart.</p>
        <a href="index.jsp">Go back</a>
<%
    } else {
        try {
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);

            // Create product map
            Map<String, Object> product = new HashMap<>();
            product.put("name", name);
            product.put("price", price);
            product.put("quantity", quantity);

            // Retrieve cart from session
            List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            boolean found = false;
            for (Map<String, Object> item : cart) {
                if (item.get("name").equals(name)) {
                    int existingQty = (int) item.get("quantity");
                    item.put("quantity", existingQty + quantity);
                    found = true;
                    break;
                }
            }

            if (!found) {
                cart.add(product);
            }

            session.setAttribute("cart", cart);
%>
            <h2>Product Added to Cart</h2>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Price:</strong> ₹<%= price %></p>
            <p><strong>Quantity:</strong> <%= quantity %></p>
            <a href="cart.jsp">View Cart</a> |
            <a href="index.jsp">Continue Shopping</a>
<%
        } catch (Exception e) {
%>
            <h2>Error parsing price or quantity.</h2>
            <p><%= e.getMessage() %></p>
            <a href="index.jsp">Go back</a>
<%
        }
    }
%>
