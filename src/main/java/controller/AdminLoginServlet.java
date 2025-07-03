package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // ✅ Hardcoded Admin Check (later we can use DB)
        if (email.equals("admin@store.com") && password.equals("admin123")) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", true);
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("admin_login.jsp?error=Invalid+Credentials");
        }
    }
}
