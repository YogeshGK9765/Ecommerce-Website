<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    // Session check → only logged-in users allowed
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("signin.jsp");
        return;
    }
    String user = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Shop | E-commerce</title>
    <style>
    /* General */
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background: #f9f9f9;
    }

    .container { width: 90%; margin: auto; padding: 40px 0; }

    h2 { text-align: center; color: #333; margin-bottom: 30px; }

    /* Search & Filter */
    .search-filter { display: flex; gap: 20px; margin-bottom: 30px; justify-content: center; flex-wrap: wrap; }
    .search-filter input, .search-filter select {
        padding: 8px 12px;
        border-radius: 5px;
        border: 1px solid #ccc;
        font-size: 14px;
    }
    .search-filter button { margin-left: 10px; }

    /* Products Grid */
    .products {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 20px;
    }

    .product {
        background: #ffffff;
        padding: 15px;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08);
        text-align: center;
        transition: transform 0.3s;
    }
    .product:hover { transform: translateY(-5px); }

    .product img {
        width: 100%;
        height: 150px;
        object-fit: cover;
        border-radius: 8px;
    }

    .product h3 { margin: 10px 0; font-size: 18px; }
    .product p { color: #555; font-size: 14px; }
    .price { color: #e74c3c; font-weight: bold; }

    .btn {
        background: #007bff;
        border: none;
        color: #fff;
        padding: 8px 14px;
        margin-top: 10px;
        cursor: pointer;
        border-radius: 5px;
        transition: background 0.3s, transform 0.3s;
    }
    .btn:hover { background: #0056b3; transform: scale(1.05); }

    .categories {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px,1fr));
        gap: 20px;
        margin-top: 40px;
    }
    .category {
        background: #ffffff;
        padding: 20px;
        text-align: center;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        cursor: pointer;
        transition: background 0.3s, color 0.3s;
    }
    .category:hover { background: #007bff; color: #fff; }
    </style>
</head>
<body>

<!-- ✅ User Navbar -->
<jsp:include page="usernav.jsp" />

<div class="container">
    <h2>Shop All Products</h2>

    <!-- Search & Filter Section -->
    <div class="search-filter">
        <!-- Search Form -->
        <form action="shop.jsp" method="get" style="flex:1; display:flex; min-width:200px;">
            <input type="text" name="search" placeholder="Search products..." 
                   value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <button type="submit" class="btn">Search</button>
        </form>

        <!-- Category Filter -->
        <form action="shop.jsp" method="get" style="flex:0.5; min-width:150px;">
            <select name="category">
                <option value="">All Categories</option>
                <% 
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
                    Statement stmt = conn.createStatement();
                    ResultSet crs = stmt.executeQuery("SELECT * FROM categories");
                    String selectedCategory = request.getParameter("category");
                    while(crs.next()) {
                        String catId = crs.getString("category_id");
                %>
                    <option value="<%= catId %>" <%= (selectedCategory != null && catId.equals(selectedCategory)) ? "selected" : "" %>>
                        <%= crs.getString("name") %>
                    </option>
                <%
                    }
                    conn.close();
                } catch(Exception e) { out.println("<option>Error loading categories</option>"); }
                %>
            </select>
            <button type="submit" class="btn">Filter</button>
        </form>
    </div>

    <!-- Products Grid -->
    <div class="products">
        <%
            String search = request.getParameter("search");
            String category = request.getParameter("category");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
                Statement stmt = conn.createStatement();
                String query = "SELECT * FROM products WHERE 1=1";
                if(search != null && !search.isEmpty()) query += " AND name LIKE '%" + search + "%'";
                if(category != null && !category.isEmpty()) query += " AND category_id=" + category;
                query += " ORDER BY created_at DESC";

                ResultSet rs = stmt.executeQuery(query);
                while(rs.next()) {
        %>
        <div class="product">
            <img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("name") %>">
            <h3><%= rs.getString("name") %></h3>
            <p><%= rs.getString("description") %></p>
            <p class="price">₹<%= rs.getDouble("price") %></p>

            <form action="check_login.jsp" method="get">
                <input type="hidden" name="product_id" value="<%= rs.getInt("product_id") %>">
                <button type="submit" class="btn">Buy Now</button>
            </form>
        </div>
        <%
                }
                conn.close();
            } catch(Exception e) { out.println("<p style='color:red;'>DB Error: "+e.getMessage()+"</p>"); }
        %>
    </div>
</div>

<!-- ✅ Footer -->
<jsp:include page="footer.html" />

</body>
</html>
