package com.artgallery.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.artgallery.util.DBUtil;

@WebServlet("/userMan")
public class UserManagement extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            
            case "delete":
                deleteUser(request, response);
                break;
            case "retrieve":
            	//retrieveUser(request, response);
            	
            default:
                // Handle default case or invalid action
                break;
        }
    }
	
	private void deleteUser (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try (Connection connection = DBUtil.getConnection()) {
            int contentId = Integer.parseInt(request.getParameter("contentId"));

            String sql = "DELETE FROM users WHERE user_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, contentId);

            int count = ps.executeUpdate();
            ps.close();

            if (count == 1) {
                // Deletion successful
                response.sendRedirect("userManagement.jsp");
            } else {
                // Deletion unsuccessful (content not found or other issue)
                response.sendRedirect("error.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
            response.sendRedirect("error.jsp");
        }
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("retrieve".equals(action)) {
           // retrieveUser(request, response);
        }
    }
}


