<?php

	include('connection.php');
	$cookie_name = "loggedin";


	if (isset($_POST['submit'])) {
		session_start();
		$username = $_POST['username'];
		$password = $_POST['password'];
		//$password = md5($password);

		$sql = "SELECT * FROM serviceproviders WHERE username='$username' AND password='$password'";
		$result = mysqli_query($conn, $sql);

		if (mysqli_num_rows($result) == 1) {
			$_SESSION['message'] = "You are now logged in";
			$_SESSION['username'] = $username;
			$cookie_value = $username;
			setcookie($cookie_name, $cookie_value, time()+86400, "/");
			header("location: home.php"); // redirect to home page
		} else {
			$_SESSION['message'] = "Username/password combination incorrect";
		}


	}
	


?>




<!DOCTYPE html>
<html>
	<head><title>Register Service Provider</title></head>
	<body>
		<div class="header">
			<h1>Log in</h1>
		</div>

		<?php

			if(isset($_SESSION['message'])) {
				echo $_SESSION['message'];
				unset($_SESSION['message']);
			}

		?>

		<form method="post" action="login.php">
			<table>
				<tr>
					<td>Username:</td>
					<td><input type="text" name="username" class="textInput"></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input type="password" name="password" class="textInput"></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" name="submit" value="Log In"></td>
				</tr>
			</table>
		</form>
	</body>
</html>