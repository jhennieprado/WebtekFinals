<!DOCTYPE html>
<html>
<?php
	session_start();
	$cookie_name = "loggedin";

	if (isset($_COOKIE[$cookie_name])) {
		$cookie_value = $_COOKIE[$cookie_name];
		$username = $cookie_value;
		echo "Welcome $cookie_value <br>"; 
		echo '<a href="chat.php"> Messages </a><br>';
		echo '<a href="clientRequest.php"> Client Requests</a><br>';
		echo '<a href="clientAccepted.php"> Accepted Requests</a><br>';
		echo '<a href="profile.php"> Profile</a><br>';
		echo '<a href="logout.php"> Logout </a> ';
	} else {
				echo "You are not logged in";
			}
    
    $today = date('Y-m-d');
    echo $today;
?>
</html>