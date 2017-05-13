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
    $query3 = "SELECT DISTINCT category FROM `services` WHERE 1";
    $result3 = mysqli_query($conn, $query3);
	//echo $spid;
	

?>
    <form method="post" action="editskill.php">
    <select name="fil">
        <option>All</option>
        <?php while($row2 = mysqli_fetch_array($result3)) {?>
        <option><?php echo $row2['category'] ?></option>
        <?php } ?>
    </select>
        <input type="submit" name="add1" value="Filter" >
    </form>
    <?php 
        $categ='';
        $query = "SELECT DISTINCT s.serviceid, s.servicename FROM services s where s.serviceid not in (SELECT serviceid FROM sp_skills NATURAL JOIN serviceproviders where username = '$username')";
        if(isset($_POST['add1'])) {
            $categ = $_POST['fil'];
            if($categ == "All"){
                 $query = "SELECT DISTINCT s.serviceid, s.servicename FROM services s where s.serviceid not in (SELECT serviceid FROM sp_skills NATURAL JOIN serviceproviders where username = '$username')";
            }else {
                $categ = $_POST['fil'];
                $query = "SELECT DISTINCT s.serviceid, s.servicename, s.category FROM services s where s.serviceid not in (SELECT serviceid FROM sp_skills NATURAL JOIN serviceproviders where username = '$username') and category = '$categ'";
            }
                
           
            echo $categ;
        }
        
	   $result = mysqli_query($conn, $query);
    ?>
	<table>
		<?php while($row = mysqli_fetch_array($result)){ ?>
		
		<tr>
			
			<td><?php echo $row['servicename']; ?></td>
			<form method="post" action="editskill.php">
            <td> <input type="text" name="price" value="0"/> </td>
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
            $price = $_POST['price'];
			$insert = "INSERT INTO sp_skills(spid, serviceid, price) VALUES($spid, $serviceid,$price)";
			$done = mysqli_query($conn, $insert);
			//echo $spid.$serviceid;
            echo "<script>
                    window.location.href = 'editskill.php';
                </script>";
            
		}
 ?>

