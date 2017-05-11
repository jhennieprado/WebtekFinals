<?php 
	session_start();
	include('connection.php');
	//include('usernamesFrame.php');
	$cookie_name = "loggedin";
	error_reporting(1);

	if (isset($_COOKIE[$cookie_name])) {
		$cookie_value = $_COOKIE[$cookie_name];
		echo "Welcome $cookie_value to your messages <br>";
	} else {
				echo "You are not logged in";
			}

	if(isset($_POST['btn'])) {
		$client = $_POST['btn'];
	}
	
	$use = "SELECT message from messages where sender_username = '$cookie_value' AND client_username='$client' ";
	$result = mysqli_query($conn, $use);

	//check if send button was clicked
	if(isset($_POST['send'])) {
		$reciever = $client;
		if (send_msg($cookie_value, $reciever, $_POST['msg'])) {
			echo 'Message Sent.';
		} else {
			echo 'Message Not Sent.';
		}
	}
	
	//send message and store to database
	function send_msg($cookie_value, $client, $message) {
		global $conn;
		$sender = $cookie_value;
		$reciever = $client;
		$message = $_POST['msg'];
		$query = "INSERT INTO messages VALUES(null,'$cookie_value','$message', '$client', '$cookie_value', '2017-04-30 04:55:54')";

		if ($conn->query($query) === TRUE) {
	    	return true;
		} else {
   		 	echo "Error: " . $query . "<br>" . $conn->error;
		}

		//check if there is a sender and a message on it
		if(!empty($sender) && !empty($message)) {
			return true;
		} else {
			return false;
		}
	}
	



 ?>
 <!DOCTYPE html>
 <html>
 	<head><title>Messages Frame</title></head>
 	<body>
 		<?php while($row = mysqli_fetch_array($result)):?>
 		<?php echo $row['message'] ;?><br>
 		<?php endwhile;?><br>
 		<a href='home.php'>back</a>

 		<form action="messages.php" method="post">
 			<textarea name="msg" placeholder="type message here" style="position:absolute; bottom:20px; left:4px; right:4px; width:100% overflow-x: hidden;"></textarea>
 			<input type="submit" name="send" value="Send" style="position:absolute; bottom:2px; left:2px; right:2px">
 		</form>
 	</body>
 </html>