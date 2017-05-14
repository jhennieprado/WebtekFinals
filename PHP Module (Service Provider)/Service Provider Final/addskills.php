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
	

?>



<!DOCTYPE html>
<html>

<head>
    <title>Add Skills</title>
    <meta charset="UTF-8">
    <meta name="Author" content="BxbWebsite">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/skills.css">
    <link rel="stylesheet" type="text/css" href="css/apps.css">
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Lato|Pacifico" rel="stylesheet">
    <link rel="icon" href="css/images/logo.png" type="image/gif" sizes="16x16">

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
                    <i class="fa fa-coffee"></i> Add a <strong>skill</strong> and provide your preferred price for the given service. Click the <strong>X</strong> beside the <strong>skills</strong> to go back.
                </div>
                <div class="dropdown">
                    <form method="post" action="addskills.php">                        
                     <select name="fil" class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">
                        <option><span class="caret">All</span></option>
                        <?php while($row2 = mysqli_fetch_array($result3)) {?>
                         <option><span><?php echo $row2['category'] ?></span></option>
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
                    
                    
                        
                        
                        
                        
                        
                        
                    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Haircut</a>
                        </li>
                    </ul>
                </div>
                <hr>
                <?php while($row = mysqli_fetch_array($result)){ ?>
                <label class="col-lg-3 control-label"><?php echo $row['servicename']; ?></label>
                <div class="input-group">
                <form method="post" action="addskills.php">
                    <input type="text" class="form-control" placeholder="Enter price" name="price">
                    <span class="input-group-btn">
                        <input class="btn btn-default" type="submit" value="Add" name="add">
                        <input type="hidden" name="id" value="<?php echo $row['serviceid']; ?>"/>
                    </span>
                </form>	
                </div>
                <?php } ?>
                <hr>
                <a button class="btn btn-lg btn-primary btn-block" type="submit" href="skills.php">Go Back</a>
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
if(isset($_POST['add'])) {
			$serviceid = $_POST['id'];
            $price = $_POST['price'];
			$insert = "INSERT INTO sp_skills(spid, serviceid, price) VALUES($spid, $serviceid,$price)";
			$done = mysqli_query($conn, $insert);
			//echo $spid.$serviceid;
            echo "<script>
                    window.location.href = 'addskills.php';
                </script>";
            
		}
 ?>