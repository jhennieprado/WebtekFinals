<%-- 
    Document   : DeleteService
    Created on : 04 28, 17, 1:42:05 AM
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
        <h1>Here is a list of all the services, choose the ones you want to delete</h1>
        <form method = "get" action="SortServiceByCat" >
            <select name="categ">
                <c:forEach var="cats" items="${categories}">
                    <option>${cats}</option>
                </c:forEach>
            </select>
            <input type="submit" value="Submit"/>
        </form>
        
        <input type="button" value = "Refresh!" onclick="location.href='ValidServicesServlet';" />
        
        <table>
            <form method = "post" action = "DeleteService">
                 <!--I Think we should just make the size into an attribute-->
  
                <tr>
                    <th> </th>
                    <th>Service ID</th>
                    <th>Service name</th>
                    <th>Service amount</th>
                    <th>Description</th>
                    <th>Category</th>
                </tr>
                <c:forEach var="service" items="${results}">                    
                    <tr>
                        <td><input type="checkbox" name="services" value="${service.serviceId}"/></td>
                        <td>${service.serviceId}</td>
                        <td>${service.serviceName}</td>
                        <td>${service.serviceAmount}</td>
                        <td>${service.description}</td>
                        <td>${service.category}</td>
                    </tr>
                </c:forEach>
                <tr>
                    <td><input type="submit" value="DELETE!"/></td>
                    <td><input type="button" onclick="location.href='InsertService.jsp';" value="INSERT!" /></td> 
                </tr>
            </form>
        </table>
    </body>
</html>
