<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.artgallery.services.AdminService" %>
<%@ page import="com.artgallery.services.Admin" %>
<%@ page import="com.artgallery.util.DBUtil" %>
<!Doctype html>
<html>
<head>
<!-- Include Bootstrap and other CSS links -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>

html{
	margin-top:100px;
}
body {
        color: #566787;
		background: #f5f5f5;
		font-family: 'Varela Round', sans-serif;
		font-size: 13px;
		
	}
	
	.container{
		border-radius: 10px;
        box-shadow: 0px 0px 10px 0px #000000;
        padding-bottom: 10px;
	}

	.table-responsive {
        margin: 30px 0;
    }
	
	.table-title {        
		
		background: #313336;
		color: #fff;
		padding: 16px 30px;
		margin: -20px -16px 10px;
		border-radius: 12px 12px 0 0;
		
    }
    .table-title h2 {
		margin: 5px 0 0;
		font-size: 24px;
	}
	.table-title .btn-group {
		float: right;
	}
	.table-title .btn {
		color: #fff;
		float: right;
		font-size: 13px;
		border: none;
		min-width: 50px;
		border-radius: 2px;
		border: none;
		outline: none !important;
		margin-left: 10px;
	}
	.table-title .btn i {
		float: left;
		font-size: 21px;
		margin-right: 5px;
	}
	.table-title .btn span {
		float: left;
		margin-top: 2px;
	}
	
	.table-div{
		padding: 0px;
	}
	table.table td a.edit {
        color: #FFC107;
    }
    table.table td a.delete {
        color: #F44336;
    }
    
      .btn-light {
	    background-color: silver;
	  }
	
	  .btn-light:hover {
	    background-color: lightgray;
	  }
    
   
</style>

</head>
<!-- Your existing HTML structure -->
<body>

<div class="container">
  <div class="table-title">
  	<div class="row">
		<div class="col-md-6">
			<h2>Manage <b>Admins</b></h2>
		</div>
		<div class="col-md-6">
			<a href="admin_home.jsp" class="btn btn-light ">Back to Home</a>
		</div>
	</div>
  </div>

	<div class="table-div">
		<table class="table table-striped table-hover">
		    <thead>
		        <tr>
		            <th>ID</th>
		            <th>Admin Name</th>
		            <th>Password</th>
		            <!-- Add other headers for fields in 'admin' table -->
		            <th>Actions</th>
		        </tr>
		    </thead>
		    <tbody>
		        <% 
		        	int idCounter = 1;// here we use idCounter to automatically count the number regardless of table id 
		            		try (Connection connection = DBUtil.getConnection()) {
		                        String sql = "SELECT * FROM admin";
		                        PreparedStatement statement = connection.prepareStatement(sql);
		                        ResultSet resultSet = statement.executeQuery();

		                        while (resultSet.next()) {
		                            int contentId = resultSet.getInt("id");
		                            String username = resultSet.getString("username");
		                            String password= resultSet.getString("password");
		            
		        %>
		            <tr>
		                <td><%= idCounter ++ %></td>
		                <td><%= username %></td>
		                <td><%= password %></td>
		                <!-- Add other fields accordingly -->
		                <td>
		                    <a href="updateList.jsp?action=retrieve&contentId=<%= contentId %>" class="edit" >
		                        <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
		                    </a>
		                    <a href="#deleteEmployeeModal" class="delete" data-toggle="modal">
		                        <i class="material-icons" data-toggle="modal" data-target="#confirmDeleteModal<%= contentId %>" title="Delete">&#xE872;</i>
		                    </a>

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
                                        <form action="adminList" method="post">
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
		<div class="clearfix">
			<ul class="pagination">
				<li class="page-item"><a href="userManagement.jsp" class="page-link">Manage Users</a></li>
			</ul>
		</div>
	</div>
</div>
<!-- Additional modals and scripts may follow... -->

</body>
</html>