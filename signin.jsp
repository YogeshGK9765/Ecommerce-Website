<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign In | E-commerce</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f0f2f5;
        }

        /* Layout */
        .main-container {
            display: flex;
            justify-content: space-between;
            padding: 60px 10%;
            gap: 40px;
        }

        .info-section, .signin-section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            flex: 1;
        }

        /* Info Section */
        .info-section h2 {
            margin-bottom: 15px;
            color: #333;
        }
        .info-section p {
            margin-bottom: 20px;
            color: #555;
            line-height: 1.6;
        }
        .info-section a {
            color: #0d6efd;
            text-decoration: none;
        }
        .info-section a:hover {
            text-decoration: underline;
        }

        /* Signin Form */
        .signin-section h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .signin-section input[type="text"],
        .signin-section input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .signin-section input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #0d6efd;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .signin-section input[type="submit"]:hover {
            background-color: #084298;
            transform: scale(1.02);
        }

        .form-link {
            text-align: center;
            margin-top: 15px;
            font-size: 0.9rem;
        }
        .form-link a {
            color: #0d6efd;
            text-decoration: none;
        }

        @media (max-width: 900px) {
            .main-container {
                flex-direction: column;
                padding: 30px;
            }
        }
    </style>
</head>
<body>

<!-- Header -->
<jsp:include page="homenav.jsp"/>

<!-- Main Content -->
<div class="main-container">
    <!-- Left Info Section -->
    <div class="info-section">
        <h2>Welcome to Our E-commerce Platform</h2>
        <p>Join thousands of users who shop online with us every day. We offer the best deals, fastest delivery, and top-quality products across a wide range of categories.</p>
        <p>By signing in, you agree to our <a href="support.jsp" target="_blank">Terms and Conditions</a>.</p>
        <p>All our pages maintain a consistent, clean, and responsive design to give you the best user experience. We aim for performance, visual appeal, and simplicity in every interaction.</p>
    </div>

    <!-- Right Sign-in Form -->
    <div class="signin-section">
        <h2>Sign In</h2>
        <form action="signinHandler.jsp" method="post">
            <input type="text" name="user" placeholder="Enter Email or Username" required>
            <input type="password" name="pass" placeholder="Enter Password" required>
            <input type="submit" value="Sign In">
        </form>
        <div class="form-link">
            <p>Don't have an account? <a href="signup.jsp">Sign Up</a></p>
            <p><a href="forgotPassword.jsp">Forgot Password?</a></p>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="footer.html"/>

</body>
</html>
