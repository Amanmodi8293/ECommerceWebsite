<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, util.DBConnection" %>
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
    <title>Manage Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="admin_header.jsp" />
<div class="container mt-5">
    <h3 class="mb-4">📋 Manage All Orders</h3>

    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>User ID</th>
            <th>Name</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Status</th>
            <th>Order Time</th>
            <th>Update</th>
        </tr>
        </thead>
        <tbody>
        <%
            try (Connection con = DBConnection.getConnection()) {
                String sql = "SELECT * FROM orders ORDER BY order_time DESC";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getInt("user_id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("status") %></td>
            <td><%= rs.getTimestamp("order_time") %></td>
            <td>
                <form action="${pageContext.request.contextPath}/UpdateOrderStatusServlet" method="post" class="d-flex">
                    <input type="hidden" name="order_id" value="<%= rs.getInt("id") %>">
                    <select name="status" class="form-select me-2" required>
                        <option <%= rs.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>
                        <option <%= rs.getString("status").equals("Shipped") ? "selected" : "" %>>Shipped</option>
                        <option <%= rs.getString("status").equals("Delivered") ? "selected" : "" %>>Delivered</option>
                    </select>
                    <button class="btn btn-sm btn-success">Update</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
