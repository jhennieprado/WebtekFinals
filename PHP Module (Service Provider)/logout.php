<?php
	setcookie("loggedin", "val", time()-86400, "/");
	//session_start();
	//session_destroy();
	//unset($_SESSION['username']);
	//$_SESSION['message'] = "You are now logged out";
	header("location: login.php");
?>