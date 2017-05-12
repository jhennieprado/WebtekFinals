<%-- 
    Document   : ApproveClient
    Created on : 05 2, 17, 1:43:19 AM
    Author     : Vash
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <table>
            <tr>
                <th></th>
                <th>Client Number</th>
                <th>Last Name</th>
                <th>First Name</th>
                <th>Birthday</th>
                <th>Email</th>
                <th>Username</th>
                <th>Password</th>
                <th>Contact No</th>
                <th>Address</th>
                <th>Status</th>
                <th>Account Created</th>
            </tr>
            <form method="post" action = "ApproveClient">
               <c:forEach var="client" items="${results}">
                   <tr>
                       <td><input type="checkbox" value="${client.clientNo}" name="pendingClient"/></td>
                       <td>${client.clientNo}</td>
                       <td>${client.lastName}</td>
                       <td>${client.firstName}</td>
                       <td>${client.birthDate}</td>
                       <td>${client.email}</td>
                       <td>${client.userName}</td>
                       <td>${client.passWord}</td>
                       <td>${client.contactno}</td>
                       <td>${client.address}</td>
                       <td>${client.status}</td>
                       <td>${client.accountCreated}</td>
                    </tr>
               </c:forEach>
                <tr>
                    <td><input type="submit" value="Submit!"/></td>
                </tr>
           </form>
        </table> 
    </body>
</html>
