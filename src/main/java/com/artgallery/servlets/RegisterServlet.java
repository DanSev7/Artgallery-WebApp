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
import com.artgallery.util.DBUtil; // Import the DBUtil class

//@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");
	    //String role = request.getParameter("role"); // Retrieve the role

	    // Get database connection
	    try (Connection connection = DBUtil.getConnection()) {
	        boolean isUsernameAvailable = UserAuthentication.isUsernameAvailable(connection, username);

	        if (isUsernameAvailable) {
	            // Register the user with role
	            UserAuthentication.registerUser(connection, username, password);
	            response.sendRedirect("login.jsp");
	        } else {
	            request.setAttribute("error", "Username already exists");
	            request.getRequestDispatcher("register.jsp").forward(request, response);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace(); // Handle exceptions properly in a real application
	    }
	}
}
