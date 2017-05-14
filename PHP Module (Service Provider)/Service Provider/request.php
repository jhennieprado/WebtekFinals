 <form method = "post" action = "request.php">
<input type="date" name="dateFilter">
<input type="submit" name="submit" value="filter">
 </form>



<?php
include('connection.php');
session_start();
  $cookie_name = "loggedin";

  if (isset($_COOKIE[$cookie_name])) {
    $cookie_value = $_COOKIE[$cookie_name];
    $username = $cookie_value;
  } else {
        echo "You are not logged in";
      }


//include('clientRequest.php');

	if(isset($_POST['submit'])) {
		$date = $_POST['dateFilter'];
        // include('requested.php');
        
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
        AND sched_date = '$date';";
			$result = mysqli_query($conn, $query);
        
echo"<table>";

        while ($row = mysqli_fetch_array($result)) {
		echo'<form method="post" action="requested.php">';
		echo"<tr>";	
			echo"<td>".$row['status']."</td>";
			echo"<td>".$row['daterequest']."</td>";
			echo"<td>".$row['address']."</td>";
			echo"<td>".$row['clientno']."</td>";
			echo"<td>".$row['first_name'].' '.$row['last_name']."</td>";
			echo"<td>".$row['servicename']."</td>";
			echo'<td> <input type="submit" name="accept" value="accept"> </td>';
			echo'<td> <input type="submit" name="deny" value="reject"> </td>';
			echo'<td> <input type="hidden" name="id" value="'.$row['appointmentno'].'"> </td>';
			echo'<td> <input type="hidden" name="dr" value="'.$row['daterequest'].'"> </td>';
		echo"</tr>";
		 }//end of while
		echo"</form>";
echo"</table>";



	}
 ?>

<a href="index.php">HOME</a>



