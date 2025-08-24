<%@ page import="java.sql.*" %>
<%
    try {
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3307/ecommerce?useSSL=false",
            "root", "966566"
        );

        String sql = "SELECT user, password, role FROM signup WHERE user=? AND password=?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, user);
        pst.setString(2, pass);

        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            String role = rs.getString("role");

            // Save user in session
            session.setAttribute("username", user);
            session.setAttribute("role", role);

            if ("admin".equalsIgnoreCase(role)) {
                RequestDispatcher rd = request.getRequestDispatcher("adminhome.jsp");
                rd.forward(request, response);
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("userhome.jsp");
                rd.forward(request, response);
            }
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("signin.jsp");
            rd.forward(request, response);
        }
    } catch (Exception e1) {
        e1.printStackTrace();
        out.println("Error: " + e1.getMessage());
    }
%>
