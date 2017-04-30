<%-- 
    Document   : DeleteSp
    Created on : 04 28, 17, 1:42:31 AM
    Author     : Vash
--%>

<%@page import="java.sql.ResultSet"%>
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
        <h1>Here are the valid service providers</h1>
        <%
            ResultSet results = (ResultSet) request.getAttribute("ValidSp");
            while(results.next()){
                out.write(results.getInt(1));
            }
        %>
    </body>
</html>
