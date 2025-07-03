<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Online Store - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f7f7f7;
        }
        .card {
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .product-img {
            height: 250px;
            object-fit: cover;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
    <div class="container py-4">
        <h2 class="mb-4 text-center">🛍️ Welcome to Our Online Store</h2>
        <div class="row">
            <%
                try {
                    Connection conn = DBConnection.getConnection();
                    String sql = "SELECT * FROM products";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
            %>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <img src="<%= rs.getString("image_url") %>" class="card-img-top product-img" alt="Product Image">
                    <div class="card-body">
                        <h5 class="card-title"><%= rs.getString("name") %></h5>
                        <p class="card-text text-muted"><%= rs.getString("category") %></p>
                        <p class="card-text">₹ <%= rs.getDouble("price") %></p>
                        <a href="ProductDetailsServlet?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-outline-primary">View Details</a>
                        <form action="AddToCartServlet" method="post" class="d-inline">
                            <input type="hidden" name="product_id" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="btn btn-sm btn-success">Add to Cart</button>
                        </form>
                    </div>
                </div>
            </div>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                }
            %>
        </div>
    </div>
</body>
</html>
