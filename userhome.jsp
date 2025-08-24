<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("signin.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Home</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { 
            background-color: #f9f9f9; 
            font-family: Arial, sans-serif; 
        }

        .welcome-section { 
            background: #fff; 
            padding: 20px; 
            margin: 30px auto; 
            max-width: 900px; 
            text-align: center; 
            border-radius: 10px; 
            box-shadow: 0 2px 6px rgba(0,0,0,0.1); 
        }
        .welcome-section h1 { 
            font-weight: 600; 
            color: #333; 
            margin-bottom: 10px; 
        }
        .welcome-section p { 
            font-size: 16px; 
            color: #555; 
        }

        .products-container { 
            max-width: 1000px; 
            margin: 0 auto 50px; 
            display: flex; 
            flex-wrap: wrap; 
            gap: 20px; 
            justify-content: center; 
        }

        .product-card { 
            background: #fff; 
            border-radius: 10px; 
            box-shadow: 0 2px 6px rgba(0,0,0,0.1); 
            width: 200px; 
            overflow: hidden; 
            text-align: center; 
            padding-bottom: 15px; 
        }
        .product-card img { 
            width: 100%; 
            height: 160px; 
            object-fit: cover; 
            border-bottom: 1px solid #eee; 
        }
        .product-card h5 { 
            margin: 10px 0 5px; 
            font-size: 16px; 
            font-weight: 600; 
            color: #333; 
        }
        .product-card p { 
            margin: 0 0 10px; 
            font-size: 15px; 
            color: #28a745; 
            font-weight: 500; 
        }
        .product-card a { 
            display: inline-block; 
            padding: 6px 12px; 
            background: #007bff; 
            color: #fff; 
            font-size: 14px;
            border-radius: 6px; 
            text-decoration: none; 
            transition: background 0.2s; 
        }
        .product-card a:hover { 
            background: #0056b3; 
        }
    </style>

</head>
<body>
    <jsp:include page="usernav.jsp" />

    <div class="container">
        <div class="welcome-section">
            <h1>Welcome, <%= username %> 👋</h1>
            <p>Explore our featured products and start shopping today!</p>
        </div>

        <div class="products-container">
            <%
                try {
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
                    Statement st = con.createStatement();
                    // Fetch 8 latest products as featured
                    ResultSet rs = st.executeQuery("SELECT * FROM products ORDER BY created_at DESC LIMIT 8");
                    while(rs.next()) {
                        String pname = rs.getString("name");
                        String image = rs.getString("image_url");
                        double price = rs.getDouble("price");
            %>
            <div class="product-card">
                <img src="<%= image %>" alt="<%= pname %>">
                <h5><%= pname %></h5>
                <p>₹ <%= String.format("%.2f", price) %></p>
                <a href="productDetails.jsp?id=<%= rs.getInt("product_id") %>">View Details</a>
            </div>
            <%
                    }
                    rs.close();
                    st.close();
                    con.close();
                } catch(Exception e) {
                    out.println("<p style='color:red;'>Error loading products: "+ e.getMessage() +"</p>");
                }
            %>
        </div>
    </div>

    <jsp:include page="footer.html" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
