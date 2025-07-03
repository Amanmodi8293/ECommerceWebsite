<%@ page import="java.util.*, model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" %>
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
    <title>Your Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container mt-5">
    <h3 class="mb-4">🛒 Your Shopping Cart</h3>

<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
%>
    <div class="alert alert-warning">Your cart is empty. <a href="index.jsp">Shop now</a></div>
<%
    } else {
        double grandTotal = 0;
%>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Product</th>
                <th>Qty</th>
                <th>Price</th>
                <th>Subtotal</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            for (CartItem item : cart) {
                double subtotal = item.getPrice() * item.getQuantity();
                grandTotal += subtotal;
        %>
            <tr>
                <td><%= item.getProductName() %></td>
                <td>
                    <form action="${pageContext.request.contextPath}/UpdateCartServlet" method="post">
				    <input type="hidden" name="productId" value="<%=item.getProductId()%>">
				    <input type="number" name="quantity" value="<%=item.getQuantity()%>" min="1" required>
				    <button type="submit" class="btn btn-primary">Update</button>
				</form>
                </td>
                <td>₹<%= item.getPrice() %></td>
                <td>₹<%= subtotal %></td>
                <td>
                    <form action="${pageContext.request.contextPath}/RemoveFromCartServlet" method="post">
                        <input type="hidden" name="product_id" value="<%= item.getProductId() %>">
                        <button type="submit" class="btn btn-sm btn-danger">Remove</button>
                    </form>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <div class="d-flex justify-content-between align-items-center">
        <a href="index.jsp" class="btn btn-outline-secondary">← Continue Shopping</a>
        <h5>Total: ₹<%= grandTotal %></h5>
        <a href="checkout.jsp" class="btn btn-success">Proceed to Checkout →</a>
    </div>

<%
    }
%>
</div>

</body>
</html>
