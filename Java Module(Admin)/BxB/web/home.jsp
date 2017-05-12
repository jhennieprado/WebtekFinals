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
        <h1>Welcome <c:out value="${sessionScope.UserName}"/> (Admin) </h1>
        <h1><c:out value="${sessionScope.UserName}"/> <h1>
        <h2>Today is <c:out value="${DateToday}"/> </h2> </br> </br>
        <a href="LogOutServlet"><h3>Logout</h3></a>
        <hr />
        <h3> Supposed to be dashboard here </h3>
        
        <h4> <c:out default="over" value="${numOfServices}"/> Services </h4>
        <h4> <c:out default="over" value="${numOfCustomers}"/> Number of Clients</h4>
        <h4> <c:out default="over" value="${numOfValSp}" /> Valid Service Providers</h4>
        <h4> <c:out default="over" value="${numOfInvalSp}" /> Service Providers Pending</h4>
        <h4> <c:out default="over" value="${numOfValC}" /> Clients Pending</h4>
        <h4> <c:out default="over" value="${numOfPendC}" /> Clients Pending</h4>
        
        <hr />
        <nav>
            <a href="MainServlet"> <h1> Dashboard </h1> </a>       
            <a href="EditTables.html"> <h1>Edit Tables</h1> </a>
            <a href="PendingServiceProviderServlet"><h1>Approve service provider</h1></a>
            <a href="PendingClient"><h1>Approve pending client</h1></a>
            <a href=""><h1>Statistics and Graphs</h1> </a>
            <a href=""> <h1>Transaction</h1> </a>
        </nav>
        <hr />
        
        <h1>Latest Clients</h1>
        <!--You could have used the fn module here -->
        <c:choose>
            <c:when test="${numOfC <=  0}">
                <h5>There are no clients! </h5>
            </c:when>
            
            <c:otherwise>
                <table>
                    <tr>
                        <th>Client No.</th>
                        <th>Last Name</th>
                        <th>First Name</th>
                        <th>Email</th>
                        <th>Contact No.</th>
                        <th>Address</th>
                        <th>Status</th>
                    </tr>
                    <c:forEach var="clients" items="${AllClients}">
                        <tr>
                            <td>${clients.clientNo}</td>
                            <td>${clients.lastName}</td>
                            <td>${clients.firstName}</td>
                            <td>${clients.email}</td>
                            <td>${clients.contactno}</td>
                            <td>${clients.address}</td>
                            <td>${clients.status}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
        <hr />
        
        <h1>Latest Messages</h1>

        <hr />
        
        <h1>Latest appointments</h1>
        <c:choose>
            <c:when test="${numOfApps <= 0}">
                <h3>There are currently no appointments</h3>
            </c:when>
                
            <c:otherwise>
                <table>
                    <tr>
                        <th>Appointment No.</th>
                        <th>Sp Sched ID</th>
                        <th>Date Requested</th>
                        <th>Client</th>
                        <th>Service id </th>
                        <th>status</th>
                        <th>rating</th>
                        <th>spid</th>
                        <th>Amount</th>
                    </tr>
                
                <c:forEach var= "apps" items="${latestAppointments}">
                    <tr>
                        <td>${apps.appointmentno}</td>
                        <td>${apps.spSchedId}</td>
                        <td>${apps.datereq}</td>
                        <td>${apps.clientno}</td>
                        <td>${apps.serviceId}</td>
                        <td>${apps.status}</td>
                        <td>${apps.rating}</td>
                        <td>${apps.spId}</td>
                        <td>${apps.amount}</td>
                    </tr>
                </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>

        <hr />
    </body>
</html>
