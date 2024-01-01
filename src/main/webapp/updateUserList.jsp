<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.artgallery.util.DBUtil" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Artist Content</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
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
      form i {
		    position: absolute;
		    top: 50%;
		    right: 10px;
		    transform: translateY(-50%);
		    cursor: pointer;
		    margin-left: -30px;
		    z-index: 1;
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
                        String sql = "SELECT * FROM users WHERE user_id = ?";
                        PreparedStatement statement = connection.prepareStatement(sql);
                        statement.setInt(1, contentId);
                        ResultSet resultSet = statement.executeQuery();

                        if (resultSet.next()) {
                            String username = resultSet.getString("username");
                            String password = resultSet.getString("password");
                            
                %>

			        <form action="userList" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="contentId" value="<%= request.getParameter("contentId") %>">

                		<div class="card p-4">
		        <h2 class="text-center mb-4">Update User</h2>
			            <div class="form-group">
			            	<label for="username">Username</label>
			                <input type="text" class="form-control" id="username" name="username"  value="<%= username %>" required>
			            </div>
			            <div class="form-group">
			            	<label for="password">Password</label>
			            	<div class="input-group">
			                <input type="password" class="form-control" id="password" name="password" value="<%= password %>" required>
			                <i class="bi bi-eye-slash" id="togglePassword"></i>
			            	</div>
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

    <script>
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');
    togglePassword.addEventListener('click', () => {
        // Toggle the type attribute using getAttribute() method
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        
        // Toggle the eye and bi-eye class names
        togglePassword.classList.toggle('bi-eye');
        togglePassword.classList.toggle('bi-eye-slash');
    });
</script>
</body>
</html>
