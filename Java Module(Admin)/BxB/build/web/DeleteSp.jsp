<%-- 
    Document   : DeleteSp
    Created on : 04 28, 17, 1:42:31 AM
    Author     : Vash
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Beans.ServiceProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <script>
            function changeSearch(){
                //Check the highlighted radio button
                //then just build the form according to that
                
                var radVal = document.getElementsByName("type");
                x = undefined;
            
                for(count = 0; count < radVal.length; count++){
                    
                    if(radVal[count].checked){
                        x = radVal[count].value;
                        break;
                    }
                }
                
                console.log(x);
                
                if(x === "ByName"){
                    var div = document.getElementById("search");
                    div.innerHTML = "<form method = 'post' action = 'SearchServicePByName'> \n\
                                        <input type='text' name = 'lastN'/>:Last Name <br />\n\
                                        <input type='text' name = 'firstN'/>:FirstName <br />\n\
                                        <input type='submit' name='SEARCH!'/>\n\
                                    </form>";
             
                }
                    
                
                if(x === "ByClassNumber"){
                    var div = document.getElementById("search");
                    div.innerHTML = "<form method = 'post' action = 'SearchServicePById'> \n\
                                        <input type='text' name = 'spId'/>:ClientNum <br />\n\
                                        <input type='submit' name='SEARCH!'/>\n\
                                    </form>";
                }
            }
        </script>
    </head>
    <body>
        <h1>Here are the valid service providers</h1>
        <table>
            
                <tr>
                    <th></th>
                    <th>ID</th>
                    <th>Last name</th>
                    <th>First name</th>
                    <th>E-mail</th>
                    <th>Contact Number </th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Status</th>
                    <th>Total rating</th>
                </tr>
                <form method="post" action="DeactivateServiceProvider">
                    <c:forEach var="sp" items="${ValidSpList}"> 
                        <tr>
                            <td>
                                <input type="checkbox" name="sp" class="awef" value="${sp.spId}"/>
                            </td>
                            
                            <td>${sp.spId}</td>
                            <td>${sp.lastName}</td>
                            <td>${sp.firstName}</td>
                            <td>${sp.email}</td>
                            <td>${sp.contactNo}</td>
                            <td>${sp.userName}</td>
                            <td>${sp.password}</td>
                            <td>${sp.status}</td>
                            <td>${sp.totalRating}</td>
                        </tr>
                           
                    </c:forEach>
                <tr>
                    <td><input type="submit" value="Deactivate!"/></td>
                    <td><input type="button" onclick="location.href='InsertSp.jsp';" value="INSERT!" /></td> 
                </tr>
            </form>
        </table>   
        <input type="button" onclick="location.href='ValidServiceProviderServlet';" value = "Refresh!" />
        <hr />
        <h2>Search here!</h2>
        <input type="radio" value="ByClassNumber" name="type" onclick="changeSearch()" default="default"/>By ServiceNum
        <input type="radio" value ="ByName" name="type" onclick="changeSearch()"/>By Name
        <div id="search">
            <form method = "post" action="SearchServiceProvider">
                <input type="text" name = "lastN"/>:Last Name <br />
                <input type="text" name = "firstN"/>:First Name <br />
                <input type="submit" value="Search!"/>
            </form>
        </div>
    </body>
</html>
