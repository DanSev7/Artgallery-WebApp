<!DOCTYPE html>
<html>
<head>
    <title>Add Artist Content</title>
    <!-- Include Bootstrap CSS -->
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
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-box">
                    <form action="artistContent" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="create">
                        <div class="container mt-5">
			    			<div class="row">
			        			<div class="col-md-6">
			            			<h2 class="text-center mb-4">Add Artist Content</h2>
			        			</div>
			        		<div class="col-md-6 text-right">
        						<a href="listArtistContents.jsp" class="btn btn-primary mb-3">Art Lists</a>
            				</div>
			    		</div>
					</div>
                        

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="artistname">Artist Name:</label>
                                    <input type="text" id="artistname" name="artistname" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="title">Title:</label>
                                    <input type="text" id="title" name="title" class="form-control" required>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="description">Description:</label>
                            <textarea id="description" name="description" class="form-control" rows="4" required></textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="category">Category:</label>
                                    <select id="category" name="category" class="form-control">
                                    	<option value="" disabled selected>Select Category</option>
                                        <option value="Abstract">Abstract</option>
                                        <option value="Portrait">Portrait</option>
                                        <!-- Add other categories -->
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="creationdate">Creation Date:</label>
                                    <input type="date" id="creationdate" name="creationdate" class="form-control" required>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="imagedata">Upload Image:</label>
                            <input type="file" id="imagedata" name="imagedata" class="form-control-file" accept="image/*" required>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">Add Content</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
