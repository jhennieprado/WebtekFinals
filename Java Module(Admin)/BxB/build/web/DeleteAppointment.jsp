<%-- 
    Document   : DeleteAppointment
    Created on : 05 1, 17, 4:09:29 PM
    Author     : Vash
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Beans.Appointment"%>
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
        <h1>Select the appointment in which you want to delete. I think we also
        need to put defined values for the status of the appointment.</h1>
        
        <c:set var="appointments" value="${Appointments}"/>
        
        <table>
            <tr>
                <th> Appointment Number </th>
                <th>  Amount </th>
                <th> Appointment Number </th>
                <th> Appointment Number </th>
                <th> Appointment Number </th>
                <th> Appointment Number </th>
                <th> Appointment Number </th>
                <th> Appointment Number </th>
            </tr>
            <c:forEach var="appointment" items="${appointments}">
                <h5> <c:out default="What happened" value="${appointment.dateFinished}"/> </h5>
            </c:forEach>
        </table>
        


        
        
    </body>
</html>
