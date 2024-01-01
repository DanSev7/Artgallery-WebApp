<%@ page import="java.sql.*, java.io.*, java.util.Base64" %>
<%@ page import="com.artgallery.util.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Artist Content</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-box {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px #000000;
            margin-top: 50px; /* Adjust margin-top if needed */
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
        <div class="form-box">
            <form action="artistContent" method="post" enctype="multipart/form-data">

                <% 
                    String imgData = "";
                    try {
                        Connection connection = DBUtil.getConnection();
                        int contentId = Integer.parseInt(request.getParameter("contentId"));

                        // Logic to fetch content details based on contentId
                        String sql = "SELECT * FROM artist_content WHERE id = ?";
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

                <input type="hidden" name="action" value="update">
                <input type="hidden" name="contentId" value="<%= request.getParameter("contentId") %>">

                		<div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="artistname">Artist Name:</label>
                                    <input type="text" name="artistname" value="<%= artistname %>" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="title">Title:</label>
                                    <input type="text" name="title" value="<%= title %>" class="form-control">
                                </div>
                            </div>
                        </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea name="description" rows="3" class="form-control"><%= description %></textarea>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="category">Category:</label>
                            <select id="category" name="category" class="form-control">
                                <option value="Abstract" <%= category.equals("Abstract") ? "selected" : "" %>>Abstract</option>
                                <option value="Portrait" <%= category.equals("Portrait") ? "selected" : "" %>>Portrait</option>
                                <!-- Add other categories -->
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="creationdate">Creation Date:</label>
                            <input type="date" name="creationdate" value="<%= creationDate %>" class="form-control">
                        </div>
                    </div>
                </div>
				<div class="row">
                <div class="form-group col-md-6">
                    <label for="imagedata">Uploaded Image:</label><br>
                    <% if (!imgData.isEmpty()) { %>
                        <img src="<%= imgData %>" width="100" height="100" /><br><br>
                    <% } %>
                </div>

                <div class="form-group col-md-6">
                    <label for="newimagedata">New Image:</label>
                    <input type="file" name="imagedata" class="form-control">
                </div>
                </div>

                <button type="submit" class="btn btn-primary btn-block">Update Content</button>
                <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Handle exceptions
                }
                %>
            </form>
        </div>
    </div>
    </div>
    </div>
    
</body>
</html>
