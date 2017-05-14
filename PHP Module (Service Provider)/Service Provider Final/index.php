<?php
    include('connection.php');
	session_start();
	$cookie_name = "loggedin";

	if (isset($_COOKIE[$cookie_name])) {
		$cookie_value = $_COOKIE[$cookie_name];
		$username = $cookie_value;
    }

    
	$query = "SELECT * from serviceproviders s join sp_skills p on s.spid = p.spid join services c on p.serviceid = c.serviceid where username = '$username' ";
	$query2 = "SELECT * from serviceproviders s join sp_skills p on s.spid = p.spid join services c on p.serviceid = c.serviceid where username = '$username' ";
	$result = mysqli_query($conn, $query);
	$result2 = mysqli_query($conn, $query2);

	$row = mysqli_fetch_array($result);
	
    $today = date('Y-m-d');
    $query3 = "SELECT * FROM appointments a JOIN serviceprovider_schedules ss ON ss.schedid = a.sp_schedid JOIN services s on s.serviceid = a.serviceid JOIN serviceproviders sp ON sp.spid = a.spid JOIN clients c ON c.clientno = a.clientno where sp.username = '$username' and ss.sched_date= '2017-05-14' and a.status='accepted' ORDER BY ss.sched_date ASC";
	$result3 = mysqli_query($conn, $query3);

?>


<!DOCTYPE html>
<html>

<head>
    <title>Service Provider</title>
    <meta charset="UTF-8">
    <meta name="Author" content="BxbWebsite">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/apps.css">
    <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
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
        <span style="font-size:1.5em;font-family:Lato;cursor:pointer;color:white;float:right;z-index:2;padding-top:50px;" onclick="openNav()">&#9776; Menu</span>
    </div>

    <div id="main">
    </div>
    <!--About Me-->
    <div id="About">
        <div id="aboutbox">
            <div id="welcome">
                Your Schedule for Today (<?php echo $today; ?>):
            </div>
            <div id="appointment">

                <ul class="no-bullet">
                   
                    <li>
                        <?php while ($row2 = mysqli_fetch_array($result3)) {?>
                        <span>Service: </span> <?php echo $row2['servicename']; ?><br>
                        <span class="float-right">Client Name: </span><?php echo $row2['first_name'].' '.$row2['last_name']; ?>
                        <br>
                        <span class="float-right">Time: </span><?php echo $row2['start_time']; ?><br>
                        <span class="float-right">Address: </span><?php echo $row2['address']; ?><br>
                        <span class="float-right">Contact No.: </span><?php echo $row2['contactno']; ?><br>
                        <span class="float-right">Email: </span><?php echo $row2['email']; ?><br>
                       
                       <?php } ?> 
                    </li>
                    
                </ul>
            </div>
        </div>
    </div>
    <!--profile-->
    <div id="Profile">
           <!--<div id="info">-->
            <!--this should be in list type-->
            <p>Hello <?php echo $username; ?></p>
            <p>Contact Info:<?php echo $row['contactno'];?>
                <br>Email Info:<?php echo $row['email'];?>
                <br>
                <br><h3>Skills</h3>
                
                    <?php while($row2 = mysqli_fetch_array($result2)){ ?>
					
                    <?php echo  $row2['servicename']."<br>"; ?>
			         
                     <?php } ?>
				
                <br>
            </p>
       <!-- </div>-->
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