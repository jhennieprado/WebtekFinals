<?php
//	include('connection.php');

	//$tableContent = '';
	//$query = "SELECT * from appointments where status = 'request' ";
	//$result = mysqli_query($conn, $query);
	
?>

<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
	<title>Appointments</title>
</head>
<body>
	<form action="appointments.php" method="post">

		<select name="filter">
		<option value = "Request">Request</option>
		<option value = "Accepted">Accepted</option>
		</select>
		<input type="submit" name="Filter" value="Filter">

	

	<table cellpadding="5" cellspacing="5">

		<?php 
		//error_reporting(1);
			if($_POST['filter'] == 'Request') {
				include('clientRequest.php');
			}  else if($_POST['filter'] == 'Accepted') {
				include('clientAccepted.php');
			}

		 ?>
	</table>
	</form>


</body>
</html>