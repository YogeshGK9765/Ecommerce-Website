<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user session exists
    String user = (String) session.getAttribute("user");

    if (user == null || user.equals("")) {
        // Not logged in → redirect to signin.jsp
        response.sendRedirect("signin.jsp");
        return; // stop further execution
    }
%>
