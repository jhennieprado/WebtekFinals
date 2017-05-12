<%-- 
    Document   : Statistics
    Created on : 05 11, 17, 8:38:45 PM
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
        <h1>This should be the stuff for the daily report</h1>
        
        <!--Insert radio button to filter per day, weekly, or monthly-->
        <form method = "get" action = "MonthlyReport">
            <select name="month">
                <c:forEach var="gei" items="${months}" varStatus="loop">
                    <option value="${loop.index+1}">${gei}</option>          

                </c:forEach>
            </select>

            <select name="year">
                <c:forEach var="izgei" items="${years}">
                    <option>${izgei}</option>
                </c:forEach>
            </select>
            
            <input type="submit" value="Submit!"/>
        </form>
    </body>
</html>
