<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container col-md-6 mt-5">
    <h3 class="mb-4">Checkout</h3>
    <form action="${pageContext.request.contextPath}/PaymentServlet" method="post">
        <div class="mb-3">
            <label>Full Name:</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Address:</label>
            <textarea name="address" class="form-control" required></textarea>
        </div>
        <div class="mb-3">
            <label>Phone:</label>
            <input type="text" name="phone" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Total Amount:</label>
            <input type="text" name="total" class="form-control" value="499.00" readonly>
        </div>
        <button class="btn btn-success w-100">Pay Now</button>
    </form>
</div>
</body>
</html>
