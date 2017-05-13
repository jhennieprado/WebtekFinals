<!DOCTYPE html>
<html>

<head>
    <title>Service Provider</title>
    <meta charset="UTF-8">
    <meta name="Author" content="BxbWebsite">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato|Pacifico" rel="stylesheet">
    <link rel="icon" href="images/logo.png" type="image/gif" sizes="16x16">

</head>

<body>
    <div id="sidenav" class="sidenav">
        <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
        <a href="index.html">Home</a>
        <a href="AcceptedReq.html">Accepted Requests</a>
        <a href="PendingReq.html">Pending Requests</a>
    </div>
    <div id="banner">
        <img src="css/images/bxb.png">
        <span style="font-size:30px;cursor:pointer;color:white;float:right;z-index:2;padding-top:40px;" onclick="openNav()">&#9776; Menu</span>
    </div>

    <div id="main">
    </div>
    <!--About Me-->
    <div id="About">
        <div id="aboutbox">
            <div id="welcome">
                Your Schedule for Today:
            </div>
            <div id="appointment">
                <p>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</p>

                <p>"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"</p>
            </div>
        </div>
    </div>
    <!--profile-->
    <div id="Profile">
        <div id="ProfBox">
            <div id="profilePic">
                <div id="img">
                    <img src="css/images/naturo.jpg" height="150px" width="150px">
                </div>
                <div id="form">
               <form action="upload.php" method="post" enctype="multipart/form-data">
                Select image to upload:
                <input type="file" name="fileToUpload" id="fileToUpload">
                <input type="submit" value="Upload Image" name="submit">
                </form>
        </div>
            </div>
                <div id="name">
                <p>Hello Clark Mariano!</p>
                </div>
            </div>
            
      
        <div id="info">
            <button id="myBtn">Edit Information</button>

            <!-- The Modal -->
            <div id="myModal" class="modal">

              <!-- Modal content -->
              <div class="modal-content">
                <span class="close">&times;</span>
                <p>Edit Settings <br>
                Contact Info:(+63) 917 234 9083
                <br>Email Info:service_provider@domain.com
                <br>
                <br>Skills:
                <br> Communication.
                <br> Ability to Work Under Pressure.
                <br> Decision Making.
                <br> Time Management.
                <br> Self-motivation.
                <br> Conflict Resolution.
                <br> Leadership.
                <br> Adaptability.
                <br>
                </p>
              </div>

            </div>
            <!--this should be in list type-->
            <p>Contact Info:(+63) 917 234 9083
                <br>Email Info:service_provider@domain.com
                <br>
                <br>Skills:
                <br> Communication.
                <br> Ability to Work Under Pressure.
                <br> Decision Making.
                <br> Time Management.
                <br> Self-motivation.
                <br> Conflict Resolution.
                <br> Leadership.
                <br> Adaptability.
                <br>
            </p>
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
        
       // Get the modal
        var modal = document.getElementById('myModal');

        // Get the button that opens the modal
        var btn = document.getElementById("myBtn");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks the button, open the modal 
        btn.onclick = function() {
            modal.style.display = "block";
        }

        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
        
    </script>
</body>

</html>