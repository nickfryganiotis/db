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
String sqlSelect = "SELECT alley_number, shelf_number, count(*) "+
"AS times_together FROM offers GROUP BY alley_number, shelf_number "
+"ORDER BY times_together DESC LIMIT 20;";
rs_1 = statement.executeQuery(sqlSelect);
ArrayList<Integer> alley_number = new ArrayList<>();
ArrayList<Integer> shelf_number = new ArrayList<>();
ArrayList<Integer> times_together = new ArrayList<>();
while(rs_1.next()){
	alley_number.add(rs_1.getInt("alley_number"));
	shelf_number.add(rs_1.getInt("shelf_number"));
	times_together.add(rs_1.getInt("times_together"));
}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="pair_products.css">
<title>Most popular product positions</title>
</head>
<body>
<h1>The most popular positions of products</h1>
 <table>
 <tr>
<td>Number</td>
<td>Alley Number</td>
<td>Shelf Number</td>
<td>Times</td>
</tr>
<%for(int i=0; i<alley_number.size(); i++){%>
<tr>
<td><%=i+1 %></td>
<td><%= alley_number.get(i)%></td>
<td><%= shelf_number.get(i)%></td>
<td><%=times_together.get(i) %></td>
</tr>
<%} %>
</table>
</body>
</html>