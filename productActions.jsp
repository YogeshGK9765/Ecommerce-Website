<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String action = request.getParameter("action"); // "add", "update", or "delete"
    String url = "jdbc:mysql://localhost:3307/ecommerce?useSSL=false";
    String dbUser = "root";
    String dbPass = "966566";

    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, dbUser, dbPass);

        if ("add".equalsIgnoreCase(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String quantity = request.getParameter("quantity");
            String category = request.getParameter("category");
            String imageUrl = request.getParameter("image_url");

            String sql = "INSERT INTO products (name, description, price, quantity, category, image_url) VALUES (?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, description);
            pst.setBigDecimal(3, new java.math.BigDecimal(price));
            pst.setInt(4, Integer.parseInt(quantity));
            pst.setString(5, category);
            pst.setString(6, imageUrl);

            int rows = pst.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("manageProducts.jsp?msg=Product Added Successfully");
            } else {
                out.println("Error: Product insertion failed.");
            }

        } else if ("update".equalsIgnoreCase(action)) {
            String productId = request.getParameter("product_id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String quantity = request.getParameter("quantity");
            String category = request.getParameter("category");
            String imageUrl = request.getParameter("image_url");

            String sql = "UPDATE products SET name=?, description=?, price=?, quantity=?, category=?, image_url=? WHERE product_id=?";
            pst = con.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, description);
            pst.setBigDecimal(3, new java.math.BigDecimal(price));
            pst.setInt(4, Integer.parseInt(quantity));
            pst.setString(5, category);
            pst.setString(6, imageUrl);
            pst.setInt(7, Integer.parseInt(productId));

            int rows = pst.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("manageProducts.jsp?msg=Product Updated Successfully");
            } else {
                out.println("Error: Product update failed.");
            }

        } else if ("delete".equalsIgnoreCase(action)) {
            String productId = request.getParameter("product_id");
            String sql = "DELETE FROM products WHERE product_id=?";
            pst = con.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(productId));
            int rows = pst.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("manageProducts.jsp?msg=Product Deleted Successfully");
            } else {
                out.println("Error: Product deletion failed.");
            }

        } else {
            out.println("Invalid action specified.");
        }

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (pst != null) try { pst.close(); } catch (SQLException ignore) {}
        if (con != null) try { con.close(); } catch (SQLException ignore) {}
    }
%>
