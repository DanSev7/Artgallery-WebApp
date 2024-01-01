package com.artgallery.servlets;

import com.artgallery.util.DBUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import com.artgallery.services.FetchUser;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/artistContent")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // Max file size for image upload
public class ArtistContentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "create":
                createArtistContent(request, response);
                break;
            case "update":
                updateArtistContent(request, response);
                break;
            case "delete":
                deleteArtistContent(request, response);
                break;
            case "retrieve":
                retrieveArtistContent(request, response);
                break;
            default:
                // Handle default case
                break;
        }
    }

    private void createArtistContent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//    	int id = FetchUser.fetchId(request, response);
//		if (id == -1) return;
        try (Connection connection = DBUtil.getConnection()) {
            String artistname = request.getParameter("artistname");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String creationDate = request.getParameter("creationdate");
//            int user_id = id;
            Part filePart = request.getPart("imagedata");
            InputStream imageStream = filePart.getInputStream();

            String sql = "INSERT INTO artist_content (artistname, title, description, category, creationdate, imagedata) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, artistname);
            statement.setString(2, title);
            statement.setString(3, description);
            statement.setString(4, category);
            statement.setString(5, creationDate);
            statement.setBlob(6, imageStream);
//            statement.setInt(7, user_id);

            statement.executeUpdate();
            statement.close();
//            response.sendRedirect("home.jsp");
            response.sendRedirect("admin_home.jsp"); // Redirect to listing page
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }
    }

    private void updateArtistContent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = DBUtil.getConnection()) {
            int contentId = Integer.parseInt(request.getParameter("contentId")); // Assuming you pass contentId for update

            // Retrieve existing content details
            String sqlSelect = "SELECT * FROM artist_content WHERE id = ?";
            PreparedStatement selectStatement = connection.prepareStatement(sqlSelect);
            selectStatement.setInt(1, contentId);
            ResultSet resultSet = selectStatement.executeQuery();

            if (resultSet.next()) {
                // Get existing content details
                String artistname = resultSet.getString("artistname");
                String title = resultSet.getString("title");
                String description = resultSet.getString("description");
                String category = resultSet.getString("category");
                String creationDate = resultSet.getString("creationdate");

                // Update content details based on form inputs
                artistname = request.getParameter("artistname");
                title = request.getParameter("title");
                description = request.getParameter("description");
                category = request.getParameter("category");
                creationDate = request.getParameter("creationdate");

                Part filePart = request.getPart("imagedata");
                InputStream imageStream = filePart.getInputStream();

                // Update content in the database
                String sqlUpdate = "UPDATE artist_content SET artistname = ?, title = ?, description = ?, category = ?, creationdate = ?, imagedata = ? WHERE id = ?";
                PreparedStatement updateStatement = connection.prepareStatement(sqlUpdate);
                updateStatement.setString(1, artistname);
                updateStatement.setString(2, title);
                updateStatement.setString(3, description);
                updateStatement.setString(4, category);
                updateStatement.setString(5, creationDate);
                updateStatement.setBlob(6, imageStream);
                updateStatement.setInt(7, contentId);

                updateStatement.executeUpdate();
                updateStatement.close();
                response.sendRedirect("listArtistContents.jsp"); // Redirect to listing page
            }

            selectStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }
    }
    private void deleteArtistContent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = DBUtil.getConnection()) {
            int contentId = Integer.parseInt(request.getParameter("contentId"));

            String sql = "DELETE FROM artist_content WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, contentId);

            int count = ps.executeUpdate();
            ps.close();

            if (count == 1) {
                // Deletion successful
                response.sendRedirect("listArtistContents.jsp");
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



    private void retrieveArtistContent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int id = FetchUser.fetchId(request, response);
		if (id == -1) return;

        try (Connection connection = DBUtil.getConnection()) {
            int contentId = Integer.parseInt(request.getParameter("contentId")); // Assuming you pass contentId for retrieval

            String sql = "SELECT * FROM artist_content WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, contentId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Set retrieved content details in request attributes for JSP rendering
                request.setAttribute("contentId", resultSet.getInt("id"));
                request.setAttribute("artistname", resultSet.getString("artistname"));
                request.setAttribute("title", resultSet.getString("title"));
                request.setAttribute("description", resultSet.getString("description"));
                request.setAttribute("category", resultSet.getString("category"));
                request.setAttribute("creationdate", resultSet.getString("creationdate"));
                // Add more attributes if needed
            }

            statement.close();

            // Forward to the updateArtistContent.jsp for rendering the retrieved data in update form
            request.getRequestDispatcher("updateArtistContent.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("retrieve".equals(action)) {
            retrieveArtistContent(request, response);
        }
    }
}
