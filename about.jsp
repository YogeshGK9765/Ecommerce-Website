<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us | E-commerce</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background:#f8f9fa; }
        .about-section { padding: 60px 20px; text-align:center; }
        .about-section h2 { color:#0d6efd; font-weight:bold; margin-bottom:20px; }
        .about-section p.lead { font-size:1.1rem; color:#444; }
        .services-section { padding: 60px 20px; }
        .service-card { transition: transform 0.3s, box-shadow 0.3s; border:none; }
        .service-card:hover { transform: translateY(-6px); box-shadow:0px 6px 20px rgba(0,0,0,0.12); }
        .service-icon { font-size:42px; color:#0d6efd; margin-bottom:15px; }
        .disclaimer { background: #e9f3ff; padding:20px; border-left:5px solid #0d6efd; margin-top:40px; }
    </style>
</head>
<body>

<!-- Navbar Include -->
<jsp:include page="homenav.jsp"/>

<!-- About Section -->
<section class="about-section">
    <div class="container">
        <h2>About Our E-commerce Platform</h2>
        <p class="lead">
            Welcome to <strong>Our E-commerce</strong>! We provide a wide range of products with unbeatable deals, secure shopping, and referral rewards.
        </p>
        <p>
            From electronics to fashion and study resources, we aim to make online shopping simple, fun, and rewarding.  
            Our platform is designed for students and customers seeking convenience, quality, and exclusive offers.
        </p>
    </div>
</section>

<!-- Services Section -->
<section class="services-section">
    <div class="container">
        <h2 class="text-center mb-5">Our Services</h2>
        <div class="row g-4">
            <div class="col-md-6 col-lg-4">
                <div class="card service-card text-center p-4 h-100 shadow-sm">
                    <i class="bi bi-box-seam service-icon"></i>
                    <h5>Wide Product Range</h5>
                    <p>Explore thousands of products across multiple categories including electronics, fashion, and accessories.</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card service-card text-center p-4 h-100 shadow-sm">
                    <i class="bi bi-tags service-icon"></i>
                    <h5>Exclusive Deals</h5>
                    <p>Save more with seasonal offers, coupons, and discount promotions on your favorite products.</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card service-card text-center p-4 h-100 shadow-sm">
                    <i class="bi bi-shield-lock service-icon"></i>
                    <h5>Secure Payments</h5>
                    <p>Shop with confidence using our safe and reliable payment methods with multiple options.</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card service-card text-center p-4 h-100 shadow-sm">
                    <i class="bi bi-cart service-icon"></i>
                    <h5>Easy Shopping</h5>
                    <p>Seamless user-friendly shopping experience with product search, filters, and quick checkout.</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card service-card text-center p-4 h-100 shadow-sm">
                    <i class="bi bi-award service-icon"></i>
                    <h5>Quality Guarantee</h5>
                    <p>All products are quality-checked to ensure customer satisfaction and trust in every purchase.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Disclaimer -->
<div class="container disclaimer rounded">
    <h5><i class="bi bi-info-circle-fill"></i> Important Notice</h5>
    <p>
        All products and services on this platform are for legitimate customer use.  
        Offers, discounts are subject to terms and conditions.  
        Enjoy safe, secure, and verified shopping.
    </p>
</div>

<!-- Footer Include -->
<jsp:include page="footer.html"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
