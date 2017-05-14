<?php
//error_reporting(1);
include('connection.php');
session_start();
  $cookie_name = "loggedin";

  if (isset($_COOKIE[$cookie_name])) {
    $cookie_value = $_COOKIE[$cookie_name];
    $username = $cookie_value;
  } else {
        echo "You are not logged in";
      }

      $query = "SELECT 
    *
FROM
    appointments
        JOIN
    serviceprovider_schedules ON serviceprovider_schedules.schedid = appointments.sp_schedid
        JOIN
    services ON services.serviceid = appointments.serviceid
        JOIN
    serviceproviders ON serviceproviders.spid = appointments.spid
        JOIN
    clients ON clients.clientno = appointments.clientno
WHERE
    serviceproviders.username = '$username'
        AND sched_date = '2017-05-11';";
			$result = mysqli_query($conn, $query);

 ?>

 <table>







		<tr>
			<td>Status</td>
			<td>Date of Service</td>
			<td>Address</td>
			<td>Client No.</td>
			<td>Client Name</td>
			<td>Service Name</td>

		</tr>
		<?php while ($row = mysqli_fetch_array($result)) { ?>
		<form method="post" action="requested.php">
		<tr>	
			<td><?php echo $row['status']; ?></td>
			<td><?php echo $row['daterequest']; ?></td>
			<td><?php echo $row['address']; ?></td>
			<td><?php echo $row['clientno']; ?></td>
			<td><?php echo $row['first_name'].' '.$row['last_name']; ?></td>
			<td><?php echo $row['servicename']; ?></td>
			<td><?php echo $row['schedid']; ?></td>
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
                    echo "<script>
                    window.location.href = 'request.php';
                </script>";
				} else if(isset($_POST['deny'])) {
					$appointmentno = $_POST['id'];
					$add = "UPDATE appointments SET status = 'rejected' WHERE appointmentno = '$appointmentno'" ;
					$res = mysqli_query($conn, $add);
					echo "rejected";
                    echo "<script>
                    window.location.href = 'request.php';
                </script>";

				}

			
		?>