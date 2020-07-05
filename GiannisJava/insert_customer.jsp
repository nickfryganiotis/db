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
String first_name = request.getParameter("First Name");
String last_name = request.getParameter("Last Name");
String street = request.getParameter("Street");
String address_number = request.getParameter("Address Number");
String postal_code = request.getParameter("Postal Code");
String city = request.getParameter("City");
String date_of_birth = request.getParameter("Date of Birth");
String family_members= request.getParameter("Family Members");
String pet = request.getParameter("Pet");
String phone_number = request.getParameter("Phone Number");

sqlInsert1 = "INSERT INTO customer (first_name,last_name ";
sqlInsert2 = "('" + first_name +"','" + last_name + "'" ;
if (street != ""){
	sqlInsert1 = sqlInsert1 + ",street";
	sqlInsert2 = sqlInsert2 + ",'" + street +"'";	
}
if (address_number != ""){
	sqlInsert1 = sqlInsert1 + ",address_number";
	sqlInsert2 = sqlInsert2 + "," + address_number;	
}
if (postal_code != ""){
	sqlInsert1 = sqlInsert1 + ",postal_code";
	sqlInsert2 = sqlInsert2 + ",'" + postal_code +"'";	
}
if (city != ""){
	sqlInsert1 = sqlInsert1 + ",city";
	sqlInsert2 = sqlInsert2 + ",'" + city +"'";	
}
if (date_of_birth != "SKATA"){
	sqlInsert1 = sqlInsert1 + ",date_of_birth";
	sqlInsert2 = sqlInsert2 + ",'" + date_of_birth +"'";	
}
if (family_members != ""){
	sqlInsert1 = sqlInsert1 + ",family_members";
	sqlInsert2 = sqlInsert2 + "," + family_members;	
}
if (pet != ""){
	sqlInsert1 = sqlInsert1 + ",pet";
	sqlInsert2 = sqlInsert2 + ",'" + pet +"'";	
}
if (phone_number != ""){
	sqlInsert1 = sqlInsert1 + ",phone_number";
	sqlInsert2 = sqlInsert2 + ",'" + phone_number +"'";	
}
sqlInsert1 = sqlInsert1 + ") VALUES ";
sqlInsert2 = sqlInsert2 + ");";
sqlFinal = sqlInsert1 + sqlInsert2;
%>
</body>
</html>