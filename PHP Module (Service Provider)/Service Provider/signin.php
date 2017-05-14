<?php

	include('connection.php');
	$cookie_name = "loggedin";


	if (isset($_POST['submit'])) {
		session_start();
		$username = $_POST['username'];
		$password = $_POST['password'];

		$sql = "SELECT * FROM serviceproviders WHERE username='$username' AND password='$password'";
		$result = mysqli_query($conn, $sql);

		if (mysqli_num_rows($result) == 1) {
			$_SESSION['message'] = "You are now logged in";
			$_SESSION['username'] = $username;
			$cookie_value = $username;
			setcookie($cookie_name, $cookie_value, time()+86400, "/");
			header("location: index.php"); // redirect to home page
		} else {
			$_SESSION['message'] = "Username/password combination incorrect";
		}


	}
	


?>



<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Signin</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/signin.css" rel="stylesheet">
    <script src="assets/js/ie-emulation-modes-warning.js"></script>
  </head>

  <body>
    <div class="logo">
        <img src="css/images/Logo.png" alt="logo" height=250px width=250px >
    </div>
    <div class="container">
      <form class="form-signin" method="post" action="signin.php">
        <h2 class="form-signin-heading">Sign in</h2>
        <label for="inputUsername" class="sr-only"></label>
        <input type="username" id="inputUsername" class="form-control" placeholder="Username" name="username" required autofocus>
        <label for="inputPassword" class="sr-only"></label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" name="password" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div> 
        <input class="btn btn-lg btn-primary btn-block" type="submit"  name = "submit" value="Sign In">
      </form>
    </div> <!-- /container -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
