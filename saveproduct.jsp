<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String action = request.getParameter("action");
    String url = "jdbc:mysql://localhost:3307/ecommerce?useSSL=false";
    String dbUser = "root";
    String dbPass = "966566";

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, dbUser, dbPass);

        if ("save".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String quantityStr = request.getParameter("quantity");
            String category = request.getParameter("category");
            String brand = request.getParameter("brand");
           // String image = request.getParameter("image");

            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);

            String query = "INSERT INTO products (name, description, price, quantity, category, brand,) VALUES (?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, description);
            pst.setDouble(3, price);
            pst.setInt(4, quantity);
            pst.setString(5, category);
            pst.setString(6, brand);
           // pst.setString(7, image);

            int rows = pst.executeUpdate();
            response.sendRedirect("viewproducts.jsp");
            out.println(rows > 0 ? "Product added successfully." : "Failed to add product.");

        } else if ("delete".equals(action)) {
            String productId = request.getParameter("product_id");
            pst = con.prepareStatement("DELETE FROM products WHERE product_id = ?");
            pst.setInt(1, Integer.parseInt(productId));
            int rows = pst.executeUpdate();
            out.println(rows > 0 ? "Deleted successfully." : "Product not found.");

        } else if ("update".equals(action)) {
            String productId = request.getParameter("product_id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String category = request.getParameter("category");
            String brand = request.getParameter("brand");
            //String image = request.getParameter("image");

            pst = con.prepareStatement("UPDATE products SET name=?, description=?, price=?, quantity=?, category=?, brand=?, WHERE product_id=?");
            pst.setString(1, name);
            pst.setString(2, description);
            pst.setDouble(3, price);
            pst.setInt(4, quantity);
            pst.setString(5, category);
            pst.setString(6, brand);
            //pst.setString(7, image);
            pst.setInt(8, Integer.parseInt(productId));

            int rows = pst.executeUpdate();
            out.println(rows > 0 ? "Updated successfully." : "Product not found.");

        } else if ("find".equals(action)) {
            String productId = request.getParameter("product_id");
            pst = con.prepareStatement("SELECT * FROM products WHERE product_id = ?");
            pst.setInt(1, Integer.parseInt(productId));
            rs = pst.executeQuery();
            if (rs.next()) {
                out.println("<h3>Product Found:</h3>");
                out.println("Name: " + rs.getString("name") + "<br>");
                out.println("Price: " + rs.getDouble("price") + "<br>");
                out.println("Quantity: " + rs.getInt("quantity") + "<br>");
                out.println("Category: " + rs.getString("category") + "<br>");
                out.println("Brand: " + rs.getString("brand") + "<br>");
            } else {
                out.println("Product not found.");
            }
        } else {
            out.println("Invalid action.");
        }

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pst != null) pst.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>
