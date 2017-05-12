<%-- 
    Document   : Report
    Created on : 05 12, 17, 11:58:27 PM
    Author     : Vash
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Total Revenue for ${month} ${year}</h2>
        <p>${totalRevForMonth}</p>
        <h2>Number of Appointments for ${month} ${year}</h2>
        <p>${numOfAppointmentThisMonth}</p>
        <h1>Reports for this month</h1>
        <h2>Top Employee for ${month} ${year} </h2>
        <p>${highestSp}</p>
        <h2>Least Favorite Employee for ${month} ${year} </h2>
        <p>${lowestSp}</p>
        <table>
            <thead><h2>Top Employees for ${month} ${year}</h2></thead>
            <tr>
                <th>SP Name</th>
                <th>Amount</th>
            </tr>
            <c:forEach var="geishat" items="${spidHiEarn}" varStatus="loop">
                <tr>
                    <td>${geishat}</td>
                    <td>${amountHiEarn[loop.index]}</td>
                </tr>
            </c:forEach>
        </table>
        
    </body>
</html>
