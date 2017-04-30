<%-- 
    Document   : index
    Created on : 04 27, 17, 10:39:31 PM
    Author     : Vash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
        </script>
       
    </head>
    <body>
        <h1>BXB Admin Login</h1>
        <form method="post" action="LogInServlet">
            Username: <input type="text" name="user_name"/>
            Password: <input type="password"  name="pass_word" />
            <input type ="submit"  value="Log in" id="LogIn"/>    
        </form>
        <hr />
    </body>
</html>
