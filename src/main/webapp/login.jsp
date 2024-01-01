<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap for the eye toggle -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            width: 400px;
            border-radius: 10px;
        }
        a:hover{
        	text-decoration: none;
        	color: #87ce00;
        }
        a{
        	color: #6ca400 ;
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
    <div class="card p-4">
        <h2 class="text-center mb-4">Login</h2>
        <form action="login" method="post">
            <div class="form-group">
                <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
            </div>
            <div class="form-group">
	            <div class="input-group">
	                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
	                <i class="bi bi-eye-slash" id="togglePassword"></i>
	            </div>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-warning btn-block">Login</button>
            </div>
            
            <p class="text-danger text-center">${error}</p>
            

	            <div class="text-center mt-4">
	            	<p>New Customer? <a href="register.jsp">Register here</a></p>
	            </div>
 
        </form>
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
