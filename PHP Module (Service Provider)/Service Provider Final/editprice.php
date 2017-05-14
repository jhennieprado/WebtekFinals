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

	
	$query = "SELECT DISTINCT s.serviceid, s.servicename, sp_skills.price FROM services s NATURAL JOIN sp_skills where s.serviceid in (SELECT serviceid FROM sp_skills NATURAL JOIN serviceproviders where username = '$username')";
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
            <td>Price: <?php echo $row['price']; ?></td>
            
			<form method="post" action="editprice.php">
			<td> <input type="hidden" name="id" value="<?php echo $row['serviceid']; ?>"/> </td>
            <td> <input type="text" name="price" value="0"/> </td>
            <td><input type="submit" name="add1" value="Edit"></td>
			</form>	

		</tr>

		<?php 
		

		}//endwhile ?>
	</table>

		


<?php
	
if(isset($_POST['add1'])) {
			$serviceid = $_POST['id'];
            $price = $_POST['price'];
			$insert = "UPDATE sp_skills SET price = '$price' WHERE spid ='$spid' and serviceid='$serviceid'";
			$done = mysqli_query($conn, $insert);
			//echo $spid.$serviceid;
            echo "<script>
                    window.location.href = 'editprice.php';
                </script>";
            
		}
 ?>
