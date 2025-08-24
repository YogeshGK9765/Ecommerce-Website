<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us | E-commerce</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background:#f8f9fa; }
        .contact-section { padding:60px 20px; }
        .card { border:none; box-shadow:0 2px 12px rgba(0,0,0,0.08); }
        .card h5 { font-weight:bold; margin-bottom:20px; }
        .btn-primary i { margin-right:6px; }
    </style>
</head>
<body>

<!-- Navbar Include -->
<jsp:include page="homenav.jsp"/>

<!-- Contact Section -->
<div class="container contact-section">
    <div class="row justify-content-center">

        <!-- Contact Info -->
        <div class="col-lg-6 mb-4">
            <div class="card p-4">
                <h5><i class="bi bi-telephone-fill"></i> Contact Information</h5>
                <p><i class="bi bi-geo-alt"></i> Remote Location, India</p>
                <p><i class="bi bi-telephone"></i> +91-XXXXXXXXXX</p>
                <p><i class="bi bi-envelope"></i> support@ecommerce.com</p>
                <p><i class="bi bi-clock"></i> Mon–Sat, 9 AM – 8 PM</p>
            </div>
        </div>

        <!-- Contact Form -->
        <div class="col-lg-6 mb-4">
            <div class="card p-4">
                <h5><i class="bi bi-send-fill"></i> Send us a Message</h5>
                <form action="contactFormHandler.jsp" method="post">
                    <div class="mb-3">
                        <label class="form-label">Your Name</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Message</label>
                        <textarea name="message" rows="5" class="form-control" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-send-fill"></i> Send Message</button>
                </form>
            </div>
        </div>

    </div>
</div>

<!-- Footer Include -->
<jsp:include page="footer.html"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
