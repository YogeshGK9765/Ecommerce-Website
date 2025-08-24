<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f9fafb;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    padding: 20px;
  }
  .confirm-box {
    background: white;
    padding: 30px 40px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    max-width: 400px;
    text-align: center;
  }
  h2 {
    color: #e67e22;
    margin-bottom: 20px;
  }
  p {
    font-size: 18px;
    margin-bottom: 30px;
    color: #333;
  }
  strong {
    color: #d35400;
  }
  form {
    display: flex;
    justify-content: center;
    gap: 20px;
  }
  button {
    background-color: #e67e22;
    color: white;
    border: none;
    padding: 12px 25px;
    font-size: 16px;
    font-weight: 600;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }
  button:hover {
    background-color: #d35400;
  }
  a {
    background-color: #bdc3c7;
    color: #2c3e50;
    padding: 12px 25px;
    text-decoration: none;
    font-weight: 600;
    border-radius: 5px;
    line-height: 1.4;
    transition: background-color 0.3s ease;
  }
  a:hover {
    background-color: #95a5a6;
  }
</style>

<%
    String productId = request.getParameter("productId");
%>

<div class="confirm-box">
  <h2>Confirm Delete</h2>
  <p>Are you sure you want to delete product with ID: <strong><%= productId %></strong>?</p>

  <form action="productActions.jsp?action=delete" method="post">
      <input type="hidden" name="productId" value="<%= productId %>">
      <button type="submit">Yes, Delete</button>
      <a href="viewproducts.jsp">Cancel</a>
  </form>
</div>
