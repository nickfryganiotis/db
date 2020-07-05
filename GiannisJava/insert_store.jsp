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
String sqlInsert1;
String sqlInsert2;
String sqlFinal;
String street = request.getParameter("Street");
String address_number = request.getParameter("Address Number");
String postal_code = request.getParameter("Postal Code");
String city = request.getParameter("City");
String size = request.getParameter("Store size in square meters");
String operating_hours = request.getParameter("Operating Hours in the form: HH:MM-HH:MM");


sqlInsert1 = "INSERT INTO store (street, address_number, postal_code, city ";
sqlInsert2 = "('" + street +"'," + address_number +" ,'" + postal_code + "','" + city + "'" ;



if (size!= ""){
	sqlInsert1 = sqlInsert1 + ",size";
	sqlInsert2 = sqlInsert2 + "," + size;	
}
if (operating_hours != ""){
	sqlInsert1 = sqlInsert1 + ",operating_hours";
	sqlInsert2 = sqlInsert2 + ",'" + operating_hours +"'";	
}
sqlInsert1 = sqlInsert1 + ") VALUES ";
sqlInsert2 = sqlInsert2 + ");";
sqlFinal = sqlInsert1 + sqlInsert2;
%>
</body>
</html>