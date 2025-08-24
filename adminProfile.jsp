<%@ page import="java.sql.*" %>
<%@ include file="adminnav.jsp" %>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("signin.jsp");
        return;
    }

    String name = "", email = "", mobile = "", arole = "";
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM signup WHERE user=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            mobile = rs.getString("mobile");
            role = rs.getString("role");
        }
        rs.close();
        ps.close();
        con.close();
    } catch(Exception e) {
        out.println("<p style='color:red;'>Error: "+ e.getMessage() +"</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f9f9f9; font-family: Arial, sans-serif; }
        .profile-container {
            max-width: 700px;
            margin: 40px auto;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        .profile-container h2 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: 600;
            color: #333;
        }
        .profile-row { margin-bottom: 15px; }
        .profile-label { font-weight: 500; color: #555; }
        .profile-value { color: #333; }
        .btn-edit {
            display: block;
            margin: 20px auto 0;
            width: 200px;
        }
    </style>
</head>
<body>

<div class="profile-container">
    <h2>My Profile 👤</h2>

    <div class="profile-row row">
        <div class="col-4 profile-label">Name:</div>
        <div class="col-8 profile-value"><%= name %></div>
    </div>

    <div class="profile-row row">
        <div class="col-4 profile-label">Username:</div>
        <div class="col-8 profile-value"><%= username %></div>
    </div>

    <div class="profile-row row">
        <div class="col-4 profile-label">Email:</div>
        <div class="col-8 profile-value"><%= email %></div>
    </div>

    <div class="profile-row row">
        <div class="col-4 profile-label">Mobile:</div>
        <div class="col-8 profile-value"><%= mobile %></div>
    </div>

    <div class="profile-row row">
        <div class="col-4 profile-label">Role:</div>
        <div class="col-8 profile-value"><%= role %></div>
    </div>

    <a href="editaProfile.jsp" class="btn btn-primary btn-edit">Edit Profile</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ include file="footer.html" %>
