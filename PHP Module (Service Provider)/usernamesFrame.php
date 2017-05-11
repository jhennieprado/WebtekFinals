<?php 
	session_start();
	$cookie_name = "loggedin";
		$query = "SELECT * FROM clients ORDER BY 2 ASC";
		$search_result = filterTable($query);
	

	function filterTable($query) {
		$conn = mysqli_connect("localhost", "root", "", "bxb");
		$filter_Result = mysqli_query($conn, $query);
		return $filter_Result;
	}



			



?>
<!DOCTYPE html>
<html>
	
	<head><title>Client Frame</title></head>
	<body>
		<form method="post" action="usernamesFrame.php">

			<table>
				<tr>
					<th>Client Names</th>
				</tr>
				<?php while($row = mysqli_fetch_array($search_result)):?>

				<tr>
					<td>
						
						<button type="submit" style="padding:0; border:none; background:none" name="btn">
							<?php echo $row['first_name'] . ' ' . $row['last_name']; ?>
						</button>
					</td>
				</tr>
				<?php endwhile; ?>
			</table>
		</form>

	</body>
</html>

<?php
if(isset($_POST['btn'])) {
	$client = $_POST['btn'];

}
?>