<?php
	include('connection.php');


	$query = "SELECT *from appointments a join clients c on a.clientno = c.clientno join services s on a.serviceid = s.serviceid  where status = 'accepted'  order by a.daterequest asc";
	$result = mysqli_query($conn, $query);
	
?>

<!DOCTYPE html>
<html>
<head>
	<title>Client Accepted</title>
</head>
<body>
<table cellpadding="5" cellspacing="5">

		<tr>
			<td>Status</td>
			<td>Client No.</td>
			<td>Client Name</td>
			<td>Contact Number</td>
			<td>Date Requested</td>
			<td>Service Name</td>
			<td>Address</td>

			

		</tr>
<?php while ($row = mysqli_fetch_array($result)) {?>
		

		<tr>
			<td><?php echo $row['status']; ?></td>
			<td><?php echo $row['clientno']; ?></td>
			<td><?php echo $row['first_name'].' '.$row['last_name']; ?></td>
			<td><?php echo $row['contactno']; ?></td>
			<td><?php echo $row['daterequest']; ?></td>
			<td><?php echo $row['servicename']; ?></td>
			<td><?php echo $row['address']; ?></td>
			<form method="post" action="clientAccepted.php">
			<td> <input type="submit" name="done" value="done"> </td>
			<td> <input type="hidden" name="id" value="<?php echo $row['appointmentno']; ?>"/> </td>
			</form>
			
		</tr>

		<?php } ?>

		<?php 
				if(isset($_POST['done'])) {

					$appointmentno = $_POST['id'];

					$done = "UPDATE appointments SET status = 'done' WHERE appointmentno = '$appointmentno'" ;
					$res = mysqli_query($conn, $done);
					echo "done";

				}

		?>
</table>
</body>
</html>