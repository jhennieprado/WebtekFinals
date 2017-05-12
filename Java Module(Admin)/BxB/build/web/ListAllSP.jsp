<%-- 
    Document   : ListAllSP
    Created on : 05 13, 17, 1:52:33 AM
    Author     : Vash, Adrian
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
        <form method="post" action="SPFilterReport">
            <select name="select1">
                <c:forEach var="gei" items="${spid}" varStatus="loop">
                    <option value="${gei}">${sp[loop.index]}</option>
                </c:forEach>
            </select>
            <input type="submit" value="Submit!">
        </form>
    </body>
</html>
