<%-- 
    Document   : InsertService
    Created on : 04 27, 17, 11:56:39 PM
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
        <form action="InsertServiceServlet" method="post">
           ServiceName <input type="text" name="service_name"/><br />
           ServiceAmount <input type="text" name="service_amount"/><br />
           Description <input type="text" name="description"/><br />
           Category <input type="text" name="category"/><br />
           <input type="submit" value="SUBMIT!"/>
        </form>
        <a href="home.jsp">Go back!</a>
    </body>
</html>
