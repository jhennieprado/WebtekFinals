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

  $query2 = "SELECT spid from serviceproviders where username = '$username'";
  $result2 = mysqli_query($conn, $query2);
  $spidInit = mysqli_fetch_assoc($result2);
  $spid = $spidInit['spid'];



 ?>
 <form action="schedule.php" method="post">
 	<input type="date" name="sched_date">
 	<select name="start_time">
 		<option value="7:00:00">7:00</option>
 		<option value="8:30:00">8:00</option>
 		<option value="9:30:00">9:00</option>
 		<option value="10:30:00">10:00</option>
 		<option value="1:00:00">1:00</option>
 		<option value="2:00:00">2:00</option>
 		<option value="3:00:00">3:00</option>
 		<option value="4:00:00">4:00</option>

 	</select>
 	<select name="end_time">
 		<option value="8:00:00">8:00</option>
 		<option value="9:00:00">9:00</option>
 		<option value="10:00:00">10:00</option>
 		<option value="11:00:00">11:00</option>
 		<option value="12:00:00">12:00</option>
 		<option value="1:00:00">1:00</option>
 		<option value="2:00:00">2:00</option>
 		<option value="3:00:00">3:00</option>
 		<option value="4:00:00">4:00</option>
 		<option value="5:00:00">5:00</option>
 	</select>
 	<input type="submit" name="submit" value="Add Schedule">


 </form>
 <?php

if(isset($_POST['submit'])) {
	$sched_date = $_POST['sched_date'];
	$start_time = $_POST['start_time'];
	$end_time = $_POST['end_time'];
    $query5 = "SELECT sched_date FROM serviceprovider_schedules WHERE sched_date = '$sched_date' and start_time = '$start_time' and end_time = '$end_time' and spid = '$spid'";
    $result5 = mysqli_query($conn, $query5);
    //$maybe = mysql_num_rows($result2);
    if(mysqli_num_rows($result5)==0){
        $insert = "INSERT INTO serviceprovider_schedules (schedid, spid, sched_date, start_time, end_time, vacant) VALUES (NULL, '$spid', '$sched_date', '$start_time', '$end_time', 'yes')";
	$done = mysqli_query($conn, $insert);
    } else{ 
        ?>
    
        <h2><?php echo "You already included this schedule!"; ?></h2>
    <?php
    }
	
	echo $sched_date.'  ';
	echo $start_time.'  ';
	echo $end_time.'  ';
	echo $spid;
}

  ?>