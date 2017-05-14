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

<!DOCTYPE html>
<html>

<head>
    <title>Service Provider</title>
    <meta charset="UTF-8">
    <meta name="Author" content="BxbWebsite">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/settings.css">
    <link rel="stylesheet" type="text/css" href="css/apps.css">
    <link href="https://fonts.googleapis.com/css?family=Lato|Pacifico" rel="stylesheet">
    <link rel="icon" href="images/logo.png" type="image/gif" sizes="16x16">

</head>

<body>
    <div id="sidenav" class="sidenav">
        <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
        <a href="index.php">Home</a>
        <a href="skills.php">Skills</a>
        <a href="settings.php">Account Settings</a>
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

         <h3>Skills Information</h3>
         <?php while($row = mysqli_fetch_array($result)){ ?>
        <!-- <form class="form-horizontal" role="form" method="post" action="notification.php">
        <div class="form-group">-->
        <div class="col-md9 skills_info">
            
            <ul id="skill_list">
                <?php 
                    
                                
                ?>
                <!-- php code here to generate dynamic li contents from database -->
                <li><?php 
                          echo $row['servicename']."<br>";
                          echo "PHP ".$row['price'].".00";
                          
                    ?>
                </li>
            </ul>
        <!--</div>
        </form>-->
        <?php } ?>
            <a href="editskill.php">Add Skills</a>
            <a href="deleteskill.php">Delete Skills</a>
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