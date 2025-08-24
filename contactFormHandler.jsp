<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contact Form Handler</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce", "root", "966566");

        String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
        ps = con.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, subject);
        ps.setString(4, message);

        int rows = ps.executeUpdate();
        if (rows > 0) {
%>
            <div class="container text-center mt-5">
                <div class="alert alert-success shadow-lg rounded">
                    <h4 class="alert-heading">✅ Message Sent!</h4>
                    <p>Thank you, <strong><%= name %></strong>. We have received your message and will get back to you shortly.</p>
                    <a href="index.jsp" class="btn btn-primary mt-3">Go Back Home</a>
                </div>
            </div>
<%
        } else {
%>
            <div class="container text-center mt-5">
                <div class="alert alert-danger shadow-lg rounded">
                    <h4 class="alert-heading">❌ Failed!</h4>
                    <p>Sorry, your message could not be sent. Please try again.</p>
                    <a href="contact.jsp" class="btn btn-danger mt-3">Back to Contact Page</a>
                </div>
            </div>
<%
        }
    } catch (Exception e) {
        out.println("<div class='container text-center mt-5'><div class='alert alert-danger'>Error: " + e.getMessage() + "</div></div>");
    } finally {
        try { if (ps != null) ps.close(); if (con != null) con.close(); } catch (Exception ignored) {}
    }
%>

</body>
</html>
