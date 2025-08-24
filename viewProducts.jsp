<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>View Products</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            padding: 20px;
        }

        .table-container {
            max-width: 1200px;
            margin: auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 30px;
        }

        img {
            max-width: 80px;
            height: auto;
            border-radius: 6px;
        }
    </style>
</head>
<body>

<div class="table-container">
    <h2>Available Products</h2>

    <%
        String url = "jdbc:mysql://localhost:3307/ecommerce?useSSL=false";
        String dbUser = "root";
        String dbPass = "966566";

        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, dbUser, dbPass);
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM products");
    %>

    <table class="table table-bordered table-striped table-hover">
        <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price (₹)</th>
            <th>Quantity</th>
            <th>Category</th>
            <th>Image</th>
            <th>Discount (%)</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("product_id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= rs.getBigDecimal("price") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td><%= rs.getString("category") %></td>
                <td>
                    <img src="<%= rs.getString("image_url") != null && !rs.getString("image_url").isEmpty() ? rs.getString("image_url") : "https://via.placeholder.com/80" %>" alt="Product Image" />
                </td>
                <td><%= rs.getInt("discount") %></td>
                <td>
                    <a href="updateProduct.jsp?product_id=<%= rs.getInt("product_id") %>" class="btn btn-sm btn-primary">Edit</a>
                    <a href="deleteProduct.jsp?product_id=<%= rs.getInt("product_id") %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <%
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (st != null) try { st.close(); } catch (SQLException ignore) {}
            if (con != null) try { con.close(); } catch (SQLException ignore) {}
        }
    %>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>

</body>
</html>
