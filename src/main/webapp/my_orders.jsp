<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, util.DBConnection" %>

<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("user_id");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container mt-5">
    <h3 class="mb-4">My Orders</h3>

    <%
        try (Connection con = DBConnection.getConnection()) {
            String orderQuery = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_time DESC";
            PreparedStatement ps = con.prepareStatement(orderQuery);
            ps.setInt(1, userId);
            ResultSet orders = ps.executeQuery();

            while (orders.next()) {
                int orderId = orders.getInt("id");
    %>
    <div class="card mb-4">
        <div class="card-header bg-dark text-white">
            Order ID: <%= orderId %> | Status: <%= orders.getString("status") %> | Total: ₹<%= orders.getDouble("total_amount") %>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Qty</th>
                        <th>Price</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    String itemQuery = "SELECT oi.quantity, oi.price, p.name FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";
                    PreparedStatement itemPS = con.prepareStatement(itemQuery);
                    itemPS.setInt(1, orderId);
                    ResultSet items = itemPS.executeQuery();

                    while (items.next()) {
                        int qty = items.getInt("quantity");
                        double price = items.getDouble("price");
                        String productName = items.getString("name");
                %>
                <tr>
                    <td><%= productName %></td>
                    <td><%= qty %></td>
                    <td>₹<%= price %></td>
                    <td>₹<%= qty * price %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <%
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>
</div>
</body>
</html>
