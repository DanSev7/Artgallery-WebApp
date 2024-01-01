package com.artgallery.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.artgallery.util.DBUtil;


@WebServlet("/adminList")
public class AdminListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            
            case "update":
                editAdmin(request, response);
                break;
            case "delete":
                deleteAdmin(request, response);
                break;
            case "retrieve":
            	retrieveAdmin(request, response);
            	
            default:
                // Handle default case or invalid action
                break;
        }
    }
    
    
    
    private void deleteAdmin (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try (Connection connection = DBUtil.getConnection()) {
            int contentId = Integer.parseInt(request.getParameter("contentId"));

            String sql = "DELETE FROM admin WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, contentId);

            int count = ps.executeUpdate();
            ps.close();

            if (count == 1) {
                // Deletion successful
                response.sendRedirect("adminList.jsp");
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
    
    private void editAdmin (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	try (Connection connection = DBUtil.getConnection()) {
            int contentId = Integer.parseInt(request.getParameter("contentId")); // Assuming you pass contentId for update

            // Retrieve existing content details
            String sqlSelect = "SELECT * FROM admin WHERE id = ?";
            PreparedStatement selectStatement = connection.prepareStatement(sqlSelect);
            selectStatement.setInt(1, contentId);
            ResultSet resultSet = selectStatement.executeQuery();

            if (resultSet.next()) {
                // Get existing content details
                String username = resultSet.getString("username");
                String password = resultSet.getString("password");


                // Update content details based on form inputs
                username = request.getParameter("username");
                password = request.getParameter("password");
                
                // Update content in the database
                String sqlUpdate = "UPDATE admin SET username = ?, password = ? WHERE id = ?";
                PreparedStatement updateStatement = connection.prepareStatement(sqlUpdate);
                updateStatement.setString(1, username);
                updateStatement.setString(2, password);
                
                updateStatement.setInt(3, contentId);

                updateStatement.executeUpdate();
                updateStatement.close();
                response.sendRedirect("adminList.jsp"); // Redirect to listing page
            }

            selectStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }
    	
    }
    
    private void retrieveAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = DBUtil.getConnection()) {
            int contentId = Integer.parseInt(request.getParameter("contentId")); // Assuming you pass contentId for retrieval

            String sql = "SELECT * FROM admin WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, contentId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Set retrieved content details in request attributes for JSP rendering
                request.setAttribute("contentId", resultSet.getInt("id"));
                request.setAttribute("username", resultSet.getString("username"));
                request.setAttribute("password", resultSet.getString("password"));
                // Add more attributes if needed
            }

            statement.close();

            // Forward to the updateArtistContent.jsp for rendering the retrieved data in update form
            request.getRequestDispatcher("updateList.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("retrieve".equals(action)) {
            retrieveAdmin(request, response);
        }
    }

}

