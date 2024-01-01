package com.artgallery.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.artgallery.util.UserAuthentication;
import com.artgallery.util.DBUtil;

//@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try (Connection connection = DBUtil.getConnection()) {
            boolean isAuthenticated = false;
            String role = "";
            
            // Check if the user is registered as an admin
            if (UserAuthentication.isAdmin(connection, username)) {
                isAuthenticated = UserAuthentication.authenticateAdmin(connection, username, password);
                role = "admin";
            } else {
                isAuthenticated = UserAuthentication.authenticate(connection, username, password);
                role = "user";
            }
            
            if (isAuthenticated) {
                    
            	int userId = UserAuthentication.authenticateAndGetUserId(connection, username, password);
            	if (userId != -1) {
            		request.getSession().setAttribute("uid", userId);
                    
                    if (role.equalsIgnoreCase("admin")) {
                        response.sendRedirect("admin_home.jsp");
                    } else if (role.equalsIgnoreCase("user")) {
                        response.sendRedirect("home.jsp");
                    } else {
                        // Handle other roles or errors
                        response.sendRedirect("error.jsp");
                    }
                    return;
                }
            }
            
            // If authentication fails
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions properly in a real application
        }
    }
}
