<%@ page import="java.sql.*, util.DBConnection" %>
<%
    Boolean admin = (Boolean) session.getAttribute("admin");
    if (admin == null || !admin) {
        response.sendRedirect("../admin_login.jsp");
        return;
    }

    int productId = Integer.parseInt(request.getParameter("id"));
    String name = "", image = "", desc = "";
    double price = 0;

    try (Connection con = DBConnection.getConnection()) {
        String sql = "SELECT * FROM products WHERE id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, productId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            image = rs.getString("image_url");
            price = rs.getDouble("price");
            desc = rs.getString("description");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="admin_header.jsp" />
<div class="container mt-5">
    <h3 class="mb-4">Edit Product</h3>
    <form action="${pageContext.request.contextPath}/EditProductServlet" method="post">
        <input type="hidden" name="id" value="<%= productId %>">
        <div class="mb-3">
            <label>Name:</label>
            <input type="text" name="name" class="form-control" value="<%= name %>" required>
        </div>
        <div class="mb-3">
            <label>Price:</label>
            <input type="number" name="price" class="form-control" step="0.01" value="<%= price %>" required>
        </div>
        <div class="mb-3">
            <label>Image URL:</label>
            <input type="text" name="image_url" class="form-control" value="<%= image %>" required>
        </div>
        <div class="mb-3">
            <label>Description:</label>
            <textarea name="description" class="form-control" rows="3"><%= desc %></textarea>
        </div>
        <button class="btn btn-success">Update Product</button>
    </form>
</div>
</body>
</html>
