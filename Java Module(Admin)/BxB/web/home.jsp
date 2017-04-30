<%-- 
    Document   : home
    Created on : 04 27, 17, 10:42:14 PM
    Author     : Vash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <h1>Welcome <c:out value="${UserName}"/> (Admin) </h1>
        <h2>Today is <c:out value="${DateToday}"/> </h2> </br> </br>
        <hr />
        <h3> Supposed to be dashboard here </h3>
        
        <h4> <c:out default="over" value="${numOfActors}"/> Registered Actors </h4>
        <h4> <c:out default="over" value="${numOfCustomers}"/> Number of Customers</h4>
        <h4> <c:out default="over" value="${numOfFilms}" /> Films Sold</h4>
        <h4> <c:out default="over" value="${numOfValSp}" /> Valid Service Providers</h4>
        <h4> <c:out default="over" value="${numOfInvalSp}" /> Service Providers Pending</h4>
        <hr />
        <h1>All valid service providers</h1>
        
        <hr/>
        <a href="InsertSp.jsp"><h1>Insert new service provider here</h1></a>
        
        <hr />
        
        <a href="InsertService.jsp"><h1>Insert New Services</h1></a>

        <hr />  
        
        <a href="ValidServiceProviderServlet"><h1>Delete Service Providers</h1></a>
        
    </body>
</html>
