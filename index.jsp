<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>E-commerce | Home</title>
    <style>
	body {
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	    background: #f4f4f9;
	}

	/* Navbar */
	.navbar {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    background: #fff;
	    padding: 12px 40px;
	    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	}
	.navbar img { height: 50px; }
	.navbar ul {
	    list-style: none;
	    display: flex;
	    gap: 18px;
	    margin: 0;
	    padding: 0;
	}
	.navbar ul li a {
	    text-decoration: none;
	    color: #333;
	    font-weight: 500;
	}
	.navbar ul li a:hover { color: #0077ff; }

	/* Hero Section */
	.hero {
	    position: relative;
	    background: url('images/bodyback1.jpg') no-repeat center center/cover;
	    height: 500px;
	    display: flex;
	    align-items: center;
	    justify-content: flex-start; /* align content to left */
	    color: #fff;
	    overflow: hidden;
	    padding-left: 60px; /* push text leftwards from edge */
	}

	.hero-overlay {
	    position: absolute;
	    top: 0; left: 0;
	    width: 100%;
	    height: 100%;
	    background: rgba(0,0,0,0.45);
	    display: flex;
	    align-items: center;
	    justify-content: flex-start; /* keep text left */
	    text-align: left;
	    padding-left: 60px; /* move content slightly left from center */
	}

	.hero-content h4 {
	    font-size: 28px;
	    color: #00ffd5;
	    letter-spacing: 2px;
	    margin-bottom: 10px;
	    animation: slideInTop 1s ease-out forwards;
	}

	.hero-content h1 {
	    font-size: 48px;
	    font-weight: 700;
	    margin-bottom: 15px;
	    animation: slideInBottom 1s ease-out forwards;
	}

	.hero-content p {
	    font-size: 18px;
	    margin-bottom: 20px;
	    color: #fff;
	    animation: fadeIn 2s ease-out forwards;
	}

	.hero-btn {
	    background: #007bff;
	    color: #fff;
	    padding: 12px 30px;
	    text-decoration: none;
	    font-weight: 600;
	    border-radius: 6px;
	    transition: background 0.3s, transform 0.3s;
	}

	.hero-btn:hover {
	    background: #0056b3;
	    transform: scale(1.05);
	}


	/* Animations */
	@keyframes slideInTop {
	    0% { opacity: 0; transform: translateY(-50px);}
	    100% { opacity: 1; transform: translateY(0);}
	}
	@keyframes slideInBottom {
	    0% { opacity: 0; transform: translateY(50px);}
	    100% { opacity: 1; transform: translateY(0);}
	}
	@keyframes fadeIn {
	    0% { opacity: 0;}
	    100% { opacity: 1;}
	}

	/* Featured Products */
	.container {
	    width: 90%;
	    margin: auto;
	    padding: 40px 0;
	}
	h2 {
	    text-align: center;
	    color: #333;
	    margin-bottom: 30px;
	}
	.products {
	    display: grid;
	    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	    gap: 20px;
	}
	.product {
	    background: #fff;
	    padding: 15px;
	    border-radius: 10px;
	    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
	    text-align: center;
	    transition: 0.3s;
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
	}
	.btn:hover { background: #0056b3; }

	/* Categories */
	.categories {
	    display: grid;
	    grid-template-columns: repeat(auto-fit, minmax(200px,1fr));
	    gap: 20px;
	    margin-top: 40px;
	}
	.category {
	    background: #fff;
	    padding: 20px;
	    text-align: center;
	    border-radius: 10px;
	    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
	    cursor: pointer;
	    transition: 0.3s;
	}
	.category:hover {
	    background: #0077ff;
	    color: #fff;
	}

    </style>
</head>
<body>

<!-- Navbar -->
<jsp:include page="homenav.jsp" />

<!-- Hero Section -->
<div class="hero">
    <div class="hero-overlay">
        <div class="hero-content hero-left">
            <h4>Super Value Deals</h4>
            <h1>On All Products</h1>
            <p>Save more with coupons & up to 70% off!</p>
            <a href="shop.jsp" class="hero-btn">Shop Now</a>
        </div>
    </div>
</div>

<div class="container">

    <!-- Featured Products -->
    <h2>Featured Products</h2>
    <div class="products">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM products ORDER BY created_at DESC LIMIT 8");
                while(rs.next()) {
        %>
        <div class="product">
            <img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("name") %>">
            <h3><%= rs.getString("name") %></h3>
            <p><%= rs.getString("description") %></p>
            <p class="price">₹<%= rs.getDouble("price") %></p>
            <button class="btn">Buy Now</button>
        </div>
        <%
                }
                conn.close();
            } catch(Exception e){ out.println("<p style='color:red;'>DB Error: "+e.getMessage()+"</p>"); }
        %>
    </div>

    <!-- Categories -->
    <h2>Shop by Categories</h2>
    <div class="categories">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM categories");
                while(rs.next()) {
        %>
        <div class="category">
            <h3><%= rs.getString("name") %></h3>
            <p><%= rs.getString("description") %></p>
        </div>
       	<%
                }
                conn.close();
            } catch(Exception e){ out.println("<p style='color:red;'>DB Error: "+e.getMessage()+"</p>"); }
        %>
    </div>

</div>

<!-- Footer -->
<jsp:include page="footer.html" />

</body>
</html>
