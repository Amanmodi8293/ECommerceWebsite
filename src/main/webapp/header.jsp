<%@page import="model.CartItem"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userName = (String) session.getAttribute("user_name");
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">🛒 MyStore</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">

                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>

                <% if (session.getAttribute("user_id") != null) { %>
                <%
				    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
				    int cartCount = (cart != null) ? cart.size() : 0;
				%>
				<a href="cart.jsp" class="btn btn-outline-light">
				    🛒 Cart (<%= cartCount %>)
				</a>

                    <li class="nav-item">
                        <a class="nav-link" href="my_orders.jsp">My Orders</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-info">Hi, <%= userName %></a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link btn btn-sm btn-danger text-white ms-2" href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="signup.jsp">Signup</a>
                    </li>
                <% } %>

            </ul>
        </div>
    </div>
</nav>
