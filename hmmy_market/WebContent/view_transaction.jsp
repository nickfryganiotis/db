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
String sqlSelect ="SELECT * FROM transaction_category_store";
rs_1 = statement.executeQuery(sqlSelect);
ArrayList<String> first_name = new ArrayList<String>();
ArrayList<String> last_name = new ArrayList<String>();
ArrayList<Integer> total_items = new  ArrayList<>();
ArrayList<String> date_time = new  ArrayList<String>();
ArrayList<Double> total_price = new  ArrayList<Double>();
ArrayList<String> category = new ArrayList<String>();
ArrayList<String> payment_method = new ArrayList<String>();
ArrayList<String> city = new ArrayList<String>();
ArrayList<String> street = new  ArrayList<String>();
ArrayList<Integer> address_number = new ArrayList<>();
while(rs_1.next()){
	first_name.add(rs_1.getString("mikro"));
	last_name.add(rs_1.getString("eponumo"));
	total_items.add(rs_1.getInt("total_items"));
	date_time.add(rs_1.getString("imerominia"));
	total_price.add(rs_1.getDouble("total_price"));
	category.add(rs_1.getString("katigoria"));
	city.add(rs_1.getString("poli"));
	payment_method.add(rs_1.getString("lefta"));
	street.add(rs_1.getString("dromos"));
	address_number.add(rs_1.getInt("arithmos"));
}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="view_transaction.css">
<title>Transaction View</title>
</head>
<body>
<h1>A relation algebra view for transactions by store and category</h1>
<table>
<tr>
<td>Date and Time</td>
<td>Name</td>
<td>Total items</td>
<td>Total Price</td>
<td>Category</td>
<td>Payment method</td>
<td>City</td>
<td>Address</td>
</tr>
<%for(int i=0; i<first_name.size(); i++){
%>
<tr>
<td><%=date_time.get(i) %></td>
<td><%=first_name.get(i)+" "+last_name.get(i) %></td>
<td><%=total_items.get(i) %>
<td><%=total_price.get(i) %></td>
<td><%=category.get(i) %></td>
<%if(payment_method.get(i).equals("null")){ %>
<td>Unknown</td>
<%} 
else{%> 
<td><%=payment_method.get(i) %>
<%} %>
<td><%=city.get(i) %></td>
<td><%=street.get(i)+" "+String.valueOf(address_number.get(i)) %></td>
</tr>
<%} %>
</table>
</body>
</html>