package com.artgallery.servlets;

import com.artgallery.services.FetchUser;
import com.artgallery.util.DBUtil;
import com.mysql.cj.jdbc.Blob;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/favoriteList")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // Max file size for image upload
public class FavoriteListServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                addFavoriteToList(request, response);
                break;
            case "delete":
                deleteFavoriteList(request, response);
                break;
            default:
                // Handle default case or invalid action
                break;
        }
    }

    private void addFavoriteToList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int id = FetchUser.fetchId(request, response);
		if (id == -1) return;
    	try (Connection connection = DBUtil.getConnection()) {
            int contentId = Integer.parseInt(request.getParameter("contentId"));

            // Fetch details from artist_content based on contentId
            String selectArtistContentSql = "SELECT * FROM artist_content WHERE id = ?";
            PreparedStatement selectArtistContentStmt = connection.prepareStatement(selectArtistContentSql);
            selectArtistContentStmt.setInt(1, contentId);
            ResultSet artistContentResultSet = selectArtistContentStmt.executeQuery();

            if (artistContentResultSet.next()) {
                // Extract all fields from artist_content
                String artistname = artistContentResultSet.getString("artistname");
                String title = artistContentResultSet.getString("title");
                String description = artistContentResultSet.getString("description");
                String category = artistContentResultSet.getString("category");
                String creationdate = artistContentResultSet.getString("creationdate");
                int user_id = id;
                // Check if the record with similar fields already exists in favorite_list
                String checkSql = "SELECT * FROM favorite_list WHERE artistname = ? AND title = ? AND description = ? AND category = ? AND creationdate = ? And user_id = ?";
                PreparedStatement checkStatement = connection.prepareStatement(checkSql);
                checkStatement.setString(1, artistname);
                checkStatement.setString(2, title);
                checkStatement.setString(3, description);
                checkStatement.setString(4, category);
                checkStatement.setString(5, creationdate);
                checkStatement.setInt(6,user_id);
                ResultSet checkResultSet = checkStatement.executeQuery();

                if (!checkResultSet.next()) {
                    // If no identical record exists, insert into favorite_list
                    String insertSql = "INSERT INTO favorite_list (artistname, title, description, category, creationdate, imagedata, user_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement insertStatement = connection.prepareStatement(insertSql);
                    insertStatement.setString(1, artistname);
                    insertStatement.setString(2, title);
                    insertStatement.setString(3, description);
                    insertStatement.setString(4, category);
                    insertStatement.setString(5, creationdate);
//                    insertStatement.setInt(6, user_id);

                    // Retrieve and set the image data, assuming 'imagedata' is a Blob in favorite_list
                    Blob imageBlob = (Blob) artistContentResultSet.getBlob("imagedata");
                    insertStatement.setBlob(6, imageBlob);
                    insertStatement.setInt(7, user_id);

                    insertStatement.executeUpdate();
                    insertStatement.close();
                }

                checkStatement.close();
            }

            selectArtistContentStmt.close();

            // Redirect to the home page or wherever needed
            response.sendRedirect("home.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
            response.sendRedirect("error.jsp");
        }
    }

    
    private void deleteFavoriteList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = DBUtil.getConnection()) {
            int contentId = Integer.parseInt(request.getParameter("contentId"));

            String deleteSql = "DELETE FROM favorite_list WHERE id = ?";
            PreparedStatement deleteStatement = connection.prepareStatement(deleteSql);
            deleteStatement.setInt(1, contentId);

            int count = deleteStatement.executeUpdate();
            deleteStatement.close();

            if (count == 1) {
                // Deletion successful
                response.sendRedirect("favorite_list.jsp");
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



    // Implement other methods (detailFavoriteList, deleteFavoriteList, retrieveFavoriteList) as per your requirements...

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Implement doGet method as needed for retrieving data or other operations
    }
}
