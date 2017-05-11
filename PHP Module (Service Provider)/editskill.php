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

	
	$query = "SELECT DISTINCT s.serviceid, s.servicename FROM services s NATURAL JOIN sp_skills where s.serviceid not in (SELECT serviceid FROM sp_skills NATURAL JOIN serviceproviders where username = '$username') order by s.category";
	$result = mysqli_query($conn, $query);
	$query2 = "SELECT spid from serviceproviders where username = '$username'";
	$result2 = mysqli_query($conn, $query2);
	$spidInit = mysqli_fetch_assoc($result2);
	$spid = $spidInit['spid'];
	//echo $spid;
	

?>



	<table>
		<?php while($row = mysqli_fetch_array($result)){ ?>
		
		<tr>
			
			<td><?php echo $row['servicename']; ?></td>
			<form method="post" action="editskill.php">
			<td><input type="submit" name="add" value="Add"></td>
			<td> <input type="hidden" name="id" value="<?php echo $row['serviceid']; ?>"/> </td>
			</form>	

		</tr>

		<?php 
		

		}//endwhile ?>
	</table>

		


<?php
	
if(isset($_POST['add'])) {
			$serviceid = $_POST['id'];
			$insert = "INSERT INTO sp_skills(spid, serviceid) VALUES($spid, $serviceid)";
			$done = mysqli_query($conn, $insert);
			//echo $spid.$serviceid;
		}
 ?>

