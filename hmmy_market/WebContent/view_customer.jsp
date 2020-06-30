<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%> 
<%@ page session="false" %>
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
String sqlSelect ="SELECT * FROM customer_info";
rs_1 = statement.executeQuery(sqlSelect);
ArrayList<String> first_name = new ArrayList<String>();
ArrayList<String> last_name = new ArrayList<String>();
ArrayList<Integer> points = new  ArrayList<>();
ArrayList<String> street = new  ArrayList<String>();
ArrayList<Integer> address_number = new  ArrayList<>();
ArrayList<Integer> postal_code = new  ArrayList<>();
ArrayList<String> city = new ArrayList<String>();
ArrayList<Integer> family_members = new  ArrayList<>();
ArrayList<String> pet = new ArrayList<String>();
ArrayList<Integer> age = new  ArrayList<>();
ArrayList<String> phone_number = new ArrayList<String>();
while(rs_1.next()){
	first_name.add(rs_1.getString("first_name"));
	last_name.add(rs_1.getString("last_name"));
	points.add(rs_1.getInt("points"));
	street.add(rs_1.getString("street"));
	address_number.add(rs_1.getInt("address_number"));
	postal_code.add(rs_1.getInt("postal_code"));
	city.add(rs_1.getString("city"));
	family_members.add(rs_1.getInt("family_members"));
	pet.add(rs_1.getString("pet"));
	age.add(rs_1.getInt("age"));
	phone_number.add(rs_1.getString("phone_number"));
}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer info view</title>
<link rel="stylesheet" href="view_customer.css">
</head>
<body>
<h1>A relation algebra view for the customer info</h1>
<table>
<tr>
<td>Name</td>
<td>Age</td>
<td>Phone number</td>
<td>City</td>
<td>Address</td>
<td>Postal Code</td>
<td>Pet</td>
<td>Points</td>
</tr>
<%for(int i=0; i<first_name.size(); i++){
%>
<tr>
<td><%=first_name.get(i)+" "+last_name.get(i) %></td>
<td><%=age.get(i) %></td>
<td><%=phone_number.get(i) %>
<td><%=city.get(i) %></td>
<td><%=street.get(i)+" "+String.valueOf(address_number.get(i)) %></td>
<td><%=postal_code.get(i) %></td>
<%if(pet.get(i).equals("null")){ %>
<td>not a pet</td>
<%} 
else{%> 
<td><%=pet.get(i) %>
<%} %>
<td><%=points.get(i) %></td>
</tr>
<%} %>
</table>
</body>
</html>