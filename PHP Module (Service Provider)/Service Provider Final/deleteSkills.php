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

	
	$query = "SELECT DISTINCT s.serviceid, s.servicename FROM services s NATURAL JOIN sp_skills where s.serviceid in (SELECT serviceid FROM sp_skills NATURAL JOIN serviceproviders where username = '$username')";
	$result = mysqli_query($conn, $query);
	$query2 = "SELECT spid from serviceproviders where username = '$username'";
	
	$result2 = mysqli_query($conn, $query2);
	$spidInit = mysqli_fetch_assoc($result2);
	$spid = $spidInit['spid'];
	

?>

<!DOCTYPE html>
<html>

<head>
    <title>Delete Skills</title>
    <meta charset="UTF-8">
    <meta name="Author" content="BxbWebsite">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/settings.css">
    <link rel="stylesheet" type="text/css" href="css/app.css">
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
        <span style="font-size:30px;cursor:pointer;color:white;float:right;z-index:2;padding-top:40px;" onclick="openNav()">&#9776; Menu</span>
    </div>
    <hr>

    <div class="container">
        <hr>
        <div class row>
            <div class="col-md-9 personal-info">
                <div class="alert alert-info alert-dismissable">
                    <a class="panel-close close" data-dismiss="alert">×</a>
                    <i class="fa fa-coffee"></i>Update your <strong>skills information</strong>.Delete skills that you no longer offer. 
                </div>
                <form class="form-horizontal" role="form" method="post" action = "deleteSkills.php">
                    <div class="form-group">
                        <div class="col-md9 skills_info">
                           <ul><form method="post" action="deleteSkills.php">
                            <?php while($row = mysqli_fetch_array($result)){ ?>
                            <li><a button class="btn" type="submit" style="color:black" name='delete' ><span><input type="submit" name="delete" value="Delete"><input type="hidden" name="id" value="<?php echo $row['serviceid']; ?>"/></span></a><?php echo $row['servicename']; ?></li>
                               <?php } ?>
                            </form>
                        </ul>
                                                </div>
                          <a button class="btn btn-lg btn-primary btn-block" type="submit" href="skills.php">Go Back</a>


                    </div>
                 </form>
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

<?php 
if(isset($_POST['delete'])) {
	$serviceid = $_POST['id'];
	$query3 = "SELECT serviceid FROM appointments a  NATURAL JOIN serviceprovider_schedules p  where a.status='accepted' and p.spid = '$spid' and serviceid = '$serviceid'";
	$result3 = mysqli_query($conn, $query3);
	$r3 = mysqli_fetch_assoc($result3);
    	
    $delete = "DELETE from sp_skills WHERE serviceid = '$serviceid' and spid = '$spid'";
    $done = mysqli_query($conn, $delete);
    echo "<script>
                    window.location.href = 'deleteSkills.php';
                </script>";
}
 ?>