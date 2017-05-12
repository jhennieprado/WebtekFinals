<%-- 
    Document   : InsertSp
    Created on : 04 27, 17, 11:54:38 PM
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
        <h1>Enter Credentials Here</h1>
        <form action="InsertServiceProviderServlet" method="post">
            firstName <input type="text" name="first_name"/><br />
            lastName <input type="text" name="last_name"/><br />
            email <input type="text" name="email"/><br />
            contact no <input type="text" name="contact"/><br />
            TotalRating <input type="text" name="rating"/><br />
            userName <input type ="text" name="user_name"/><br />
            password <input type = "password" name="pass_word"/><br />
            <input type="submit" value="SUBMIT!"/>
        </form>
    </body>
</html>
