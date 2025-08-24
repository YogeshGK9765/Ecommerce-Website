<%@page import="java.sql.*, java.security.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String mobile = request.getParameter("mobile");
    String user = request.getParameter("user");
    String password = request.getParameter("password"); // plain password

    try {
        // Hash password using SHA-256
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(password.getBytes("UTF-8"));
        byte[] digest = md.digest();
        StringBuilder sb = new StringBuilder();
        for (byte b : digest) {
            sb.append(String.format("%02x", b));
        }
        String hashedPassword = sb.toString(); // renamed variable

        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/ecommerce?useSSL=false", "root", "966566");
             PreparedStatement pst = con.prepareStatement(
                     "INSERT INTO signup (name,email,mobile,user,password) VALUES(?,?,?,?,?)")) {

            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, mobile);
            pst.setString(4, user);
            pst.setString(5, hashedPassword); // use hashed password

            int i = pst.executeUpdate();

            if (i == 1) {
                response.sendRedirect("signin.jsp"); // redirect on success
            } else {
                response.sendRedirect("signup.jsp"); // redirect on failure
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("signup.jsp"); // fallback
    }
%>
