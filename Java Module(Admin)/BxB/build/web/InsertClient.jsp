<%-- 
    Document   : InsertClient
    Created on : 05 1, 17, 12:35:20 AM
    Author     : Vash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form method="post" action="InsertClientServlet">
            First name<input type="text" name="first_name"/></br>
            Last name<input type="text" name="last_name"/></br>
            Birthdate: <input type="date" name="birthdate"/></br>
            Email: <input type="text" name="email"/></br>
            Username:<input type="text" name="username"/></br>
            Password: <input type="text" name="password"/></br>           
            Contact Number: <input type="text" name="contactNo"/></br>
            Address: <input type="text" name="address"/></br>
            <input type="submit" value="SUBMIT!"/>
            <!--Remember to include the picture and use the JSP comments here-->
        </form>
    </body>
</html>
