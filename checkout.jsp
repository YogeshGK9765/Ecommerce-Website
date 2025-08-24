<%@ page import="java.util.*,java.sql.*" %>
<%
    HashMap<Integer,Integer> cart = (HashMap<Integer,Integer>) session.getAttribute("cart");
    int userId = (int) session.getAttribute("userId"); // from login

    if (cart != null && !cart.isEmpty()) {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
        con.setAutoCommit(false);

        PreparedStatement ps = con.prepareStatement("INSERT INTO orders(user_id,status) VALUES (?,?)", Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, userId);
        ps.setString(2, "Placed");
        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        int orderId = 0;
        if (rs.next()) orderId = rs.getInt(1);

        PreparedStatement ps2 = con.prepareStatement("INSERT INTO order_items(order_id,product_id,quantity,price) VALUES (?,?,?,?)");

        for (Map.Entry<Integer,Integer> entry : cart.entrySet()) {
            int pid = entry.getKey();
            int qty = entry.getValue();

            PreparedStatement ps3 = con.prepareStatement("SELECT price FROM products WHERE product_id=?");
            ps3.setInt(1, pid);
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) {
                double price = rs3.getDouble(1);
                ps2.setInt(1, orderId);
                ps2.setInt(2, pid);
                ps2.setInt(3, qty);
                ps2.setDouble(4, price);
                ps2.executeUpdate();
            }
        }

        con.commit();
        session.removeAttribute("cart"); // clear cart
        out.println("<h3>Order placed successfully! Your Order ID: "+orderId+"</h3>");
    } else {
        out.println("<h3>Your cart is empty.</h3>");
    }
%>
