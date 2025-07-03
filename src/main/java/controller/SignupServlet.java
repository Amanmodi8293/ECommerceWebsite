package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;
import util.DBConnection;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String rawPassword = request.getParameter("password");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        String hashed = BCrypt.hashpw(rawPassword, BCrypt.gensalt());

        try (Connection con = DBConnection.getConnection()) {
            // Check for duplicate email
            PreparedStatement check = con.prepareStatement("SELECT * FROM users WHERE email=?");
            check.setString(1, email);
            ResultSet rs = check.executeQuery();
            if (rs.next()) {
                response.sendRedirect("signup.jsp?error=Email+already+registered");
                return;
            }

            PreparedStatement ps = con.prepareStatement("INSERT INTO users(name, email, password, address, phone) VALUES (?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, hashed);
            ps.setString(4, address);
            ps.setString(5, phone);
            ps.executeUpdate();

            response.sendRedirect("login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=Signup+failed");
        }
    }
}
