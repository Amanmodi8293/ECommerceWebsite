<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="admin_header.jsp" />
<div class="container col-md-4 mt-5">
    <h3 class="text-center mb-4">Admin Login</h3>
    <form action="${pageContext.request.contextPath}/AdminLoginServlet" method="post">
        <div class="mb-3">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button class="btn btn-dark w-100">Login</button>
    </form>
</div>
</body>
</html>
