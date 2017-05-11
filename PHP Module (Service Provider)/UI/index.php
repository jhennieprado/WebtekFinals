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



  $query = "SELECT *from appointments a join clients c on a.clientno = c.clientno join services s on a.serviceid = s.serviceid  where status = 'accepted'  order by a.daterequest asc";
  $result = mysqli_query($conn, $query);
  
?>



<!DOCTYPE html>
<html>
	<head>
		<title>Service Provider</title>
		<meta charset="UTF-8">
		<meta name="Author" content="WEbtekFinals">
		<link rel="stylesheet" type="text/css" href="style/Layout.css">
		<link rel="icon" href="images/logo.png" type="image/gif" sizes="16x16">
	</head>
	
	<body>
	    <div id="sidenav" class="sidenav">
      <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
      <a href="index.php">Home</a>
      <a href="profile.html">Profile</a>
      <a href="clientAccepted.php">Accepted Requests</a>
      <a href="clientRequest.php">Pending Requests</a>
      <a href="Report.html">Report</a>
    </div>
        <div id="banner">
            <img src="style/images/bxb.png">
              <span style="font-size:30px;cursor:pointer;color:white;float:right;z-index:2;padding-top:40px;" onclick="openNav()">&#9776; Menu</span>
        </div>
        
    <div id="main">
        </div>
	<!--About Me-->
			<div id="About">
					<div id="aboutbox">
                        <div id="welcome">
                           <h1>Hello <?php echo $username;?></h1>
                        </div>
						<div id="appointment">
						<div id="head">Your Appointments for Today: </div>

            <table cellpadding="5" cellspacing="5">
            <form method="post" action="clientAccepted.php">
                <?php while ($row = mysqli_fetch_array($result)) {?>
                  <li>Client No.: <?php echo $row['clientno']; ?></li>
                  <li>Client Name: <?php echo $row['first_name'].' '.$row['last_name']; ?></li>
                  <li>Contact No.: <?php echo $row['contactno']; ?></li>
                  <li>Date Of Service: <?php echo $row['daterequest']; ?></li>
                  <li>Service Name: <?php echo $row['servicename']; ?></li>
                  <li>Address: <?php echo $row['address']; ?></li>
                   <input type="submit" name="done" value="done"> 
                  <input type="hidden" name="id" value="<?php echo $row['appointmentno']; ?>"/> 
                  <hr></hr>
                  </form>
                <?php } ?>
                <?php 
                    if(isset($_POST['done'])) {

                      $appointmentno = $_POST['id'];

                      $done = "UPDATE appointments SET status = 'done' WHERE appointmentno = '$appointmentno'" ;
                      $res = mysqli_query($conn, $done);
                      echo "done";

                    }

                ?>
            </table>
						
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
        document.getElementById("main").style.marginLeft= "0";
        document.body.style.backgroundColor = "white";
    }
    </script>
	</body>
</html>