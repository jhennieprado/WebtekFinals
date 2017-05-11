<?php
	include('connection.php');

	session_start();
	$cookie_name = "loggedin";

	if (isset($_COOKIE[$cookie_name])) {
		$cookie_value = $_COOKIE[$cookie_name];
		$username = $cookie_value;
		echo "Welcome $cookie_value to profile <br>";
	} else {
				echo "You are not logged in";
			}
	

	$query = "SELECT * from serviceproviders s join sp_skills p on s.spid = p.spid join services c on p.serviceid = c.serviceid where username = '$username' ";
	$query2 = "SELECT * from serviceproviders s join sp_skills p on s.spid = p.spid join services c on p.serviceid = c.serviceid where username = '$username' ";
	$result = mysqli_query($conn, $query);
	$result2 = mysqli_query($conn, $query2);

	$row = mysqli_fetch_array($result);
	//$row2 = mysqli_fetch_array($result2);

	


 ?>

 <table cellpadding="5" cellspacing="5">
 			
 			<tr>
 			<form action="profile.php" method="post" enctype="multipart/form-data" >
 			<td><input type="file" name="picture"></td>
			<td><input type ="submit" name="upload" value="Upload"></td>
 			</form>
 			</tr>
		
			<tr>
			<td>First Name: </td><td><?php echo $row['first_name']; ?></td>
			</tr>
			<tr>
			<td>Last Name: </td><td><?php echo $row['last_name']; ?></td>
			</tr>
			<tr>
			<td>Contact Number: </td><td><?php echo $row['contactno']; ?></td>
			</tr>
			<tr>
			<td>Email: </td><td><?php echo $row['email']; ?></td>
			</tr>
			<tr>

			<td>Skills: </td><td> <ul>
			<?php 
					while($row2 = mysqli_fetch_array($result2)){
			?>
					<li> <?php echo $row2['servicename']; ?></li>
			<?php 
				}
				?>
				</ul>
				</td>
			</tr>

		
</table>
		
		<form action="profile.php" method="post" enctype="multipart/form-data">
		<input type="submit" name="edit" value="Edit Contact No." />
		<input type="submit" name="editskill" value="Add Skill" />
		<input type="submit" name="deleteskill" value="Delete Skill" /><br>
		
		</form>

<?php
	if(isset($_POST['edit'])){
		header("location: editprofile.php");
	} else if(isset($_POST['editskill'])) {
		header("location: editskill.php");
	} else if(isset($_POST['deleteskill'])) {
		header("location: deleteskill.php");
	}// else if(isset($_POST['upload'])) {
		//header("location: upload.php");
	//}
?>
