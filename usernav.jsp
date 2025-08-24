<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("username") == null) {
        // If not logged in → redirect to signin
        response.sendRedirect("signin.jsp");
        return;
    }
    String user = (String) session1.getAttribute("username");
%>

<!-- ====== USER NAVIGATION BAR ====== -->
<header>
  <nav class="navbar">
    <!-- Left Corner Logo / Brand -->
    <div class="logo">
      <a href="userhome.jsp">
        <img src="images/logo-main.png" alt="ShopSmart Logo" class="nav-logo">
      </a>
    </div>

    <!-- Right Corner Links -->
    <ul class="nav-links">
      <li><a href="userhome.jsp">Home</a></li>
      <li><a href="product.jsp">Products</a></li>
      <li><a href="deals-u.jsp">Deals</a></li>
      <li><a href="cart.jsp">My Cart</a></li>
      <li><a href="orders.jsp">Orders</a></li>
      <li><a href="profile.jsp">Hi, <%= user %> 👤</a></li>
      <li><a href="logout.jsp" class="logout-btn">Logout</a></li>
    </ul>
  </nav>
</header>

<!-- ====== BASIC CSS (same theme as guest navbar) ====== -->
<style>
  .navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #ffffff;
    padding: 14px 40px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    position: sticky;
    top: 0;
    z-index: 1000;
  }

  .nav-logo {
    max-height: 50px;
    width: auto;
    display: block;
  }

  .nav-links {
    list-style: none;
    display: flex;
    gap: 22px;
    margin: 0;
    padding: 0;
  }

  .nav-links a {
    color: #333;
    text-decoration: none;
    font-size: 15px;
    font-weight: 500;
    transition: color 0.3s, transform 0.2s;
  }

  .nav-links a:hover {
    color: #0077ff;
    transform: translateY(-2px);
  }

  /* Logout button style */
  .logout-btn {
    background: #ff4d4d;
    color: #fff !important;
    padding: 6px 12px;
    border-radius: 4px;
    font-weight: 600;
    transition: background 0.3s;
  }

  .logout-btn:hover {
    background: #d93636;
    transform: translateY(-2px);
  }
</style>
