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
String sqlUpdate1;
String sqlUpdate2;
String sqlFinal;
String si = request.getParameter ("ID of Store to Change");
String street = request.getParameter("New Street");
String address_number = request.getParameter("New Address Number");
String postal_code = request.getParameter("New Postal Code");
String city = request.getParameter("New City");
String size = request.getParameter("New Size");
String operating_hours = request.getParameter("New Operating Hours");
String helpful = "";

sqlUpdate1 = "UPDATE store SET ";
sqlUpdate2 = "(";
if (street != ""){
	sqlUpdate2 = helpful + "street = '" + street +"'";
	helpful = ",";
}
if (address_number != ","){
	sqlUpdate2 = helpful + "address_number = " + address_number;
	helpful = ",";
}
if (postal_code != ""){
	sqlUpdate2 = helpful + "postal_code = '" + postal_code +"'";
	helpful = ",";
}
if (city != ""){
	sqlUpdate2 = helpful + "city = '" + city +"'";
	helpful = ",";
}
if (size != ""){
	sqlUpdate2 = helpful + "size = " + size;
	helpful = ",";
}
if (operating_hours != ""){
	sqlUpdate2 = helpful + "operating_hours = '" + operating_hours +"'";
	helpful = ",";
}
sqlUpdate2 = sqlUpdate2 + ") WHERE storeID = " + si + ";" ;
sqlFinal = sqlUpdate1 + sqlUpdate2;

%>
</body>
</html>