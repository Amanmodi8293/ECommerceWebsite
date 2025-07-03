<!DOCTYPE html>
<html>
<head>
    <title>Customer Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container col-md-5 mt-5">
    <h3 class="text-center mb-4">Customer Login</h3>
    <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
        <div class="mb-3">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button class="btn btn-success w-100">Login</button>
    </form>
    <p class="text-center mt-3">New user? <a href="signup.jsp">Create Account</a></p>
</div>
</body>
<footer class="text-center mt-5 mb-2">
    <a href="admin_login.jsp" class="text-muted small">Admin Login</a>
</footer>
</html>
