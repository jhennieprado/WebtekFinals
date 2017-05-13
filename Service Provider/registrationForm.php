<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Registration Form</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/signup.css" rel="stylesheet">
    <script src="assets/ie-emulation-modes-warning.js"></script>
  </head>

  <body>
    <div class="logo">
        <img src="images/Logo.png" alt="logo">
    </div>
      
    <div class="container">
      <form class="form-signup">
        <h2 class="form-signup-heading">Please fill in the form</h2>

        <label for="inputFirstName" class="sr-only">First Name</label>
        <input type="Fname" id="inputFirstName" class="form-control" placeholder="First Name" required autofocus>

        <label for="inputLastName" class="sr-only">Last Name</label>
        <input type="Lname" id="inputLastName" class="form-control" placeholder="Last Name" required autofocus>

        <div class="maxl">
          <label class="radio inline"> 
              <input type="radio" name="sex" value="male">
              <span> Male </span> 
           </label>
          <label class="radio inline"> 
              <input type="radio" name="sex" value="female">
              <span>Female </span> 
          </label>
        </div>

        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>


        <label for="inputcontactNumber" class="sr-only">Contact Number</label>
        <input type="contactNumber" id="inputcontactNumber" class="form-control" placeholder="Contact Number" required autofocus>

        <label for="inputUsername" class="sr-only"></label>
        <input type="username" id="inputUsername" class="form-control" placeholder="Username" required autofocus>

        <label for="inputPassword" class="sr-only"></label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>

        <br>

        <button class="btn btn-lg btn-primary btn-block" type="submit">Register</button>
      </form>
    </div> <!-- /container -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
