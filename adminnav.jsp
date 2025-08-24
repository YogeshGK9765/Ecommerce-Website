<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String admin = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    if (admin == null || !"admin".equals(role)) {
        response.sendRedirect("signin.jsp");
        return;
    }
%>
<style>
    .admin-navbar {
        background-color: #343a40;
        padding: 10px 20px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
    }
    .admin-navbar a {
        color: #fff;
        text-decoration: none;
        margin-right: 15px;
        font-weight: 500;
        padding: 6px 12px;
        border-radius: 5px;
        transition: background 0.2s;
    }
    .admin-navbar a:hover {
        background-color: #495057;
    }
    .navbar-left, .navbar-right {
        display: flex;
        align-items: center;
    }
    .navbar-right {
        gap: 10px;
    }
</style>

<div class="admin-navbar">
    <div class="navbar-left">
        <a href="adminhome.jsp">Dashboard</a>
        <a href="manageProducts.jsp">Products</a>
        <a href="manageOrders.jsp">Orders</a>
        <a href="manageUsers.jsp">Users</a>
        <a href="manageCategories.jsp">Categories</a>
        <a href="notifications.jsp">Notifications</a>
    </div>
    <div class="navbar-right">
        <span style="color:#fff; margin-right:10px;">Welcome, <%= admin %> 👋</span>
        <a href="adminProfile.jsp">Profile</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>
