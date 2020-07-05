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
String bc = request.getParameter ("Barcode of Product to Delete");

sqlFinal = "DELETE FROM product WHERE barcode = '" + bc +"';";

%>
</body>
</html>