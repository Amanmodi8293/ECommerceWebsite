package controller;

import model.CartItem;
import util.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("jsp/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("user_id");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        double total = 0;
        for (CartItem item : cart) {
            total += item.getPrice() * item.getQuantity();
        }

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false); // Start transaction

            // Insert into orders
            String orderSql = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, 'Pending')";
            PreparedStatement orderStmt = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, userId);
            orderStmt.setDouble(2, total);
            orderStmt.executeUpdate();
            ResultSet rs = orderStmt.getGeneratedKeys();
            rs.next();
            int orderId = rs.getInt(1);

            // Insert into order_items
            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement itemStmt = con.prepareStatement(itemSql);
            for (CartItem item : cart) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, item.getProductId());
                itemStmt.setInt(3, item.getQuantity());
                itemStmt.setDouble(4, item.getPrice());
                itemStmt.addBatch();
            }
            itemStmt.executeBatch();

            con.commit(); // Success

            session.removeAttribute("cart");
            response.sendRedirect("order_success.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkout.jsp?error=Order Failed");
        }
    }
}
