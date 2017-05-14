<?php
    include('connection.php');
	session_start();
	$cookie_name = "loggedin";

	if (isset($_COOKIE[$cookie_name])) {
		$cookie_value = $_COOKIE[$cookie_name];
		$username = $cookie_value;
    }

    $query = "SELECT * from serviceproviders s join sp_skills p on s.spid = p.spid join services c on p.serviceid = c.serviceid where username = '$username' ";
    $result = mysqli_query($conn, $query);
    $row = mysqli_fetch_array($result);


$query2 = "SELECT spid from serviceproviders where username = '$username'";
  $result2 = mysqli_query($conn, $query2);
  $spidInit = mysqli_fetch_assoc($result2);
  $spid = $spidInit['spid'];
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
        <a href="accepted.php">Appointments</a>
        <a href="pending.php">Pending Requests</a>
    </div>
    <div id="banner">
        <img src="css/images/bxb.png">
        <span style="font-size:30px;cursor:pointer;color:white;float:right;z-index:2;padding-top:40px;" onclick="openNav()">&#9776; Menu</span>
    </div>
    <div class="container">
        <h1>Edit Profile</h1>
        <hr>
        <div class="row">
            <!-- left column -->
            <div class="col-md-3">
                <div class="text-center">
                    <img src="css/images/-text.png" onerror="if (this.src != 'error.jpg') this.src = 'error.jpg';">
                    <h6>Upload a different photo...</h6>
                    <form class="form-horizontal" role="form" method="post" action="settings.php" enctype="multipart/form-data" >
                    <input type="file" class="form-control" name="profpic">
                </div>
            </div>

            <!-- edit form column -->
            <div class="col-md-9 personal-info">
                <div class="alert alert-info alert-dismissable">
                    <a class="panel-close close" data-dismiss="alert">×</a>
                    <i class="fa fa-coffee"></i> This is an <strong>.alert</strong>. Use this to show important messages to the user.
                </div>
                <h3>Personal info</h3>

                
                    <div class="form-group">
                        <label class="col-lg-3 control-label">Contact Number:</label>
                        <div class="col-lg-8">
                            <input class="form-control" type="tel" name="contactno" placeholder="<?php echo $row['contactno'];?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label">Email:</label>
                        <div class="col-lg-8">
                            <input class="form-control" type="text" name="email" placeholder="<?php echo $row['email']; ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"></label>
                        <div class="col-md-8">
                            <input type="submit" class="btn btn-primary" value="Save Changes" name="apply">
                            <span></span>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <?php 
            if(isset($_POST['apply'])) {
	           $contactno = $_POST['contactno'];
               $email = $_POST['email'];
               $profpic = $_POST['profpic'];
                //path to store the uploaded image
                $target = "Service Provider/images/".basename($_FILES['profpic']['name']);
                
                $profpic=$_FILES['profpic']['name'];
               
	           $info = "UPDATE serviceproviders SET contactno = '$contactno', email='$email', profpic='$profpic' where username = '$username'";
	           $update = mysqli_query($conn, $info);
                
                if(move_uploaded_file($_FILES['tmp_name']['name'], $target)) {
                    $msg = "Image upload successfully";
                } else{
                    $msg = "There was a problem uploading image";
                }
	           echo "<script>
                    window.location.href = 'settings.php';
                </script>";
              

} 
?>
        
        
        
        
        <hr>
        <div class="col-md-9 personal-info">
            <h3>Edit Schedule</h3>
            <form class="form-horizontal" role="form" action="settings.php" method="post">
                <div class="form-group">
                    <label class="col-md-3 control-label" for="event_date">Date:</label>
                    <div class="col-md-8">
                        <input type="date" placeholder="" name="sched_date" class="form-control" required="">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label">End Time</label>
                    <div class="col-lg-8">
                        <div class="ui-select">
                            <select id="user_time_zone" class="form-control" name="start_time">
                                <option value="7:00:00">7:00</option>
                                <option value="8:00:00">8:00</option>
                                <option value="9:00:00">9:00</option>
                                <option value="10:00:00">10:00</option>
                                <option value="11:00:00">11:00</option>
                                <option value="12:00:00">12:00</option>
                                <option value="1:00:00">1:00</option>
                                <option value="2:00:00">2:00</option>
                                <option value="3:00:00">3:00</option>
                                <option value="4:00:00">4:00</option>
                                <option value="5:00:00">5:00</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label">End Time</label>
                    <div class="col-lg-8">
                        <div class="ui-select">
                            <select id="user_time_zone" class="form-control" name="end_time">
                                <option value="8:00:00">8:00</option>
                                <option value="9:00:00">9:00</option>
                                <option value="10:00:00">10:00</option>
                                <option value="11:00:00">11:00</option>
                                <option value="12:00:00">12:00</option>
                                <option value="1:00:00">1:00</option>
                                <option value="2:00:00">2:00</option>
                                <option value="3:00:00">3:00</option>
                                <option value="4:00:00">4:00</option>
                                <option value="5:00:00">5:00</option>
                                <option value="6:00:00">6:00</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label"></label>
                    <div class="col-md-8">
                        <input type="submit" class="btn btn-primary" name="submit2" value="Save Schedule">
                        <span></span>
                    </div>
                </div>
            </form>
            <hr>
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

if(isset($_POST['submit2'])) {
	$sched_date = $_POST['sched_date'];
	$start_time = $_POST['start_time'];
	$end_time = $_POST['end_time'];
    $sched = "SELECT sched_date FROM serviceprovider_schedules WHERE sched_date = '$sched_date' and start_time = '$start_time' and end_time = '$end_time' and spid = '$spid'";
    $result5 = mysqli_query($conn, $sched);
    //$maybe = mysql_num_rows($result2);
    if(mysqli_num_rows($result5)==0){
        $insert = "INSERT INTO serviceprovider_schedules (schedid, spid, sched_date, start_time, end_time, vacant) VALUES (NULL, '$spid', '$sched_date', '$start_time', '$end_time', 'yes')";
	$done = mysqli_query($conn, $insert);
    } else{ 
        ?>
    
        <h2><?php echo "You already included this schedule!"; ?></h2> <?php
    }
}
?>
    
    
    
    