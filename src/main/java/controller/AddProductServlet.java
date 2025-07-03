package controller;

import util.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String name = request.getParameter("name");
        String image = request.getParameter("image_url");
        double price = Double.parseDouble(request.getParameter("price"));
        String desc = request.getParameter("description");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO products (name, price, image_url, description) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setString(3, image);
            ps.setString(4, desc);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("manage_products.jsp");
    }
}
