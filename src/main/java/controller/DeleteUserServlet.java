package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.DBConnection;

import java.io.IOException;
import java.sql.*;



@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection()) {

            // STEP 1: Delete order_items linked to user's orders
            String deleteOrderItemsSql = "DELETE FROM order_items WHERE order_id IN (SELECT id FROM orders WHERE user_id = ?)";
            PreparedStatement ps1 = conn.prepareStatement(deleteOrderItemsSql);
            ps1.setInt(1, userId);
            ps1.executeUpdate();

            // STEP 2: Delete orders of this user
            String deleteOrdersSql = "DELETE FROM orders WHERE user_id = ?";
            PreparedStatement ps2 = conn.prepareStatement(deleteOrdersSql);
            ps2.setInt(1, userId);
            ps2.executeUpdate();

            // STEP 3: Delete the user
            String deleteUserSql = "DELETE FROM users WHERE id = ?";
            PreparedStatement ps3 = conn.prepareStatement(deleteUserSql);
            ps3.setInt(1, userId);
            int rowsAffected = ps3.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("manage_users.jsp?msg=deleted");
            } else {
                response.sendRedirect("manage_users.jsp?msg=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_users.jsp?msg=error");
        }
    }
}
