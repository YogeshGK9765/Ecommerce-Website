<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #f9f9f9;
        color: #333;
        padding: 20px;
    }
    h2 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 20px;
        font-weight: 700;
    }
    table {
        border-collapse: collapse;
        width: 100%;
        max-width: 900px;
        margin: 0 auto;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        background: #fff;
        border-radius: 8px;
        overflow: hidden;
    }
    th, td {
        padding: 12px 15px;
        text-align: center;
    }
    th {
        background-color: #3498db;
        color: white;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }
    tr:nth-child(even) {
        background-color: #f2f6fc;
    }
    tr:hover {
        background-color: #d6eaff;
        cursor: default;
    }
</style>

<%
    String url = "jdbc:mysql://localhost:3306/student";  // your DB
    String dbUser = "root"; 
    String dbPass = "0000";

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, dbUser, dbPass);
        st = con.createStatement();
        rs = st.executeQuery("SELECT * FROM signup");
%>

<h2>Registered Customers</h2>
<table>
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Mobile</th>
        <th>Username</th>
        <th>Password</th>
    </tr>
<%
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("mobile") %></td>
        <td><%= rs.getString("user") %></td>
        <td><%= rs.getString("password") %></td>
    </tr>
<%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (st != null) try { st.close(); } catch (SQLException ignore) {}
        if (con != null) try { con.close(); } catch (SQLException ignore) {}
    }
%>
</table>
