<%@ page import="model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="product" scope="request" class="model.Product" />

<!DOCTYPE html>
<html>
<head>
    <title><%= product.getName() %> - Product Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp" />

<div class="container mt-5">
    <div class="row">
        <div class="col-md-6">
            <img src="<%= product.getImageUrl() %>" class="img-fluid" alt="Product Image">
        </div>
        <div class="col-md-6">
            <h3><%= product.getName() %></h3>
            <p class="text-muted">Category: <%= product.getCategory() %></p>
            <h4>₹ <%= product.getPrice() %></h4>
            <p><%= product.getDescription() %></p>
            <form action="AddToCartServlet" method="post">
                <input type="hidden" name="product_id" value="<%= product.getId() %>">
                <button type="submit" class="btn btn-success">Add to Cart</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>
