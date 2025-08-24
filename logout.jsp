<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate session to logout user
    if (session != null) {
        session.invalidate();
    }

    // Redirect to login page or home page
    response.sendRedirect("signin.jsp"); 
%>
