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
String cn = request.getParameter ("Card Number of Customer to Change");
String first_name = request.getParameter("New First Name");
String last_name = request.getParameter("New Last Name");
String street = request.getParameter("New Street");
String address_number = request.getParameter("New Address Number");
String postal_code = request.getParameter("New Postal Code");
String city = request.getParameter("New City");
String date_of_birth = request.getParameter("New Date of Birth");
String family_members= request.getParameter("New Family Members");
String pet = request.getParameter("New Pet");
String phone_number = request.getParameter("New Phone Number");
String helpful = "";

sqlUpdate1 = "UPDATE customer SET ";
sqlUpdate2 = "(";
if (first_name != ""){
	sqlUpdate2 = sqlUpdate2 + "first_name =  '" + first_name + "'";
	helpful = ",";
}
if (last_name != ""){
	sqlUpdate2 = helpful + "last_name = '" + last_name + "'";
	helpful = ",";
}
if (street != ""){
	sqlUpdate2 = helpful + "street = '" + street + "'";
	helpful = ",";
}
if (address_number != ","){
	sqlUpdate2 = helpful + "address_number = " + address_number;
	helpful = ",";
}
if (postal_code != ""){
	sqlUpdate2 = helpful + "postal_code = '" + postal_code + "'";
	helpful = ",";
}
if (city != ""){
	sqlUpdate2 = helpful + "city = '" + city +"'";
	helpful = ",";
}
if (date_of_birth != "SKATA"){
	sqlUpdate2 = helpful + "date_of_birth = '" + date_of_birth +"'";
	helpful = ",";
}
if (family_members != ""){
	sqlUpdate2 = helpful + "family_members = " + family_members;
	helpful = ",";
}
if (pet != ""){
	sqlUpdate2 = helpful + "pet = '" + pet +"'";
	helpful = ",";
}
if (phone_number != ""){
	sqlUpdate2 = helpful + "phone_number = " + phone_number;
	helpful = ",";
}
sqlUpdate2 = sqlUpdate2 + ") WHERE card_number = " + cn + ";" ;
sqlFinal = sqlUpdate1 + sqlUpdate2;

%>
</body>
</html>