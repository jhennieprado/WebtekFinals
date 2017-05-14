<?php
	include('connection.php');


	$query = "SELECT *from appointments a join clients c on a.clientno = c.clientno join services s on a.serviceid = s.serviceid  where status = 'request' order by a.daterequest asc  ";
	$result = mysqli_query($conn, $query);
	
?>

<!DOCTYPE html>
<html>
<head>
	<title>Client Request</title>
</head>
<body>
<table>
		<tr>
			<td>Status</td>
			<td>Date Requested</td>
			<td>Address</td>
			<td>Client No.</td>
			<td>Client Name</td>
			<td>Service Name</td>

		</tr>
		<?php while ($row = mysqli_fetch_array($result)) { ?>
		<form method="post" action="clientRequest.php">
		<tr>	
			<td><?php echo $row['status']; ?></td>
			<td><?php echo $row['daterequest']; ?></td>
			<td><?php echo $row['address']; ?></td>
			<td><?php echo $row['clientno']; ?></td>
			<td><?php echo $row['first_name'].' '.$row['last_name']; ?></td>
			<td><?php echo $row['servicename']; ?></td>
			<td> <input type="submit" name="accept" value="accept"> </td>
			<td> <input type="submit" name="deny" value="reject"> </td>
			<td> <input type="hidden" name="id" value="<?php echo $row['appointmentno']; ?>"> </td>
			<td> <input type="hidden" name="dr" value="<?php echo $row['daterequest']; ?>"> </td>
		</tr>
		<?php } ?>
		</form>
</table>
		
		<?php 
				if(isset($_POST['accept'])) {
					$appointmentno = $_POST['id'];
					$dr = $_POST['dr'];
					$add = "UPDATE appointments SET status = 'accepted' WHERE appointmentno = '$appointmentno'"; 
					$denyOther = "UPDATE appointments SET status = 'rejected' where appointmentno != '$appointmentno' and daterequest = '$dr'";
					$res = mysqli_query($conn, $add);
					$res2 = mysqli_query($conn, $denyOther);


					echo "added";
				} else if(isset($_POST['deny'])) {
					$appointmentno = $_POST['id'];
					$add = "UPDATE appointments SET status = 'rejected' WHERE appointmentno = '$appointmentno'" ;
					$res = mysqli_query($conn, $add);
					echo "rejected";

				}

			
		?>

		

</body>
</html>