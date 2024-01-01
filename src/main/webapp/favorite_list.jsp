<%@ page import="java.sql.*, java.io.*, java.util.Base64" %>
<%@ page import="com.artgallery.util.DBUtil" %>
<%@ page import = "com.artgallery.services.FetchUser" %>
<!DOCTYPE html>
<html>
<head>
    <title>List of Artist Contents</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <!-- Include Bootstrap JavaScript and jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
    	body {
            background-color: #333; /* Use the same background color as in home.jsp */
            color: #f2f2f2; /* Adjust text color for better contrast */
        }
         th,td
         {
        	color: #f2f2f2;
        }
        h5,p
        {
        	color: black;
        }
        
      
        
    </style>
    
</head>
<body>

    <div class="container mt-5">
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-6">
                    <h2>Favorite Lists</h2>
                </div>
                <div class="col-md-6 text-right">
                    <a href="home.jsp" class="btn btn-light mb-3">Back to Home</a>
                </div>
            </div>
        </div>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Artist Name</th>
                    <th>Category</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                int id = FetchUser.fetchId(request, response);
              	if (id == -1)return;
                    int idCounter = 1; // Initialize the ID counter
                    try (Connection connection = DBUtil.getConnection()) {
                        String sql = "SELECT * FROM favorite_list where user_id=?";
                        PreparedStatement statement = connection.prepareStatement(sql);
                       
                		statement.setInt(1, id);
                        ResultSet resultSet = statement.executeQuery();

                        while (resultSet.next()) {
                            int contentId = resultSet.getInt("id");
                            String title = resultSet.getString("title");
                            String artistName = resultSet.getString("artistname");
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
                <tr>
                    <td><%= idCounter++ %></td> <!-- Increment and display the custom ID -->
                    <td><%= title %></td>
                    <td><%= artistName %></td>
                    <td><%= category %></td>
                    <td><img src="<%= imgData %>" width="100" height="100" /></td>
                    <td>
                        <a href="detailFavoriteList.jsp?action=retrieve&contentId=<%= contentId %>" class="btn btn-info">Detail</a>
                        <button class="btn btn-danger" data-toggle="modal" data-target="#confirmDeleteModal<%= contentId %>">Delete</button>

                        <!-- Modal -->
                        <div class="modal fade" id="confirmDeleteModal<%= contentId %>" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel<%= contentId %>" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="confirmDeleteModalLabel<%= contentId %>">Confirm Deletion</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Are you sure you want to delete this content?</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                        <form action="favoriteList" method="post">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="contentId" value="<%= contentId %>">
                                            <button type="submit" class="btn btn-danger">Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <% 
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Handle exceptions
                }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
