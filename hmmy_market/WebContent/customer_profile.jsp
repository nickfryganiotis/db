<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/market";
	Connection connection = null;
	Statement statement = null;	
	ResultSet rs = null;
%>
<%
    String username = "root";
    String password = "";
    Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, username,password);
	statement = connection.createStatement();
	String sqlSelect = "SELECT first_name,last_name,city,age FROM customer;";
	rs = statement.executeQuery(sqlSelect);
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer_profile</title>
<link rel="stylesheet" href="customer_profile.css">
<script src="customer_profile.js"></script>
</head>
<body>
<%if(rs==null){ %>
<h1>Oops, something went wrong!</h1>
<p>The Database is Empty</p>
<% }
else{%>
	<table>
	  <tr>
	    <th>First Name</th>
	    <th>Last name</th>
	    <th>City</th>
	    <th>Age</th>
	  </tr>
<% while(rs.next()){
	String first_name=rs.getString("first_name");
	String last_name = rs.getString("last_name");
	String city = rs.getString("city");
	String age = rs.getString("age");
%>
<tr>
    <td><%=first_name %></td>
    <td><%=last_name%></td>
    <td><%=city%></td>
    <td><%=age%></td>
</tr>
	
<% }
}%>

</body>
</html>