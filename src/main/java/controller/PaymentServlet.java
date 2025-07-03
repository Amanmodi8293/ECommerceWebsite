package controller;

import model.CartItem;
import util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        Integer userId = (Integer) session.getAttribute("user_id");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        double total = 0;
        for (CartItem item : cart) {
            total += item.getQuantity() * item.getPrice();
        }

        try (Connection con = DBConnection.getConnection()) {
            // 1. Insert into orders table
            String orderSql = "INSERT INTO orders (user_id, name, address, phone, total_amount, status, order_time) VALUES (?, ?, ?, ?, ?, 'Pending', NOW())";
            PreparedStatement orderPS = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderPS.setInt(1, userId);
            orderPS.setString(2, name);
            orderPS.setString(3, address);
            orderPS.setString(4, phone);
            orderPS.setDouble(5, total);

            int rows = orderPS.executeUpdate();
            ResultSet generatedKeys = orderPS.getGeneratedKeys();
            int orderId = 0;

            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }

            // 2. Insert each product into order_items
            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement itemPS = con.prepareStatement(itemSql);

            for (CartItem item : cart) {
                itemPS.setInt(1, orderId);
                itemPS.setInt(2, item.getProductId());
                itemPS.setInt(3, item.getQuantity());
                itemPS.setDouble(4, item.getPrice());
                itemPS.addBatch();
            }

            itemPS.executeBatch();

            // 3. Clear cart and redirect
            session.removeAttribute("cart");
            response.sendRedirect("order_success.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
