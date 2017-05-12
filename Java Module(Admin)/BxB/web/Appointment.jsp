<%-- 
    Document   : Appointment
    Created on : 05 5, 17, 10:10:02 PM
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
        <h1>Here are the valid appointmens</h1>
        <table>
            <form>
                <tr>
                    <th></th>
                    <th>Appointment Number</th>
                    <th>Sched ID</th>
                    <th>Date Request</th>
                    <th>Client Number</th>
                    <th>Service ID</th>
                    <th>Status</th>
                </tr>
                
                <c:forEach var="Appointment" items="${Appointments}">
                    <tr>
                        <td><input type="checkbox" value="${Appointment.appointmentno}"/></td>
                        <td>${Appointment.spSchedId}</td>
                        <td>${Appointment.datereq}</td>
                        <td>${Appointment.clientno}</td>
                        <td>${Appointment.serviceId}</td>
                        <td>${Appointment.status}</td>
                    </tr>
                </c:forEach>
                   
            </form>
        </table>
        <br />
        <p>Sort by</p>
        <form method = "get" action="SortAppointment">
            <input type="radio" value="1" name="sort" />Rejected 
            <input type="radio" value="2" name="sort" />Accepted/Ongoing
            <input type="radio" value="3" name="sort" />Finished 
            <input type="radio" value="4" name="sort" />Request
            <br />
            <input type ="submit" value="Sort!"/>          
        </form>
        <input type="button" value = "Refresh!" onclick="location.href='ValidAppointments';" />
    </body>
</html>
