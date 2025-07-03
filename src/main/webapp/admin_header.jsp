<%@ page contentType="text/html;charset=UTF-8" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="dashboard.jsp">Admin Panel</a>
        <div class="d-flex">
            <a class="nav-link text-white me-3" href="manage_products.jsp">Products</a>
            <a class="nav-link text-white me-3" href="manage_orders.jsp">Orders</a>
            <a class="nav-link text-white me-3" href="manage_users.jsp">Users</a>
            <a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
        </div>
    </div>
</nav>
