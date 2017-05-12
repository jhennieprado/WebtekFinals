<%-- 
    Document   : DeleteClient
    Created on : 05 3, 17, 10:02:31 PM
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
                    div.innerHTML = "<form method = 'post' action = 'SearchClient'> \n\
                                        <input type='text' name = 'lastN'/>:Last Name <br />\n\
                                        <input type='text' name = 'firstN'/>:FirstName <br />\n\
                                        <input type='submit' name='SEARCH!'/>\n\
                                    </form>";
             
                }
                    
                
                if(x === "ByClassNumber"){
                    var div = document.getElementById("search");
                    div.innerHTML = "<form method = 'post' action = 'SearchClientById'> \n\
                                        <input type='text' name = 'ClientNumber'/>:ClientNum <br />\n\
                                        <input type='submit' name='SEARCH!'/>\n\
                                    </form>";
                }
            }
        </script>
    </head>
    <body>
        <h1>This will show all of the valid clients that you supposedly can deactivate</h1>
        <table>
            <form method="post" action="DeactivateClient">
                <tr>
                    <th></th>
                    <th>Client Number</th>
                    <th>Last Name</th>
                    <th>First Name</th>
                    <th>Birthdate</th>
                    <th>E-mail</th>
                    <th>User name</th>
                    <th>Password</th>
                    <th>Contact No.</th>
                    <th>Address</th>
                    <th>Account Created</th>
                    <th>Status</th>
                </tr>
                <c:forEach var="client" items="${clients}">
                    <tr>
                        <td><input type="checkbox" value="${client.clientNo}" name="clients"/></td>
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
                    <td><input type="submit" value="Deactivate!"/></td>
                    <td><input type="button" onclick="location.href='InsertClient.jsp';" value="INSERT!" /></td> 
                </tr>
            </form>
        </table>
        
        <input type="button" value = "Refresh!" onclick="location.href='ValidClients';" />
        
        <hr />
        <h2>Search here!</h2>
        <input type="radio" value="ByClassNumber" name="type" onclick="changeSearch()" default="default"/>By ClientNum
        <input type="radio" value ="ByName" name="type" onclick="changeSearch()"/>By Name
        <div id="search">
            <form method = "post" action = "SearchClient">         
                <input type="text" name = "lastN"/>:Last Name<br />
                <input type="text" name = "firstN"/>:First Name<br />
                <input type="submit" name = "Search!"/>
            </form>
        </div>
    </body>
</html>
