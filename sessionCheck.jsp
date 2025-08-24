<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    if(username == null){
        // User not logged in → redirect to signin page
        response.sendRedirect("signin.jsp");
        return;
    }
%>
