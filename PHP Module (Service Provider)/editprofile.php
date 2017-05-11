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
	

	$query = "SELECT * from serviceproviders s join sp_skills p on s.spid = p.spid join services c on p.serviceid = c.serviceid where username = '$username' ";
	$result = mysqli_query($conn, $query);
	$row = mysqli_fetch_array($result);
?>

<form action="editprofile.php" method="post">
<table>
	<tr>
		<td>Contact Number: </td>
		<td><input type="text" name="cn" value="<?php echo $row['contactno']; ?>"></td>
	</tr>
</table>
<input type="submit" name="apply" value="Apply Changes">
</form>
<?php 
if(isset($_POST['apply'])) {
	$contactno = $_POST['cn'];
	$contact = "UPDATE serviceproviders SET contactno = '$contactno' where username = '$username'";
	$update = mysqli_query($conn, $contact);
	header("location: profile.php");

} 
?>

