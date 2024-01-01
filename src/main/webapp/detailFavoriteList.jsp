<%@ page import="java.sql.*, java.io.*, java.util.Base64" %>
<%@ page import="com.artgallery.util.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fetch Artist Content</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .art-details-box {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px #000000;
            margin-top: 50px; /* Adjust margin-top if needed */
        }
        
        .art-image {
            max-width: 310px;
            max-height: 310px;
            padding: 5px; /* Add padding to the image */
            margin-bottom: 20px; /* Add margin-bottom to create space between image and next div */
        }
        
	    .btn-light {
	     	background-color: lightgray;
	    }
	    
	    .btn-light:hover {
	    	background-color: silver;
	  	}
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="art-details-box">
                    <h3>Art Details</h3>
                    <hr>
                    <% 
                        String imgData = "";
                        try {
                            Connection connection = DBUtil.getConnection();
                            int contentId = Integer.parseInt(request.getParameter("contentId"));

                            // Logic to fetch content details based on contentId
                            String sql = "SELECT * FROM favorite_list WHERE id = ?";
                            PreparedStatement statement = connection.prepareStatement(sql);
                            statement.setInt(1, contentId);
                            ResultSet resultSet = statement.executeQuery();

                            if (resultSet.next()) {
                                String artistname = resultSet.getString("artistname");
                                String title = resultSet.getString("title");
                                String description = resultSet.getString("description");
                                String category = resultSet.getString("category");
                                String creationDate = resultSet.getString("creationdate");
                                Blob imageBlob = resultSet.getBlob("imagedata");
                                if (imageBlob != null) {
                                    int blobLength = (int) imageBlob.length();
                                    byte[] imageBytes = imageBlob.getBytes(1, blobLength);
                                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                                    String mimeType = "image/jpeg"; // Change if your image format differs
                                    imgData = "data:" + mimeType + ";base64," + base64Image;
                                }
                    %>

                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="imagedata">Image</label><br>
                               <% if (!imgData.isEmpty()) { %>
								    <div class="art-image">
								        <img src="<%= imgData %>" class="img-fluid" /><br><br>
								        <!-- Download button -->
								        <a href="<%= imgData %>" download="artwork_image.jpg">
								            <button>Download Image</button>
								        </a>
								    </div>
								<% } %>

                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="form-group">
                                <label for="artistname">Artist Name</label>
                                <input type="text" readonly value="<%= artistname %>" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" readonly value="<%= title %>" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="description">Description</label>
                                <textarea readonly rows="3" class="form-control"><%= description %></textarea>
                            </div>
                            <div class="form-group">
                                <label for="category">Category</label>
                                <input type="text" readonly value="<%= category %>" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="creationdate">Creation Date</label>
                                <input type="text" readonly value="<%= creationDate %>" class="form-control">
                            </div>
                        </div>
                    </div>
                    <a href="favorite_list.jsp" class="btn btn-light">Go Back</a>
                    <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        // Handle exceptions
                    }
                    %>
                </div>
            </div>
        </div>
    </div>
    
</body>
</html>