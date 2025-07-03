<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>
<%
    Boolean admin = (Boolean) session.getAttribute("admin");
    if (admin == null || !admin) {
        response.sendRedirect("../admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="admin_header.jsp" />
<div class="container mt-5">
    <h2 class="text-center mb-4">🛠️ Admin Dashboard</h2>
    <div class="row text-center">
        <div class="col-md-4 mb-3">
            <a href="manage_products.jsp" class="btn btn-outline-primary w-100">📦 Manage Products</a>
        </div>
        <div class="col-md-4 mb-3">
            <a href="manage_orders.jsp" class="btn btn-outline-success w-100">📋 Manage Orders</a>
        </div>
        <div class="col-md-4 mb-3">
            <a href="manage_users.jsp" class="btn btn-outline-warning w-100">👥 View Users</a>
        </div>
    </div>
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-danger">Logout</a>
    </div>
</div>
</body>
</html>
