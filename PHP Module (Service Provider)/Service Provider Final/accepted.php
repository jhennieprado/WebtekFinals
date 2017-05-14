<?php
	include('connection.php');


	$query = "SELECT *from appointments a join clients c on a.clientno = c.clientno join services s on a.serviceid = s.serviceid  where status = 'accepted'  order by a.daterequest asc";
	$result = mysqli_query($conn, $query);
	
?>

<!DOCTYPE html>
<html>

<head>
    <title>Accepted Requests</title>
    <meta charset="UTF-8">
    <meta name="Author" content="BxbWebsite">
    <link rel="stylesheet" type="text/css" href="css/request.css">
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

    <div id="Accept">
        <div id="Acceptbox">
            <div id="welcome">
                 <a href="index.php">&times;</a>
                Accepted Appointments
            </div>
            <div id="appointment">
                <?php while ($row = mysqli_fetch_array($result)) {?>
                <ul class="no-bullet">
                    <li>
                        <span>Service</span> <?php echo $row['servicename']; ?><br>
                        <span class="float-right">Name: <?php echo $row['first_name'].' '.$row['last_name']; ?></span>
                        <br>
                        <span class="float-right"><?php echo $row['contactno']; ?>Contact No.:</span><br>
                        <span class="float-right"><?php echo $row['email']; ?>Email: </span><br>
                        <span class="float-right"><?php echo $row['address']; ?>Address: </span><br>
                        
                        <form method="post" action="accepted.php">
                            <span><input type="submit" name="done" value="done"></span>
                            <input type="hidden" name="id" value="<?php echo $row['appointmentno']; ?>"/>
                        </form>
                        
                    </li>
                </ul>

            <?php } ?>    
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
				if(isset($_POST['done'])) {

					$appointmentno = $_POST['id'];

					$done = "UPDATE appointments SET status = 'done' WHERE appointmentno = '$appointmentno'" ;
					$res = mysqli_query($conn, $done);
					echo "done";

				}

		?>