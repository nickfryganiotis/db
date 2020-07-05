<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%

String sqlFinal;
String cn = request.getParameter ("Card Number of Customer to Delete");

sqlFinal = "DELETE FROM customer WHERE card_number = " + cn +';';

%>
</body>
</html>