<!DOCTYPE html>
<html>

<head>
    <title>Accepted Requests</title>
    <meta charset="UTF-8">
    <meta name="Author" content="BxbWebsite">
    <link rel="stylesheet" type="text/css" href="css/request.css">
    <link rel="stylesheet" type="text/css" href="css/apps.css">
    <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato|Pacifico" rel="stylesheet">
    <link rel="icon" href="images/logo.png" type="image/gif" sizes="16x16">

</head>

<body>
     <div id="sidenav" class="sidenav">
        <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
        <a href="index.php">Home</a>
        <a href="skills.php">Skills</a>
        <a href="settings.php">Account Settings</a>
        <a href="accepted.php">Appointments</a>
        <a href="pending.php">Pending Requests</a>
    </div>
    <div id="banner">
        <img src="css/images/bxb.png">
        <span style="font-size:1.5em;font-family:Lato;cursor:pointer;color:white;float:right;z-index:2;padding-top:50px;" onclick="openNav()">&#9776; Menu</span>
    </div>

    <div id="Accept">
        <div id="Acceptbox">
            <div id="welcome">
                <a href="index.php">&times;</a>
                Pending Appointments
            </div>
            
            <div id="appointment">
                 <form method = "post" action = "pending.php">
<input type="date" name="dateFilter">
<input type="submit" name="submit" value="filter">
 </form>
                <table cellspacing= "5" cellpadding="5">
                <td>Status</td>
			<td>Date Requested</td>
			<td>Address</td>
			<td>Client No.</td>
			<td>Client Name</td>
			<td>Service Name</td>
                    </table>
                
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



	if(isset($_POST['submit'])) {
        $date = $_POST['dateFilter'];
        if($date == ''){
            $blank = "SELECT *from appointments a join clients c on a.clientno = c.clientno join services s on a.serviceid = s.serviceid join serviceproviders sp on a.spid = sp.spid  where status = 'request' and sp.username='$username'  order by a.daterequest asc  ";
	        $resulta = mysqli_query($conn, $blank);
            
            echo"<table>";

            while ($row = mysqli_fetch_array($resulta)) {
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
            
            
        }else {        
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
        AND sched_date = '$date' and appointments.status='request';";
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
    }
 ?>
            </div>
        </div>
    </div>

    <script>
        function openNav() {
            document.getElementById("sidenav").style.width = "250px";
            document.getElementById("main").style.marginLeft = "250px";
            document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
        }

        function closeNav() {
            document.getElementById("sidenav").style.width = "0";
            document.getElementById("main").style.marginLeft = "0";
            document.body.style.backgroundColor = "white";
        }

    </script>
</body>

</html>