<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, util.DBConnection" %>
<%
    Boolean admin = (Boolean) session.getAttribute("admin");
    if (admin == null || !admin) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="admin_header.jsp" />
<div class="container mt-5">
    <h3 class="mb-4">Manage Products</h3>

    <a href="add_product.jsp" class="btn btn-primary mb-3">+ Add New Product</a>

    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th><th>Name</th><th>Price</th><th>Image</th><th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            try (Connection con = DBConnection.getConnection()) {
                String sql = "SELECT * FROM products";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td>₹ <%= rs.getDouble("price") %></td>
            <td><img src="<%= rs.getString("image_url") %>" width="60"></td>
            <td>
                <a href="edit_product.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-warning">Edit</a>
                <a href="${pageContext.request.contextPath}/DeleteProductServlet?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger" onclick="return confirm('Delete this product?')">Delete</a>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
