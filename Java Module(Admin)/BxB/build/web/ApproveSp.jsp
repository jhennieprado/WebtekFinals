<%-- 
    Document   : ApproveSp
    Created on : 04 29, 17, 11:00:59 AM
    Author     : Vash
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>These are the service providers that are still awaiting approval </h1>
        <table>
            <tr>
                <th></th>
                <th>ID</th>
                <th>Last Name</th>
                <th>First Name</th>
                <th>Email</th>
                <th>Contact Number</th>
                <th>Username</th>
                <th>Password</th>
                <th>Status</th>
            </tr>
            <form method="post" action="ApprovePServiceProvider">
                <c:forEach var="spN" items="${PendingSp}">
                    <tr>
                        <td><input type="checkbox" value="${spN.spId}" name="pendingSp"/></td>
                        <td>${spN.spId}</td>
                        <td>${spN.lastName}</td>
                        <td>${spN.firstName}</td>
                        <td>${spN.email}</td>
                        <td>${spN.contactNo}</td>
                        <td>${spN.userName}</td>
                        <td>${spN.password}</td>
                        <td>${spN.status}</td>
                    </tr>
                </c:forEach>
                <tr>
                    <td><input type="submit" value="Submit!"/></td>
                </tr>
            </form>
        </table>
    
    </body>
</html>
