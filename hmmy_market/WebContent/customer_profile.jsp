<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page session="false" %>
<%@ page import="java.sql.*"%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/market";
	Connection connection = null;
	Statement statement = null;	
	ResultSet rs_1 = null;
%>
<%
    String username = "root";
    String password = "";
    Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, username,password);
	statement = connection.createStatement();
	String sqlSelect = "SELECT first_name,last_name,city,age FROM customer;";
	rs_1 = statement.executeQuery(sqlSelect);
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customers_page</title>
<link rel="stylesheet" href="customer_profile.css">
<script src="customer_profile.js"></script>
</head>
<body>
<%if(rs_1==null){ %>
<h1>Oops, something went wrong!</h1>
<p>The Database is Empty</p>
<% }
else{
	int counter = 0;  
	while(rs_1.next()){
	String first_name=rs_1.getString("first_name");
	String last_name = rs_1.getString("last_name");
	String city = rs_1.getString("city");
	String age = rs_1.getString("age"); 
%>
<table>
<tr>
    <td>Name:</td>
    <td id= "<%="customer_name"+String.valueOf(counter)%>"> <%=first_name+" "+last_name %>
    </td>
</tr>
<tr>
    <td>City:</td>
    <td><%=city%></td>
</tr>
<tr>
    <td>Age:</td>
    <td><%=age%></td>
</tr>
</table>
<button type="button" onclick="check_customer(<%=counter%>)">Check Customer</button>
<button type="button" onclick="check_customer(<%=counter%>)">Delete Customer</button>
<button type="button" onclick="check_customer(<%=counter%>)">Update Profile Info</button>
<br>
<br>
<br>
<% counter++;}
}%>

</body>
</html>