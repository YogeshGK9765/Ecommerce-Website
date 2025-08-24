<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Update Product</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background-color: #ffffff;
            color: #000000;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container-box {
            max-width: 700px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #000000;
            font-weight: bold;
            margin-bottom: 30px;
        }
    </style>
</head>

<body>
    <div class="container-box">
        <h1>Update Product</h1>

        <%
            String productId = request.getParameter("id"); // FIXED: was "product_id"
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                if (productId == null || productId.isEmpty()) {
                    out.println("<p style='color:red;'>Invalid product ID.</p>");
                    return;
                }

                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce?useSSL=false", "root", "966566");

                String sql = "SELECT * FROM products WHERE product_id = ?";
                pst = con.prepareStatement(sql);
                pst.setInt(1, Integer.parseInt(productId));
                rs = pst.executeQuery();

                if (rs.next()) {
        %>
        <form action="productActions.jsp" method="post">
            <input type="hidden" name="product_id" value="<%= rs.getInt("product_id") %>" />

            <div class="form-group">
                <label for="name">Product Name:</label>
                <input type="text" id="name" name="name" class="form-control" value="<%= rs.getString("name") %>" required />
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" class="form-control" rows="3" required><%= rs.getString("description") %></textarea>
            </div>

            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" step="0.01" id="price" name="price" class="form-control" value="<%= rs.getBigDecimal("price").toPlainString() %>" required />
            </div>

            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" class="form-control" value="<%= rs.getInt("quantity") %>" required />
            </div>

            <div class="form-group">
                <label for="category">Category:</label>
                <input type="text" id="category" name="category" class="form-control" value="<%= rs.getString("category") %>" />
            </div>

            <div class="form-group">
                <label for="image_url">Image URL:</label>
                <input type="text" id="image_url" name="image_url" class="form-control" value="<%= rs.getString("image_url") %>" />
            </div>

            <div class="form-group">
                <label for="discount">Discount (%):</label>
                <input type="number" id="discount" name="discount" class="form-control" value="<%= rs.getInt("discount") %>" />
            </div>

            <button type="submit" name="action" value="update" class="btn btn-success">Update</button>
            <a href="manageProducts.jsp" class="btn btn-warning">Cancel</a>
        </form>
        <%
                } else {
                    out.println("<p style='color:red;'>Product not found.</p>");
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
                if (con != null) try { con.close(); } catch (SQLException ignored) {}
            }
        %>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
</body>

</html>
