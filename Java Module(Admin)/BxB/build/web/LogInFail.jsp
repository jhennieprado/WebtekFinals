<%-- 
    Document   : LogInFail
    Created on : 04 28, 17, 2:30:17 AM
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
        <h1>Wrong credentials!</h1>
        <p><c:out value="${requestScope.thisId}"/></p>
    </body>
</html>
