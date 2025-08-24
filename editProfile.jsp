<%@ page import="java.sql.*" %>
<%@ include file="usernav.jsp" %>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("signin.jsp");
        return;
    }

    String name = "", email = "", mobile = "", role = "";
    String message = "";
    
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ecommerce","root","966566");
        
        // Handle form submission
        if(request.getMethod().equalsIgnoreCase("POST")) {
            String newName = request.getParameter("name");
            String newEmail = request.getParameter("email");
            String newMobile = request.getParameter("mobile");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            
            // Check current password
            PreparedStatement psCheck = con.prepareStatement("SELECT password FROM signup WHERE user=?");
            psCheck.setString(1, username);
            ResultSet rsCheck = psCheck.executeQuery();
            if(rsCheck.next()) {
                String dbPassword = rsCheck.getString("password");
                if(dbPassword.equals(currentPassword) || currentPassword.isEmpty()) {
                    // Update profile
                    if(newPassword == null || newPassword.trim().isEmpty()) newPassword = dbPassword; // Keep old password if blank
                    PreparedStatement psUpdate = con.prepareStatement(
                        "UPDATE signup SET name=?, email=?, mobile=?, password=? WHERE user=?"
                    );
                    psUpdate.setString(1, newName);
                    psUpdate.setString(2, newEmail);
                    psUpdate.setString(3, newMobile);
                    psUpdate.setString(4, newPassword);
                    psUpdate.setString(5, username);
                    int updated = psUpdate.executeUpdate();
                    if(updated > 0) {
                        message = "Profile updated successfully!";
                        name = newName; email = newEmail; mobile = newMobile;
                    } else {
                        message = "No changes were made.";
                    }
                    psUpdate.close();
                } else {
                    message = "Current password is incorrect!";
                }
            }
            rsCheck.close();
            psCheck.close();
        }
        
        // Load current info if first visit or after update
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
    <title>Edit Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f9f9f9; font-family: Arial, sans-serif; }
        .edit-container { max-width: 600px; margin: 40px auto; background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 3px 10px rgba(0,0,0,0.1); }
        .edit-container h2 { text-align: center; margin-bottom: 20px; font-weight: 600; color: #333; }
        .form-label { font-weight: 500; }
        .btn-submit { display: block; margin: 20px auto 0; width: 200px; }
        .message { text-align: center; margin-bottom: 15px; font-weight: 500; }
    </style>
</head>
<body>

<div class="edit-container">
    <h2>Edit Profile</h2>
    <% if(!message.isEmpty()) { %>
        <p class="message text-success"><%= message %></p>
    <% } %>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" name="name" class="form-control" value="<%= name %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" value="<%= email %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Mobile</label>
            <input type="text" name="mobile" class="form-control" value="<%= mobile %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Role (cannot change)</label>
            <input type="text" class="form-control" value="<%= role %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Current Password (required to change password)</label>
            <input type="password" name="currentPassword" class="form-control">
        </div>

        <div class="mb-3">
            <label class="form-label">New Password</label>
            <input type="password" name="newPassword" class="form-control">
        </div>

        <button type="submit" class="btn btn-primary btn-submit">Update Profile</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ include file="footer.html" %>
