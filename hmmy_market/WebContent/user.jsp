<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page session="false" %>
<%Cookie cookie = null;
Cookie[] cookies = null; 
cookies = request.getCookies();

System.out.println(cookies[0].getValue());
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>user</title>
</head>
<body>

</body>
</html>