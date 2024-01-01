<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.artgallery.model.ArtistWork" %>
<%@ page import="com.artgallery.dao.ArtGalleryDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>
<%@ page import="com.artgallery.util.DBUtil" %>

<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Additional CSS or styles -->
    <style>
        /* Your custom styles here */

        /* Navbar styles */
        .navbar {
            overflow: hidden;
            background-color: #333;
            display: flex;
            justify-content: space-between; /* Aligns items at both ends */
            align-items: center; /* Aligns items vertically in the center */
            padding: 10px;
        }

        .navbar a {
            display: inline-block; /* Displays links as blocks */
            color: #f2f2f2;
            text-align: center;
            padding: 16px 18px;
            text-decoration: none;
            margin-right: 20px; /* Adjust margin between links */
        }

        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }

        /* Search box styles */
        .search-box {
            display: flex;
            align-items: center; /* Align items vertically */
        }

        .search-box input[type="text"] {
            width: 300px; /* Adjust the width of the input field */
            padding: 8px;
            margin-right: 5px; /* Margin between input and button */
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .search-box button {
            padding: 8px 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .filter select {
        	margin-right: 5px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        
        .filter button {
        	padding: 8px 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .add-btn-fav {
        	padding: 8px 15px;
            border: 1px solid #b7b7b7;
            border-radius: 5px;
            cursor: pointer;
        }
        

        /* Logout link styles */
        .logout-link {
            margin-right: 20px;
        }

        /* Art gallery styles */
        .art-gallery {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-top: 0px;
        }

        .art-gallery1 {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-top: 5px;
        }

        .art-card {
            width: 300px;
            margin: 10px;
            margin-top:30px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .art-card img {
            width: 100%;
            border-radius: 5px;
        }
        
        .home-nav{
            display: flex;
            align-items: center;
        }
        
    </style>
</head>
<body>

<div class="navbar art-gallery">
    <div class="home-nav">
        <div>
            <a href="home.jsp">Home</a>
        </div>
        <div class="filter">
            <form action="#" method="GET">
                <select name="category">
                    <option value="">All</option>
                    <option value="portrait">Portrait</option>
                    <option value="abstract">Abstract</option>
                </select>
                <button type="submit">Filter</button>
            </form>
        </div>
    </div>
    <div class="search-box">
	    <form action="#" method="GET">
	        <input type="text" placeholder="Search by Title or Artist" name="search">
	        <button type="submit">Search</button>
	    </form>
	</div>

    
    <div>
        <a href="listArtistContents.jsp">Art lists</a>
        <a href="adminList.jsp" class="logout-link">Admin</a>
    </div>
</div>

<div class="art-gallery1">
    <%
        int idCounter = 1; // Initialize the ID counter
        String selectedCategory = request.getParameter("category"); // Get the selected category from the request
        String searchQuery = request.getParameter("search"); // Get the search parameter from the request

        try (Connection connection = DBUtil.getConnection()) {
            String sql;
            PreparedStatement statement;

            if (selectedCategory != null && !selectedCategory.isEmpty()) {
                // Filter by category if a category is selected
                sql = "SELECT * FROM artist_content WHERE category = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, selectedCategory);
            } else if (searchQuery != null && !searchQuery.isEmpty()) {
                // Search by title or artist name if a search query is provided
                sql = "SELECT * FROM artist_content WHERE title LIKE ? OR artistname LIKE ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, "%" + searchQuery + "%");
                statement.setString(2, "%" + searchQuery + "%");
            } else {
                // Fetch all records if no category or search query is selected
                sql = "SELECT * FROM artist_content";
                statement = connection.prepareStatement(sql);
            }

            ResultSet resultSet = statement.executeQuery();
            boolean found = false; // Flag to track if any records are found

            while (resultSet.next()) {
                // Retrieve the data from the result set
                int id = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String artist = resultSet.getString("artistname");
                String category = resultSet.getString("category");
                Blob imageBlob = resultSet.getBlob("imagedata");
                String imgData = "";
                if (imageBlob != null) {
                    int blobLength = (int) imageBlob.length();
                    byte[] imageBytes = imageBlob.getBytes(1, blobLength);
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    String mimeType = "image/jpeg"; // Change if your image format differs
                    imgData = "data:" + mimeType + ";base64," + base64Image;
                }
    %>
                <div class="art-card">
                    <img src="<%= imgData %>" alt="Artwork">
                    <h3><%= title %></h3>
                    <h4><%= artist %></h4>
                    <p><%= category %></p>
                    
                </div>
    <%
                found = true; // Records found
            }

            // Display a message if no records are found
            if (!found) {
    %>
                <div class="no-results">
                    <p>No available artist or art.</p>
                </div>
    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }
    %>
</div>

<!-- ...existing code... -->

</body>
</html>
