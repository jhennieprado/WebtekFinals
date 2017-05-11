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

	
	$query = "SELECT DISTINCT s.serviceid, s.servicename FROM services s NATURAL JOIN sp_skills where s.serviceid in (SELECT serviceid FROM sp_skills NATURAL JOIN serviceproviders where username = '$username') order by s.category";
	$result = mysqli_query($conn, $query);
	$query2 = "SELECT spid from serviceproviders where username = '$username'";
	
	$result2 = mysqli_query($conn, $query2);
	$spidInit = mysqli_fetch_assoc($result2);
	$spid = $spidInit['spid'];
	

?>



	<table>
		<?php while($row = mysqli_fetch_array($result)){ ?>
		
		<tr>
			
			<td><?php echo $row['servicename']; ?></td>
			<form method="post" action="deleteskill.php">
			<td><input type="submit" name="delete" value="Delete"></td>
			<td> <input type="hidden" name="id" value="<?php echo $row['serviceid']; ?>"/> </td>
			</form>	

		</tr>

		<?php 
		

		}//endwhile ?>
	</table>

		


<?php


if(isset($_POST['delete'])) {
	$serviceid = $_POST['id'];
	$query3 = "SELECT serviceid FROM appointments a  NATURAL JOIN serviceprovider_schedules p  where a.status='accepted' and p.spid = '$spid' and serviceid = '$serviceid'";
	$result3 = mysqli_query($conn, $query3);
	$r3 = mysqli_fetch_assoc($result3);
	if (mysqli_num_rows($result3) != 0) {

		echo "There is a current appointment that this skill will be used on";
	} else {
			
			$delete = "DELETE from sp_skills WHERE serviceid = '$serviceid' and spid = '$spid'";
			$done = mysqli_query($conn, $delete);
	}
}
 ?>

