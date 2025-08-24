<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up | E-commerce</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f0f2f5;
            animation: fadeIn 1.2s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .main-container {
            display: flex;
            justify-content: space-between;
            padding: 60px 10%;
            gap: 40px;
        }

        /* Left Form */
        .signup-form {
            flex: 1;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .signup-form h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .signup-form input[type="text"],
        .signup-form input[type="password"],
        .signup-form input[type="email"],
        .signup-form input[type="tel"] {
            width: 100%;
            padding: 12px;
            font-size: 1rem;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .signup-form input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #0d6efd;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .signup-form input[type="submit"]:hover {
            background-color: #084298;
            transform: scale(1.02);
        }

        .form-link {
            text-align: center;
            margin-top: 10px;
            font-size: 0.9rem;
        }

        .form-link a {
            color: #0d6efd;
            text-decoration: none;
        }

        /* Right Info */
        .info-section {
            flex: 1;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .info-section p {
            color: #555;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .info-section a {
            color: #0d6efd;
            text-decoration: none;
        }

        .info-section a:hover {
            text-decoration: underline;
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

<!-- Header Include -->
<jsp:include page="homenav.jsp"/>

<!-- Main Content -->
<div class="main-container">
    <!-- Left: Sign Up Form -->
    <div class="signup-form">
        <h2>Sign Up</h2>
        <form action="signupdb.jsp" method="post">
            <input type="text" name="name" placeholder="Enter Full Name" required>
            <input type="tel" name="mobile" placeholder="Enter Mobile Number" required>
            <input type="email" name="email" placeholder="Enter Gmail ID" required>
            <input type="text" name="user" placeholder="Create new Username" required>
            <input type="password" name="password" placeholder="Create new Password" required>
            <input type="submit" value="Sign Up">
        </form>
        <div class="form-link">
            <p>Already have an account? <a href="signin.jsp">Sign In</a></p>
        </div>
    </div>

    <!-- Right: Platform Info -->
    <div class="info-section">
        <p>Generate sign in page details and terms and conditions link below. Give some info about our eCommerce platform.</p>
        <p>All pages should be identical and look good and attractive with user animation effects if needed.</p>
        <p>Keep in mind that the signup page should be attractive and animated so that users can appreciate your work.</p>
        <p>Click here to read our <a href="support.jsp" target="_blank">Terms & Conditions</a>.</p>
        <p>Animations enhance the user experience and make the interface interactive when users visit this page.</p>
    </div>
</div>

<!-- Footer Include -->
<jsp:include page="footer.html"/>

</body>
</html>
