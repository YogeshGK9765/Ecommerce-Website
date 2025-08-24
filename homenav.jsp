<!-- ====== HEADER / NAVIGATION BAR (General with Sign In/Up) ====== -->
<header>
  <nav class="navbar">
    <!-- Left Corner Logo / Brand -->
    <div class="logo">
      <a href="index.jsp">
        <img src="images/logo-main.png" alt="ShopSmart Logo" class="nav-logo">
      </a>
    </div>

    <!-- Right Corner Links -->
    <ul class="nav-links">
      <li><a href="index.jsp">Home</a></li>
      <li><a href="shop.jsp">Shop</a></li>
      <li><a href="deals.jsp">Deals</a></li>
      <li><a href="about.jsp">About Us</a></li>
      <li><a href="support.jsp">Help & Support</a></li>
      <li><a href="signin.jsp">Sign In</a></li>
      <li><a href="signup.jsp" class="signup-btn">Sign Up</a></li>
    </ul>
  </nav>
</header>

<!-- ====== BASIC CSS ====== -->
<style>
  body {
    margin: 0;
    font-family: "Segoe UI", Arial, sans-serif;
    background: #fff;
  }

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

  /* Logo Styling */
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

  /* Highlight Sign Up Button */
  .signup-btn {
    background: #0077ff;
    color: #fff !important;
    padding: 6px 12px;
    border-radius: 4px;
    font-weight: 600;
    transition: background 0.3s;
  }

  .signup-btn:hover {
    background: #005fcc;
    transform: translateY(-2px);
  }
</style>
