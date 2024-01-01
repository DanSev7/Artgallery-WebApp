<%@ page import="java.sql.*, java.io.*, java.util.Base64" %>
<%@ page import="com.artgallery.util.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
    <title>List of Artist Contents</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Include Bootstrap JavaScript and jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
	  .btn-light {
	    background-color: lightgray;
	  }
	
	  .btn-light:hover {
	    background-color: silver;
	  }
	</style>
</head>
<body>
    <div class="container mt-5">
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-6">
                    <h2>List of Artist Contents</h2>
                </div>
                <div class="col-md-6 text-right">
                	<a href="admin_home.jsp" class="btn btn-light mb-3">Back to Home</a>
                    <a href="addArtistContent.jsp" class="btn btn-primary mb-3">Add New Content</a>
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
                    int idCounter = 1; // Initialize the ID counter
                    try (Connection connection = DBUtil.getConnection()) {
                        String sql = "SELECT * FROM artist_content";
                        PreparedStatement statement = connection.prepareStatement(sql);
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
                        <a href="updateArtistContent.jsp?action=retrieve&contentId=<%= contentId %>" class="btn btn-success">Edit</a>
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
                                        <form action="artistContent" method="post">
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
