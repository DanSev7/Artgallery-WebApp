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
            

                <% 
                    
                    try {
                        Connection connection = DBUtil.getConnection();
                        int contentId = Integer.parseInt(request.getParameter("contentId"));

                        // Logic to fetch content details based on contentId
                        String sql = "SELECT * FROM admin WHERE id = ?";
                        PreparedStatement statement = connection.prepareStatement(sql);
                        statement.setInt(1, contentId);
                        ResultSet resultSet = statement.executeQuery();

                        if (resultSet.next()) {
                            String username = resultSet.getString("username");
                            String password = resultSet.getString("password");
                            
                %>

			        <form action="adminList" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="contentId" value="<%= request.getParameter("contentId") %>">

                		<div class="card p-4">
		        <h2 class="text-center mb-4">Update Admin</h2>
			            <div class="form-group">
			                <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
			            </div>
			            <div class="form-group">
			                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
			            </div>
			            
			            <div class="form-group">
			                <button type="submit" class="btn btn-success btn-block">Save</button>
			            </div>
			            <p class="text-danger text-center">${error}</p>
			            </div>
			            
			        </form>
		    </div>
                

                
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

    
</body>
</html>
